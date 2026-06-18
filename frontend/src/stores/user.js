import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { login as loginApi, register as registerApi, getUserInfo } from '../api/user'

const MOCK_USERS_KEY = 'mock_users'

function getMockUsers() {
  try { return JSON.parse(localStorage.getItem(MOCK_USERS_KEY) || '{}') } catch { return {} }
}

function saveMockUser(key, data) {
  const users = getMockUsers()
  users[key] = data
  localStorage.setItem(MOCK_USERS_KEY, JSON.stringify(users))
}

export const useUserStore = defineStore('user', () => {
  const token = ref(localStorage.getItem('token') || '')
  const userInfo = ref(null)
  const isLoggedIn = computed(() => !!token.value)

  async function login(form) {
    try {
      const res = await loginApi(form)
      token.value = res.data.token
      localStorage.setItem('token', res.data.token)
      await fetchUserInfo()
      return res
    } catch (e) {
      // 后端返回的 message 直接透传
      if (e.isBusinessError) throw e
      // 后端不通才走本地 mock
      const users = getMockUsers()
      const user = users[form.username]
      if (!user) throw new Error('账号不存在')
      if (user.password !== form.password) throw new Error('密码错误')
      const mockToken = 'mock_token_' + form.username
      token.value = mockToken
      localStorage.setItem('token', mockToken)
      userInfo.value = { username: form.username, nickname: user.nickname, email: user.email, phone: user.phone, createdAt: user.createdAt }
      return { data: { token: mockToken } }
    }
  }

  async function register(form) {
    try {
      return await registerApi(form)
    } catch (e) {
      // 后端返回的 message 直接透传
      if (e.isBusinessError) throw e
      // 后端不通才走本地 mock
      const users = getMockUsers()
      if (users[form.username]) throw new Error('用户名已存在')
      const userData = {
        nickname: form.nickname,
        password: form.password,
        email: form.email || '',
        phone: form.phone,
        createdAt: new Date().toISOString().slice(0, 10)
      }
      saveMockUser(form.username, userData)
      return { data: null }
    }
  }

  async function fetchUserInfo() {
    if (!token.value) return
    try {
      const res = await getUserInfo()
      userInfo.value = res.data
    } catch {
      if (!token.value.startsWith('mock_token_')) {
        logout()
      }
    }
  }

  function logout() {
    token.value = ''
    userInfo.value = null
    localStorage.removeItem('token')
  }

  return { token, userInfo, isLoggedIn, login, register, fetchUserInfo, logout }
})
