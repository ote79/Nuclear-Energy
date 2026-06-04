<template>
  <div class="min-h-screen bg-gray-50">
    <div class="page-container py-8">
      <el-button text class="mb-4" @click="$router.push('/')">← 返回首页</el-button>

      <div class="mb-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-2">互动练习</h1>
        <p class="text-gray-500">答题后即时查看解析，无时间限制，巩固知识点</p>
      </div>

      <!-- Mode Selector -->
      <div class="flex items-center gap-3 mb-6">
        <span class="text-sm text-gray-500">练习专题：</span>
        <el-select v-model="currentTopic" placeholder="选择专题" size="large" style="width: 240px">
          <el-option v-for="t in topics" :key="t.id" :label="t.name" :value="t.id" />
        </el-select>
        <el-radio-group v-model="mode" size="large">
          <el-radio-button value="qa">逐题练习</el-radio-button>
          <el-radio-button value="flashcard">闪卡模式</el-radio-button>
        </el-radio-group>
      </div>

      <!-- Q&A Mode -->
      <div v-if="mode === 'qa'" class="max-w-3xl mx-auto">
        <div v-if="currentQuestion" class="bg-white rounded-xl border border-gray-100 p-8 shadow-sm">
          <!-- Progress -->
          <div class="text-center mb-4">
            <el-tag size="small" type="info" class="mb-2">{{ currentTopicName }}</el-tag>
            <div class="text-sm text-gray-400 mt-1">{{ currentIndex + 1 }} / {{ questions.length }}</div>
          </div>
          <el-progress :percentage="Math.round((currentIndex + 1) / questions.length * 100)" :stroke-width="4" class="mb-6" />

          <!-- Question -->
          <div class="mb-6 text-center">
            <span class="inline-flex items-center justify-center w-8 h-8 rounded-full bg-teal-500 text-white font-bold text-sm mb-3">
              {{ currentIndex + 1 }}
            </span>
            <p class="text-lg font-bold text-gray-800 mb-2">{{ currentQuestion.title }}</p>
            <el-tag v-if="currentQuestion.type === 'single'" size="small">单选</el-tag>
            <el-tag v-else-if="currentQuestion.type === 'multi'" size="small" type="warning">多选</el-tag>
            <el-tag v-else size="small" type="info">判断</el-tag>
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
                  <span class="w-7 h-7 rounded-lg inline-flex items-center justify-center font-bold text-sm" :class="getOptionBadgeClass(opt.key)">
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
                class="p-4 rounded-xl border-2 cursor-pointer transition-all"
                :class="getSingleClass(opt.key)"
                @click="selectAnswer(opt.key)"
              >
                <div class="flex items-center justify-center gap-3 text-center">
                  <span class="w-7 h-7 rounded-lg flex items-center justify-center font-bold text-sm flex-shrink-0" :class="getOptionBadgeClass(opt.key)">
                    {{ opt.key }}
                  </span>
                  <span class="text-gray-700">{{ opt.text }}</span>
                </div>
              </div>
            </template>
          </div>

          <!-- Answer actions -->
          <div v-if="!answered" class="flex justify-center gap-3">
            <el-button type="primary" size="large" :disabled="!hasSelection" @click="checkAnswer">
              提交答案
            </el-button>
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
          <div v-if="answered" class="flex justify-center">
            <el-button v-if="currentIndex < questions.length - 1" type="primary" size="large" @click="nextQuestion">
              下一题
            </el-button>
            <el-button v-else type="success" size="large" @click="finishPractice">
              完成练习
            </el-button>
          </div>
        </div>

        <!-- Topic intro -->
        <div v-if="!currentTopic && !currentQuestion" class="text-center py-20">
          <el-icon :size="64" class="text-gray-300 mb-4"><Edit /></el-icon>
          <h3 class="text-xl font-bold text-gray-400 mb-2">请选择练习专题</h3>
          <p class="text-gray-400">从上方下拉菜单选择你想练习的知识专题</p>
        </div>

        <!-- Practice complete -->
        <div v-if="practiceDone" class="bg-white rounded-xl border border-gray-100 p-10 text-center">
          <el-icon :size="72" color="#14b8a6" class="mb-4"><CircleCheckFilled /></el-icon>
          <h2 class="text-2xl font-bold text-gray-800 mb-2">练习完成！</h2>
          <div class="text-gray-500 mb-6">
            正确率 {{ correctCount }}/{{ questions.length }} ({{ Math.round(correctCount / questions.length * 100) }}%)
          </div>
          <div class="flex justify-center gap-3">
            <el-button type="primary" size="large" @click="restartPractice">再练一次</el-button>
            <el-button size="large" @click="$router.push('/quiz')">去测验 →</el-button>
          </div>
        </div>
      </div>

      <!-- Flashcard Mode -->
      <div v-if="mode === 'flashcard'" class="max-w-2xl mx-auto">
        <div v-if="currentFlashcard" class="bg-white rounded-xl border border-gray-100 p-8 shadow-sm">
          <div class="flex items-center justify-between mb-4">
            <el-tag size="small" type="info">{{ currentTopicName }}</el-tag>
            <span class="text-sm text-gray-400">{{ flashcardIndex + 1 }} / {{ flashcards.length }}</span>
          </div>

          <div class="relative cursor-pointer" @click="flipCard" style="perspective: 1000px;">
            <div class="transition-all duration-500" :class="{ 'rotate-y-180': flipped }" style="transform-style: preserve-3d;">
              <!-- Front: Question -->
              <div v-if="!flipped" class="bg-gradient-to-br from-teal-500 to-blue-600 text-white rounded-xl p-10 text-center min-h-48 flex flex-col items-center justify-center">
                <el-icon :size="32" class="mb-3 opacity-70"><QuestionFilled /></el-icon>
                <p class="text-xl font-bold">{{ currentFlashcard.question }}</p>
                <p class="text-sm mt-4 opacity-70">点击卡片翻转查看答案</p>
              </div>
              <!-- Back: Answer -->
              <div v-if="flipped" class="bg-gradient-to-br from-amber-400 to-orange-500 text-white rounded-xl p-10 text-center min-h-48 flex flex-col items-center justify-center">
                <el-icon :size="32" class="mb-3 opacity-70"><Lightning /></el-icon>
                <p class="text-xl font-bold mb-3">{{ currentFlashcard.answer }}</p>
                <p class="text-sm opacity-80 leading-relaxed max-w-md">{{ currentFlashcard.explanation }}</p>
              </div>
            </div>
          </div>

          <div class="flex gap-3 mt-6">
            <el-button size="large" class="flex-1" @click="prevFlashcard" :disabled="flashcardIndex === 0">上一张</el-button>
            <el-button size="large" type="primary" class="flex-1" @click="nextFlashcard" :disabled="flashcardIndex >= flashcards.length - 1">下一张</el-button>
          </div>
        </div>

        <div v-if="!currentTopic && !currentFlashcard" class="text-center py-20">
          <el-icon :size="64" class="text-gray-300 mb-4"><Collection /></el-icon>
          <h3 class="text-xl font-bold text-gray-400 mb-2">请选择练习专题</h3>
          <p class="text-gray-400">闪卡模式帮你快速记忆核心概念</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const mode = ref('qa')
const currentTopic = ref('')
const currentIndex = ref(0)
const userAnswer = ref('')
const multiAnswers = ref([])
const answered = ref(false)
const isCorrect = ref(false)
const correctCount = ref(0)
const practiceDone = ref(false)

// Flashcard mode
const flipped = ref(false)
const flashcardIndex = ref(0)

const topics = ref([
  { id: 'radiation', name: '核辐射基础' },
  { id: 'nuclear', name: '核电站原理' },
  { id: 'protection', name: '辐射防护' },
  { id: 'history', name: '核事故与历史' }
])

const currentTopicName = computed(() => topics.value.find(t => t.id === currentTopic.value)?.name || '')

// Q&A data
const questionData = {
  radiation: [
    { id: 1, title: '以下哪种射线穿透力最强？', type: 'single',
      options: [{ key: 'A', text: 'α 射线' }, { key: 'B', text: 'β 射线' }, { key: 'C', text: 'γ 射线' }, { key: 'D', text: '中子辐射' }],
      answer: 'C', explanation: 'γ 射线是高能电磁波，波长极短，穿透力在三种射线中最强，需要厚实的铅板或混凝土才能有效屏蔽。' },
    { id: 2, title: '衡量辐射对人体生物效应的国际单位是什么？', type: 'single',
      options: [{ key: 'A', text: '贝可勒尔(Bq)' }, { key: 'B', text: '戈瑞(Gy)' }, { key: 'C', text: '希沃特(Sv)' }, { key: 'D', text: '居里(Ci)' }],
      answer: 'C', explanation: '希沃特(Sv)是有效剂量单位，用于衡量辐射对人体健康的影响。1 Sv = 1000 mSv = 1,000,000 μSv。' },
    { id: 3, title: '以下哪些是天然辐射来源？（多选）', type: 'multi',
      options: [{ key: 'A', text: '宇宙射线' }, { key: 'B', text: 'X 光检查' }, { key: 'C', text: '食物中的钾-40' }, { key: 'D', text: '砖石中的放射性元素' }],
      answer: 'A, C, D', explanation: '宇宙射线、食物中的钾-40、建筑材料中的放射性元素都是天然辐射来源。X光检查属于人工辐射源。' },
    { id: 4, title: '一张普通纸可以挡住哪种射线？', type: 'single',
      options: [{ key: 'A', text: 'α 射线' }, { key: 'B', text: 'β 射线' }, { key: 'C', text: 'γ 射线' }, { key: 'D', text: '以上都可以' }],
      answer: 'A', explanation: 'α 粒子质量大、带双正电荷，电离能力最强但穿透力最弱，一张纸或几厘米空气就能完全阻挡。' }
  ],
  nuclear: [
    { id: 1, title: '核电站利用的是哪种核反应？', type: 'single',
      options: [{ key: 'A', text: '核裂变' }, { key: 'B', text: '核聚变' }, { key: 'C', text: '放射性衰变' }, { key: 'D', text: '化学燃烧' }],
      answer: 'A', explanation: '目前全球所有商业核电站都利用核裂变（主要是铀-235的裂变）产生热量来发电。可控核聚变仍处于研究阶段。' },
    { id: 2, title: '核电站控制棒的主要材料是什么？', type: 'single',
      options: [{ key: 'A', text: '铁' }, { key: 'B', text: '镉或硼' }, { key: 'C', text: '铀' }, { key: 'D', text: '铅' }],
      answer: 'B', explanation: '控制棒使用能吸收中子的材料（如镉、硼、铪），通过调节插入反应堆的深度来控制链式反应的速率。' },
    { id: 3, title: '核电站反应堆中，重水的作用是什么？', type: 'single',
      options: [{ key: 'A', text: '慢化剂（减速中子）' }, { key: 'B', text: '核燃料' }, { key: 'C', text: '冷却液' }, { key: 'D', text: '防护屏蔽' }],
      answer: 'A', explanation: '重水(D₂O)作为慢化剂，能有效将快中子减速为热中子，从而提高裂变反应效率。重水堆（如CANDU堆）可以使用天然铀作燃料。' }
  ],
  protection: [
    { id: 1, title: '核电站设计中，"纵深防御"的含义是什么？', type: 'single',
      options: [{ key: 'A', text: '只有一层防护' }, { key: 'B', text: '多层独立安全屏障' }, { key: 'C', text: '深埋地下' }, { key: 'D', text: '远程控制操作' }],
      answer: 'B', explanation: '纵深防御是指设置多重独立的安全屏障，确保即使某一层防护失效，后续防护层仍能阻止事故发生或缓解事故后果。' },
    { id: 2, title: '对于γ射线，应使用以下哪种材料进行防护？', type: 'single',
      options: [{ key: 'A', text: '一张纸' }, { key: 'B', text: '铝板' }, { key: 'C', text: '铅板或厚混凝土' }, { key: 'D', text: '有机玻璃' }],
      answer: 'C', explanation: 'γ射线穿透力极强，需要使用高密度材料如铅板或厚混凝土墙进行屏蔽。屏蔽厚度取决于射线能量和所需的减弱倍数。' }
  ],
  history: [
    { id: 1, title: '切尔诺贝利核事故发生在哪一年？', type: 'single',
      options: [{ key: 'A', text: '1979年' }, { key: 'B', text: '1986年' }, { key: 'C', text: '2011年' }, { key: 'D', text: '1957年' }],
      answer: 'B', explanation: '1986年4月26日，切尔诺贝利核电站4号机组在测试中发生爆炸，是全球首例被评定为7级的核事故。' },
    { id: 2, title: '福岛核事故的直接原因是什么？', type: 'single',
      options: [{ key: 'A', text: '操作失误' }, { key: 'B', text: '地震海啸导致冷却失效' }, { key: 'C', text: '反应堆老化' }, { key: 'D', text: '恐怖袭击' }],
      answer: 'B', explanation: '2011年3月11日，9.0级大地震引发的巨大海啸淹没了应急电源系统，导致反应堆冷却功能丧失，最终造成堆芯熔毁。' }
  ]
}

// Flashcard data
const flashcardData = {
  radiation: [
    { question: 'α 射线的本质是什么？', answer: '氦原子核（2个质子+2个中子）', explanation: 'α 粒子质量大、带正电荷，电离能力强但穿透力弱，一张纸即可阻挡。' },
    { question: '什么是放射性半衰期？', answer: '放射性原子核数量减少一半所需的时间', explanation: '每种放射性同位素都有固定的半衰期，从微秒到数十亿年不等。' },
    { question: '天然本底辐射的主要来源？', answer: '宇宙射线、土壤和岩石、食物、氡气', explanation: '全球年均天然本底辐射约2.4 mSv，其中氡气贡献约一半。' }
  ],
  nuclear: [
    { question: '核裂变的定义？', answer: '重原子核分裂为两个中等质量核的过程', explanation: '铀-235吸收一个中子后分裂成两个碎片，释放2-3个中子和约200 MeV能量。' },
    { question: '链式反应是什么？', answer: '裂变产生的中子继续引发新裂变的持续过程', explanation: '可控链式反应是核电站的基础，通过控制中子数量来调节反应速率。' }
  ],
  protection: [
    { question: '辐射防护三原则？', answer: '正当性、最优化、剂量限值', explanation: '任何照射必须利大于弊；在合理可达到的范围内尽量低；不超过法定剂量限值。' },
    { question: '外照射防护三要素？', answer: '时间、距离、屏蔽', explanation: '缩短受照时间、增大与源的距离（剂量与距离平方成反比）、使用屏蔽材料。' }
  ],
  history: [
    { question: '世界上第一座核电站？', answer: '苏联奥布宁斯克核电站', explanation: '1954年建成发电，装机容量仅5MW，开启了人类和平利用核能的新纪元。' },
    { question: '中国大陆第一座核电站？', answer: '秦山核电站（浙江海盐）', explanation: '1991年12月15日首次并网发电，结束了中国大陆无核电的历史。' }
  ]
}

// Q&A computed
const questions = computed(() => questionData[currentTopic.value] || [])
const currentQuestion = computed(() => questions.value[currentIndex.value] || null)

// Flashcards computed
const flashcards = computed(() => flashcardData[currentTopic.value] || [])
const currentFlashcard = computed(() => flashcards.value[flashcardIndex.value] || null)

const hasSelection = computed(() => {
  if (!currentQuestion.value) return false
  if (currentQuestion.value.type === 'multi') return multiAnswers.value.length > 0
  return !!userAnswer.value
})

// Single select
function selectAnswer(key) {
  if (answered.value) return
  userAnswer.value = key
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

// Multi select
function toggleMultiAnswer(key) {
  if (answered.value) return
  const idx = multiAnswers.value.indexOf(key)
  if (idx >= 0) multiAnswers.value.splice(idx, 1)
  else multiAnswers.value.push(key)
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

function getOptionBadgeClass(key) {
  if (!answered.value) return 'bg-gray-100 text-gray-600'
  const correct = currentQuestion.value.answer?.split(',') || []
  const selected = currentQuestion.value.type === 'multi' ? multiAnswers.value : [userAnswer.value]
  if (correct.includes(key) && selected.includes(key)) return 'bg-green-500 text-white'
  if (correct.includes(key)) return 'bg-green-500 text-white'
  if (selected.includes(key)) return 'bg-red-500 text-white'
  return 'bg-gray-100 text-gray-400'
}

// Actions
function checkAnswer() {
  if (!currentQuestion.value) return
  answered.value = true

  const correct = currentQuestion.value.answer?.split(',') || []
  let userAns = currentQuestion.value.type === 'multi'
    ? [...multiAnswers.value].sort()
    : [userAnswer.value]

  const correctSorted = [...correct].sort()
  isCorrect.value = correctSorted.join(',') === userAns.join(',')
  if (isCorrect.value) correctCount.value++
}

function skipQuestion() {
  goToQuestion(currentIndex.value + 1)
}

function nextQuestion() {
  goToQuestion(currentIndex.value + 1)
}

function goToQuestion(index) {
  if (index >= questions.value.length) {
    practiceDone.value = true
    return
  }
  currentIndex.value = index
  userAnswer.value = ''
  multiAnswers.value = []
  answered.value = false
  isCorrect.value = false
}

function finishPractice() {
  practiceDone.value = true
}

function restartPractice() {
  currentIndex.value = 0
  correctCount.value = 0
  practiceDone.value = false
  userAnswer.value = ''
  multiAnswers.value = []
  answered.value = false
}

// Flashcard actions
function flipCard() {
  flipped.value = !flipped.value
}

function nextFlashcard() {
  if (flashcardIndex.value < flashcards.value.length - 1) {
    flashcardIndex.value++
    flipped.value = false
  }
}

function prevFlashcard() {
  if (flashcardIndex.value > 0) {
    flashcardIndex.value--
    flipped.value = false
  }
}
</script>
