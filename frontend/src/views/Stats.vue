<template>
  <div class="page-container py-8">
    <h1 class="text-3xl font-bold text-gray-800 mb-8">学习统计</h1>

    <div v-loading="loading" class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
      <div v-for="card in statCards" :key="card.label" class="bg-white rounded-xl p-5 shadow-sm">
        <div class="flex items-center gap-3 mb-2">
          <div class="w-10 h-10 rounded-lg flex items-center justify-center" :style="{ background: card.bg }">
            <el-icon :size="20" :color="card.color"><component :is="card.icon" /></el-icon>
          </div>
          <span class="text-sm text-gray-500">{{ card.label }}</span>
        </div>
        <div class="text-2xl font-bold text-gray-800">{{ card.value }}</div>
      </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <div class="bg-white rounded-xl p-6 shadow-sm">
        <h3 class="font-bold text-gray-800 mb-4">学习时长趋势</h3>
        <div class="h-64">
          <canvas ref="learningChartRef" />
        </div>
      </div>
      <div class="bg-white rounded-xl p-6 shadow-sm">
        <h3 class="font-bold text-gray-800 mb-4">测验正确率</h3>
        <div class="h-64">
          <canvas ref="quizChartRef" />
        </div>
      </div>
    </div>

    <!-- Recent records -->
    <div class="bg-white rounded-xl p-6 shadow-sm mt-6">
      <h3 class="font-bold text-gray-800 mb-4">最近学习记录</h3>
      <el-table :data="records" stripe>
        <el-table-column prop="title" label="课程/文章" />
        <el-table-column prop="type" label="类型" width="100">
          <template #default="{ row }">
            <el-tag :type="row.type === 'course' ? '' : 'warning'" size="small">
              {{ row.type === 'course' ? '课程' : '知识' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="progress" label="进度" width="120">
          <template #default="{ row }">
            <el-progress :percentage="row.progress" :stroke-width="6" />
          </template>
        </el-table-column>
        <el-table-column prop="updatedAt" label="最近学习" width="180" />
      </el-table>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick } from 'vue'
import { Chart, registerables } from 'chart.js'
import { getLearningStats, getQuizStats } from '../api/stats'

Chart.register(...registerables)

const loading = ref(false)
const learningChartRef = ref(null)
const quizChartRef = ref(null)
const records = ref([])

const statCards = ref([
  { label: '学习时长', value: '12 小时', icon: 'Timer', color: '#1a73e8', bg: '#e8f0fe' },
  { label: '完成课程', value: '3 门', icon: 'VideoCamera', color: '#0d9488', bg: '#ccfbf1' },
  { label: '测验次数', value: '8 次', icon: 'Edit', color: '#f59e0b', bg: '#fef3c7' },
  { label: '平均正确率', value: '78%', icon: 'TrendCharts', color: '#ef4444', bg: '#fee2e2' }
])

const mockRecords = [
  { title: '核能基础知识入门', type: 'course', progress: 100, updatedAt: '2026-06-02 14:30' },
  { title: '什么是核辐射', type: 'knowledge', progress: 100, updatedAt: '2026-06-01 10:20' },
  { title: '辐射防护与安全', type: 'course', progress: 60, updatedAt: '2026-05-30 16:45' },
  { title: '核电站安全知识测验', type: 'knowledge', progress: 100, updatedAt: '2026-05-28 09:15' }
]

let learningChart = null
let quizChart = null

function renderCharts(learningData, quizData) {
  if (learningChart) learningChart.destroy()
  if (quizChart) quizChart.destroy()

  if (learningChartRef.value) {
    learningChart = new Chart(learningChartRef.value, {
      type: 'line',
      data: {
        labels: learningData.labels || [],
        datasets: [{
          label: '学习时长(分钟)',
          data: learningData.values || [],
          borderColor: '#1a73e8',
          backgroundColor: 'rgba(26,115,232,0.1)',
          fill: true,
          tension: 0.4
        }]
      },
      options: { responsive: true, maintainAspectRatio: false }
    })
  }
  if (quizChartRef.value) {
    quizChart = new Chart(quizChartRef.value, {
      type: 'bar',
      data: {
        labels: quizData.labels || [],
        datasets: [{
          label: '正确率(%)',
          data: quizData.values || [],
          backgroundColor: '#0d9488',
          borderRadius: 6
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        scales: { y: { beginAtZero: true, max: 100 } }
      }
    })
  }
}

onMounted(async () => {
  loading.value = true
  try {
    const [lRes, qRes] = await Promise.allSettled([getLearningStats(), getQuizStats()])
    const lData = lRes.status === 'fulfilled' ? lRes.value.data : null
    const qData = qRes.status === 'fulfilled' ? qRes.value.data : null

    if (lData?.cards) {
      statCards.value[0].value = `${lData.cards.totalHours || 0} 小时`
      statCards.value[1].value = `${lData.cards.completedCourses || 0} 门`
    }
    if (qData?.cards) {
      statCards.value[2].value = `${qData.cards.totalAttempts || 0} 次`
      statCards.value[3].value = `${qData.cards.avgScore || 0}%`
    }
    records.value = lData?.records?.length ? lData.records : mockRecords

    await nextTick()
    renderCharts(
      lData?.chart || { labels: ['05-28', '05-29', '05-30', '05-31', '06-01', '06-02', '06-03'], values: [30, 45, 20, 60, 35, 50, 40] },
      qData?.chart || { labels: ['第1次', '第2次', '第3次', '第4次', '第5次'], values: [60, 72, 85, 78, 90] }
    )
  } catch {
    records.value = mockRecords
    await nextTick()
    renderCharts(
      { labels: ['05-28', '05-29', '05-30', '05-31', '06-01', '06-02', '06-03'], values: [30, 45, 20, 60, 35, 50, 40] },
      { labels: ['第1次', '第2次', '第3次', '第4次', '第5次'], values: [60, 72, 85, 78, 90] }
    )
  } finally {
    loading.value = false
  }
})
</script>
