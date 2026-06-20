# 核能科普知识平台项目

## 1. 项目概述

核能科普知识平台是一个面向公众的核能知识学习系统，围绕“知识浏览、课程学习、在线测验、错题复习、学习统计”构建学习流程，同时提供核设施展示、辐射剂量计算、用户中心和管理员用户管理等功能。

项目采用前后端分离架构：

- 前端负责页面展示、路由跳转、用户交互和后端接口调用。
- 后端负责身份认证、权限控制、业务处理和数据持久化。
- MySQL 保存用户、课程、文章、题库和学习记录等业务数据。
- Redis 为项目提供缓存相关能力。

## 2. 技术栈

### 2.1 前端技术

| 技术 | 主要作用 |
|---|---|
| Vue 3 | 构建页面和组件 |
| Vue Router | 管理前端路由 |
| Pinia | 管理用户等全局状态 |
| Axios | 调用后端接口 |
| Element Plus | 提供界面组件 |
| Tailwind CSS | 编写页面样式 |
| Chart.js、vue-chartjs | 展示统计图表 |
| Vite | 启动开发环境和构建项目 |

### 2.2 后端技术

| 技术 | 主要作用 |
|---|---|
| Java 17 | 后端开发语言和运行环境 |
| Spring Boot 4.0.6 | 后端基础框架 |
| Spring MVC | 提供 REST 接口 |
| Spring Security | 认证与权限控制 |
| JWT | 保存无状态登录凭证 |
| MyBatis-Plus 3.5.15 | 数据库访问和实体映射 |
| MySQL | 保存核心业务数据 |
| Redis | 提供缓存能力 |
| Spring Validation | 校验接口请求参数 |
| SpringDoc OpenAPI | 生成 Swagger 接口文档 |
| Lombok | 简化实体类代码 |

## 3. 项目结构

```text
nuclearEnergy
├── backend/                       Spring Boot 后端项目
│   ├── src/main/java/.../common   统一响应对象
│   ├── src/main/java/.../config   Security 和 Web 配置
│   ├── src/main/java/.../controller
│   ├── src/main/java/.../dto      接口请求对象
│   ├── src/main/java/.../entity   数据库实体
│   ├── src/main/java/.../mapper   数据访问层
│   ├── src/main/java/.../service  业务层
│   ├── src/main/java/.../vo       接口响应对象
│   └── src/main/resources         应用配置
├── frontend/                      Vue 前端项目
│   ├── src/api                    Axios 接口封装
│   ├── src/components             公共组件
│   ├── src/router                 路由配置
│   ├── src/stores                 全局状态
│   └── src/views                  业务页面
├── demo-data.sql                  演示基础数据
├── quiz-bank-100.sql              100 道题题库数据
├── nuclear_energy_full_dump.sql   数据库完整导出
└── wrong-book-api-docs.md         错题本接口说明
```

后端采用分层结构：

```text
Controller → Service → Mapper → MySQL
```

- `Controller`：接收前端请求并返回统一结果。
- `Service`：处理判分、学习进度和身份验证等业务逻辑。
- `Mapper`：执行 SQL，完成数据库查询和写入。
- `DTO`：接收前端提交的请求参数。
- `VO`：定义返回给前端的数据结构。

## 4. 核心功能

### 4.1 用户认证与个人中心

- 用户注册和登录。
- BCrypt 密码加密与校验。
- JWT 生成、解析和登录身份恢复。
- 获取当前用户资料。
- 修改昵称、手机号、邮箱和头像。
- 修改用户密码。
- 用户退出登录。

### 4.2 角色与管理员功能

- 普通用户和管理员角色关联。
- 管理员查询用户列表。
- 管理员启用或禁用用户。
- 管理员修改用户角色。
- 使用方法级鉴权保护管理员接口。

### 4.3 科普知识

- 查询知识分类。
- 分页查询知识文章。
- 根据分类筛选文章。
- 根据关键词搜索文章。
- 查看文章详情。

### 4.4 在线课程

- 分页查询已发布课程。
- 根据关键词搜索课程。
- 查看课程详情和章节内容。
- 提交章节学习进度。
- 记录课程总进度、当前章节和学习时长。
- 查询个人课程学习记录。
- 通过课程章节访问相关学习视频。

### 4.5 在线测验

- 分页查询已发布测验。
- 查询测验题目和选项。
- 登录用户提交测验答案。
- 后端自动计算分数和正确题数。
- 保存测验记录和每道题的答题记录。
- 查询个人测验历史和历史最高分。

当前演示题库包含：

- 10 套测验；
- 每套 10 道题；
- 共 100 道题；
- 每道题 4 个选项，共 400 个选项。

### 4.6 错题本

- 根据当前用户的错误答题记录生成错题列表。
- 分页查询错题及其选项。
- 移除指定错题。
- 清空当前用户错题本。
- 根据登录用户隔离错题数据。

错题数据来自 `quiz_answer_record` 中的错误答题记录。

### 4.7 学习统计

- 统计累计学习时长。
- 统计已完成课程数量。
- 查询最近学习记录。
- 展示学习趋势图表。
- 统计测验次数和平均分。
- 展示测验成绩趋势。
- 展示平台用户、课程、文章和测验总数。

### 4.8 首页与核设施展示

- 展示首页轮播图。
- 展示平台数据概览。
- 查询核设施信息。
- 展示核设施名称、位置、状态和坐标。

### 4.9 文件上传

- 登录用户上传文件。
- 保存头像等用户文件。
- 记录上传文件信息。
- 通过 `/uploads/**` 路径访问上传资源。

### 4.10 前端辅助功能

- 辐射剂量计算。
- 互动练习。
- 错题练习。
- 学习与测验数据图表。
- 响应式导航栏和页面布局。

## 5. 主要后端接口

前端开发环境通过 Vite 将 `/api` 请求代理到后端。下表列出后端控制器中的实际路径。

| 模块 | 方法 | 接口路径 | 说明 |
|---|---|---|---|
| 认证 | POST | `/auth/login` | 用户登录 |
| 认证 | POST | `/auth/register` | 用户注册 |
| 用户 | GET | `/user/me` | 获取当前用户信息 |
| 用户 | POST | `/user/profile` | 修改个人资料 |
| 用户 | POST | `/user/password` | 修改密码 |
| 知识 | GET | `/knowledge/categories` | 查询知识分类 |
| 知识 | GET | `/knowledge/list` | 查询知识文章列表 |
| 知识 | GET | `/knowledge/{id}` | 查询文章详情 |
| 课程 | GET | `/course/list` | 查询课程列表 |
| 课程 | GET | `/course/{id}` | 查询课程详情 |
| 课程 | POST | `/course/progress` | 提交学习进度 |
| 课程 | GET | `/course/records` | 查询个人课程记录 |
| 测验 | GET | `/quiz/list` | 查询测验列表 |
| 测验 | GET | `/quiz/list?id={id}` | 查询测验详情 |
| 测验 | POST | `/quiz/submit` | 提交测验答案 |
| 测验 | GET | `/quiz/records` | 查询个人测验记录 |
| 错题本 | GET | `/quiz/wrong-questions` | 查询个人错题 |
| 错题本 | POST | `/quiz/wrong-questions/remove` | 移除指定错题 |
| 错题本 | DELETE | `/quiz/wrong-questions` | 清空个人错题 |
| 统计 | GET | `/stats/learning` | 查询学习统计 |
| 统计 | GET | `/stats/quiz` | 查询测验统计 |
| 统计 | GET | `/stats/platform` | 查询平台统计 |
| 首页 | GET | `/banners` | 查询轮播图 |
| 设施 | GET | `/facilities` | 查询核设施 |
| 上传 | POST | `/upload` | 上传文件 |
| 管理员 | GET | `/admin/users` | 查询用户列表 |
| 管理员 | PUT | `/admin/users/{userId}/status` | 修改用户状态 |
| 管理员 | PUT | `/admin/users/{userId}/roles` | 修改用户角色 |

后端接口统一返回以下结构：

```json
{
  "code": 200,
  "message": "success",
  "data": {}
}
```

## 6. 数据设计

| 业务范围 | 主要数据表 |
|---|---|
| 用户与权限 | `sys_user`、`sys_role`、`sys_user_role` |
| 知识文章 | `knowledge_category`、`knowledge_article` |
| 课程学习 | `course`、`course_chapter`、`course_study_record`、`course_chapter_progress` |
| 在线测验 | `quiz`、`quiz_question`、`quiz_option`、`quiz_record`、`quiz_answer_record` |
| 首页内容 | `banner`、`nuclear_facility` |
| 文件上传 | `upload_file` |

主要业务关系：

- 一个用户可以拥有多个角色。
- 一门课程可以包含多个章节。
- 一个用户可以产生多条课程和章节学习记录。
- 一套测验可以包含多道题目。
- 一道题目可以包含多个选项。
- 一次测验提交会产生一条测验记录和多条逐题答题记录。

## 7. 本地运行方式

### 7.1 环境要求

- JDK 17
- Node.js 和 npm
- MySQL 8
- Redis

### 7.2 准备后端配置

复制开发环境配置示例：

```powershell
Copy-Item backend\src\main\resources\application-dev.example.yml `
  backend\src\main\resources\application-dev.yml
```

在 `application-dev.yml` 中填写当前环境使用的 MySQL、Redis 和 JWT 配置。

### 7.3 初始化数据库

项目提供以下 SQL 文件：

- `nuclear_energy_full_dump.sql`：完整数据库结构和数据。
- `demo-data.sql`：课程、轮播图和核设施等演示数据。
- `quiz-bank-100.sql`：100 道测验题数据。

### 7.4 启动后端

```powershell
Set-Location backend
.\mvnw.cmd test
.\mvnw.cmd spring-boot:run
```

后端默认地址：`http://localhost:8081`。

Swagger 页面地址：`http://localhost:8081/swagger-ui/index.html`。

### 7.5 启动前端

```powershell
Set-Location frontend
npm.cmd install
npm.cmd run dev
```

前端默认开发端口为 `3000`。

构建前端：

```powershell
npm.cmd run build
```

## 8. 项目特点

- 项目主题明确，围绕核能科普和在线学习展开。
- 采用 Vue 与 Spring Boot 前后端分离架构。
- 后端按照 Controller、Service、Mapper 进行分层。
- 使用 JWT 和角色权限实现身份认证。
- 课程、测验、错题和统计组成完整学习流程。
- 题库包含 100 道题，具备完整演示数据。
- 错题本使用真实答题记录并按用户隔离。
- 核设施展示、课程视频和辐射剂量计算体现核能主题特色。

## 9. 简介

核能科普知识平台是一个包含前端页面、后端接口、数据库和业务数据的全栈项目。系统以核能知识传播为主题，将文章阅读、课程学习、在线测验、错题练习和学习统计等功能整合到同一平台中。

项目后端实现了用户认证、角色权限、知识文章、课程、测验、错题、统计和文件上传等业务；前端提供了对应的页面交互和数据展示，形成了较完整的核能科普学习平台。
