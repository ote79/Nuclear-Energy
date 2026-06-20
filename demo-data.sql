-- 核能科普平台演示数据
-- 可重复执行：主键冲突时更新演示内容，不会清空已有业务数据。

set names utf8mb4;

update course_chapter
set content = concat(content, '<p><strong>B站学习链接：</strong><a href="https://search.bilibili.com/all?keyword=%E6%A0%B8%E8%83%BD%20%E5%9F%BA%E7%A1%80%20%E8%AF%BE%E7%A8%8B" target="_blank">在 Bilibili 搜索“核能 基础 课程”</a></p>')
where course_id = 1 and content not like '%B站学习链接%';

update course_chapter
set content = concat(content, '<p><strong>B站学习链接：</strong><a href="https://search.bilibili.com/all?keyword=%E8%BE%90%E5%B0%84%E9%98%B2%E6%8A%A4%20%E8%AF%BE%E7%A8%8B" target="_blank">在 Bilibili 搜索“辐射防护 课程”</a></p>')
where course_id = 2 and content not like '%B站学习链接%';

update course_chapter
set content = concat(content, '<p><strong>B站学习链接：</strong><a href="https://search.bilibili.com/all?keyword=%E6%A0%B8%E7%94%B5%E7%AB%99%20%E5%B7%A5%E4%BD%9C%E5%8E%9F%E7%90%86" target="_blank">在 Bilibili 搜索“核电站 工作原理”</a></p>')
where course_id = 3 and content not like '%B站学习链接%';

update course_chapter
set content = concat(content, '<p><strong>B站学习链接：</strong><a href="https://search.bilibili.com/all?keyword=%E6%A0%B8%E7%87%83%E6%96%99%E5%BE%AA%E7%8E%AF%20%E8%AF%BE%E7%A8%8B" target="_blank">在 Bilibili 搜索“核燃料循环 课程”</a></p>')
where course_id = 4 and content not like '%B站学习链接%';

update course_chapter
set content = concat(content, '<p><strong>B站学习链接：</strong><a href="https://search.bilibili.com/all?keyword=%E6%A0%B8%E6%8A%80%E6%9C%AF%20%E5%8C%BB%E5%AD%A6%E5%BA%94%E7%94%A8%20%E7%A7%91%E6%99%AE" target="_blank">在 Bilibili 搜索“核技术 医学应用 科普”</a></p>')
where course_id = 5 and content not like '%B站学习链接%';

update course_chapter
set content = concat(content, '<p><strong>B站学习链接：</strong><a href="https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE" target="_blank">在 Bilibili 搜索“核安全 核事故 科普”</a></p>')
where course_id >= 6 and content not like '%B站学习链接%';

insert into quiz(id, title, description, question_count, time_limit, status, create_time, update_time) values
(1001, '核辐射基础知识测验', '测试核辐射类型、单位和基础防护知识。', 5, 10, 1, now(), now()),
(1002, '核电站安全知识测验', '检验核电站工作原理、安全屏障和事故认知。', 5, 12, 1, now(), now()),
(1003, '核技术应用测验', '了解核技术在医学、工业和能源中的应用。', 5, 10, 1, now(), now())
on duplicate key update
title = values(title),
description = values(description),
question_count = values(question_count),
time_limit = values(time_limit),
status = values(status),
update_time = now();

insert into quiz_question(id, quiz_id, title, question_type, answer, explanation, sort, status, create_time, update_time) values
(10001, 1001, '以下哪种辐射穿透力通常最强？', 'single', 'C', 'γ射线属于高能电磁波，穿透力通常强于α射线和β射线。', 1, 1, now(), now()),
(10002, 1001, '一张普通纸可以较好阻挡哪种射线？', 'single', 'A', 'α射线穿透力弱，纸张或人体表皮通常就能阻挡。', 2, 1, now(), now()),
(10003, 1001, '以下哪些属于天然辐射来源？', 'multi', 'A,C', '宇宙射线和土壤、岩石中的放射性核素属于天然辐射来源。', 3, 1, now(), now()),
(10004, 1001, '衡量辐射对人体生物效应常用的单位是？', 'single', 'C', '希沃特（Sv）用于描述辐射对人体造成的生物效应。', 4, 1, now(), now()),
(10005, 1001, '减少外照射剂量的基本方法包括？', 'multi', 'A,B,C', '辐射防护常用时间、距离、屏蔽三原则。', 5, 1, now(), now()),
(10006, 1002, '当前商业核电站主要利用哪类反应释放能量？', 'single', 'A', '目前商业核电站主要利用铀等重核的可控核裂变释放热量。', 1, 1, now(), now()),
(10007, 1002, '压水堆核电站中，反应堆释放的热量主要先传给什么？', 'single', 'B', '压水堆一回路冷却剂从堆芯带出热量，再通过蒸汽发生器传递给二回路。', 2, 1, now(), now()),
(10008, 1002, '核电站多重安全屏障通常包括？', 'multi', 'A,B,C', '燃料芯块、燃料包壳和安全壳等共同构成多道安全屏障。', 3, 1, now(), now()),
(10009, 1002, '控制棒的主要作用是吸收中子、调节链式反应。', 'judge', 'A', '控制棒材料具有较强中子吸收能力，可用于调节或停止反应。', 4, 1, now(), now()),
(10010, 1002, '核电站正常运行时不需要环境辐射监测。', 'judge', 'B', '核电站正常运行也需要持续开展环境辐射监测。', 5, 1, now(), now()),
(10011, 1003, '放射性同位素可用于医学诊断和治疗。', 'judge', 'A', '核医学中常用放射性药物进行显像检查或靶向治疗。', 1, 1, now(), now()),
(10012, 1003, '工业无损检测常利用射线检查材料内部缺陷。', 'judge', 'A', '射线探伤可以在不破坏工件的情况下发现内部裂纹或缺陷。', 2, 1, now(), now()),
(10013, 1003, '以下哪些是核技术的常见应用？', 'multi', 'A,B,C', '医学影像、食品辐照保鲜和工业探伤都是核技术应用场景。', 3, 1, now(), now()),
(10014, 1003, '核聚变目前已经是商业核电站的主流发电方式。', 'judge', 'B', '商业核电站当前主要使用核裂变，核聚变仍处于研发和示范阶段。', 4, 1, now(), now()),
(10015, 1003, '食品辐照保鲜的目的通常是？', 'single', 'B', '食品辐照主要用于杀菌、杀虫、延长保存时间。', 5, 1, now(), now())
on duplicate key update
title = values(title),
question_type = values(question_type),
answer = values(answer),
explanation = values(explanation),
sort = values(sort),
status = values(status),
update_time = now();

insert into quiz_option(id, question_id, option_key, option_text, sort, create_time, update_time) values
(100001, 10001, 'A', 'α射线', 1, now(), now()),
(100002, 10001, 'B', 'β射线', 2, now(), now()),
(100003, 10001, 'C', 'γ射线', 3, now(), now()),
(100004, 10001, 'D', '可见光', 4, now(), now()),
(100005, 10002, 'A', 'α射线', 1, now(), now()),
(100006, 10002, 'B', 'γ射线', 2, now(), now()),
(100007, 10002, 'C', '中子辐射', 3, now(), now()),
(100008, 10002, 'D', 'X射线', 4, now(), now()),
(100009, 10003, 'A', '宇宙射线', 1, now(), now()),
(100010, 10003, 'B', '胸部CT检查', 2, now(), now()),
(100011, 10003, 'C', '土壤中的放射性核素', 3, now(), now()),
(100012, 10003, 'D', '工业探伤设备', 4, now(), now()),
(100013, 10004, 'A', '贝可勒尔（Bq）', 1, now(), now()),
(100014, 10004, 'B', '瓦特（W）', 2, now(), now()),
(100015, 10004, 'C', '希沃特（Sv）', 3, now(), now()),
(100016, 10004, 'D', '摄氏度（℃）', 4, now(), now()),
(100017, 10005, 'A', '缩短受照时间', 1, now(), now()),
(100018, 10005, 'B', '增大与辐射源的距离', 2, now(), now()),
(100019, 10005, 'C', '使用合适屏蔽材料', 3, now(), now()),
(100020, 10005, 'D', '忽略剂量监测', 4, now(), now()),
(100021, 10006, 'A', '核裂变', 1, now(), now()),
(100022, 10006, 'B', '核聚变', 2, now(), now()),
(100023, 10006, 'C', '化学燃烧', 3, now(), now()),
(100024, 10006, 'D', '太阳能光伏', 4, now(), now()),
(100025, 10007, 'A', '控制棒', 1, now(), now()),
(100026, 10007, 'B', '一回路冷却剂', 2, now(), now()),
(100027, 10007, 'C', '发电机转子', 3, now(), now()),
(100028, 10007, 'D', '冷却塔空气', 4, now(), now()),
(100029, 10008, 'A', '燃料芯块', 1, now(), now()),
(100030, 10008, 'B', '燃料包壳', 2, now(), now()),
(100031, 10008, 'C', '安全壳', 3, now(), now()),
(100032, 10008, 'D', '办公楼玻璃', 4, now(), now()),
(100033, 10009, 'A', '正确', 1, now(), now()),
(100034, 10009, 'B', '错误', 2, now(), now()),
(100035, 10010, 'A', '正确', 1, now(), now()),
(100036, 10010, 'B', '错误', 2, now(), now()),
(100037, 10011, 'A', '正确', 1, now(), now()),
(100038, 10011, 'B', '错误', 2, now(), now()),
(100039, 10012, 'A', '正确', 1, now(), now()),
(100040, 10012, 'B', '错误', 2, now(), now()),
(100041, 10013, 'A', '核医学影像', 1, now(), now()),
(100042, 10013, 'B', '食品辐照保鲜', 2, now(), now()),
(100043, 10013, 'C', '工业无损检测', 3, now(), now()),
(100044, 10013, 'D', '普通机械打磨', 4, now(), now()),
(100045, 10014, 'A', '正确', 1, now(), now()),
(100046, 10014, 'B', '错误', 2, now(), now()),
(100047, 10015, 'A', '增加食品放射性', 1, now(), now()),
(100048, 10015, 'B', '杀菌杀虫并延长保存时间', 2, now(), now()),
(100049, 10015, 'C', '让食品发电', 3, now(), now()),
(100050, 10015, 'D', '改变食品包装颜色', 4, now(), now())
on duplicate key update
option_text = values(option_text),
sort = values(sort),
update_time = now();

insert into banner(id, title, image_url, link_url, sort, status, create_time, update_time) values
(1001, '核能科普知识平台', '/uploads/banner/nuclear-science.svg', '/knowledge', 1, 1, now(), now()),
(1002, '系统学习核能基础课程', '/uploads/banner/course.svg', '/course', 2, 1, now(), now()),
(1003, '完成测验检验学习效果', '/uploads/banner/quiz.svg', '/quiz', 3, 1, now(), now())
on duplicate key update
title = values(title),
image_url = values(image_url),
link_url = values(link_url),
sort = values(sort),
status = values(status),
update_time = now();

insert into nuclear_facility(id, name, facility_type, lat, lng, status, summary, detail, map_url, news_url, gradient, map_x, map_y, sort, enabled, create_time, update_time) values
(1001, '大亚湾核电站', 'power_plant', 22.5964, 114.5425, 'operating', '中国首座大型商用核电站，位于广东深圳大鹏新区。', '大亚湾核电站采用压水堆技术，是中国商业核电发展的重要起点，长期保持稳定运行。', 'https://www.google.com/maps?q=22.5964,114.5425', 'https://www.baidu.com/s?wd=大亚湾核电站', 'linear-gradient(135deg, #0d9488 0%, #14b8a6 100%)', 74, 48, 1, 1, now(), now()),
(1002, '秦山核电站', 'power_plant', 30.4344, 120.9572, 'operating', '中国大陆第一座自行设计、建造和运营的核电站。', '秦山核电站位于浙江海盐，是中国核电自主化发展的标志性工程。', 'https://www.google.com/maps?q=30.4344,120.9572', 'https://www.baidu.com/s?wd=秦山核电站', 'linear-gradient(135deg, #2563eb 0%, #3b82f6 100%)', 77, 38, 2, 1, now(), now()),
(1003, '福岛第一核电站', 'historical', 37.4211, 141.0328, 'decommissioned', '2011年地震海啸后发生严重核事故，现处于退役处理中。', '福岛第一核电站事故推动了全球核电站极端自然灾害防护和应急体系再评估。', 'https://www.google.com/maps?q=37.4211,141.0328', 'https://www.baidu.com/s?wd=福岛第一核电站事故', 'linear-gradient(135deg, #0c3547 0%, #1a6b8a 100%)', 82, 30, 3, 1, now(), now()),
(1004, '切尔诺贝利核电站', 'historical', 51.3894, 30.0988, 'decommissioned', '1986年发生严重核事故，周边区域长期受到影响。', '切尔诺贝利事故是核安全史上的重要案例，深刻影响了反应堆安全设计和应急管理。', 'https://www.google.com/maps?q=51.3894,30.0988', 'https://www.baidu.com/s?wd=切尔诺贝利核事故', 'linear-gradient(135deg, #1a1a2e 0%, #0f3460 100%)', 54, 28, 4, 1, now(), now()),
(1005, '三里岛核电站', 'historical', 40.1537, -76.7244, 'decommissioned', '1979年发生美国商业核电史上重要事故。', '三里岛事故虽未造成大规模放射性后果，但显著改变了核电行业的运行管理和公众沟通方式。', 'https://www.google.com/maps?q=40.1537,-76.7244', 'https://www.baidu.com/s?wd=三里岛核事故', 'linear-gradient(135deg, #991b1b 0%, #dc2626 100%)', 25, 32, 5, 1, now(), now()),
(1006, '国际原子能机构', 'monitoring', 48.235, 16.415, 'monitoring', '国际原子能机构推动核安全、核安保与和平利用核能。', 'IAEA 通过安全标准、同行评审和监测合作支持各国提升核与辐射安全水平。', 'https://www.google.com/maps?q=48.235,16.415', 'https://www.iaea.org/', 'linear-gradient(135deg, #b45309 0%, #f59e0b 100%)', 52, 26, 6, 1, now(), now())
on duplicate key update
name = values(name),
facility_type = values(facility_type),
lat = values(lat),
lng = values(lng),
status = values(status),
summary = values(summary),
detail = values(detail),
map_url = values(map_url),
news_url = values(news_url),
gradient = values(gradient),
map_x = values(map_x),
map_y = values(map_y),
sort = values(sort),
enabled = values(enabled),
update_time = now();

-- 执行后可用这些查询快速验证：
-- select count(*) from quiz;
-- select count(*) from quiz_question;
-- select count(*) from quiz_option;
-- select count(*) from banner;
-- select count(*) from nuclear_facility;
-- select count(*) from course_chapter where content like '%B站学习链接%';
