<template>
  <div class="min-h-screen flex relative overflow-hidden" style="background: linear-gradient(135deg, #0d9488 0%, #0891b2 20%, #2563eb 55%, #1e40af 100%);">
    <!-- Background decorations -->
    <div class="absolute inset-0 opacity-[0.06]" style="background-image: linear-gradient(rgba(255,255,255,0.8) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.8) 1px, transparent 1px); background-size: 50px 50px;" />
    <div class="absolute -top-40 -right-40 w-[32rem] h-[32rem] rounded-full border-2 border-white/10" />
    <div class="absolute -bottom-40 -left-40 w-[28rem] h-[28rem] rounded-full border border-white/8" />
    <div class="absolute top-1/4 left-1/3 w-3 h-3 rounded-full bg-white/30 animate-pulse-glow" />
    <div class="absolute bottom-1/3 right-1/4 w-2 h-2 rounded-full bg-cyan-300/40 animate-pulse-glow" style="animation-delay: 0.5s" />

    <!-- Main content -->
    <div class="relative z-10 w-full flex items-center justify-center px-4 py-12">
      <div class="w-full max-w-5xl flex flex-col lg:flex-row items-stretch gap-0 rounded-2xl overflow-hidden shadow-2xl">

        <!-- Left: Brand panel -->
        <div class="lg:w-1/2 bg-white/10 backdrop-blur-sm p-10 lg:p-14 flex flex-col justify-center text-white relative overflow-hidden">
          <div class="absolute -bottom-20 -right-20 w-64 h-64 rounded-full bg-white/5 blur-2xl" />
          <div class="relative">
            <div class="flex items-center gap-3 mb-8">
              <div class="w-12 h-12 rounded-xl bg-white/20 flex items-center justify-center">
                <el-icon :size="28" color="white"><Sunny /></el-icon>
              </div>
              <span class="text-2xl font-bold tracking-wide">核能科普</span>
            </div>
            <h2 class="text-3xl font-bold mb-4 leading-tight">欢迎回来</h2>
            <p class="text-white/70 mb-10 leading-relaxed">
              登录您的账号，继续探索核能世界。<br />系统学习核能与辐射安全知识。
            </p>

            <div class="space-y-4">
              <div class="flex items-center gap-3 p-3 rounded-xl bg-white/10">
                <el-icon :size="20" color="#a5f3fc"><Reading /></el-icon>
                <span class="text-sm text-white/80">100+ 科普文章，系统知识库</span>
              </div>
              <div class="flex items-center gap-3 p-3 rounded-xl bg-white/10">
                <el-icon :size="20" color="#a5f3fc"><VideoCamera /></el-icon>
                <span class="text-sm text-white/80">50+ 专业视频课程</span>
              </div>
              <div class="flex items-center gap-3 p-3 rounded-xl bg-white/10">
                <el-icon :size="20" color="#a5f3fc"><Edit /></el-icon>
                <span class="text-sm text-white/80">1000+ 测验题目，巩固知识</span>
              </div>
              <div class="flex items-center gap-3 p-3 rounded-xl bg-white/10">
                <el-icon :size="20" color="#a5f3fc"><DataAnalysis /></el-icon>
                <span class="text-sm text-white/80">辐射剂量计算 + 错题重练</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Right: Login form -->
        <div class="lg:w-1/2 bg-white p-10 lg:p-14 flex flex-col justify-center">
          <div class="mb-2">
            <h2 class="text-2xl font-bold text-gray-800 mb-1">账号登录</h2>
            <p class="text-sm text-gray-400">请选择登录方式</p>
          </div>

          <!-- Login method toggle -->
          <div class="flex gap-2 mb-8">
            <div
              class="flex-1 py-2 rounded-lg text-center text-sm font-medium cursor-pointer transition-colors"
              :class="loginMethod === 'email' ? 'bg-teal-50 text-teal-600 border border-teal-200' : 'bg-gray-50 text-gray-500 border border-gray-100 hover:bg-gray-100'"
              @click="switchMethod('email')"
            >
              <el-icon :size="16"><Message /></el-icon> 邮箱登录
            </div>
            <div
              class="flex-1 py-2 rounded-lg text-center text-sm font-medium cursor-pointer transition-colors"
              :class="loginMethod === 'phone' ? 'bg-teal-50 text-teal-600 border border-teal-200' : 'bg-gray-50 text-gray-500 border border-gray-100 hover:bg-gray-100'"
              @click="switchMethod('phone')"
            >
              <el-icon :size="16"><Cellphone /></el-icon> 手机号登录
            </div>
          </div>

          <el-form
            ref="formRef"
            :model="form"
            :rules="activeRules"
            label-position="top"
            size="large"
          >
            <el-form-item v-if="loginMethod === 'email'" label="邮箱" prop="email">
              <el-input
                v-model="form.email"
                placeholder="请输入邮箱地址"
                prefix-icon="Message"
                class="!h-12"
              />
            </el-form-item>
            <el-form-item v-if="loginMethod === 'phone'" label="手机号" prop="phone">
              <el-input
                v-model="form.phone"
                placeholder="请输入手机号"
                prefix-icon="Cellphone"
                class="!h-12"
              />
            </el-form-item>
            <el-form-item label="密码" prop="password">
              <el-input
                v-model="form.password"
                type="password"
                placeholder="请输入密码"
                prefix-icon="Lock"
                show-password
                class="!h-12"
                @keyup.enter="handleLogin"
              />
            </el-form-item>
            <el-form-item class="mt-2">
              <el-button
                type="primary"
                class="w-full !h-12 !text-base !font-medium"
                :loading="loading"
                @click="handleLogin"
              >
                登 录
              </el-button>
            </el-form-item>
          </el-form>

          <div class="text-center text-sm text-gray-500">
            还没有账号？
            <router-link to="/register" class="text-teal-600 hover:text-teal-700 font-medium hover:underline">立即注册</router-link>
          </div>
          <div class="text-center mt-4">
            <router-link to="/" class="text-xs text-gray-400 hover:text-gray-500">← 返回首页</router-link>
          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../stores/user'
import { ElMessage } from 'element-plus'

const router = useRouter()
const userStore = useUserStore()
const formRef = ref()
const loading = ref(false)
const loginMethod = ref('email')

const form = reactive({ email: '', phone: '', password: '' })

const emailRules = {
  email: [
    { required: true, message: '请输入邮箱', trigger: 'blur' },
    { type: 'email', message: '邮箱格式不正确', trigger: 'blur' }
  ],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
}

const phoneRules = {
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '手机号格式不正确', trigger: 'blur' }
  ],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
}

const activeRules = computed(() => loginMethod.value === 'email' ? emailRules : phoneRules)

function switchMethod(method) {
  loginMethod.value = method
  formRef.value?.clearValidate()
}

async function handleLogin() {
  const valid = await formRef.value?.validate().catch(() => false)
  if (!valid) return
  loading.value = true
  try {
    const loginData = loginMethod.value === 'email' ? { email: form.email, password: form.password } : { phone: form.phone, password: form.password }
    await userStore.login(loginData)
    ElMessage.success('登录成功')
    router.push('/')
  } catch (e) {
    ElMessage.error(e?.message || '登录失败')
  } finally {
    loading.value = false
  }
}
</script>
