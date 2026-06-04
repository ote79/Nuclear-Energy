import request from './request'

export const login = (data) => request.post('/user/login', data)

export const register = (data) => request.post('/user/register', data)

export const getUserInfo = () => request.get('/user/info')

export const updateUserInfo = (data) => request.put('/user/update', data)

export const uploadAvatar = (file) => {
  const formData = new FormData()
  formData.append('file', file)
  return request.post('/upload', formData, {
    headers: { 'Content-Type': 'multipart/form-data' }
  })
}
