<template>
  <div class="page-container py-8">
    <div class="mb-8">
      <h1 class="text-3xl font-bold text-gray-800 mb-2">知识测验</h1>
      <p class="text-gray-500">通过测验巩固所学知识，检验学习成果</p>
    </div>

    <!-- 错题重练入口 -->
    <div class="bg-gradient-to-r from-orange-50 to-red-50 rounded-xl border border-orange-200 p-5 mb-6 flex flex-wrap items-center justify-between gap-4">
      <div class="flex items-center gap-4">
        <div class="w-12 h-12 rounded-xl bg-orange-100 flex items-center justify-center flex-shrink-0">
          <el-icon :size="24" color="#f97316"><RefreshRight /></el-icon>
        </div>
        <div>
          <h3 class="font-bold text-gray-800">错题重练</h3>
          <p class="text-sm text-gray-500">
            错题库共 <strong class="text-orange-500">{{ wrongCount }}</strong> 题 · 来自各次测验的累积错题
          </p>
        </div>
      </div>
      <el-button type="warning" size="large" :disabled="wrongCount === 0" @click="$router.push('/wrong-practice')">
        开始重练 ({{ wrongCount }}题)
      </el-button>
    </div>

    <div v-loading="loading" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <div
        v-for="item in list"
        :key="item.id"
        class="bg-white rounded-xl p-6 card-hover cursor-pointer"
        @click="$router.push(`/quiz/${item.id}`)"
      >
        <div class="w-14 h-14 rounded-xl bg-amber-50 flex items-center justify-center mb-4">
          <el-icon :size="28" color="#f59e0b"><Edit /></el-icon>
        </div>
        <h3 class="text-lg font-bold text-gray-800 mb-2">{{ item.title }}</h3>
        <p class="text-sm text-gray-500 mb-4">{{ item.description }}</p>
        <div class="flex items-center justify-between text-sm text-gray-400">
          <span>{{ item.questionCount }} 题</span>
          <span>限时 {{ item.timeLimit }} 分钟</span>
        </div>
        <div v-if="item.bestScore !== undefined" class="mt-3">
          <el-tag :type="item.bestScore >= 60 ? 'success' : 'danger'" size="small">最高分: {{ item.bestScore }}</el-tag>
        </div>
      </div>
    </div>

    <el-empty v-if="!loading && list.length === 0" description="暂无测验" />

    <div v-if="total > pageSize" class="mt-8 flex justify-center">
      <el-pagination v-model:current-page="page" :page-size="pageSize" :total="total" layout="prev, pager, next" @current-change="fetchData" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { getQuizList, getWrongQuestions } from '../api/quiz'

const loading = ref(false)
const wrongCount = ref(0)
const list = ref([])
const page = ref(1)
const pageSize = 9
const total = ref(0)

async function fetchData() {
  loading.value = true
  try {
    const res = await getQuizList({ page: page.value, pageSize })
    list.value = res.data?.list || []
    total.value = res.data?.total || 0
  } catch (e) {
    list.value = []
    total.value = 0
    ElMessage.error(e.message || '加载测验失败')
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchData()
  // 获取错题数（失败不提示）
  getWrongQuestions({ page: 1, pageSize: 1 }).then(r => {
    wrongCount.value = r.data?.total || 0
  }).catch(() => {})
})
</script>
