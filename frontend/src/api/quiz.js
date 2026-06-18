import request from './request'

export const getQuizList = (params) => request.get('/quiz/list', { params })

export const submitQuiz = (data) => request.post('/quiz/submit', data)

export const getQuizRecords = (params) => request.get('/quiz/records', { params })
