<template>
  <div class="page-container py-8">
    <h1 class="text-3xl font-bold text-gray-800 mb-8">个人中心</h1>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <!-- User card -->
      <div class="bg-white rounded-xl p-6 border border-gray-100 text-center">
        <el-avatar :size="80" class="mx-auto mb-4">{{ form.nickname?.[0] || '用' }}</el-avatar>
        <h2 class="text-xl font-bold text-gray-800">{{ form.nickname }}</h2>
        <p class="text-sm text-gray-400 mt-1">@{{ form.username }}</p>
        <el-divider />
        <div class="text-sm text-gray-500 space-y-1">
          <p v-if="form.email"><el-icon :size="14"><Message /></el-icon> {{ form.email }}</p>
          <p v-if="form.phone"><el-icon :size="14"><Cellphone /></el-icon> {{ form.phone }}</p>
          <p>注册时间：{{ userInfo?.createdAt?.slice(0, 10) || '-' }}</p>
        </div>
      </div>

      <!-- Edit forms -->
      <div class="lg:col-span-2 space-y-6">
        <!-- Edit profile -->
        <div class="bg-white rounded-xl p-6 border border-gray-100">
          <h3 class="text-lg font-bold text-gray-800 mb-4">编辑资料</h3>
          <el-form ref="formRef" :model="form" :rules="rules" label-width="80px" size="large">
            <el-form-item label="用户名">
              <el-input v-model="form.username" disabled />
            </el-form-item>
            <el-form-item label="昵称" prop="nickname">
              <el-input v-model="form.nickname" placeholder="请输入昵称" />
            </el-form-item>
            <el-form-item label="手机号" prop="phone">
              <el-input v-model="form.phone" placeholder="请输入手机号" />
            </el-form-item>
            <el-form-item label="邮箱" prop="email">
              <el-input v-model="form.email" placeholder="请输入邮箱（选填）" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" :loading="saving" @click="handleSave">保存修改</el-button>
            </el-form-item>
          </el-form>
        </div>

        <!-- Change password -->
        <div class="bg-white rounded-xl p-6 border border-gray-100">
          <h3 class="text-lg font-bold text-gray-800 mb-4">修改密码</h3>
          <el-form ref="pwdFormRef" :model="pwdForm" :rules="pwdRules" label-width="100px" size="large">
            <el-form-item label="当前密码" prop="oldPassword">
              <el-input v-model="pwdForm.oldPassword" type="password" show-password />
            </el-form-item>
            <el-form-item label="新密码" prop="newPassword">
              <el-input v-model="pwdForm.newPassword" type="password" show-password />
            </el-form-item>
            <el-form-item label="确认新密码" prop="confirmPassword">
              <el-input v-model="pwdForm.confirmPassword" type="password" show-password />
            </el-form-item>
            <el-form-item>
              <el-button type="warning" :loading="changingPwd" @click="handleChangePwd">修改密码</el-button>
            </el-form-item>
          </el-form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useUserStore } from '../stores/user'
import { updateProfile, changePassword } from '../api/user'
import { ElMessage } from 'element-plus'

const userStore = useUserStore()
const formRef = ref()
const pwdFormRef = ref()
const saving = ref(false)
const changingPwd = ref(false)
const userInfo = ref(null)

const form = reactive({ username: '', nickname: '', phone: '', email: '' })
const pwdForm = reactive({ oldPassword: '', newPassword: '', confirmPassword: '' })

const rules = {
  nickname: [{ required: true, message: '请输入昵称', trigger: 'blur' }],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '手机号格式不正确', trigger: 'blur' }
  ],
  email: [{ type: 'email', message: '邮箱格式不正确', trigger: 'blur' }]
}

const validateConfirm = (rule, value, callback) => {
  if (value !== pwdForm.newPassword) {
    callback(new Error('两次输入密码不一致'))
  } else {
    callback()
  }
}

const pwdRules = {
  oldPassword: [{ required: true, message: '请输入当前密码', trigger: 'blur' }],
  newPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 6, message: '密码至少 6 位', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认新密码', trigger: 'blur' },
    { validator: validateConfirm, trigger: 'blur' }
  ]
}

async function handleSave() {
  const valid = await formRef.value?.validate().catch(() => false)
  if (!valid) return
  saving.value = true
  try {
    await updateProfile({ nickname: form.nickname, phone: form.phone, email: form.email })
    await userStore.fetchUserInfo()
    ElMessage.success('保存成功')
  } catch (e) {
    ElMessage.error(e?.message || '保存失败')
  } finally {
    saving.value = false
  }
}

async function handleChangePwd() {
  const valid = await pwdFormRef.value?.validate().catch(() => false)
  if (!valid) return
  changingPwd.value = true
  try {
    await changePassword({ oldPassword: pwdForm.oldPassword, newPassword: pwdForm.newPassword })
    ElMessage.success('密码修改成功')
    pwdFormRef.value?.resetFields()
  } catch (e) {
    ElMessage.error(e?.message || '修改失败')
  } finally {
    changingPwd.value = false
  }
}

onMounted(async () => {
  await userStore.fetchUserInfo()
  userInfo.value = userStore.userInfo
  if (userInfo.value) {
    Object.assign(form, {
      username: userInfo.value.username || '',
      nickname: userInfo.value.nickname || '',
      phone: userInfo.value.phone || '',
      email: userInfo.value.email || ''
    })
  }
})
</script>
