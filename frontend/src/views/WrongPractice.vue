<template>
  <div class="page-container py-8">
    <el-button text class="mb-4" @click="$router.push('/quiz')">← 返回测验列表</el-button>

    <div class="mb-8">
      <h1 class="text-3xl font-bold text-gray-800 mb-2">错题重练</h1>
      <p class="text-gray-500">所有测验中累积的错题，反复练习直到掌握</p>
    </div>

    <!-- Empty state -->
    <div v-if="allQuestions.length === 0 && !submitted" class="text-center py-20">
      <el-icon :size="72" color="#14b8a6" class="mb-4"><CircleCheckFilled /></el-icon>
      <h2 class="text-2xl font-bold text-gray-400 mb-2">错题库为空</h2>
      <p class="text-gray-400 mb-6">太棒了！你还没有做错的题目，继续保持！</p>
      <el-button type="primary" size="large" @click="$router.push('/quiz')">去做测验</el-button>
    </div>

    <div v-else>
      <!-- Header -->
      <div class="bg-white rounded-xl p-5 border border-gray-100 mb-6">
        <div class="flex flex-wrap items-center justify-between gap-4">
          <div>
            <div class="text-sm text-gray-400">错题库共</div>
            <div class="text-2xl font-bold" :class="allQuestions.length > 0 ? 'text-orange-500' : 'text-green-500'">
              {{ allQuestions.length }} 题
            </div>
          </div>
          <div class="flex items-center gap-3">
            <el-tag v-for="label in uniqueQuizTitles" :key="label" size="small" type="info">{{ label }}</el-tag>
          </div>
          <div class="flex gap-2">
            <el-button v-if="!submitted && allQuestions.length > 0" type="warning" @click="clearWrongBook">
              <el-icon><Delete /></el-icon> 清空错题库
            </el-button>
            <el-button v-if="!submitted" type="primary" size="large" :disabled="allQuestions.length === 0" @click="startPractice">
              开始练习
            </el-button>
            <el-button v-if="submitted" size="large" @click="handleRetry">重新练习</el-button>
          </div>
        </div>
      </div>

      <!-- Questions (during practice) -->
      <div v-if="practiceMode" class="max-w-3xl mx-auto">
        <div v-if="currentQuestion" class="bg-white rounded-xl border border-gray-100 p-8 shadow-sm">
          <!-- Progress -->
          <div class="flex items-center justify-between mb-6">
            <el-tag type="warning" size="small">
              错题 {{ currentIndex + 1 }}/{{ practiceQuestions.length }} ·
              错 {{ practiceQuestions[currentIndex]?.wrongCount || 1 }} 次
            </el-tag>
          </div>
          <el-progress :percentage="Math.round((currentIndex + 1) / practiceQuestions.length * 100)" :stroke-width="4" class="mb-6" />

          <!-- Question -->
          <div class="mb-6 text-center">
            <span class="inline-flex items-center justify-center w-8 h-8 rounded-full bg-orange-500 text-white font-bold text-sm mb-3">
              {{ currentIndex + 1 }}
            </span>
            <p class="text-lg font-bold text-gray-800 mb-2">{{ currentQuestion.title }}</p>
            <el-tag v-if="currentQuestion.type === 'single'" size="small">单选</el-tag>
            <el-tag v-else-if="currentQuestion.type === 'multi'" size="small" type="warning">多选</el-tag>
          </div>

          <!-- Options -->
          <div class="space-y-3 mb-6">
            <template v-if="currentQuestion.type === 'multi'">
              <div
                v-for="opt in currentQuestion.options"
                :key="opt.key"
                class="p-4 rounded-xl border-2 cursor-pointer transition-all text-center"
                :class="getMultiClass(opt.key)"
                @click="toggleMultiAnswer(opt.key)"
              >
                <div class="inline-flex items-center justify-center gap-2">
                  <span class="w-7 h-7 rounded-lg inline-flex items-center justify-center font-bold text-sm" :class="getBadgeClass(opt.key)">
                    {{ opt.key }}
                  </span>
                  <span class="text-gray-700">{{ opt.text }}</span>
                </div>
              </div>
            </template>
            <template v-else>
              <div
                v-for="opt in currentQuestion.options"
                :key="opt.key"
                class="p-4 rounded-xl border-2 cursor-pointer transition-all text-center"
                :class="getSingleClass(opt.key)"
                @click="selectAnswer(opt.key)"
              >
                <div class="inline-flex items-center justify-center gap-2">
                  <span class="w-7 h-7 rounded-lg inline-flex items-center justify-center font-bold text-sm" :class="getBadgeClass(opt.key)">
                    {{ opt.key }}
                  </span>
                  <span class="text-gray-700">{{ opt.text }}</span>
                </div>
              </div>
            </template>
          </div>

          <!-- Actions -->
          <div class="flex justify-center gap-3 mb-4" v-if="!answered">
            <el-button type="primary" size="large" :disabled="!hasSelection" @click="checkAnswer">提交答案</el-button>
            <el-button size="large" @click="skipQuestion">跳过</el-button>
          </div>

          <!-- Feedback -->
          <div v-if="answered" class="p-5 rounded-xl mb-4" :class="isCorrect ? 'bg-green-50 border border-green-200' : 'bg-red-50 border border-red-200'">
            <div class="flex items-center gap-2 mb-2">
              <el-icon :size="22" :color="isCorrect ? '#16a34a' : '#dc2626'">
                <component :is="isCorrect ? 'CircleCheckFilled' : 'CircleCloseFilled'" />
              </el-icon>
              <span class="font-bold" :class="isCorrect ? 'text-green-700' : 'text-red-700'">
                {{ isCorrect ? '回答正确！' : '回答错误' }}
              </span>
            </div>
            <p v-if="!isCorrect" class="text-sm text-gray-600 mb-2">
              正确答案：<strong class="text-green-700">{{ currentQuestion.answer }}</strong>
            </p>
            <div class="p-4 bg-white/50 rounded-lg text-sm text-gray-700 leading-relaxed">
              <strong>解析：</strong>{{ currentQuestion.explanation }}
            </div>
          </div>

          <!-- Next -->
          <div class="flex justify-center">
            <el-button v-if="answered && currentIndex < practiceQuestions.length - 1" type="primary" size="large" @click="nextQuestion">下一题</el-button>
            <el-button v-if="answered && currentIndex === practiceQuestions.length - 1" type="success" size="large" @click="finishPractice">完成</el-button>
          </div>
        </div>
      </div>

      <!-- Completion -->
      <div v-if="practiceDone" class="bg-white rounded-xl border border-gray-100 p-10 text-center max-w-lg mx-auto">
        <el-icon :size="72" color="#14b8a6" class="mb-4"><CircleCheckFilled /></el-icon>
        <h2 class="text-2xl font-bold text-gray-800 mb-2">练习完成！</h2>
        <div class="text-gray-500 mb-2">
          正确 {{ correctCount }}/{{ practiceQuestions.length }} 题
        </div>
        <div class="text-sm text-gray-400 mb-6">
          做对的题目已从错题库移除 · 剩余 {{ wrongQuestionIds.length }} 题
        </div>
        <div class="flex justify-center gap-3">
          <el-button v-if="wrongQuestionIds.length > 0" type="warning" size="large" @click="restartWrong">
            <el-icon><RefreshRight /></el-icon> 继续练剩余错题
          </el-button>
          <el-button size="large" @click="handleRetry">全部重练</el-button>
          <el-button size="large" type="primary" @click="$router.push('/quiz')">去测验</el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { getWrongQuestions, removeWrongQuestions, clearWrongQuestions } from '../api/quiz'
import { ElMessage, ElMessageBox } from 'element-plus'

const allQuestions = ref([])
const practiceMode = ref(false)
const practiceDone = ref(false)
const practiceQuestions = ref([])
const currentIndex = ref(0)
const userAnswer = ref('')
const multiAnswers = ref([])
const answered = ref(false)
const isCorrect = ref(false)
const correctCount = ref(0)
const wrongQuestionIds = ref([])
const submitted = ref(false)

const currentQuestion = computed(() => practiceQuestions.value[currentIndex.value] || null)

const hasSelection = computed(() => {
  if (!currentQuestion.value) return false
  if (currentQuestion.value.type === 'multi') return multiAnswers.value.length > 0
  return !!userAnswer.value
})

const uniqueQuizTitles = computed(() =>
  [...new Set(allQuestions.value.map(q => q.quizTitle).filter(Boolean))]
)

const loading = ref(false)

async function loadQuestions() {
  loading.value = true
  try {
    const res = await getWrongQuestions({ page: 1, pageSize: 999 })
    allQuestions.value = res.data?.list || []
  } catch (e) {
    ElMessage.error(e?.message || '获取错题失败')
    allQuestions.value = []
  } finally {
    loading.value = false
  }
}

function startPractice() {
  practiceQuestions.value = [...allQuestions.value]
  currentIndex.value = 0
  userAnswer.value = ''
  multiAnswers.value = []
  answered.value = false
  correctCount.value = 0
  wrongQuestionIds.value = []
  practiceMode.value = true
  practiceDone.value = false
}

function selectAnswer(key) {
  if (answered.value) return
  userAnswer.value = key
}

function toggleMultiAnswer(key) {
  if (answered.value) return
  const idx = multiAnswers.value.indexOf(key)
  if (idx >= 0) multiAnswers.value.splice(idx, 1)
  else multiAnswers.value.push(key)
}

function getSingleClass(key) {
  if (!answered.value) {
    return userAnswer.value === key ? 'border-teal-500 bg-teal-50' : 'border-gray-100 hover:border-teal-200'
  }
  const correct = currentQuestion.value.answer
  if (key === correct) return 'border-green-500 bg-green-50'
  if (key === userAnswer.value) return 'border-red-500 bg-red-50'
  return 'border-gray-100 opacity-50'
}

function getMultiClass(key) {
  if (!answered.value) {
    return multiAnswers.value.includes(key) ? 'border-teal-500 bg-teal-50' : 'border-gray-100 hover:border-teal-200'
  }
  const correct = currentQuestion.value.answer?.split(',') || []
  if (correct.includes(key) && multiAnswers.value.includes(key)) return 'border-green-500 bg-green-50'
  if (correct.includes(key)) return 'border-green-500 bg-green-50'
  if (multiAnswers.value.includes(key)) return 'border-red-500 bg-red-50'
  return 'border-gray-100 opacity-50'
}

function getBadgeClass(key) {
  if (!answered.value) return 'bg-gray-100 text-gray-600'
  const correct = currentQuestion.value.answer?.split(',') || []
  const selected = currentQuestion.value.type === 'multi' ? multiAnswers.value : [userAnswer.value]
  if (correct.includes(key) && selected.includes(key)) return 'bg-green-500 text-white'
  if (correct.includes(key)) return 'bg-green-500 text-white'
  if (selected.includes(key)) return 'bg-red-500 text-white'
  return 'bg-gray-100 text-gray-400'
}

function checkAnswer() {
  if (!currentQuestion.value) return
  answered.value = true
  const correct = currentQuestion.value.answer?.split(',') || []
  let userAns = currentQuestion.value.type === 'multi'
    ? [...multiAnswers.value].sort()
    : [userAnswer.value]
  const correctSorted = [...correct].sort()
  isCorrect.value = correctSorted.join(',') === userAns.join(',')
  if (isCorrect.value) {
    correctCount.value++
  } else {
    wrongQuestionIds.value.push(currentQuestion.value.id)
  }
}

function skipQuestion() {
  wrongQuestionIds.value.push(currentQuestion.value?.id)
  goToQuestion(currentIndex.value + 1)
}

function nextQuestion() {
  goToQuestion(currentIndex.value + 1)
}

function goToQuestion(index) {
  if (index >= practiceQuestions.value.length) {
    finishPractice()
    return
  }
  currentIndex.value = index
  userAnswer.value = ''
  multiAnswers.value = []
  answered.value = false
  isCorrect.value = false
}

async function finishPractice() {
  practiceDone.value = true
  submitted.value = true
  // 移除做对的题目
  const correctIds = practiceQuestions.value
    .filter(q => !wrongQuestionIds.value.includes(q.id))
    .map(q => q.id)
  if (correctIds.length > 0) {
    removeWrongQuestions({ questionIds: correctIds }).catch(() => {})
  }
}

async function restartWrong() {
  const correctIds = practiceQuestions.value
    .filter(q => !wrongQuestionIds.value.includes(q.id))
    .map(q => q.id)
  if (correctIds.length > 0) {
    try { await removeWrongQuestions({ questionIds: correctIds }) } catch {}
  }
  await loadQuestions()
  startPractice()
}

function handleRetry() {
  startPractice()
  // 重新开始不用重新加载
}

async function clearWrongBookConfirm() {
  try {
    await ElMessageBox.confirm('确定要清空所有错题记录吗？', '确认', { type: 'warning' })
    await clearWrongQuestions()
    allQuestions.value = []
    ElMessage.success('错题库已清空')
  } catch { /* cancelled */ }
}

onMounted(() => {
  loadQuestions()
})
</script>
