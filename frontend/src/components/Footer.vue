<template>
  <footer class="bg-gray-800 text-gray-300 py-8 mt-auto">
    <div class="page-container">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
        <div>
          <h3 class="text-white text-lg font-bold mb-3 flex items-center gap-2">
            <el-icon><Sunny /></el-icon> 核能科普
          </h3>
          <p class="text-sm leading-relaxed">
            致力于核能与辐射安全知识的普及教育，帮助公众正确认识核能技术，了解辐射防护知识。
          </p>
        </div>
        <div>
          <h4 class="text-white font-medium mb-3">快速导航</h4>
          <ul class="space-y-2 text-sm">
            <li><router-link to="/knowledge" class="hover:text-white transition-colors">科普知识</router-link></li>
            <li><router-link to="/course" class="hover:text-white transition-colors">在线课程</router-link></li>
            <li><router-link to="/quiz" class="hover:text-white transition-colors">知识测验</router-link></li>
          </ul>
        </div>
        <div>
          <h4 class="text-white font-medium mb-3">关于我们</h4>
          <ul class="space-y-2 text-sm">
            <li>联系方式：contact@nuclear-edu.com</li>
            <li>服务热线：400-000-0000</li>
          </ul>
        </div>
      </div>
      <div class="border-t border-gray-700 mt-6 pt-6 text-center text-sm text-gray-500">
        &copy; {{ new Date().getFullYear() }} 核能科普平台 版权所有
      </div>
    </div>
  </footer>
</template>
