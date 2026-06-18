<template>
  <div class="page-container py-8">
    <div class="mb-8">
      <h1 class="text-3xl font-bold text-gray-800 mb-2">在线课程</h1>
      <p class="text-gray-500">专业的核能科普视频课程，系统学习</p>
    </div>

    <el-input v-model="keyword" placeholder="搜索课程..." prefix-icon="Search" class="mb-6 max-w-md" clearable @input="handleSearch" />

    <div v-loading="loading" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      <div
        v-for="item in list"
        :key="item.id"
        class="bg-white rounded-xl p-6 card-hover cursor-pointer"
        @click="$router.push(`/course/${item.id}`)"
      >
        <div class="w-14 h-14 rounded-xl bg-green-50 flex items-center justify-center mb-4">
          <el-icon :size="28" color="#0d9488"><VideoCamera /></el-icon>
        </div>
        <h3 class="text-lg font-bold text-gray-800 mb-2">{{ item.title }}</h3>
        <p class="text-sm text-gray-500 mb-4 line-clamp-2">{{ item.description }}</p>
        <div class="flex items-center justify-between text-sm text-gray-400 mb-3">
          <span>{{ item.chapterCount }} 章节</span>
          <span>{{ item.duration }}</span>
        </div>
        <el-progress :percentage="item.progress || 0" :stroke-width="8" />
      </div>
    </div>

    <el-empty v-if="!loading && list.length === 0" description="暂无课程" />

    <div v-if="total > pageSize" class="mt-8 flex justify-center">
      <el-pagination v-model:current-page="page" :page-size="pageSize" :total="total" layout="prev, pager, next" @current-change="fetchData" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getCourseList } from '../api/course'

const loading = ref(false)
const list = ref([])
const page = ref(1)
const pageSize = 9
const total = ref(0)
const keyword = ref('')

const mockList = [
  { id: 1, title: '核能基础知识入门', description: '从原子结构到核裂变原理，系统讲解核能基础知识。', chapterCount: 10, duration: '5小时30分', progress: 0 },
  { id: 2, title: '辐射防护与安全', description: '了解各类辐射的防护措施和安全操作规范。', chapterCount: 8, duration: '4小时', progress: 0 },
  { id: 3, title: '核电站运行原理', description: '深入学习核电站各系统的工作原理和运行机制。', chapterCount: 12, duration: '6小时', progress: 0 },
  { id: 4, title: '核能与环境保护', description: '探讨核能发电对环境的影响及可持续发展。', chapterCount: 6, duration: '3小时', progress: 0 },
  { id: 5, title: '核技术在医疗中的应用', description: '放射性同位素在诊断和治疗中的应用。', chapterCount: 7, duration: '3小时30分', progress: 0 },
  { id: 6, title: '世界核电发展历程', description: '从第一座核电站到第四代核能系统的演进。', chapterCount: 9, duration: '4小时30分', progress: 0 }
]

let searchTimer = null

function handleSearch() {
  clearTimeout(searchTimer)
  searchTimer = setTimeout(() => {
    page.value = 1
    fetchData()
  }, 300)
}

async function fetchData() {
  loading.value = true
  try {
    const res = await getCourseList({ page: page.value, pageSize, keyword: keyword.value })
    list.value = res.data?.list || []
    total.value = res.data?.total || 0
  } catch {
    list.value = mockList
    total.value = mockList.length
  } finally {
    loading.value = false
  }
}

onMounted(() => fetchData())
</script>
