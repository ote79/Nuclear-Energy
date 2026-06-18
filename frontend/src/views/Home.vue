<template>
  <div class="min-h-screen bg-gray-50">
    <!-- === 1. Hero Banner 渐变科技风 === -->
    <section class="relative overflow-hidden" style="background: linear-gradient(135deg, #0d9488 0%, #0891b2 15%, #2563eb 40%, #1e40af 65%, #1e3a5f 100%);">
      <!-- 网格纹理 -->
      <div class="absolute inset-0 opacity-[0.06]" style="background-image: linear-gradient(rgba(255,255,255,0.8) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.8) 1px, transparent 1px); background-size: 50px 50px;" />
      <!-- 几何装饰圆环 -->
      <div class="absolute -top-40 -right-40 w-[32rem] h-[32rem] rounded-full border-2 border-white/10" />
      <div class="absolute -top-20 -right-20 w-96 h-96 rounded-full border border-white/10" />
      <div class="absolute top-1/3 -right-16 w-72 h-72 rounded-full border border-white/8" />
      <div class="absolute -bottom-60 -left-32 w-[40rem] h-[40rem] rounded-full border border-white/5" />
      <div class="absolute bottom-1/4 -left-16 w-64 h-64 rounded-full border border-white/8" />
      <!-- 大光晕 -->
      <div class="absolute -top-20 left-1/4 w-80 h-80 rounded-full bg-white/5 blur-3xl" />
      <div class="absolute top-1/2 -right-10 w-60 h-60 rounded-full bg-cyan-300/10 blur-3xl" />
      <!-- 脉冲光点 -->
      <div class="absolute top-16 right-1/4 w-2 h-2 rounded-full bg-white/40 animate-pulse-glow" />
      <div class="absolute top-1/3 right-1/3 w-3 h-3 rounded-full bg-white/30 animate-pulse-glow" style="animation-delay: 0.7s" />
      <div class="absolute bottom-28 left-1/3 w-2 h-2 rounded-full bg-white/30 animate-pulse-glow" style="animation-delay: 1.4s" />
      <div class="absolute bottom-40 left-[60%] w-3 h-3 rounded-full bg-cyan-300/40 animate-pulse-glow" style="animation-delay: 0.3s" />

      <div class="page-container py-20 relative z-10">
        <div class="flex flex-col lg:flex-row items-center gap-10">
          <div class="flex-1 text-center lg:text-left">
            <h1 class="text-3xl md:text-4xl lg:text-5xl font-bold text-white mb-4 leading-tight tracking-wide">
              核能科普知识平台
            </h1>
            <p class="text-base md:text-lg text-white/75 max-w-lg leading-relaxed">
              正确认识核能技术，了解辐射防护知识<br />做科学理性的现代公民
            </p>
          </div>
          <div class="hidden lg:block flex-shrink-0">
            <div class="relative">
              <div class="w-64 h-64 rounded-full bg-white/8 backdrop-blur flex items-center justify-center border border-white/15">
                <el-icon :size="88" color="rgba(255,255,255,0.9)"><Sunny /></el-icon>
              </div>
              <!-- 绕转小点 -->
              <div class="absolute top-0 left-1/2 -translate-x-1/2 -translate-y-1/2 w-3 h-3 rounded-full bg-cyan-300/60" />
              <div class="absolute bottom-0 left-1/2 -translate-x-1/2 translate-y-1/2 w-2 h-2 rounded-full bg-blue-300/60" />
              <div class="absolute top-1/2 right-0 translate-x-1/2 -translate-y-1/2 w-2 h-2 rounded-full bg-teal-300/60" />
              <div class="absolute top-1/2 left-0 -translate-x-1/2 -translate-y-1/2 w-2 h-2 rounded-full bg-sky-300/60" />
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- === 2. 核辐射监测站 === -->
    <section class="page-container pt-8 pb-4">
      <div class="flex items-center justify-between mb-1">
        <h2 class="text-lg font-bold text-gray-800">核辐射监测站</h2>
        <el-button text type="primary" size="small" @click="showAllFacilities = true">查看全部</el-button>
      </div>
      <p class="text-sm text-gray-400 mb-5">全球主要核设施实时坐标与资讯</p>
      <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-3">
        <div
          v-for="fac in facilities"
          :key="fac.id"
          class="bg-white rounded-xl border border-gray-100 hover:shadow-lg hover:border-teal-200 transition-all overflow-hidden cursor-pointer group"
          @click="openFacilityDetail(fac)"
        >
          <!-- 图片区域 -->
          <div class="h-28 relative overflow-hidden" :style="{ background: fac.gradient }">
            <div class="absolute inset-0 flex items-center justify-center">
              <div class="text-white/60 text-center">
                <el-icon :size="32"><Location /></el-icon>
              </div>
            </div>
            <div class="absolute top-2 right-2">
              <el-tag :type="fac.statusTag" size="small" effect="dark" round>{{ fac.statusLabel }}</el-tag>
            </div>
            <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/70 to-transparent p-2">
              <h4 class="text-white font-bold text-sm truncate">{{ fac.name }}</h4>
            </div>
          </div>
          <!-- 坐标信息 -->
          <div class="p-3">
            <div class="flex items-center gap-1 text-xs text-gray-400 mb-2">
              <el-icon :size="12"><Position /></el-icon>
              <span class="truncate">{{ fac.coord }}</span>
            </div>
            <div class="flex gap-1">
              <el-button size="small" text type="primary" class="!text-xs !px-1" @click.stop="openSatellite(fac)">
                <el-icon :size="12"><Link /></el-icon> 高德卫星图
              </el-button>
              <el-button size="small" text type="warning" class="!text-xs !px-1" @click.stop="openFacilityNews(fac)">
                <el-icon :size="12"><Reading /></el-icon> 新闻
              </el-button>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 设施详情弹窗 -->
    <el-dialog v-model="facilityDialog" :title="selectedFacility?.name" width="560px" destroy-on-close>
      <template v-if="selectedFacility">
        <div class="rounded-xl overflow-hidden mb-4 h-40" :style="{ background: selectedFacility.gradient }">
          <div class="h-full flex items-center justify-center">
            <el-icon :size="56" color="rgba(255,255,255,0.3)"><Location /></el-icon>
          </div>
        </div>
        <div class="flex items-center gap-3 mb-3">
          <el-tag :type="selectedFacility.statusTag" size="small">{{ selectedFacility.statusLabel }}</el-tag>
          <span class="text-sm text-gray-400"><el-icon :size="14"><Position /></el-icon> {{ selectedFacility.coord }}</span>
        </div>
        <p class="text-gray-600 leading-relaxed mb-4 text-sm">{{ selectedFacility.detail }}</p>
        <div class="flex gap-2">
          <el-button type="primary" @click="openMap(selectedFacility, 'amap')">
            <el-icon><Location /></el-icon> 高德卫星图
          </el-button>
          <el-button @click="openMap(selectedFacility, 'baidu')">
            <el-icon><Link /></el-icon> 百度地图
          </el-button>
          <el-button @click="openFacilityNews(selectedFacility)">
            <el-icon><Reading /></el-icon> 相关新闻
          </el-button>
        </div>
      </template>
    </el-dialog>

    <!-- === 3. 学习概览 === -->
    <section class="page-container py-8">
      <h2 class="text-lg font-bold text-gray-800 mb-1">学习概览</h2>
      <p class="text-sm text-gray-400 mb-5">知识掌握情况与辐射剂量统计</p>
      <div class="grid grid-cols-2 lg:grid-cols-4 gap-4">
        <div class="bg-white rounded-xl p-5 border border-gray-100 hover:shadow-md transition-all cursor-default">
          <div class="flex items-center justify-between mb-3">
            <span class="text-sm text-gray-400">学习进度</span>
            <div class="w-8 h-8 rounded-lg bg-teal-50 flex items-center justify-center">
              <el-icon :size="18" color="#14b8a6"><TrendCharts /></el-icon>
            </div>
          </div>
          <div class="text-[28px] font-bold text-gray-800 mb-3">65%</div>
          <el-progress :percentage="65" :stroke-width="8" color="#14b8a6" :show-text="false" />
          <div class="text-xs text-gray-400 mt-2">已完成 8/12 课程</div>
        </div>

        <div class="bg-white rounded-xl p-5 border border-gray-100 hover:shadow-md transition-all cursor-default">
          <div class="flex items-center justify-between mb-3">
            <span class="text-sm text-gray-400">累计剂量</span>
            <div class="w-8 h-8 rounded-lg bg-orange-50 flex items-center justify-center">
              <el-icon :size="18" color="#f97316"><WarningFilled /></el-icon>
            </div>
          </div>
          <div class="text-[28px] font-bold text-gray-800 mb-3">120 <span class="text-sm font-normal text-gray-400">mSv</span></div>
          <div class="h-2 bg-gray-100 rounded-full overflow-hidden">
            <div class="h-full bg-gradient-to-r from-green-400 via-yellow-400 to-red-500 rounded-full" style="width: 12%" />
          </div>
          <div class="text-xs text-gray-400 mt-2">远低于安全阈值 1000 mSv</div>
        </div>

        <div class="bg-white rounded-xl p-5 border border-gray-100 hover:shadow-md transition-all cursor-default">
          <div class="flex items-center justify-between mb-3">
            <span class="text-sm text-gray-400">等效香蕉数</span>
            <div class="w-8 h-8 rounded-lg bg-yellow-50 flex items-center justify-center">
              <el-icon :size="18" color="#eab308"><Apple /></el-icon>
            </div>
          </div>
          <div class="text-[28px] font-bold text-gray-800 mb-3">12,000</div>
          <div class="text-xs text-gray-400">约 1,200 公斤 🍌</div>
          <div class="text-xs text-teal-500 mt-1">等效辐射剂量参考</div>
        </div>

        <div class="bg-white rounded-xl p-5 border border-gray-100 hover:shadow-md transition-all cursor-default">
          <div class="flex items-center justify-between mb-3">
            <span class="text-sm text-gray-400">背景辐射</span>
            <div class="w-8 h-8 rounded-lg bg-blue-50 flex items-center justify-center">
              <el-icon :size="18" color="#3b82f6"><Sunny /></el-icon>
            </div>
          </div>
          <div class="text-[28px] font-bold text-gray-800 mb-3">2.4 <span class="text-sm font-normal text-gray-400">mSv/年</span></div>
          <div class="h-2 bg-gray-100 rounded-full overflow-hidden">
            <div class="h-full bg-blue-400 rounded-full" style="width: 3%" />
          </div>
          <div class="text-xs text-gray-400 mt-2">全球年均天然辐射水平</div>
        </div>
      </div>
    </section>

    <!-- === 3. 辐射剂量对比图 === -->
    <section class="page-container pb-8">
      <div class="bg-white rounded-xl p-6 border border-gray-100">
        <h2 class="text-lg font-bold text-gray-800 mb-1">剂量统计</h2>
        <p class="text-sm text-gray-400 mb-5">不同场景辐射剂量直观对比</p>
        <div class="space-y-3">
          <div v-for="item in radiationData" :key="item.name">
            <div class="flex items-end gap-3 mb-1">
              <span class="text-sm text-gray-600 w-24 flex-shrink-0 text-right">{{ item.name }}</span>
              <div class="flex-1 bg-gray-100 rounded-full h-7 relative overflow-hidden">
                <div class="h-7 rounded-full flex items-center px-3 text-xs text-white font-medium min-w-[60px] tracking-wide" :style="{ width: Math.max(item.width, 3) + '%', background: item.color }">
                  {{ item.dose }}
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="mt-5 pt-4 border-t border-gray-100 flex items-center justify-between text-xs text-gray-400">
          <span>数据来源：WHO / ICRP</span>
          <span>μSv = 微希沃特  mSv = 毫希沃特  Sv = 希沃特</span>
        </div>
      </div>
    </section>

    <!-- === 4. 互动练习 === -->
    <section class="page-container pb-8">
      <div class="flex items-center justify-between mb-1">
        <h2 class="text-lg font-bold text-gray-800">互动练习</h2>
        <el-button text type="primary" @click="$router.push('/practice')">更多练习 →</el-button>
      </div>
      <p class="text-sm text-gray-400 mb-5">巩固所学知识，检验学习成果</p>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div
          class="bg-white rounded-xl border border-gray-100 hover:shadow-md transition-all p-5 cursor-pointer group"
          @click="$router.push('/practice')"
        >
          <div class="flex items-start gap-4">
            <div class="w-12 h-12 rounded-xl bg-teal-50 flex items-center justify-center flex-shrink-0">
              <el-icon :size="24" color="#14b8a6"><Edit /></el-icon>
            </div>
            <div class="flex-1 min-w-0">
              <h4 class="font-bold text-gray-800 mb-1 group-hover:text-teal-600 transition-colors">核辐射基础</h4>
              <p class="text-sm text-gray-400 mb-3">检验核辐射基本概念和防护知识</p>
              <div class="flex items-center gap-3 text-xs text-gray-400">
                <span>20 题</span>
                <span>·</span>
                <span>限时 30 分钟</span>
                <span class="text-teal-500 font-medium ml-auto">去答题 →</span>
              </div>
            </div>
          </div>
        </div>
        <div
          class="bg-white rounded-xl border border-gray-100 hover:shadow-md transition-all p-5 cursor-pointer group"
          @click="$router.push('/practice')"
        >
          <div class="flex items-start gap-4">
            <div class="w-12 h-12 rounded-xl bg-blue-50 flex items-center justify-center flex-shrink-0">
              <el-icon :size="24" color="#3b82f6"><Search /></el-icon>
            </div>
            <div class="flex-1 min-w-0">
              <h4 class="font-bold text-gray-800 mb-1 group-hover:text-teal-600 transition-colors">核电站安全</h4>
              <p class="text-sm text-gray-400 mb-3">核电站安全防护体系知识测验</p>
              <div class="flex items-center gap-3 text-xs text-gray-400">
                <span>15 题</span>
                <span>·</span>
                <span>限时 20 分钟</span>
                <span class="text-teal-500 font-medium ml-auto">去答题 →</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- === 5. 推荐课程 === -->
    <section class="page-container pb-8">
      <div class="flex items-center justify-between mb-1">
        <h2 class="text-lg font-bold text-gray-800">推荐课程</h2>
        <el-button text type="primary" @click="$router.push('/course')">查看全部 →</el-button>
      </div>
      <p class="text-sm text-gray-400 mb-5">精选核能科普视频课程</p>
      <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div
          v-for="course in courseCards"
          :key="course.id"
          class="bg-white rounded-xl border border-gray-100 hover:shadow-md transition-all overflow-hidden group cursor-pointer"
          @click="$router.push(`/course/${course.id}`)"
        >
          <div class="h-36 relative overflow-hidden" :style="{ background: course.gradient }">
            <div class="absolute inset-0 flex items-center justify-center">
              <el-icon :size="48" color="rgba(255,255,255,0.6)"><VideoCamera /></el-icon>
            </div>
            <div class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/60 to-transparent p-3">
              <el-tag :type="course.tagType" size="small" effect="dark">{{ course.tag }}</el-tag>
            </div>
          </div>
          <div class="p-4">
            <h4 class="font-bold text-gray-800 mb-1 group-hover:text-teal-600 transition-colors">{{ course.title }}</h4>
            <p class="text-sm text-gray-400 mb-3 line-clamp-2">{{ course.desc }}</p>
            <div class="flex items-center justify-between">
              <div class="flex items-center gap-3 text-xs text-gray-400">
                <span><el-icon :size="14"><VideoCamera /></el-icon> {{ course.chapterCount }} 章节</span>
                <span><el-icon :size="14"><Clock /></el-icon> {{ course.duration }}</span>
              </div>
              <el-button size="small" type="primary" text>开始学习</el-button>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- === 5. 快捷工具 + 排行榜 === -->
    <section class="page-container pb-8">
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <!-- 快捷工具 -->
        <div class="bg-white rounded-xl p-6 border border-gray-100">
          <h2 class="text-lg font-bold text-gray-800 mb-1">快捷工具</h2>
          <p class="text-sm text-gray-400 mb-5">常用功能快速入口</p>
          <div class="grid grid-cols-2 gap-3">
            <div
              v-for="tool in quickTools"
              :key="tool.label"
              class="flex items-center gap-3 p-4 rounded-xl bg-gray-50 hover:bg-teal-50 cursor-pointer transition-colors group"
              @click="$router.push(tool.path)"
            >
              <div class="w-10 h-10 rounded-xl flex items-center justify-center flex-shrink-0" :style="{ background: tool.bg }">
                <el-icon :size="22" :color="tool.color"><component :is="tool.icon" /></el-icon>
              </div>
              <div class="flex-1 min-w-0">
                <div class="font-bold text-gray-800 text-sm group-hover:text-teal-600 transition-colors">{{ tool.label }}</div>
                <div class="text-xs text-gray-400">{{ tool.desc }}</div>
              </div>
              <el-icon class="text-gray-300 group-hover:text-teal-500 transition-colors" :size="16"><ArrowRight /></el-icon>
            </div>
          </div>
        </div>

        <!-- 学习排行榜 -->
        <div class="bg-white rounded-xl p-6 border border-gray-100">
          <h2 class="text-lg font-bold text-gray-800 mb-1">学习排行榜</h2>
          <p class="text-sm text-gray-400 mb-5">本周学习积分排名</p>
          <div class="space-y-3">
            <div
              v-for="user in leaderboard"
              :key="user.name"
              class="flex items-center gap-3 p-3 rounded-xl hover:bg-gray-50 transition-colors"
            >
              <div class="w-8 h-8 rounded-full flex items-center justify-center font-bold text-sm flex-shrink-0" :class="user.rankClass">
                {{ user.rank }}
              </div>
              <el-avatar :size="36" :style="{ background: user.avatarBg }">
                {{ user.name[0] }}
              </el-avatar>
              <div class="flex-1 min-w-0">
                <div class="font-medium text-gray-800 text-sm">{{ user.name }}</div>
                <div class="text-xs text-gray-400">{{ user.progress }}</div>
              </div>
              <div class="text-right">
                <div class="font-bold text-gray-800">{{ user.score }}</div>
                <div class="text-xs text-gray-400">积分</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- === 6. 底部信息 === -->
    <section class="bg-gray-800 text-gray-400 py-10 mt-4">
      <div class="page-container">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div>
            <div class="flex items-center gap-2 text-white font-bold text-lg mb-3">
              <el-icon :size="22" color="#14b8a6"><Sunny /></el-icon> 核能科普
            </div>
            <p class="text-sm leading-relaxed">致力于核能与辐射安全知识的普及教育，帮助公众正确认识核能技术，了解辐射防护知识。</p>
          </div>
          <div>
            <h4 class="text-white font-medium mb-3 text-sm">快速导航</h4>
            <div class="grid grid-cols-2 gap-2 text-sm">
              <router-link to="/knowledge" class="hover:text-white transition-colors">科普知识</router-link>
              <router-link to="/course" class="hover:text-white transition-colors">在线课程</router-link>
              <router-link to="/quiz" class="hover:text-white transition-colors">知识测验</router-link>
              <router-link to="/stats" class="hover:text-white transition-colors">学习统计</router-link>
            </div>
          </div>
          <div>
            <h4 class="text-white font-medium mb-3 text-sm">关于我们</h4>
            <div class="text-sm space-y-1">
              <p>联系邮箱：contact@nuclear-edu.com</p>
              <p>服务热线：400-000-0000</p>
            </div>
          </div>
        </div>
        <div class="border-t border-gray-700 mt-6 pt-6 text-center text-xs text-gray-500">
          &copy; {{ new Date().getFullYear() }} 核能科普平台 版权所有
        </div>
      </div>
    </section>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const radiationData = [
  { name: '吃一根香蕉', dose: '0.1 μSv', width: 1.5, color: '#22c55e' },
  { name: '一次胸透X光', dose: '20 μSv', width: 3.5, color: '#10b981' },
  { name: '飞行 10 小时', dose: '30 μSv', width: 4.5, color: '#34d399' },
  { name: '每天天然本底', dose: '10 μSv', width: 3, color: '#3b82f6' },
  { name: '年天然本底辐射', dose: '2.4 mSv', width: 8, color: '#6366f1' },
  { name: '一次胸部CT', dose: '7 mSv', width: 14, color: '#f59e0b' },
  { name: '年剂量限值(公众)', dose: '1 mSv', width: 6, color: '#f97316' },
  { name: '年剂量限值(职业)', dose: '20 mSv', width: 28, color: '#ef4444' },
  { name: '急性辐射病阈值', dose: '1,000 mSv', width: 75, color: '#dc2626' },
  { name: 'LD50 半致死剂量', dose: '4,000 mSv', width: 95, color: '#991b1b' }
]

const courseCards = [
  {
    id: 1,
    title: '核能基础知识入门',
    desc: '从原子结构、核裂变原理到核电站组成，系统讲解核能基础知识。',
    chapterCount: 10,
    duration: '5h 30m',
    tag: '入门',
    tagType: 'success',
    gradient: 'linear-gradient(135deg, #0d9488 0%, #14b8a6 100%)'
  },
  {
    id: 2,
    title: '辐射防护与安全',
    desc: '了解α、β、γ射线的特性及防护措施，掌握安全操作规范。',
    chapterCount: 8,
    duration: '4h',
    tag: '进阶',
    tagType: 'warning',
    gradient: 'linear-gradient(135deg, #2563eb 0%, #3b82f6 100%)'
  },
  {
    id: 3,
    title: '核电站运行原理',
    desc: '深入学习核电站各系统工作原理和运行机制，了解核电发展。',
    chapterCount: 12,
    duration: '6h',
    tag: '高级',
    tagType: 'danger',
    gradient: 'linear-gradient(135deg, #7c3aed 0%, #8b5cf6 100%)'
  }
]

const quickTools = [
  { label: '科普知识', desc: '核能知识库', icon: 'Reading', color: '#3b82f6', bg: '#eff6ff', path: '/knowledge' },
  { label: '在线课程', desc: '系统学习', icon: 'VideoCamera', color: '#14b8a6', bg: '#f0fdfa', path: '/course' },
  { label: '知识测验', desc: '检验成果', icon: 'Edit', color: '#f59e0b', bg: '#fffbeb', path: '/quiz' },
  { label: '剂量计算', desc: '辐射剂量', icon: 'DataAnalysis', color: '#f97316', bg: '#fff7ed', path: '/dose-calculator' }
]

const leaderboard = [
  { rank: 1, rankClass: 'bg-yellow-500 text-white', name: '张晓明', progress: '完成 12 门课程', score: 1280, avatarBg: '#3b82f6' },
  { rank: 2, rankClass: 'bg-gray-300 text-white', name: '李华', progress: '测验正确率 92%', score: 1150, avatarBg: '#14b8a6' },
  { rank: 3, rankClass: 'bg-orange-300 text-white', name: '王芳', progress: '学习时长 48h', score: 980, avatarBg: '#8b5cf6' },
  { rank: 4, rankClass: 'bg-gray-100 text-gray-600', name: '赵强', progress: '完成 8 门课程', score: 820, avatarBg: '#f59e0b' },
  { rank: 5, rankClass: 'bg-gray-100 text-gray-600', name: '刘敏', progress: '完成 7 门课程', score: 760, avatarBg: '#ef4444' },
  { rank: 6, rankClass: 'bg-gray-100 text-gray-600', name: '陈勇', progress: '完成 6 门课程', score: 690, avatarBg: '#06b6d4' }
]

// 核辐射监测站数据
const facilities = [
  {
    id: 1, name: '切尔诺贝利', coord: '51.389°N, 30.099°E', lng: 30.099, lat: 51.389,
    gradient: 'linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%)',
    statusTag: 'danger', statusLabel: '已关闭',
    detail: '1986年4月26日，4号反应堆发生爆炸，导致史上最严重的核事故。周围30公里被划为禁区。事故促使全球核电安全标准大幅提升。',
    newsUrl: 'https://www.baidu.com/s?wd=切尔诺贝利核事故最新'
  },
  {
    id: 2, name: '福岛第一', coord: '37.421°N, 141.033°E', lng: 141.033, lat: 37.421,
    gradient: 'linear-gradient(135deg, #0c3547 0%, #134e6f 50%, #1a6b8a 100%)',
    statusTag: 'danger', statusLabel: '退役中',
    detail: '2011年3月11日，日本东北部9.0级大地震引发海啸，导致核电站冷却系统失效，1-3号机组堆芯熔毁。约15万人撤离，核废水处理至今仍在进行。',
    newsUrl: 'https://www.baidu.com/s?wd=福岛第一核电站最新进展'
  },
  {
    id: 3, name: '大亚湾', coord: '22.596°N, 114.543°E', lng: 114.543, lat: 22.596,
    gradient: 'linear-gradient(135deg, #0d4f3c 0%, #0d9488 50%, #14b8a6 100%)',
    statusTag: 'success', statusLabel: '运行中',
    detail: '中国首座大型商用核电站，位于深圳市大鹏新区。1994年投入商业运行，2台984MW压水堆机组，年发电量约150亿千瓦时，主要供应香港和广东。',
    newsUrl: 'https://www.baidu.com/s?wd=大亚湾核电站运行情况'
  },
  {
    id: 4, name: '秦山核电', coord: '30.434°N, 120.957°E', lng: 120.957, lat: 30.434,
    gradient: 'linear-gradient(135deg, #1e3a5f 0%, #2563eb 50%, #3b82f6 100%)',
    statusTag: 'success', statusLabel: '运行中',
    detail: '中国大陆第一座核电基地，位于浙江海盐。1991年首次并网发电，目前共9台机组，总装机容量约660万千瓦，是中国最大的核电基地之一。',
    newsUrl: 'https://www.baidu.com/s?wd=秦山核电站'
  },
  {
    id: 5, name: '三里岛', coord: '40.154°N, 76.724°W', lng: -76.724, lat: 40.154,
    gradient: 'linear-gradient(135deg, #4a1d1d 0%, #991b1b 50%, #dc2626 100%)',
    statusTag: 'danger', statusLabel: '已退役',
    detail: '1979年3月28日，2号机组因设备故障和操作失误导致部分堆芯熔毁。虽未造成直接伤亡，但严重打击了美国核电发展。2019年全部退役。',
    newsUrl: 'https://www.baidu.com/s?wd=三里岛核事故'
  },
  {
    id: 6, name: 'IAEA监测站', coord: '48.235°N, 16.415°E', lng: 16.415, lat: 48.235,
    gradient: 'linear-gradient(135deg, #422006 0%, #b45309 50%, #f59e0b 100%)',
    statusTag: 'warning', statusLabel: '监测中',
    detail: '国际原子能机构(IAEA)总部位于奥地利维也纳，在全球设有多个辐射监测站，实时监测环境辐射水平，发布全球辐射安全报告。',
    newsUrl: 'https://www.iaea.org/'
  }
]

const facilityDialog = ref(false)
const selectedFacility = ref(null)
const showAllFacilities = ref(false)

function openFacilityDetail(fac) {
  selectedFacility.value = fac
  facilityDialog.value = true
}

function openSatellite(fac) {
  openMap(fac, 'amap')
}

function openMap(fac, provider) {
  const name = encodeURIComponent(fac.name)
  if (provider === 'amap') {
    window.open(`https://uri.amap.com/marker?position=${fac.lng},${fac.lat}&name=${name}&callnative=1`, '_blank')
  } else if (provider === 'baidu') {
    window.open(`https://api.map.baidu.com/marker?location=${fac.lat},${fac.lng}&title=${name}&content=${name}&output=html&coord_type=gcj02`, '_blank')
  }
}

function openFacilityNews(fac) {
  window.open(fac.newsUrl, '_blank')
}
</script>
