import request from './request'

export const getKnowledgeList = (params) => request.get('/knowledge/list', { params })

export const getKnowledgeDetail = (id) => request.get(`/knowledge/${id}`)

export const getCategories = () => request.get('/knowledge/categories')
