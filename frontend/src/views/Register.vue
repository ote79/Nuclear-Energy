<template>
  <div class="min-h-screen flex relative overflow-hidden" style="background: linear-gradient(135deg, #0d9488 0%, #0891b2 20%, #2563eb 55%, #1e40af 100%);">
    <!-- Background decorations -->
    <div class="absolute inset-0 opacity-[0.06]" style="background-image: linear-gradient(rgba(255,255,255,0.8) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.8) 1px, transparent 1px); background-size: 50px 50px;" />
    <div class="absolute -top-40 -left-40 w-[32rem] h-[32rem] rounded-full border-2 border-white/10" />
    <div class="absolute -bottom-40 -right-40 w-[28rem] h-[28rem] rounded-full border border-white/8" />
    <div class="absolute top-1/3 right-1/4 w-3 h-3 rounded-full bg-white/30 animate-pulse-glow" />
    <div class="absolute bottom-1/4 left-1/3 w-2 h-2 rounded-full bg-cyan-300/40 animate-pulse-glow" style="animation-delay: 0.5s" />

    <!-- Main content -->
    <div class="relative z-10 w-full flex items-center justify-center px-4 py-12">
      <div class="w-full max-w-5xl flex flex-col lg:flex-row items-stretch rounded-2xl overflow-hidden shadow-2xl">

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
            <h2 class="text-3xl font-bold mb-4 leading-tight">加入我们</h2>
            <p class="text-white/70 mb-10 leading-relaxed">
              创建账号，开启核能知识学习之旅。<br />解锁全部课程和测验功能。
            </p>

            <div class="space-y-4">
              <div class="flex items-center gap-3 p-3 rounded-xl bg-white/10">
                <el-icon :size="20" color="#a5f3fc"><CircleCheck /></el-icon>
                <span class="text-sm text-white/80">解锁全部科普文章和视频课程</span>
              </div>
              <div class="flex items-center gap-3 p-3 rounded-xl bg-white/10">
                <el-icon :size="20" color="#a5f3fc"><CircleCheck /></el-icon>
                <span class="text-sm text-white/80">参与知识测验，检验学习成果</span>
              </div>
              <div class="flex items-center gap-3 p-3 rounded-xl bg-white/10">
                <el-icon :size="20" color="#a5f3fc"><CircleCheck /></el-icon>
                <span class="text-sm text-white/80">追踪学习进度，查看个人统计</span>
              </div>
              <div class="flex items-center gap-3 p-3 rounded-xl bg-white/10">
                <el-icon :size="20" color="#a5f3fc"><CircleCheck /></el-icon>
                <span class="text-sm text-white/80">错题重练 + 辐射剂量计算器</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Right: Register form -->
        <div class="lg:w-1/2 bg-white p-10 lg:p-14 flex flex-col justify-center">
          <div class="mb-8">
            <h2 class="text-2xl font-bold text-gray-800 mb-1">创建账号</h2>
            <p class="text-sm text-gray-400">填写信息，立即注册</p>
          </div>

          <el-form
            ref="formRef"
            :model="form"
            :rules="rules"
            label-position="top"
            size="large"
          >
            <el-form-item label="邮箱" prop="email">
              <el-input v-model="form.email" placeholder="请输入邮箱地址" prefix-icon="Message" class="!h-12" />
            </el-form-item>
            <el-form-item label="手机号" prop="phone">
              <el-input v-model="form.phone" placeholder="请输入手机号（选填）" prefix-icon="Cellphone" class="!h-12" />
            </el-form-item>
            <el-form-item label="昵称" prop="nickname">
              <el-input v-model="form.nickname" placeholder="请输入您的昵称" prefix-icon="UserFilled" class="!h-12" />
            </el-form-item>
            <el-form-item label="密码" prop="password">
              <el-input v-model="form.password" type="password" placeholder="请输入密码（至少6位）" prefix-icon="Lock" show-password class="!h-12" />
            </el-form-item>
            <el-form-item label="确认密码" prop="confirmPassword">
              <el-input v-model="form.confirmPassword" type="password" placeholder="请再次输入密码" prefix-icon="Lock" show-password class="!h-12" @keyup.enter="handleRegister" />
            </el-form-item>
            <el-form-item class="mt-2">
              <el-button type="primary" class="w-full !h-12 !text-base !font-medium" :loading="loading" @click="handleRegister">注 册</el-button>
            </el-form-item>
          </el-form>

          <div class="text-center text-sm text-gray-500">
            已有账号？
            <router-link to="/login" class="text-teal-600 hover:text-teal-700 font-medium hover:underline">立即登录</router-link>
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
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../stores/user'
import { ElMessage } from 'element-plus'

const router = useRouter()
const userStore = useUserStore()
const formRef = ref()
const loading = ref(false)

const form = reactive({ email: '', phone: '', nickname: '', password: '', confirmPassword: '' })

const validateConfirm = (rule, value, callback) => {
  if (value !== form.password) {
    callback(new Error('两次输入密码不一致'))
  } else {
    callback()
  }
}

const rules = {
  email: [
    { required: true, message: '请输入邮箱', trigger: 'blur' },
    { type: 'email', message: '邮箱格式不正确', trigger: 'blur' }
  ],
  nickname: [{ required: true, message: '请输入昵称', trigger: 'blur' }],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, message: '密码至少 6 位', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认密码', trigger: 'blur' },
    { validator: validateConfirm, trigger: 'blur' }
  ]
}

async function handleRegister() {
  const valid = await formRef.value?.validate().catch(() => false)
  if (!valid) return
  loading.value = true
  try {
    await userStore.register(form)
    ElMessage.success('注册成功，请登录')
    router.push('/login')
  } catch (e) {
    ElMessage.error(e?.message || '注册失败')
  } finally {
    loading.value = false
  }
}
</script>
