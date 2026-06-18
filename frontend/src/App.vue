<template>
  <el-config-provider :locale="zhCn">
    <div class="min-h-screen flex flex-col bg-gray-50">
      <Navbar v-if="!isAuthPage" />
      <main class="flex-1">
        <router-view />
      </main>
      <Footer v-if="!isAuthPage && !isHomePage" />
    </div>
  </el-config-provider>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import zhCn from 'element-plus/dist/locale/zh-cn.mjs'
import Navbar from './components/Navbar.vue'
import Footer from './components/Footer.vue'

const route = useRoute()
const isAuthPage = computed(() =>
  ['/login', '/register'].includes(route.path)
)
const isHomePage = computed(() => route.path === '/')
</script>
