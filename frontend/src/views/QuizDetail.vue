<template>
  <div class="page-container py-8">
    <el-button text class="mb-4" @click="$router.push('/quiz')">← 返回测验列表</el-button>

    <div v-loading="loading">
      <template v-if="quiz">
        <!-- Quiz header -->
        <div class="bg-white rounded-xl p-6 shadow-sm mb-6">
          <h1 class="text-2xl font-bold text-gray-800 mb-2">{{ quiz.title }}</h1>
          <div class="flex items-center gap-4 text-sm text-gray-400">
            <span>共 {{ quiz.questions?.length }} 题</span>
            <span>限时 {{ quiz.timeLimit }} 分钟</span>
            <el-tag v-if="submitted" :type="score >= 60 ? 'success' : 'danger'">得分: {{ score }}</el-tag>
          </div>
        </div>

        <!-- Questions -->
        <div class="space-y-6">
          <div v-for="(q, qIndex) in quiz.questions" :key="q.id" class="bg-white rounded-xl p-6 shadow-sm">
            <div class="flex items-start gap-3 mb-4">
              <span class="w-8 h-8 rounded-full bg-blue-50 text-nuclear-blue flex items-center justify-center font-bold text-sm flex-shrink-0">
                {{ qIndex + 1 }}
              </span>
              <div>
                <p class="font-medium text-gray-800">{{ q.title }}</p>
                <el-tag v-if="q.type === 'single'" size="small" class="mt-1">单选</el-tag>
                <el-tag v-else-if="q.type === 'multi'" size="small" type="warning" class="mt-1">多选</el-tag>
                <el-tag v-else size="small" type="info" class="mt-1">判断</el-tag>
              </div>
            </div>

            <el-radio-group
              v-if="q.type === 'single' || q.type === 'judge'"
              v-model="answers[q.id]"
              :disabled="submitted"
              class="flex flex-col gap-3"
            >
              <el-radio v-for="opt in q.options" :key="opt.key" :value="opt.key" class="!items-start">
                <span :class="getOptionClass(q, opt.key)">{{ opt.key }}. {{ opt.text }}</span>
              </el-radio>
            </el-radio-group>

            <el-checkbox-group v-else v-model="answers[q.id]" :disabled="submitted" class="flex flex-col gap-3">
              <el-checkbox v-for="opt in q.options" :key="opt.key" :value="opt.key" class="!items-start">
                <span :class="getOptionClass(q, opt.key)">{{ opt.key }}. {{ opt.text }}</span>
              </el-checkbox>
            </el-checkbox-group>

            <div v-if="submitted && q.explanation" class="mt-4 p-4 bg-blue-50 rounded-lg text-sm text-gray-700">
              <strong>解析：</strong>{{ q.explanation }}
            </div>
          </div>
        </div>

        <!-- Submit button -->
        <div class="mt-8 text-center">
          <div v-if="!submitted">
            <el-button type="primary" size="large" :loading="submitting" @click="handleSubmit">提交答卷</el-button>
          </div>
          <div v-else class="flex flex-col items-center gap-3">
            <!-- Score card -->
            <div class="w-72 rounded-xl p-5 mb-2" :class="score >= 60 ? 'bg-green-50 border border-green-200' : 'bg-orange-50 border border-orange-200'">
              <div class="text-4xl font-bold mb-1" :class="score >= 60 ? 'text-green-600' : 'text-orange-500'">{{ score }} 分</div>
              <div class="text-sm" :class="score >= 60 ? 'text-green-500' : 'text-orange-500'">
                {{ score >= 60 ? '🎉 恭喜通过！' : '还需努力，继续加油！' }}
              </div>
              <div class="text-xs text-gray-400 mt-1">
                正确 {{ correctCount }}/{{ quiz.questions.length }} 题 ·
                错误 {{ quiz.questions.length - correctCount }}/{{ quiz.questions.length }} 题
              </div>
            </div>
            <div class="text-xs text-gray-400">
              错题已自动加入错题库，可在测验列表页进行"错题重练"
            </div>
            <el-button size="large" @click="handleRetry">重新测验</el-button>
          </div>
        </div>
      </template>
      <el-empty v-if="!loading && !quiz" description="测验不存在" />
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { submitQuiz } from '../api/quiz'
import { getQuizList } from '../api/quiz'
import { ElMessage } from 'element-plus'

const route = useRoute()
const loading = ref(false)
const submitting = ref(false)
const quiz = ref(null)
const answers = reactive({})
const submitted = ref(false)
const score = ref(0)
const correctCount = ref(0)
const wrongQuestionIds = ref([])

function getOptionClass(q, key) {
  if (!submitted.value) return ''
  const correct = q.answer?.split(',') || []
  const selected = Array.isArray(answers[q.id]) ? answers[q.id] : [answers[q.id]]
  if (correct.includes(key) && selected.includes(key)) return 'text-green-600 font-medium'
  if (correct.includes(key)) return 'text-green-600'
  if (selected.includes(key)) return 'text-red-500 line-through'
  return ''
}

async function handleSubmit() {
  const unanswered = quiz.value.questions.filter(q => {
    const a = answers[q.id]
    return !a || (Array.isArray(a) && a.length === 0)
  })
  if (unanswered.length > 0) {
    ElMessage.warning(`还有 ${unanswered.length} 题未作答`)
    return
  }
  submitting.value = true
  try {
    const data = quiz.value.questions.map(q => ({
      questionId: q.id,
      answer: Array.isArray(answers[q.id]) ? answers[q.id].join(',') : answers[q.id]
    }))
    const res = await submitQuiz({ quizId: quiz.value.id, answers: data })
    submitted.value = true
    score.value = res.data?.score ?? 0
    correctCount.value = res.data?.correctCount ?? 0
    wrongQuestionIds.value = res.data?.wrongQuestionIds ?? []
    ElMessage.success(score.value >= 60 ? '恭喜通过！' : '继续努力！')
  } catch (e) {
    ElMessage.error(e?.message || '提交失败')
  } finally {
    submitting.value = false
  }
}

function handleRetry() {
  submitted.value = false
  score.value = 0
  correctCount.value = 0
  wrongQuestionIds.value = []
  quiz.value.questions.forEach(q => {
    answers[q.id] = q.type === 'multi' ? [] : ''
  })
}

onMounted(async () => {
  loading.value = true
  try {
    const res = await getQuizList({ id: route.params.id })
    quiz.value = res.data?.list?.[0] || res.data
    if (quiz.value?.questions) {
      quiz.value.questions.forEach(q => {
        answers[q.id] = q.type === 'multi' ? [] : ''
      })
    }
  } catch (e) {
    quiz.value = null
    ElMessage.error(e?.message || '获取测验失败')
  } finally {
    loading.value = false
  }
})
</script>
