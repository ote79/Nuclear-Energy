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
import { addWrongQuestions } from '../stores/wrongBook'

const route = useRoute()
const loading = ref(false)
const submitting = ref(false)
const quiz = ref(null)
const answers = reactive({})
const submitted = ref(false)
const score = ref(0)
const correctCount = ref(0)
const wrongQuestionIds = ref([])

const mockQuiz = {
  id: 1,
  title: '核辐射基础知识测验',
  description: '测试你对核辐射基本概念的理解',
  timeLimit: 10,
  questions: [
    {
      id: 1, title: '以下哪种辐射穿透力最强？', type: 'single',
      options: [{ key: 'A', text: 'α 射线' }, { key: 'B', text: 'β 射线' }, { key: 'C', text: 'γ 射线' }, { key: 'D', text: '中子辐射' }],
      answer: 'C', explanation: 'γ 射线是高能电磁波，穿透力最强，需要厚铅板才能屏蔽。'
    },
    {
      id: 2, title: '核电站利用的是哪种核反应？', type: 'single',
      options: [{ key: 'A', text: '核裂变' }, { key: 'B', text: '核聚变' }, { key: 'C', text: '放射性衰变' }, { key: 'D', text: '电子俘获' }],
      answer: 'A', explanation: '目前核电站利用的是重核（如铀-235）的裂变反应来产生能量。'
    },
    {
      id: 3, title: '以下哪些是天然辐射来源？', type: 'multi',
      options: [{ key: 'A', text: '宇宙射线' }, { key: 'B', text: 'X 光检查' }, { key: 'C', text: '土壤中的放射性物质' }, { key: 'D', text: '核电站正常运行' }],
      answer: 'A,C', explanation: '宇宙射线和土壤中的放射性物质是天然辐射来源，X光和核电站属于人工辐射源。'
    },
    {
      id: 4, title: '辐射剂量的国际单位是什么？', type: 'single',
      options: [{ key: 'A', text: '贝可勒尔（Bq）' }, { key: 'B', text: '戈瑞（Gy）' }, { key: 'C', text: '希沃特（Sv）' }, { key: 'D', text: '居里（Ci）' }],
      answer: 'C', explanation: '希沃特（Sv）是衡量辐射对人体生物效应的国际单位。'
    },
    {
      id: 5, title: '一张普通的纸可以阻挡哪种射线？', type: 'single',
      options: [{ key: 'A', text: 'α 射线' }, { key: 'B', text: 'β 射线' }, { key: 'C', text: 'γ 射线' }, { key: 'D', text: '以上都不能' }],
      answer: 'A', explanation: 'α 射线电离能力强但穿透力最弱，一张纸或几厘米空气就能完全阻挡。'
    }
  ]
}

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
    score.value = res.data?.score || 0
    submitted.value = true
    calcWrongQuestions()
    saveWrongToBook()
    ElMessage.success(score.value >= 60 ? '恭喜通过！' : '继续努力！')
  } catch {
    calcWrongQuestions()
    saveWrongToBook()
    score.value = Math.round((correctCount.value / quiz.value.questions.length) * 100)
    submitted.value = true
    ElMessage.success(score.value >= 60 ? '恭喜通过！' : '继续努力！')
  } finally {
    submitting.value = false
  }
}

function calcWrongQuestions() {
  const qs = quiz.value.questions
  const wrongIds = []
  let correct = 0
  qs.forEach(q => {
    const correctAnswers = q.answer?.split(',') || []
    const userAnswers = Array.isArray(answers[q.id]) ? answers[q.id] : [answers[q.id]]
    if (correctAnswers.sort().join(',') === userAnswers.sort().join(',')) {
      correct++
    } else {
      wrongIds.push(q.id)
    }
  })
  correctCount.value = correct
  wrongQuestionIds.value = wrongIds
}

function saveWrongToBook() {
  const wrongQs = quiz.value.questions.filter(q => wrongQuestionIds.value.includes(q.id))
  if (wrongQs.length > 0) {
    addWrongQuestions(wrongQs.map(q => ({
      id: q.id,
      title: q.title,
      type: q.type,
      options: q.options,
      answer: q.answer,
      explanation: q.explanation,
      quizTitle: quiz.value.title
    })))
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
  } catch {
    quiz.value = mockQuiz
    mockQuiz.questions.forEach(q => {
      answers[q.id] = q.type === 'multi' ? [] : ''
    })
  } finally {
    loading.value = false
  }
})
</script>
