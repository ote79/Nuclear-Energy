<template>
  <!-- 学习概览 -->
  <section class="page-container py-8">
    <h2 class="text-xl font-bold text-gray-800 mb-5 flex items-center gap-2">
      <span class="w-1 h-5 bg-teal-500 rounded-full inline-block" />
      学习概览
    </h2>
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-4">
      <!-- 学习进度 -->
      <div class="bg-white rounded-xl p-5 shadow-sm border border-gray-100 hover:shadow-md transition-shadow">
        <div class="flex items-center justify-between mb-3">
          <span class="text-sm text-gray-500">学习进度</span>
          <div class="w-9 h-9 rounded-lg bg-teal-50 flex items-center justify-center">
            <el-icon :size="20" color="#14b8a6"><TrendCharts /></el-icon>
          </div>
        </div>
        <div class="text-3xl font-bold text-gray-800 mb-2">65%</div>
        <el-progress :percentage="65" :stroke-width="8" color="#14b8a6" />
        <div class="text-xs text-gray-400 mt-2">已完成 8/12 课程</div>
      </div>

      <!-- 累计剂量 -->
      <div class="bg-white rounded-xl p-5 shadow-sm border border-gray-100 hover:shadow-md transition-shadow">
        <div class="flex items-center justify-between mb-3">
          <span class="text-sm text-gray-500">累计剂量</span>
          <div class="w-9 h-9 rounded-lg bg-red-50 flex items-center justify-center">
            <el-icon :size="20" color="#ef4444"><WarningFilled /></el-icon>
          </div>
        </div>
        <div class="text-3xl font-bold text-gray-800 mb-1">120 <span class="text-base font-normal text-gray-400">mSv</span></div>
        <div class="h-2 bg-gray-100 rounded-full overflow-hidden">
          <div class="h-full bg-gradient-to-r from-green-400 via-yellow-400 to-red-500 rounded-full" style="width: 8%" />
        </div>
        <div class="text-xs text-gray-400 mt-2">远低于安全阈值 (1000 mSv)</div>
      </div>

      <!-- 等效香蕉数 -->
      <div class="bg-white rounded-xl p-5 shadow-sm border border-gray-100 hover:shadow-md transition-shadow">
        <div class="flex items-center justify-between mb-3">
          <span class="text-sm text-gray-500">等效香蕉数</span>
          <div class="w-9 h-9 rounded-lg bg-yellow-50 flex items-center justify-center">
            <el-icon :size="20" color="#eab308"><Apple /></el-icon>
          </div>
        </div>
        <div class="text-3xl font-bold text-gray-800 mb-1">12,000</div>
        <div class="text-xs text-gray-400 mb-2">约 1,200 公斤香蕉</div>
        <div class="text-xs text-teal-500">🍌 × 12,000 等效剂量</div>
      </div>

      <!-- 天然背景辐射 -->
      <div class="bg-white rounded-xl p-5 shadow-sm border border-gray-100 hover:shadow-md transition-shadow">
        <div class="flex items-center justify-between mb-3">
          <span class="text-sm text-gray-500">背景辐射</span>
          <div class="w-9 h-9 rounded-lg bg-blue-50 flex items-center justify-center">
            <el-icon :size="20" color="#1a73e8"><Sunny /></el-icon>
          </div>
        </div>
        <div class="text-3xl font-bold text-gray-800 mb-1">2.4 <span class="text-base font-normal text-gray-400">mSv/年</span></div>
        <div class="h-2 bg-gray-100 rounded-full overflow-hidden">
          <div class="h-full bg-blue-400 rounded-full" style="width: 2%" />
        </div>
        <div class="text-xs text-gray-400 mt-2">全球年均天然辐射水平</div>
      </div>
    </div>
  </section>
</template>
