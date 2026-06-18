<template>
  <div class="min-h-screen bg-gray-50">
    <div class="page-container py-8">
      <el-button text class="mb-4" @click="$router.push('/')">← 返回首页</el-button>

      <div class="mb-8">
        <h1 class="text-3xl font-bold text-gray-800 mb-2">辐射剂量计算器</h1>
        <p class="text-gray-500">选择您经历过的医疗检查或活动，计算累计辐射剂量</p>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <!-- Left: Item selector -->
        <div class="lg:col-span-2">
          <div class="bg-white rounded-xl border border-gray-100 p-6 mb-6">
            <h2 class="text-lg font-bold text-gray-800 mb-4">选择剂量来源</h2>
            <div class="grid grid-cols-2 md:grid-cols-3 gap-3">
              <div
                v-for="item in doseItems"
                :key="item.id"
                class="relative rounded-xl border-2 p-4 cursor-pointer transition-all hover:shadow-md"
                :class="item.selected ? 'border-teal-500 bg-teal-50' : 'border-gray-100 hover:border-teal-200'"
                @click="toggleItem(item)"
              >
                <div class="w-10 h-10 rounded-xl flex items-center justify-center mb-2" :style="{ background: item.bg }">
                  <el-icon :size="22" :color="item.color"><component :is="item.icon" /></el-icon>
                </div>
                <h4 class="font-bold text-gray-800 text-sm mb-1">{{ item.name }}</h4>
                <p class="text-xs text-gray-400">{{ item.dose }}</p>
                <div v-if="item.selected" class="absolute top-2 right-2 w-5 h-5 rounded-full bg-teal-500 flex items-center justify-center">
                  <el-icon :size="12" color="white"><Check /></el-icon>
                </div>
              </div>
            </div>

            <!-- Category tabs -->
            <el-divider />
            <div class="mb-3">
              <el-radio-group v-model="doseType" size="small">
                <el-radio-button value="all">全部</el-radio-button>
                <el-radio-button value="medical">医学检查</el-radio-button>
                <el-radio-button value="daily">日常生活</el-radio-button>
                <el-radio-button value="travel">出行旅行</el-radio-button>
              </el-radio-group>
            </div>
            <div class="grid grid-cols-2 md:grid-cols-3 gap-3">
              <div
                v-for="item in filteredExtraItems"
                :key="item.id"
                class="relative rounded-xl border-2 p-4 cursor-pointer transition-all hover:shadow-md"
                :class="item.selected ? 'border-teal-500 bg-teal-50' : 'border-gray-100 hover:border-teal-200'"
                @click="toggleItem(item)"
              >
                <div class="font-bold text-gray-800 text-sm mb-1">{{ item.name }}</div>
                <p class="text-xs text-gray-400">{{ item.dose }}</p>
                <p class="text-xs text-gray-400 mt-1">{{ item.freq }}</p>
                <div v-if="item.selected" class="absolute top-2 right-2 w-5 h-5 rounded-full bg-teal-500 flex items-center justify-center">
                  <el-icon :size="12" color="white"><Check /></el-icon>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Right: Calculation result -->
        <div>
          <div class="bg-white rounded-xl border border-gray-100 p-6 sticky top-20">
            <h2 class="text-lg font-bold text-gray-800 mb-4">剂量合计</h2>

            <!-- Selected items -->
            <div v-if="selectedItems.length === 0" class="text-center py-8 text-gray-400">
              <el-icon :size="48" class="mb-2"><DataAnalysis /></el-icon>
              <p class="text-sm">请从左侧选择检查项目</p>
            </div>
            <div v-else class="space-y-2 mb-4 max-h-64 overflow-y-auto">
              <div v-for="item in selectedItems" :key="item.id" class="flex items-center justify-between p-3 rounded-lg bg-gray-50">
                <div class="flex-1 min-w-0">
                  <div class="text-sm font-medium text-gray-800 truncate">{{ item.name }}</div>
                  <div class="text-xs text-gray-400">{{ item.dose }}</div>
                </div>
                <el-button :icon="Close" circle size="small" class="ml-2" @click="toggleItem(item)" />
              </div>
            </div>

            <el-divider />

            <!-- Total -->
            <div class="text-center mb-4">
              <div class="text-xs text-gray-400 mb-1">累计辐射剂量</div>
              <div class="text-3xl font-bold" :class="totalDoseColor">{{ displayTotal }}</div>
              <div class="text-xs text-gray-400 mt-1">{{ totalBananas }} 根香蕉</div>
            </div>

            <!-- Gauge bar -->
            <div class="mb-2">
              <div class="flex justify-between text-xs text-gray-400 mb-1">
                <span>0</span><span>安全阈值 1 mSv</span><span>1000 mSv</span>
              </div>
              <div class="h-3 bg-gray-100 rounded-full overflow-hidden relative">
                <div class="absolute inset-0 bg-gradient-to-r from-green-400 via-yellow-400 via-orange-500 to-red-600 opacity-20" />
                <div class="h-3 rounded-full transition-all duration-500" :style="{ width: gaugePercent + '%', background: gaugeColor }" />
                <div class="absolute top-0 bottom-0 border-l-2 border-dashed border-gray-400" style="left: 0.1%" />
              </div>
            </div>

            <!-- Assessment -->
            <div class="p-4 rounded-xl text-center" :class="assessmentBg">
              <el-icon :size="24"><component :is="assessmentIcon" /></el-icon>
              <p class="font-bold mt-1">{{ assessmentText }}</p>
              <p class="text-xs mt-1 opacity-70">{{ assessmentDesc }}</p>
            </div>

            <div class="flex gap-2 mt-4">
              <el-button size="small" class="flex-1" @click="clearAll">清空重置</el-button>
              <el-button size="small" type="primary" class="flex-1" @click="shareResult">分享结果</el-button>
            </div>
          </div>
        </div>
      </div>

      <!-- Reference table -->
      <div class="bg-white rounded-xl border border-gray-100 p-6 mt-6">
        <h2 class="text-lg font-bold text-gray-800 mb-4">辐射剂量参考表</h2>
        <el-table :data="referenceTable" stripe size="large" max-height="400">
          <el-table-column prop="name" label="检查 / 活动" min-width="180" />
          <el-table-column prop="dose" label="辐射剂量" width="150" align="center">
            <template #default="{ row }">
              <span class="font-bold">{{ row.dose }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="level" label="风险等级" width="120" align="center">
            <template #default="{ row }">
              <el-tag :type="row.levelColor" size="small">{{ row.level }}</el-tag>
            </template>
          </el-table-column>
          <el-table-column prop="desc" label="备注" min-width="200">
            <template #default="{ row }">
              <span class="text-sm text-gray-500">{{ row.desc }}</span>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { ElMessage } from 'element-plus'

const doseType = ref('all')

// 核心剂量来源
const doseItems = ref([
  { id: 1, name: '胸部 X 光', dose: '0.02 mSv', doseMsv: 0.02, category: 'medical', icon: 'FirstAidKit', color: '#3b82f6', bg: '#eff6ff', freq: '单次', selected: false },
  { id: 2, name: '牙科 X 光', dose: '0.005 mSv', doseMsv: 0.005, category: 'medical', icon: 'Tooth', color: '#14b8a6', bg: '#f0fdfa', freq: '单次', selected: false },
  { id: 3, name: '乳腺 X 光', dose: '0.4 mSv', doseMsv: 0.4, category: 'medical', icon: 'Female', color: '#8b5cf6', bg: '#f5f3ff', freq: '单次', selected: false },
  { id: 4, name: '头部 CT', dose: '2 mSv', doseMsv: 2, category: 'medical', icon: 'Cpu', color: '#f59e0b', bg: '#fffbeb', freq: '单次', selected: false },
  { id: 5, name: '胸部 CT', dose: '7 mSv', doseMsv: 7, category: 'medical', icon: 'Cpu', color: '#f97316', bg: '#fff7ed', freq: '单次', selected: false },
  { id: 6, name: '腹部 CT', dose: '8 mSv', doseMsv: 8, category: 'medical', icon: 'Cpu', color: '#ef4444', bg: '#fef2f2', freq: '单次', selected: false }
])

// 扩展项
const extraItems = ref([
  { id: 7, name: '全身 CT', dose: '10 mSv', doseMsv: 10, category: 'medical', freq: '单次', selected: false },
  { id: 8, name: 'PET-CT', dose: '25 mSv', doseMsv: 25, category: 'medical', freq: '单次', selected: false },
  { id: 9, name: '骨密度扫描', dose: '0.001 mSv', doseMsv: 0.001, category: 'medical', freq: '单次', selected: false },
  { id: 10, name: '甲状腺扫描', dose: '1.5 mSv', doseMsv: 1.5, category: 'medical', freq: '单次', selected: false },
  { id: 11, name: '乘坐飞机(10h)', dose: '0.03 mSv', doseMsv: 0.03, category: 'travel', freq: '每次', selected: false },
  { id: 12, name: '乘坐飞机(20h)', dose: '0.06 mSv', doseMsv: 0.06, category: 'travel', freq: '每次', selected: false },
  { id: 13, name: '生活在高海拔地区', dose: '1.5 mSv', doseMsv: 1.5, category: 'daily', freq: '每年', selected: false },
  { id: 14, name: '吸烟(每天1包/年)', dose: '0.36 mSv', doseMsv: 0.36, category: 'daily', freq: '每年', selected: false },
  { id: 15, name: '核电站周边生活', dose: '0.001 mSv', doseMsv: 0.001, category: 'daily', freq: '每年', selected: false },
])

const filteredExtraItems = computed(() => {
  if (doseType.value === 'all') return extraItems.value
  return extraItems.value.filter(i => i.category === doseType.value)
})

const selectedItems = computed(() => [
  ...doseItems.value.filter(i => i.selected),
  ...extraItems.value.filter(i => i.selected)
])

const totalDoseMsv = computed(() =>
  selectedItems.value.reduce((sum, i) => sum + i.doseMsv, 0)
)

const displayTotal = computed(() => {
  const v = totalDoseMsv.value
  if (v >= 1000) return (v / 1000).toFixed(1) + ' Sv'
  return v.toFixed(v < 0.01 ? 3 : v < 1 ? 2 : 1) + ' mSv'
})

const totalBananas = computed(() => {
  const bananaDose = 0.0001 // 1 banana ≈ 0.1 μSv = 0.0001 mSv
  return Math.round(totalDoseMsv.value / bananaDose).toLocaleString()
})

const totalDoseColor = computed(() => {
  const v = totalDoseMsv.value
  if (v >= 1000) return 'text-red-600'
  if (v >= 50) return 'text-orange-500'
  if (v >= 10) return 'text-yellow-600'
  return 'text-teal-600'
})

const gaugePercent = computed(() => {
  const v = totalDoseMsv.value
  if (v <= 0) return 0
  if (v >= 1000) return 100
  return Math.log10(v + 1) / Math.log10(1001) * 100
})

const gaugeColor = computed(() => {
  const v = totalDoseMsv.value
  if (v >= 1000) return '#ef4444'
  if (v >= 50) return '#f97316'
  if (v >= 10) return '#f59e0b'
  return '#14b8a6'
})

const assessmentIcon = computed(() => {
  const v = totalDoseMsv.value
  if (v >= 1000) return 'WarningFilled'
  if (v >= 50) return 'InfoFilled'
  if (v >= 10) return 'Check'
  return 'CircleCheckFilled'
})

const assessmentText = computed(() => {
  const v = totalDoseMsv.value
  if (v >= 1000) return '剂量较高'
  if (v >= 50) return '需关注'
  if (v >= 10) return '在正常范围内'
  return '非常安全'
})

const assessmentDesc = computed(() => {
  const v = totalDoseMsv.value
  if (v >= 1000) return '已达到急性辐射病阈值，请立即咨询医生'
  if (v >= 50) return '接近职业年剂量限值(20 mSv/年)，建议咨询专业医生'
  if (v >= 10) return '年有效剂量在安全范围内，无需担心'
  return `仅相当于 ${(v * 1000 / 2.4).toFixed(1)} 小时天然本底辐射`
})

const assessmentBg = computed(() => {
  const v = totalDoseMsv.value
  if (v >= 1000) return 'bg-red-50 text-red-600'
  if (v >= 50) return 'bg-orange-50 text-orange-500'
  if (v >= 10) return 'bg-yellow-50 text-yellow-600'
  return 'bg-teal-50 text-teal-600'
})

function toggleItem(item) {
  item.selected = !item.selected
}

function clearAll() {
  doseItems.value.forEach(i => i.selected = false)
  extraItems.value.forEach(i => i.selected = false)
}

function shareResult() {
  const text = `我在核能科普平台的辐射剂量计算器上计算了我的累计辐射剂量：${displayTotal.value}（约等于 ${totalBananas.value} 根香蕉的等效剂量）。来试试你的吧！`
  ElMessage.success('计算结果已复制到剪贴板')
  navigator.clipboard?.writeText(text)
}

const referenceTable = [
  { name: '单手部 X 光', dose: '0.001 mSv', level: '微剂量', levelColor: 'success', desc: '可忽略，约 10 根香蕉' },
  { name: '牙科 X 光', dose: '0.005 mSv', level: '微剂量', levelColor: 'success', desc: '约 50 根香蕉' },
  { name: '胸部 X 光', dose: '0.02 mSv', level: '微剂量', levelColor: 'success', desc: '约 200 根香蕉' },
  { name: '乳腺 X 光', dose: '0.4 mSv', level: '低剂量', levelColor: 'success', desc: '约 4000 根香蕉' },
  { name: '腰椎 X 光', dose: '1.5 mSv', level: '中剂量', levelColor: 'warning', desc: '约 15,000 根香蕉' },
  { name: '头部 CT', dose: '2 mSv', level: '中剂量', levelColor: 'warning', desc: '约 20,000 根香蕉' },
  { name: '胸部 CT', dose: '7 mSv', level: '中高剂量', levelColor: 'warning', desc: '约 70,000 根香蕉' },
  { name: '腹部 CT', dose: '8 mSv', level: '中高剂量', levelColor: 'warning', desc: '约 80,000 根香蕉' },
  { name: '全身 CT', dose: '10 mSv', level: '较高剂量', levelColor: 'danger', desc: '约 100,000 根香蕉' },
  { name: 'PET-CT', dose: '25 mSv', level: '较高剂量', levelColor: 'danger', desc: '约 250,000 根香蕉' },
  { name: '天然年本底', dose: '2.4 mSv/年', level: '基础水平', levelColor: 'info', desc: '每人每年无可避免接收' },
  { name: '公众年剂量限值', dose: '1 mSv/年', level: '安全限值', levelColor: 'success', desc: 'ICRP 建议值(除医疗外)' }
]
</script>
