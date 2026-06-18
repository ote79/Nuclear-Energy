<template>
  <div class="page-container py-8">
    <el-button text class="mb-4" @click="$router.push('/course')">← 返回课程列表</el-button>

    <div v-loading="loading">
      <template v-if="detail">
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
          <!-- Main content -->
          <div class="lg:col-span-2">
            <div class="bg-white rounded-xl p-6 shadow-sm mb-6">
              <h1 class="text-2xl font-bold text-gray-800 mb-2">{{ detail.title }}</h1>
              <p class="text-gray-500 mb-4">{{ detail.description }}</p>
              <div class="flex gap-4 text-sm text-gray-400">
                <span>{{ detail.chapterCount }} 章节</span>
                <span>{{ detail.duration }}</span>
              </div>
            </div>

            <!-- Video player placeholder -->
            <div class="bg-black rounded-xl aspect-video flex items-center justify-center mb-6">
              <div class="text-center text-white">
                <el-icon :size="64"><VideoCamera /></el-icon>
                <p class="mt-2">课程视频播放区域</p>
                <p class="text-sm text-gray-400 mt-1">{{ currentChapter?.title || '请选择章节' }}</p>
              </div>
            </div>

            <!-- Chapter content -->
            <div v-if="currentChapter" class="bg-white rounded-xl p-6 shadow-sm">
              <h2 class="text-xl font-bold text-gray-800 mb-4">{{ currentChapter.title }}</h2>
              <div class="prose max-w-none text-gray-700" v-html="currentChapter.content" />
            </div>
          </div>

          <!-- Sidebar: chapter list -->
          <div>
            <div class="bg-white rounded-xl p-5 shadow-sm sticky top-20">
              <h3 class="font-bold text-gray-800 mb-4">课程目录</h3>
              <div class="space-y-2">
                <div
                  v-for="(chapter, index) in detail.chapters"
                  :key="chapter.id"
                  class="flex items-center gap-3 p-3 rounded-lg cursor-pointer transition-colors"
                  :class="currentIndex === index ? 'bg-blue-50 text-nuclear-blue' : 'hover:bg-gray-50'"
                  @click="selectChapter(index)"
                >
                  <span
                    class="w-6 h-6 rounded-full flex items-center justify-center text-xs font-medium"
                    :class="chapter.completed ? 'bg-green-500 text-white' : 'bg-gray-200 text-gray-600'"
                  >
                    {{ chapter.completed ? '✓' : index + 1 }}
                  </span>
                  <span class="text-sm">{{ chapter.title }}</span>
                </div>
              </div>
              <el-divider />
              <el-progress :percentage="progress" :stroke-width="10" />
              <p class="text-xs text-gray-400 mt-2 text-center">学习进度 {{ progress }}%</p>
            </div>
          </div>
        </div>
      </template>
      <el-empty v-if="!loading && !detail" description="课程不存在" />
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getCourseDetail, submitProgress } from '../api/course'

const route = useRoute()
const loading = ref(false)
const detail = ref(null)
const currentIndex = ref(0)

const currentChapter = computed(() => detail.value?.chapters?.[currentIndex.value])

const progress = computed(() => {
  if (!detail.value?.chapters?.length) return 0
  const done = detail.value.chapters.filter(c => c.completed).length
  return Math.round((done / detail.value.chapters.length) * 100)
})

function selectChapter(index) {
  currentIndex.value = index
  // 标记当前章节已完成
  if (detail.value?.chapters?.[index]) {
    detail.value.chapters[index].completed = true
  }
  // 同步进度到后端（静默，失败不影响前端体验）
  const courseId = Number(route.params.id)
  const chapter = detail.value?.chapters?.[index]
  if (courseId && chapter?.id) {
    submitProgress({ courseId, chapterId: chapter.id, progress: 100 }).catch(() => {})
  }
}

onMounted(async () => {
  loading.value = true
  try {
    const res = await getCourseDetail(route.params.id)
    detail.value = res.data
  } catch (e) {
    ElMessage.error(e?.message || '获取课程详情失败')
  } finally {
    loading.value = false
  }
})
</script>
