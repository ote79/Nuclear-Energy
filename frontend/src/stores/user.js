import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { login as loginApi, register as registerApi, getUserInfo } from '../api/user'

const MOCK_USERS_KEY = 'mock_users'

function getMockUsers() {
  try { return JSON.parse(localStorage.getItem(MOCK_USERS_KEY) || '{}') } catch { return {} }
}

function saveMockUser(username, data) {
  const users = getMockUsers()
  users[username] = data
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
    } catch {
      const users = getMockUsers()
      const usersList = Object.values(users)
      // Lookup by email or phone
      const key = form.email || form.phone
      let user = users[key]
      if (!user && form.phone) {
        user = usersList.find(u => u.phone === form.phone)
      }
      if (!user) throw new Error('账号不存在')
      if (user.password !== form.password) throw new Error('密码错误')
      const mockToken = 'mock_token_' + key
      token.value = mockToken
      localStorage.setItem('token', mockToken)
      userInfo.value = { email: user.email || key, phone: user.phone, nickname: user.nickname, createdAt: user.createdAt }
      return { data: { token: mockToken } }
    }
  }

  async function register(form) {
    try {
      return await registerApi(form)
    } catch {
      const users = getMockUsers()
      if (form.email && users[form.email]) throw new Error('该邮箱已注册')
      if (form.phone && Object.values(users).some(u => u.phone === form.phone)) throw new Error('该手机号已注册')
      const key = form.email || form.phone
      const userData = {
        email: form.email,
        phone: form.phone,
        nickname: form.nickname,
        password: form.password,
        createdAt: new Date().toISOString().slice(0, 10)
      }
      saveMockUser(key, userData)
      return { data: null }
    }
  }

  async function fetchUserInfo() {
    if (!token.value) return
    try {
      const res = await getUserInfo()
      userInfo.value = res.data
    } catch {
      // Mock: for mock tokens, userInfo already set during login
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
