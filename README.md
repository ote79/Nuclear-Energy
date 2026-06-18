# 核能科普知识平台项目说明

## 一、项目简介

核能科普知识平台是一个面向公众的核能知识学习与测验系统，主要用于展示核能基础知识、辐射防护常识、核电站运行原理、核设施信息以及在线测验效果。

项目采用前后端分离架构：

- 前端负责页面展示、交互、路由跳转和接口调用。
- 后端负责用户认证、课程、知识文章、测验、学习记录、统计、错题本、上传等业务接口。
- 数据库保存用户、课程、文章、题库、答题记录、学习记录、设施信息等数据。

## 二、技术栈

### 前端

- Vue 3
- Vue Router
- Pinia
- Axios
- Element Plus
- Tailwind CSS
- Chart.js
- Vite

### 后端

- Spring Boot 4.0.6
- Spring Security
- JWT
- MyBatis-Plus
- MySQL 8
- Redis
- Lombok
- Spring Validation
- SpringDoc OpenAPI

## 三、目录结构

```text
nuclearEnergy
├── backend                         后端 Spring Boot 项目
│   ├── src/main/java
│   │   └── org/nuclearEnergy/backend
│   │       ├── common              统一返回结果
│   │       ├── config              安全配置、Web 配置
│   │       ├── controller          控制器接口层
│   │       ├── dto                 请求参数对象
│   │       ├── entity              数据库实体
│   │       ├── exception           全局异常处理
│   │       ├── mapper              MyBatis 数据访问层
│   │       ├── security            JWT 过滤器
│   │       ├── service             业务接口
│   │       ├── service/impl        业务实现
│   │       ├── utils               工具类
│   │       └── vo                  返回给前端的数据对象
│   └── src/main/resources          配置文件
├── frontend                        前端 Vue 项目
│   ├── src/api                     前端接口封装
│   ├── src/components              通用组件
│   ├── src/router                  前端路由
│   ├── src/stores                  前端状态和本地缓存
│   └── src/views                   页面视图
├── demo-data.sql                   演示基础数据 SQL
├── quiz-bank-100.sql               100 道题题库 SQL
├── frontend-api-docs.md            前端接口文档
├── wrong-book-api-docs.md          错题本接口文档
└── README.md                       项目基础说明
```

## 四、核心功能

### 1. 用户与认证

- 用户注册
- 用户登录
- JWT token 鉴权
- 获取当前用户信息
- 修改个人资料
- 修改密码
- 管理员用户管理

### 2. 知识文章

- 获取知识分类
- 分页查询知识文章
- 按分类筛选文章
- 按关键词搜索文章
- 查看文章详情

### 3. 在线课程

- 分页查询课程列表
- 查看课程详情和章节内容
- 提交课程学习进度
- 查询当前用户课程学习记录
- 课程章节中包含 Bilibili 学习链接

### 4. 知识测验

- 查询测验列表
- 查看测验详情和题目
- 登录后提交测验答案
- 后端自动判分
- 保存测验记录
- 查询当前用户测验记录

当前演示题库规模：

- 10 套测验
- 每套 10 道题
- 共 100 道题
- 共 400 个选项

### 5. 错题本

错题本采用后端方案，不依赖浏览器本地缓存。

- 根据当前登录用户的答题记录生成错题本
- 查询当前用户错题列表
- 移除指定错题
- 清空当前用户错题本

错题来源：

```text
quiz_record + quiz_answer_record
```

其中 `quiz_answer_record.is_correct = 0` 的记录会进入错题本。

接口详情见：

```text
wrong-book-api-docs.md
```

### 6. 学习统计

- 学习时长统计
- 已完成课程数量
- 最近学习记录
- 学习趋势图表
- 测验次数统计
- 平均正确率
- 测验成绩图表
- 平台总体统计

### 7. 首页与设施展示

- 首页轮播图
- 核设施列表
- 核设施坐标
- 核设施状态
- 核设施详情

### 8. 文件上传

- 支持登录用户上传文件
- 当前主要用于头像上传
- 上传文件保存到后端本地 `uploads` 目录
- 通过 `/uploads/**` 静态资源路径访问

## 五、主要接口概览

### 认证接口

| 方法 | 地址 | 说明 |
|---|---|---|
| POST | `/auth/login` | 用户登录 |
| POST | `/auth/register` | 用户注册 |

### 用户接口

| 方法 | 地址 | 说明 |
|---|---|---|
| GET | `/user/me` | 获取当前用户信息 |
| POST | `/user/profile` | 修改个人资料 |
| POST | `/user/password` | 修改密码 |

### 知识文章接口

| 方法 | 地址 | 说明 |
|---|---|---|
| GET | `/knowledge/categories` | 获取知识分类 |
| GET | `/knowledge/list` | 获取知识文章列表 |
| GET | `/knowledge/{id}` | 获取知识文章详情 |

### 课程接口

| 方法 | 地址 | 说明 |
|---|---|---|
| GET | `/course/list` | 获取课程列表 |
| GET | `/course/{id}` | 获取课程详情 |
| POST | `/course/progress` | 提交学习进度 |
| GET | `/course/records` | 获取当前用户课程记录 |

### 测验接口

| 方法 | 地址 | 说明 |
|---|---|---|
| GET | `/quiz/list` | 获取测验列表 |
| GET | `/quiz/list?id={id}` | 获取测验详情 |
| POST | `/quiz/submit` | 提交测验 |
| GET | `/quiz/records` | 获取当前用户测验记录 |

### 错题本接口

| 方法 | 地址 | 说明 |
|---|---|---|
| GET | `/quiz/wrong-questions` | 获取当前用户错题列表 |
| POST | `/quiz/wrong-questions/remove` | 移除指定错题 |
| DELETE | `/quiz/wrong-questions` | 清空当前用户错题本 |

### 统计接口

| 方法 | 地址 | 说明 |
|---|---|---|
| GET | `/stats/learning` | 获取学习统计 |
| GET | `/stats/quiz` | 获取测验统计 |
| GET | `/stats/platform` | 获取平台统计 |

### 首页与上传接口

| 方法 | 地址 | 说明 |
|---|---|---|
| GET | `/banners` | 获取首页轮播图 |
| GET | `/facilities` | 获取核设施列表 |
| POST | `/upload` | 上传文件 |

## 六、统一返回格式

后端接口统一返回：

```json
{
  "code": 200,
  "message": "success",
  "data": {}
}
```

常见错误：

```json
{
  "code": 401,
  "message": "用户未登录",
  "data": null
}
```

```json
{
  "code": 403,
  "message": "没有访问权限",
  "data": null
}
```

## 七、本地运行

### 1. 启动后端

进入后端目录：

```bash
cd backend
```

运行测试：

```bash
./mvnw.cmd test
```

启动服务：

```bash
./mvnw.cmd spring-boot:run
```

默认端口：

```text
http://localhost:8081
```

### 2. 启动前端

进入前端目录：

```bash
cd frontend
```

安装依赖：

```bash
npm install
```

启动开发服务：

```bash
npm.cmd run dev
```

构建前端：

```bash
npm.cmd run build
```

说明：Windows PowerShell 可能禁止执行 `npm.ps1`，此时使用 `npm.cmd`。

## 八、数据库与演示数据

项目使用 MySQL 保存业务数据。

演示数据文件：

```text
demo-data.sql
quiz-bank-100.sql
```

其中：

- `demo-data.sql`：基础演示数据，包括课程链接、轮播图、核设施等。
- `quiz-bank-100.sql`：100 道测验题库。

如果需要重新初始化演示题库，可以执行：

```sql
source D:/java/nuclearEnergy/quiz-bank-100.sql;
```

## 九、当前注意事项

### 1. 互动练习页面

`Practice.vue` 目前仍使用前端写死的数据，没有接入后端题库。

真正接入后端题库的是：

- `/quiz`
- `/quiz/:id`

### 2. 前端本地错题缓存

旧的前端错题本使用 `localStorage`，key 为：

```js
wrong_questions_book
```

这会导致切换账号时错题串号。

后端已经提供用户隔离的错题本接口，后续前端应改为调用：

```text
GET /api/quiz/wrong-questions
POST /api/quiz/wrong-questions/remove
DELETE /api/quiz/wrong-questions
```

### 3. 测验提交

正式测验提交需要登录。

未登录时后端无法知道答题结果属于哪个用户，因此不能记录测验成绩和错题。

### 4. 上传目录

上传文件保存在：

```text
backend/uploads
```

该目录属于运行时文件，已加入 `.gitignore`，不应提交到仓库。

## 十、项目展示亮点

- 前后端分离结构清晰。
- 已实现 JWT 登录鉴权。
- 课程、文章、测验、统计、错题本形成完整学习闭环。
- 题库已扩展到 100 道，适合演示测验效果。
- 错题本采用后端用户隔离方案，避免多账号切换时数据串号。
- 核设施地图和课程 Bilibili 链接增强了项目展示效果。
