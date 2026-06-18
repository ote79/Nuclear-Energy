<template>
  <div class="page-container py-8">
    <el-button text class="mb-4" @click="$router.push('/knowledge')">← 返回列表</el-button>

    <div v-loading="loading">
      <article v-if="detail" class="bg-white rounded-xl p-8 shadow-sm max-w-3xl mx-auto">
        <div class="flex items-center gap-3 mb-4">
          <el-tag>{{ detail.categoryName }}</el-tag>
          <span class="text-sm text-gray-400">{{ detail.createdAt?.slice(0, 10) }}</span>
        </div>
        <h1 class="text-3xl font-bold text-gray-800 mb-6">{{ detail.title }}</h1>
        <div class="prose max-w-none text-gray-700 leading-relaxed" v-html="detail.content" />
      </article>
      <el-empty v-if="!loading && !detail" description="文章不存在" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { useRoute } from 'vue-router'
import { getKnowledgeDetail } from '../api/knowledge'

const route = useRoute()
const loading = ref(false)
const detail = ref(null)

onMounted(async () => {
  loading.value = true
  try {
    const res = await getKnowledgeDetail(route.params.id)
    detail.value = res.data
  } catch (e) {
    detail.value = null
    ElMessage.error(e?.response?.data?.message || '获取文章详情失败')
  } finally {
    loading.value = false
  }
})
</script>
