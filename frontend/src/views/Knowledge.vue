<template>
  <div class="page-container py-8">
    <div class="mb-8">
      <h1 class="text-3xl font-bold text-gray-800 mb-2">科普知识</h1>
      <p class="text-gray-500">了解核能与辐射安全的基础知识</p>
    </div>

    <!-- Category filter -->
    <div class="flex flex-wrap gap-2 mb-6">
      <el-button :type="activeCategory === '' ? 'primary' : ''" @click="activeCategory = ''">全部</el-button>
      <el-button
        v-for="cat in categories"
        :key="cat.id"
        :type="activeCategory === cat.id ? 'primary' : ''"
        @click="activeCategory = cat.id"
      >
        {{ cat.name }}
      </el-button>
    </div>

    <!-- Search -->
    <el-input v-model="keyword" placeholder="搜索科普知识..." prefix-icon="Search" class="mb-6 max-w-md" clearable @input="handleSearch" />

    <!-- List -->
    <div v-loading="loading" class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div
        v-for="item in list"
        :key="item.id"
        class="bg-white rounded-xl overflow-hidden card-hover cursor-pointer"
        @click="$router.push(`/knowledge/${item.id}`)"
      >
        <div class="h-44 bg-gradient-to-br from-blue-400 to-blue-600 flex items-center justify-center">
          <el-icon :size="48" color="#fff"><Reading /></el-icon>
        </div>
        <div class="p-5">
          <div class="flex items-center gap-2 mb-2">
            <el-tag size="small">{{ item.categoryName }}</el-tag>
            <span class="text-xs text-gray-400">{{ item.createdAt?.slice(0, 10) }}</span>
          </div>
          <h3 class="text-lg font-bold text-gray-800 mb-1">{{ item.title }}</h3>
          <p class="text-sm text-gray-500 line-clamp-2">{{ item.summary }}</p>
        </div>
      </div>
    </div>

    <el-empty v-if="!loading && list.length === 0" description="暂无相关知识" />

    <div v-if="total > pageSize" class="mt-8 flex justify-center">
      <el-pagination v-model:current-page="page" :page-size="pageSize" :total="total" layout="prev, pager, next" @current-change="fetchData" />
    </div>
  </div>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue'
import { getKnowledgeList, getCategories } from '../api/knowledge'

const loading = ref(false)
const list = ref([])
const categories = ref([])
const page = ref(1)
const pageSize = 9
const total = ref(0)
const keyword = ref('')
const activeCategory = ref('')

const mockCategories = [
  { id: 1, name: '基础常识' },
  { id: 2, name: '核电原理' },
  { id: 3, name: '辐射防护' },
  { id: 4, name: '核能应用' }
]

const mockList = [
  { id: 1, title: '什么是核辐射', summary: '核辐射是指原子核从一种结构或能量状态转变为另一种结构或能量状态时释放出的微观粒子流。', categoryName: '基础常识', createdAt: '2026-06-01T00:00:00' },
  { id: 2, title: '核电站的工作原理', summary: '核电站利用核裂变反应产生的热能来加热水产生蒸汽，驱动汽轮机发电。', categoryName: '核电原理', createdAt: '2026-05-28T00:00:00' },
  { id: 3, title: '日常生活中的辐射', summary: '我们每天都暴露在各种自然辐射中，包括宇宙射线、土壤中的放射性物质等。', categoryName: '辐射防护', createdAt: '2026-05-25T00:00:00' },
  { id: 4, title: '核医学的应用', summary: '放射性同位素在医学诊断和治疗中发挥着重要作用，如PET扫描和放射性碘治疗。', categoryName: '核能应用', createdAt: '2026-05-20T00:00:00' },
  { id: 5, title: 'α、β、γ射线的区别', summary: '三种射线在穿透力、电离能力和防护方式上有显著差异。', categoryName: '基础常识', createdAt: '2026-05-18T00:00:00' },
  { id: 6, title: '核电站的安全防护体系', summary: '现代核电站采用多重安全屏障，确保辐射不会泄漏到环境中。', categoryName: '辐射防护', createdAt: '2026-05-15T00:00:00' }
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
    const res = await getKnowledgeList({
      page: page.value,
      pageSize,
      keyword: keyword.value,
      categoryId: activeCategory.value || undefined
    })
    list.value = res.data?.list || []
    total.value = res.data?.total || 0
  } catch {
    list.value = mockList
    total.value = mockList.length
  } finally {
    loading.value = false
  }
}

watch(activeCategory, () => {
  page.value = 1
  fetchData()
})

onMounted(async () => {
  try {
    const res = await getCategories()
    categories.value = res.data?.length ? res.data : mockCategories
  } catch {
    categories.value = mockCategories
  }
  fetchData()
})
</script>
