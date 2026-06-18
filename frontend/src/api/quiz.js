import request from './request'

export const getQuizList = (params) => request.get('/quiz/list', { params })

export const submitQuiz = (data) => request.post('/quiz/submit', data)

export const getQuizRecords = (params) => request.get('/quiz/records', { params })

// 错题本
export const getWrongQuestions = (params) => request.get('/quiz/wrong-questions', { params })
export const removeWrongQuestions = (data) => request.post('/quiz/wrong-questions/remove', data)
export const clearWrongQuestions = () => request.delete('/quiz/wrong-questions')
