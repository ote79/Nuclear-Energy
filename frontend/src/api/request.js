import axios from 'axios'
import { ElMessage } from 'element-plus'
import router from '../router'

const request = axios.create({
  baseURL: '/api',
  timeout: 5000
})

request.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => Promise.reject(error)
)

request.interceptors.response.use(
  (response) => {
    const res = response.data
    if (res.code !== 200) {
      if (res.code === 401) {
        localStorage.removeItem('token')
        router.push('/login')
      }
      const err = new Error(res.message)
      err.isBusinessError = true
      return Promise.reject(err)
    }
    return res
  },
  (error) => {
    // 后端未运行或网络不通时静默处理，不弹错误提示
    if (!error.response) {
      return Promise.reject(error)
    }
    switch (error.response.status) {
      case 401:
        localStorage.removeItem('token')
        router.push('/login')
        ElMessage.error('登录已过期，请重新登录')
        break
      case 403:
        ElMessage.error('没有权限访问')
        break
    }
    return Promise.reject(error)
  }
)

export default request
