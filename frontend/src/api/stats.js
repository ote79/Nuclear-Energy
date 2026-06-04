import request from './request'

export const getLearningStats = () => request.get('/stats/learning')

export const getQuizStats = () => request.get('/stats/quiz')

export const getBanners = () => request.get('/banners')

export const getPlatformStats = () => request.get('/stats/platform')

export const getNuclearFacilities = () => request.get('/facilities')
