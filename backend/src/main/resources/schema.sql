-- 核知识科普系统数据库初始化脚本

-- 课程表
CREATE TABLE IF NOT EXISTS `course` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(200) NOT NULL COMMENT '课程标题',
    `description` TEXT COMMENT '课程描述',
    `category` VARCHAR(50) COMMENT '分类: basic/protection/medical/emergency/myth',
    `cover` VARCHAR(500) COMMENT '封面图片URL',
    `duration` INT DEFAULT 30 COMMENT '预计学时(分钟)',
    `status` INT DEFAULT 1 COMMENT '状态: 1=启用, 0=禁用',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='培训课程表';

-- 课程章节表
CREATE TABLE IF NOT EXISTS `course_chapter` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `course_id` BIGINT NOT NULL COMMENT '所属课程ID',
    `title` VARCHAR(200) NOT NULL COMMENT '章节标题',
    `sort_order` INT DEFAULT 0 COMMENT '排序',
    `content` TEXT COMMENT '章节内容(HTML)',
    FOREIGN KEY (`course_id`) REFERENCES `course`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程章节表';

-- 用户课程进度表
CREATE TABLE IF NOT EXISTS `user_course_progress` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `course_id` BIGINT NOT NULL COMMENT '课程ID',
    `chapter_id` BIGINT NOT NULL COMMENT '章节ID',
    `completed` INT DEFAULT 0 COMMENT '是否完成: 1=完成, 0=未完成',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY `uk_user_course_chapter` (`user_id`, `course_id`, `chapter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户学习进度表';

-- 练习题表
CREATE TABLE IF NOT EXISTS `practice_question` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `question` TEXT NOT NULL COMMENT '题目',
    `options` TEXT NOT NULL COMMENT '选项(JSON数组)',
    `answer` INT NOT NULL COMMENT '正确答案索引',
    `explanation` TEXT COMMENT '答案解析',
    `category` VARCHAR(50) COMMENT '分类'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='练习题表';

-- 考题表
CREATE TABLE IF NOT EXISTS `exam_question` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `question` TEXT NOT NULL COMMENT '题目',
    `options` TEXT NOT NULL COMMENT '选项(JSON数组)',
    `answer` INT NOT NULL COMMENT '正确答案索引',
    `category` VARCHAR(50) COMMENT '分类'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='考题表';

-- 辐射记录表
CREATE TABLE IF NOT EXISTS `radiation_record` (
    `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `exam_type` VARCHAR(100) NOT NULL COMMENT '检查类型key',
    `dose` DOUBLE NOT NULL COMMENT '辐射剂量(mSv)',
    `exam_date` VARCHAR(20) COMMENT '检查日期',
    `hospital` VARCHAR(200) COMMENT '医院名称',
    `remark` VARCHAR(500) COMMENT '备注',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='个人辐射记录表';

-- 插入默认课程数据
INSERT INTO `course` (`title`, `description`, `category`, `cover`, `duration`) VALUES
('辐射基础知识入门', '了解什么是辐射、辐射的种类与来源、背景辐射与人工辐射的区别', 'basic', 'https://picsum.photos/seed/nuclear1/400/250', 45),
('辐射防护三原则', '掌握时间、距离、屏蔽三原则，了解日常生活中的辐射源', 'protection', 'https://picsum.photos/seed/nuclear2/400/250', 60),
('核医学检查须知', '了解核医学检查流程、患者注意事项及陪同家属须知', 'medical', 'https://picsum.photos/seed/nuclear3/400/250', 50),
('辐射应急处理', '学习遇到辐射突发状况的应对方法和公众自我保护措施', 'emergency', 'https://picsum.photos/seed/nuclear4/400/250', 40),
('核知识辟谣', '澄清常见误区，如"所有的辐射都有害"等错误认知', 'myth', 'https://picsum.photos/seed/nuclear5/400/250', 35);

-- 插入默认章节数据
INSERT INTO `course_chapter` (`course_id`, `title`, `sort_order`) VALUES
(1, '什么是辐射', 1), (1, '辐射的种类', 2), (1, '辐射的来源', 3), (1, '背景辐射与人工辐射', 4),
(2, '时间防护原则', 1), (2, '距离防护原则', 2), (2, '屏蔽防护原则', 3), (2, '日常生活中的辐射源', 4),
(3, '核医学检查流程', 1), (3, '患者注意事项', 2), (3, '陪同家属须知', 3),
(4, '辐射事故类型', 1), (4, '应急响应流程', 2), (4, '公众自我保护', 3),
(5, '辐射等于核泄漏吗？', 1), (5, '手机辐射致癌吗？', 2), (5, '微波炉辐射有害吗？', 3), (5, '核电站安全吗？', 4);

-- 插入默认练习题
INSERT INTO `practice_question` (`question`, `options`, `answer`, `explanation`, `category`) VALUES
('辐射防护的"三原则"不包括以下哪项？', '["时间防护","距离防护","温度防护","屏蔽防护"]', 2, '辐射防护三原则是：时间防护、距离防护、屏蔽防护。温度防护不属于辐射防护原则。', 'protection'),
('一次胸部CT检查的辐射剂量约为多少mSv？', '["0.02 mSv","2 mSv","7 mSv","25 mSv"]', 2, '一次胸部CT检查的辐射剂量约为7 mSv，远高于普通胸部X光的0.02 mSv。', 'basic'),
('人体每年接受的天然本底辐射约为？', '["0.1 mSv","2.4 mSv","10 mSv","50 mSv"]', 1, '人体每年接受的天然本底辐射约为2.4 mSv，这是自然环境中存在的辐射水平。', 'basic'),
('以下哪种材料屏蔽γ射线效果最好？', '["纸张","木板","铅板","塑料"]', 2, '铅板是屏蔽γ射线最常用的材料，因为铅的原子序数高，对γ射线有很好的吸收效果。', 'protection'),
('手机辐射属于哪种类型的辐射？', '["电离辐射","非电离辐射","核辐射","宇宙辐射"]', 1, '手机辐射属于非电离辐射（射频辐射），其能量较低，不足以使原子电离。', 'myth'),
('遇到核事故时，服用碘片的目的是？', '["治疗辐射病","保护甲状腺","增强免疫力","预防感冒"]', 1, '服用碘片（碘化钾）的目的是使甲状腺"吃饱"稳定碘，减少对放射性碘-131的吸收。', 'emergency'),
('距离辐射源距离增加一倍，辐射强度降低为原来的？', '["1/2","1/3","1/4","1/8"]', 2, '根据"平方反比定律"，距离增加一倍，辐射强度降低为原来的1/4。', 'protection'),
('公众年辐射剂量限值（不含医疗照射）是多少？', '["0.1 mSv","1 mSv","5 mSv","20 mSv"]', 1, '国际辐射防护委员会(ICRP)建议公众年辐射剂量限值为1 mSv（不含医疗照射和天然本底辐射）。', 'basic');

-- 插入默认考题
INSERT INTO `exam_question` (`question`, `options`, `answer`, `category`) VALUES
('辐射防护的"三原则"是什么？', '["时间、距离、屏蔽","温度、湿度、气压","速度、力度、角度","颜色、形状、大小"]', 0, 'protection'),
('一次胸部X光的辐射剂量约为多少？', '["7 mSv","0.02 mSv","25 mSv","100 mSv"]', 1, 'basic'),
('以下哪个是电离辐射？', '["手机信号","WiFi","X射线","微波"]', 2, 'basic'),
('公众年辐射剂量限值（不含医疗）是多少？', '["1 mSv","5 mSv","20 mSv","50 mSv"]', 0, 'protection'),
('核事故时服用碘片保护哪个器官？', '["心脏","肝脏","甲状腺","肺"]', 2, 'emergency'),
('距离增加一倍，辐射强度变为原来的？', '["1/2","1/4","1/8","不变"]', 1, 'protection'),
('以下哪种屏蔽γ射线效果最好？', '["纸张","铝板","铅板","木板"]', 2, 'protection'),
('天然本底辐射年剂量约为？', '["0.1 mSv","2.4 mSv","10 mSv","50 mSv"]', 1, 'basic'),
('核医学检查后应怎么做？', '["少喝水","多喝水","不需要特殊处理","立即洗澡"]', 1, 'medical'),
('手机辐射属于什么类型？', '["电离辐射","非电离辐射","核辐射","α射线"]', 1, 'myth');
