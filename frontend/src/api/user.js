import request from './request'

export const login = (data) => request.post('/auth/login', data)

export const register = (data) => request.post('/auth/register', data)

export const getUserInfo = () => request.get('/user/me')

export const updateProfile = (data) => request.post('/user/profile', data)

export const changePassword = (data) => request.post('/user/password', data)

export const uploadAvatar = (file) => {
  const formData = new FormData()
  formData.append('file', file)
  return request.post('/upload', formData, {
    headers: { 'Content-Type': 'multipart/form-data' }
  })
}
