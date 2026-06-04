<template>
  <section class="py-16 bg-gray-50">
    <div class="page-container">
      <div class="text-center mb-10">
        <h2 class="text-3xl font-bold text-gray-800 mb-2">全球核设施监控</h2>
        <p class="text-gray-500">查看全球主要核设施位置、状态及相关资讯</p>
      </div>

      <!-- Map container -->
      <div class="relative bg-white rounded-2xl shadow-lg overflow-hidden mb-8">
        <!-- Map background -->
        <div class="relative w-full" style="padding-bottom: 50%;">
          <div class="absolute inset-0 map-background">
            <!-- World map grid lines -->
            <div class="absolute inset-0 opacity-20" style="background-image: linear-gradient(rgba(26,115,232,0.4) 1px, transparent 1px), linear-gradient(90deg, rgba(26,115,232,0.4) 1px, transparent 1px); background-size: 8% 10%;" />

            <!-- Continent outlines (simplified) -->
            <svg class="absolute inset-0 w-full h-full" viewBox="0 0 1000 500" preserveAspectRatio="none">
              <!-- Asia -->
              <ellipse cx="720" cy="200" rx="180" ry="120" fill="rgba(26,115,232,0.08)" stroke="rgba(26,115,232,0.2)" stroke-width="1" />
              <!-- Europe -->
              <ellipse cx="520" cy="170" rx="80" ry="70" fill="rgba(26,115,232,0.08)" stroke="rgba(26,115,232,0.2)" stroke-width="1" />
              <!-- North America -->
              <ellipse cx="250" cy="200" rx="130" ry="100" fill="rgba(26,115,232,0.08)" stroke="rgba(26,115,232,0.2)" stroke-width="1" />
              <!-- Africa -->
              <ellipse cx="530" cy="320" rx="80" ry="100" fill="rgba(26,115,232,0.06)" stroke="rgba(26,115,232,0.15)" stroke-width="1" />
              <!-- South America -->
              <ellipse cx="310" cy="350" rx="60" ry="90" fill="rgba(26,115,232,0.06)" stroke="rgba(26,115,232,0.15)" stroke-width="1" />
              <!-- Oceania -->
              <ellipse cx="830" cy="370" rx="60" ry="40" fill="rgba(26,115,232,0.06)" stroke="rgba(26,115,232,0.15)" stroke-width="1" />
            </svg>

            <!-- Facility markers -->
            <div
              v-for="facility in facilities"
              :key="facility.id"
              class="absolute cursor-pointer group"
              :style="{ left: facility.mapX + '%', top: facility.mapY + '%' }"
              @click="openDetail(facility)"
            >
              <!-- Pulse ring -->
              <div
                class="absolute -inset-3 rounded-full animate-pulse-glow"
                :style="{ background: getStatusColor(facility.status) }"
              />
              <!-- Marker dot -->
              <div
                class="relative w-4 h-4 rounded-full border-2 border-white shadow-lg z-10 transition-transform group-hover:scale-150"
                :style="{ background: getStatusColor(facility.status) }"
              />

              <!-- Hover tooltip -->
              <div class="absolute bottom-full left-1/2 -translate-x-1/2 mb-3 w-52 bg-gray-900 text-white text-xs rounded-lg p-3 shadow-xl opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-20">
                <div class="font-bold text-sm mb-1">{{ facility.name }}</div>
                <div class="text-gray-400 mb-1">{{ facility.lat.toFixed(4) }}°N, {{ facility.lng.toFixed(4) }}°E</div>
                <el-tag :type="getStatusTagType(facility.status)" size="small">{{ getStatusLabel(facility.status) }}</el-tag>
                <div class="absolute top-full left-1/2 -translate-x-1/2 w-0 h-0 border-l-4 border-r-4 border-t-4 border-transparent border-t-gray-900" />
              </div>
            </div>
          </div>

          <!-- Map legend -->
          <div class="absolute bottom-4 left-4 bg-white/90 backdrop-blur-sm rounded-lg p-3 shadow-sm text-xs">
            <div class="font-bold text-gray-700 mb-2">图例</div>
            <div class="flex flex-col gap-1">
              <div class="flex items-center gap-2"><span class="w-3 h-3 rounded-full bg-green-500" /> 运行中</div>
              <div class="flex items-center gap-2"><span class="w-3 h-3 rounded-full bg-yellow-500" /> 监测中</div>
              <div class="flex items-center gap-2"><span class="w-3 h-3 rounded-full bg-red-500" /> 已关闭/事故</div>
            </div>
          </div>
        </div>
      </div>

      <!-- Facility cards grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div
          v-for="facility in facilities"
          :key="facility.id"
          class="bg-white rounded-xl overflow-hidden card-hover cursor-pointer"
          @click="openDetail(facility)"
        >
          <div class="h-40 relative overflow-hidden">
            <div class="absolute inset-0 facility-image" :style="{ background: facility.gradient }" />
            <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent" />
            <div class="absolute bottom-3 left-4 right-4">
              <el-tag :type="getStatusTagType(facility.status)" size="small" class="mb-1">
                {{ getStatusLabel(facility.status) }}
              </el-tag>
              <h3 class="text-white font-bold text-lg">{{ facility.name }}</h3>
            </div>
          </div>
          <div class="p-4">
            <div class="flex items-center gap-2 text-xs text-gray-400 mb-2">
              <el-icon><Location /></el-icon>
              <span>{{ facility.lat.toFixed(4) }}°N, {{ facility.lng.toFixed(4) }}°E</span>
            </div>
            <p class="text-sm text-gray-500 line-clamp-2">{{ facility.summary }}</p>
          </div>
        </div>
      </div>

      <!-- Detail dialog -->
      <el-dialog v-model="dialogVisible" :title="selectedFacility?.name" width="600px" destroy-on-close>
        <template v-if="selectedFacility">
          <div class="rounded-xl overflow-hidden mb-4 h-48" :style="{ background: selectedFacility.gradient }" />
          <div class="flex items-center gap-3 mb-3">
            <el-tag :type="getStatusTagType(selectedFacility.status)">
              {{ getStatusLabel(selectedFacility.status) }}
            </el-tag>
            <span class="text-sm text-gray-400">
              {{ selectedFacility.lat.toFixed(4) }}°N, {{ selectedFacility.lng.toFixed(4) }}°E
            </span>
          </div>
          <p class="text-gray-700 leading-relaxed mb-6">{{ selectedFacility.detail }}</p>
          <div class="flex gap-3">
            <el-button type="primary" @click="openMap(selectedFacility)">
              <el-icon><Location /></el-icon> 查看卫星地图
            </el-button>
            <el-button @click="openNews(selectedFacility)">
              <el-icon><Link /></el-icon> 相关新闻
            </el-button>
          </div>
        </template>
      </el-dialog>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getNuclearFacilities } from '../api/stats'

const dialogVisible = ref(false)
const selectedFacility = ref(null)

const facilities = ref([])

const mockFacilities = [
  {
    id: 1,
    name: '切尔诺贝利核电站',
    type: 'historical',
    lat: 51.3894,
    lng: 30.0988,
    status: 'decommissioned',
    summary: '1986年4月26日发生史上最严重的核事故，4号反应堆爆炸，大量放射性物质扩散至欧洲大部分地区。',
    detail: '切尔诺贝利核电站位于乌克兰普里皮亚季市附近。1986年4月26日凌晨1点23分，4号反应堆在进行安全测试时发生爆炸，引发了历史上最严重的核事故。事故导致大量放射性物质释放到大气中，影响了整个欧洲。周围30公里的区域被疏散，至今仍是禁区。该事故深刻影响了全球核能政策和安全标准。',
    mapUrl: 'https://www.google.com/maps?q=51.3894,30.0988',
    newsUrl: 'https://zh.wikipedia.org/wiki/切尔诺贝利核事故',
    gradient: 'linear-gradient(135deg, #1a1a2e 0%, #16213e 50%, #0f3460 100%)',
    mapX: 54,
    mapY: 28
  },
  {
    id: 2,
    name: '福岛第一核电站',
    type: 'historical',
    lat: 37.4211,
    lng: 141.0328,
    status: 'decommissioned',
    summary: '2011年3月11日大地震引发海啸，导致福岛第一核电站发生严重核泄漏事故。',
    detail: '福岛第一核电站位于日本福岛县大熊町。2011年3月11日，日本东北部发生9.0级大地震并引发海啸，导致核电站冷却系统失效，1至3号机组堆芯熔毁，大量放射性物质泄漏。这是继切尔诺贝利之后第二个被评估为7级（最严重级别）的核事故。事故导致约15万人被迫撤离，核废水处理问题至今仍在持续。',
    mapUrl: 'https://www.google.com/maps?q=37.4211,141.0328',
    newsUrl: 'https://zh.wikipedia.org/wiki/福岛第一核电站事故',
    gradient: 'linear-gradient(135deg, #0c3547 0%, #134e6f 50%, #1a6b8a 100%)',
    mapX: 82,
    mapY: 30
  },
  {
    id: 3,
    name: '大亚湾核电站',
    type: 'power_plant',
    lat: 22.5964,
    lng: 114.5425,
    status: 'operating',
    summary: '中国首座大型商用核电站，位于广东省深圳市大鹏新区，装机容量约3000兆瓦。',
    detail: '大亚湾核电站是中国第一座大型商用核电站，位于广东省深圳市大鹏新区大亚湾畔。1987年开工建设，1994年投入商业运行。采用法国M310压水堆技术，拥有2台984MW发电机组。核电站年发电量约150亿千瓦时，主要供应香港和广东地区。投运以来保持良好的安全运行记录，是中国核电发展的标杆项目。',
    mapUrl: 'https://www.google.com/maps?q=22.5964,114.5425',
    newsUrl: 'https://zh.wikipedia.org/wiki/大亚湾核电站',
    gradient: 'linear-gradient(135deg, #0d4f3c 0%, #0d9488 50%, #14b8a6 100%)',
    mapX: 74,
    mapY: 48
  },
  {
    id: 4,
    name: '秦山核电站',
    type: 'power_plant',
    lat: 30.4344,
    lng: 120.9572,
    status: 'operating',
    summary: '中国大陆第一座核电站，位于浙江省海盐县，被称为"国之光荣"。',
    detail: '秦山核电站位于浙江省嘉兴市海盐县秦山镇，是中国大陆第一座自行设计、建造和运营管理的核电站。一期工程300MW压水堆于1985年开工建设，1991年12月15日首次并网发电，结束了中国大陆无核电的历史。目前秦山核电基地共有9台机组，总装机容量约660万千瓦，是中国最大的核电基地之一。',
    mapUrl: 'https://www.google.com/maps?q=30.4344,120.9572',
    newsUrl: 'https://zh.wikipedia.org/wiki/秦山核电站',
    gradient: 'linear-gradient(135deg, #1e3a5f 0%, #2563eb 50%, #3b82f6 100%)',
    mapX: 77,
    mapY: 38
  },
  {
    id: 5,
    name: '三里岛核电站',
    type: 'historical',
    lat: 40.1537,
    lng: -76.7244,
    status: 'decommissioned',
    summary: '1979年发生美国历史上最严重的核电站事故，2号机组部分堆芯熔毁。',
    detail: '三里岛核电站位于美国宾夕法尼亚州哈里斯堡附近。1979年3月28日，2号机组因设备故障和人为操作失误导致冷却水流失，堆芯部分熔毁。虽然放射性物质释放量较少，未造成直接人员伤亡，但该事故严重打击了公众对核能的信心，对美国及全球核电发展产生了深远影响。2号机组永久关闭，1号机组于2019年退役。',
    mapUrl: 'https://www.google.com/maps?q=40.1537,-76.7244',
    newsUrl: 'https://zh.wikipedia.org/wiki/三里岛核事故',
    gradient: 'linear-gradient(135deg, #4a1d1d 0%, #991b1b 50%, #dc2626 100%)',
    mapX: 25,
    mapY: 32
  },
  {
    id: 6,
    name: '戈尔诺耶核设施',
    type: 'monitoring',
    lat: 52.1156,
    lng: 115.6089,
    status: 'monitoring',
    summary: '位于俄罗斯的核材料存储与处理设施，处于国际原子能机构监测之下。',
    detail: '戈尔诺耶核设施位于俄罗斯外贝加尔边疆区，是俄罗斯核工业体系中的重要设施之一，主要用于核材料的存储和处理。该设施在苏联时期建设，目前仍在运行中，接受国际原子能机构（IAEA）的定期监测和检查。设施周边设有环境监测站，持续监测辐射水平。',
    mapUrl: 'https://www.google.com/maps?q=52.1156,115.6089',
    newsUrl: 'https://www.iaea.org/',
    gradient: 'linear-gradient(135deg, #422006 0%, #b45309 50%, #f59e0b 100%)',
    mapX: 70,
    mapY: 25
  }
]

function getStatusColor(status) {
  const map = { operating: '#22c55e', monitoring: '#eab308', decommissioned: '#ef4444' }
  return map[status] || '#6b7280'
}

function getStatusTagType(status) {
  const map = { operating: 'success', monitoring: 'warning', decommissioned: 'danger' }
  return map[status] || 'info'
}

function getStatusLabel(status) {
  const map = { operating: '运行中', monitoring: '监测中', decommissioned: '已关闭' }
  return map[status] || status
}

function openDetail(facility) {
  selectedFacility.value = facility
  dialogVisible.value = true
}

function openMap(facility) {
  window.open(facility.mapUrl, '_blank')
}

function openNews(facility) {
  window.open(facility.newsUrl, '_blank')
}

onMounted(async () => {
  try {
    const res = await getNuclearFacilities()
    if (res.data?.length) {
      facilities.value = res.data
    } else {
      facilities.value = mockFacilities
    }
  } catch {
    facilities.value = mockFacilities
  }
})
</script>
