import request from './request'

export const getCourseList = (params) => request.get('/course/list', { params })

export const getCourseDetail = (id) => request.get(`/course/${id}`)

export const submitProgress = (data) => request.post('/course/progress', data)

export const getMyRecords = (params) => request.get('/course/records', { params })
