<template>
  <header class="bg-white shadow-sm sticky top-0 z-50">
    <div class="page-container flex items-center justify-between h-16">
      <router-link to="/" class="flex items-center gap-2 text-xl font-bold text-nuclear-blue">
        <el-icon :size="28"><Sunny /></el-icon>
        <span>核能科普</span>
      </router-link>

      <nav class="hidden md:flex items-center gap-6">
        <router-link
          v-for="item in navItems"
          :key="item.path"
          :to="item.path"
          class="text-gray-600 hover:text-nuclear-blue transition-colors"
          active-class="text-nuclear-blue font-medium"
        >
          {{ item.label }}
        </router-link>
      </nav>

      <div class="flex items-center gap-3">
        <template v-if="userStore.isLoggedIn">
          <el-dropdown trigger="click">
            <div class="flex items-center gap-2 cursor-pointer">
              <el-avatar :size="32" :src="userStore.userInfo?.avatar">
                {{ userStore.userInfo?.nickname?.[0] || '用' }}
              </el-avatar>
              <span class="hidden sm:inline text-sm text-gray-700">
                {{ userStore.userInfo?.nickname || '用户' }}
              </span>
            </div>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="$router.push('/profile')">
                  <el-icon><User /></el-icon> 个人中心
                </el-dropdown-item>
                <el-dropdown-item @click="$router.push('/stats')">
                  <el-icon><DataAnalysis /></el-icon> 学习统计
                </el-dropdown-item>
                <el-dropdown-item divided @click="handleLogout">
                  <el-icon><SwitchButton /></el-icon> 退出登录
                </el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </template>
        <template v-else>
          <el-button type="primary" @click="$router.push('/login')">登录</el-button>
          <el-button @click="$router.push('/register')">注册</el-button>
        </template>

        <!-- Mobile menu -->
        <el-dropdown trigger="click" class="md:hidden">
          <el-icon :size="24" class="cursor-pointer text-gray-600"><Menu /></el-icon>
          <template #dropdown>
            <el-dropdown-menu>
              <el-dropdown-item
                v-for="item in navItems"
                :key="item.path"
                @click="$router.push(item.path)"
              >
                {{ item.label }}
              </el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
      </div>
    </div>
  </header>
</template>

<script setup>
import { onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../stores/user'

const router = useRouter()
const userStore = useUserStore()

const navItems = [
  { path: '/', label: '首页' },
  { path: '/knowledge', label: '科普知识' },
  { path: '/course', label: '在线课程' },
  { path: '/practice', label: '互动练习' },
  { path: '/quiz', label: '知识测验' },
  { path: '/dose-calculator', label: '剂量计算' }
]

onMounted(() => {
  if (userStore.isLoggedIn) {
    userStore.fetchUserInfo()
  }
})

function handleLogout() {
  userStore.logout()
  router.push('/')

  //dffwfwfwf
}


</script>
