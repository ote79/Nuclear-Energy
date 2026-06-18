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
import { getCourseDetail } from '../api/course'

const route = useRoute()
const loading = ref(false)
const detail = ref(null)
const currentIndex = ref(0)

const mockDetail = {
  id: 1,
  title: '核能基础知识入门',
  description: '从原子结构到核裂变原理，系统讲解核能基础知识。',
  chapterCount: 4,
  duration: '2小时',
  chapters: [
    { id: 1, title: '第一章 原子结构与核物理基础', content: '<h2>原子的结构</h2><p>原子由原子核和电子组成。原子核位于原子中心，由质子和中子（统称核子）组成。原子核虽然体积极小，但集中了原子99.9%以上的质量。</p><h2>核力</h2><p>核力是将质子和中子结合在一起的力，它是一种短程力，作用范围约为10⁻¹⁵米。核力的特点是强度大、作用距离短、具有饱和性。</p><h2>放射性衰变</h2><p>不稳定的原子核会自发地发生衰变，释放出粒子或电磁辐射。常见的衰变类型包括α衰变、β衰变和γ衰变。</p>', completed: true },
    { id: 2, title: '第二章 核裂变与链式反应', content: '<h2>核裂变</h2><p>核裂变是指重原子核（如铀-235、钚-239）在中子轰击下分裂为两个或多个较轻原子核的过程。裂变过程中会释放出大量能量和2-3个中子。</p><h2>链式反应</h2><p>裂变产生的中子可以继续轰击其他原子核，引发新的裂变反应，形成链式反应。如果链式反应能够自持进行，就称为可控链式反应，这是核电站工作的基础。</p><h2>临界质量</h2><p>能够维持链式反应的最小裂变材料质量称为临界质量。临界质量的大小取决于材料种类、纯度和几何形状等因素。</p>', completed: false },
    { id: 3, title: '第三章 核电站的工作原理', content: '<h2>核电站的基本组成</h2><p>核电站主要由反应堆、蒸汽发生器、汽轮机和发电机组成。反应堆是核电站的核心，核裂变反应在这里进行。</p><h2>冷却系统</h2><p>反应堆产生的热量通过冷却剂（通常是水）传递到蒸汽发生器，产生高温高压蒸汽驱动汽轮机发电。</p><h2>控制棒</h2><p>控制棒由能够吸收中子的材料（如镉、硼）制成，通过调节控制棒插入反应堆的深度来控制链式反应的速率。</p>', completed: false },
    { id: 4, title: '第四章 核能的安全与防护', content: '<h2>三道安全屏障</h2><p>现代核电站设有三道安全屏障：燃料包壳、反应堆压力容器和安全壳。这三道屏障确保放射性物质不会泄漏到环境中。</p><h2>纵深防御</h2><p>核安全采用纵深防御原则，通过多层防护措施确保即使某一层防护失效，后续防护层仍能阻止事故扩大。</p><h2>应急响应</h2><p>核电站制定有完善的应急响应计划，包括场内应急和场外应急，确保在异常情况下能够快速有效地保护公众安全。</p>', completed: false }
  ]
}

const currentChapter = computed(() => detail.value?.chapters?.[currentIndex.value])

const progress = computed(() => {
  if (!detail.value?.chapters?.length) return 0
  const done = detail.value.chapters.filter(c => c.completed).length
  return Math.round((done / detail.value.chapters.length) * 100)
})

function selectChapter(index) {
  currentIndex.value = index
}

onMounted(async () => {
  loading.value = true
  try {
    const res = await getCourseDetail(route.params.id)
    detail.value = res.data
  } catch {
    detail.value = mockDetail
  } finally {
    loading.value = false
  }
})
</script>
