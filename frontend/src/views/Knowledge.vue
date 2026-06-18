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
import { ElMessage } from 'element-plus'
import { getKnowledgeList, getCategories } from '../api/knowledge'

const loading = ref(false)
const list = ref([])
const categories = ref([])
const page = ref(1)
const pageSize = 9
const total = ref(0)
const keyword = ref('')
const activeCategory = ref('')

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
  } catch (e) {
    list.value = []
    total.value = 0
    ElMessage.error(e?.response?.data?.message || '获取知识列表失败')
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
    categories.value = res.data?.length ? res.data : []
  } catch (e) {
    categories.value = []
    ElMessage.error(e?.response?.data?.message || '获取分类列表失败')
  }
  fetchData()
})
</script>
