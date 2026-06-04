<template>
  <div class="page-container py-8">
    <h1 class="text-3xl font-bold text-gray-800 mb-8">个人中心</h1>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <!-- User card -->
      <div class="bg-white rounded-xl p-6 shadow-sm text-center">
        <el-avatar :size="80" :src="form.avatar" class="mx-auto mb-4">
          {{ form.nickname?.[0] || '用' }}
        </el-avatar>
        <h2 class="text-xl font-bold text-gray-800">{{ form.nickname }}</h2>
        <p class="text-sm text-gray-400 mt-1">{{ form.email }}</p>
        <el-divider />
        <div class="text-sm text-gray-500">
          <p>注册时间：{{ userInfo?.createdAt?.slice(0, 10) || '-' }}</p>
        </div>
      </div>

      <!-- Edit form -->
      <div class="lg:col-span-2 bg-white rounded-xl p-6 shadow-sm">
        <h3 class="text-lg font-bold text-gray-800 mb-6">编辑资料</h3>
        <el-form
          ref="formRef"
          :model="form"
          :rules="rules"
          label-width="80px"
          size="large"
        >
          <el-form-item label="邮箱">
            <el-input v-model="form.email" disabled />
          </el-form-item>
          <el-form-item label="昵称" prop="nickname">
            <el-input v-model="form.nickname" placeholder="请输入昵称" />
          </el-form-item>
          <el-form-item label="头像">
            <el-upload
              class="avatar-uploader"
              :show-file-list="false"
              :before-upload="beforeAvatarUpload"
              :http-request="handleAvatarUpload"
            >
              <el-avatar :size="64" :src="form.avatar">
                {{ form.nickname?.[0] || '用' }}
              </el-avatar>
              <div class="text-xs text-gray-400 mt-1">点击更换头像</div>
            </el-upload>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" :loading="saving" @click="handleSave">
              保存修改
            </el-button>
          </el-form-item>
        </el-form>

        <el-divider />

        <h3 class="text-lg font-bold text-gray-800 mb-4">修改密码</h3>
        <el-form
          ref="pwdFormRef"
          :model="pwdForm"
          :rules="pwdRules"
          label-width="100px"
          size="large"
        >
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
            <el-button type="warning" :loading="changingPwd" @click="handleChangePwd">
              修改密码
            </el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useUserStore } from '../stores/user'
import { updateUserInfo, uploadAvatar } from '../api/user'
import { ElMessage } from 'element-plus'

const userStore = useUserStore()
const formRef = ref()
const pwdFormRef = ref()
const saving = ref(false)
const changingPwd = ref(false)
const userInfo = ref(null)

const form = reactive({ email: '', nickname: '', avatar: '' })
const pwdForm = reactive({ oldPassword: '', newPassword: '', confirmPassword: '' })

const rules = {
  nickname: [{ required: true, message: '请输入昵称', trigger: 'blur' }]
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

function beforeAvatarUpload(file) {
  const isImage = ['image/jpeg', 'image/png', 'image/webp'].includes(file.type)
  const isLt2M = file.size / 1024 / 1024 < 2
  if (!isImage) ElMessage.error('头像只能是 JPG/PNG/WebP 格式')
  if (!isLt2M) ElMessage.error('头像大小不能超过 2MB')
  return isImage && isLt2M
}

async function handleAvatarUpload({ file }) {
  try {
    const res = await uploadAvatar(file)
    form.avatar = res.data.url
    ElMessage.success('头像上传成功')
  } catch {
    // handled
  }
}

async function handleSave() {
  const valid = await formRef.value?.validate().catch(() => false)
  if (!valid) return
  saving.value = true
  try {
    await updateUserInfo({ nickname: form.nickname, avatar: form.avatar })
    await userStore.fetchUserInfo()
    ElMessage.success('保存成功')
  } catch {
    // handled
  } finally {
    saving.value = false
  }
}

async function handleChangePwd() {
  const valid = await pwdFormRef.value?.validate().catch(() => false)
  if (!valid) return
  changingPwd.value = true
  try {
    await updateUserInfo(pwdForm)
    ElMessage.success('密码修改成功')
    pwdFormRef.value?.resetFields()
  } catch {
    // handled
  } finally {
    changingPwd.value = false
  }
}

onMounted(async () => {
  await userStore.fetchUserInfo()
  userInfo.value = userStore.userInfo
  if (userInfo.value) {
    Object.assign(form, {
      email: userInfo.value.username || userInfo.value.email || '',
      nickname: userInfo.value.nickname,
      avatar: userInfo.value.avatar
    })
  }
})
</script>
