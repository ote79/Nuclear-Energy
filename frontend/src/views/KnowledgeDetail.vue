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
import { useRoute } from 'vue-router'
import { getKnowledgeDetail } from '../api/knowledge'

const route = useRoute()
const loading = ref(false)
const detail = ref(null)

const mockDetail = {
  id: 1,
  title: '什么是核辐射',
  categoryName: '基础常识',
  createdAt: '2026-06-01T00:00:00',
  content: `
    <h2>核辐射的定义</h2>
    <p>核辐射是指原子核从一种结构或能量状态转变为另一种结构或能量状态时释放出的微观粒子流。这些粒子包括α粒子、β粒子、γ射线和中子等。</p>
    <h2>三种主要射线</h2>
    <h3>α射线（阿尔法射线）</h3>
    <p>α射线由两个质子和两个中子组成，也就是氦原子核。它的电离能力最强，但穿透力最弱，一张纸就能挡住。</p>
    <h3>β射线（贝塔射线）</h3>
    <p>β射线是高速运动的电子流。它的穿透力比α射线强，需要几毫米厚的铝板才能阻挡。</p>
    <h3>γ射线（伽马射线）</h3>
    <p>γ射线是高能电磁波，穿透力最强，需要厚实的铅板或混凝土才能有效屏蔽。</p>
    <h2>辐射的来源</h2>
    <p>辐射无处不在。我们每天都会接触到天然本底辐射，包括宇宙射线、土壤和岩石中的放射性物质、食物中的放射性元素等。此外，医疗检查（如X光）、核能发电等也会产生人工辐射。</p>
    <h2>辐射的单位</h2>
    <p>衡量辐射的常用单位包括：</p>
    <ul>
      <li><strong>贝可勒尔（Bq）</strong>：放射性活度单位</li>
      <li><strong>戈瑞（Gy）</strong>：吸收剂量单位</li>
      <li><strong>希沃特（Sv）</strong>：有效剂量单位，衡量辐射对人体的影响</li>
    </ul>
    <h2>日常生活中的辐射量</h2>
    <p>一次胸透X光检查约0.02毫希沃特，一次胸部CT约7毫希沃特，而每年的天然本底辐射约2.4毫希沃特。低于100毫希沃特的辐射剂量通常不会对人体造成明显的健康影响。</p>
  `
}

onMounted(async () => {
  loading.value = true
  try {
    const res = await getKnowledgeDetail(route.params.id)
    detail.value = res.data
  } catch {
    detail.value = mockDetail
  } finally {
    loading.value = false
  }
})
</script>
