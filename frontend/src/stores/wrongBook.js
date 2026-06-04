const STORAGE_KEY = 'wrong_questions_book'

export function getAllWrongQuestions() {
  try {
    return JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]')
  } catch {
    return []
  }
}

export function getWrongCount() {
  return getAllWrongQuestions().length
}

export function addWrongQuestions(questions) {
  const existing = getAllWrongQuestions()
  for (const q of questions) {
    const idx = existing.findIndex(e => e.id === q.id)
    if (idx >= 0) {
      existing[idx].wrongCount = (existing[idx].wrongCount || 1) + 1
      existing[idx].lastWrongAt = new Date().toISOString()
    } else {
      existing.push({
        ...q,
        wrongCount: 1,
        lastWrongAt: new Date().toISOString()
      })
    }
  }
  localStorage.setItem(STORAGE_KEY, JSON.stringify(existing))
}

export function removeWrongQuestion(id) {
  const existing = getAllWrongQuestions().filter(q => q.id !== id)
  localStorage.setItem(STORAGE_KEY, JSON.stringify(existing))
}

export function removeCorrectQuestions(ids) {
  const existing = getAllWrongQuestions().filter(q => !ids.includes(q.id))
  localStorage.setItem(STORAGE_KEY, JSON.stringify(existing))
}

export function clearWrongBook() {
  localStorage.removeItem(STORAGE_KEY)
}
