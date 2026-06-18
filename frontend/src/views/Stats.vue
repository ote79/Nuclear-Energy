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
import { ElMessage } from 'element-plus'
import { getLearningStats, getQuizStats } from '../api/stats'

Chart.register(...registerables)

const loading = ref(false)
const learningChartRef = ref(null)
const quizChartRef = ref(null)
const records = ref([])

const statCards = ref([
  { label: '学习时长', value: '--', icon: 'Timer', color: '#1a73e8', bg: '#e8f0fe' },
  { label: '完成课程', value: '--', icon: 'VideoCamera', color: '#0d9488', bg: '#ccfbf1' },
  { label: '测验次数', value: '--', icon: 'Edit', color: '#f59e0b', bg: '#fef3c7' },
  { label: '平均正确率', value: '--', icon: 'TrendCharts', color: '#ef4444', bg: '#fee2e2' }
])

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

    if (lRes.status === 'rejected') {
      ElMessage.error(lRes.reason?.message || '获取学习统计失败')
    }
    if (qRes.status === 'rejected') {
      ElMessage.error(qRes.reason?.message || '获取测验统计失败')
    }

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
    records.value = lData?.records?.length ? lData.records : []

    await nextTick()
    renderCharts(
      lData?.chart || { labels: [], values: [] },
      qData?.chart || { labels: [], values: [] }
    )
  } catch (e) {
    ElMessage.error(e?.message || '加载统计数据失败')
    records.value = []
    await nextTick()
    renderCharts(
      { labels: [], values: [] },
      { labels: [], values: [] }
    )
  } finally {
    loading.value = false
  }
})
</script>
