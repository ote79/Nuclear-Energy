-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: nuclear_energy
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `nuclear_energy`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `nuclear_energy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `nuclear_energy`;

--
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banner` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '轮播图ID',
  `title` varchar(200) NOT NULL COMMENT '标题',
  `image_url` varchar(500) NOT NULL COMMENT '图片地址',
  `link_url` varchar(500) DEFAULT NULL COMMENT '跳转地址',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序号',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：1启用 0禁用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_status_sort` (`status`,`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=1004 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='首页轮播图表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner`
--

LOCK TABLES `banner` WRITE;
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
INSERT INTO `banner` VALUES (1001,'核能科普知识平台','/uploads/banner/nuclear-science.svg','/knowledge',1,1,'2026-06-18 13:19:13','2026-06-18 13:19:13'),(1002,'系统学习核能基础课程','/uploads/banner/course.svg','/course',2,1,'2026-06-18 13:19:13','2026-06-18 13:19:13'),(1003,'完成测验检验学习效果','/uploads/banner/quiz.svg','/quiz',3,1,'2026-06-18 13:19:13','2026-06-18 13:19:13');
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `cover_url` varchar(255) DEFAULT NULL,
  `chapter_count` int NOT NULL DEFAULT '0',
  `duration` varchar(50) NOT NULL DEFAULT '',
  `status` tinyint NOT NULL DEFAULT '1',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'核能基础知识入门','从原子结构、核反应到核能利用，系统了解核能基础知识。','https://example.com/course1.jpg',3,'2小时30分',1,'2026-06-11 18:34:30','2026-06-11 18:34:30'),(2,'辐射防护与安全','学习常见辐射类型、防护原则和日常安全规范。','https://example.com/course2.jpg',3,'2小时',1,'2026-06-11 18:34:30','2026-06-11 18:34:30'),(3,'核电站工作原理','介绍核电站主要系统、能量转换过程和基本运行逻辑。','https://example.com/course3.jpg',3,'3小时10分',1,'2026-06-11 18:34:30','2026-06-11 18:34:30'),(4,'核燃料循环概论','了解核燃料从开采、加工到后处理的完整过程。','https://example.com/course4.jpg',3,'2小时45分',1,'2026-06-11 18:34:30','2026-06-11 18:34:30'),(5,'核技术与医学应用','认识放射性同位素在检查、治疗中的主要用途。','https://example.com/course5.jpg',3,'1小时50分',1,'2026-06-11 18:34:30','2026-06-11 18:34:30'),(6,'世界核电发展史','回顾全球核电发展的重要阶段和代表性事件。','https://example.com/course6.jpg',3,'2小时15分',1,'2026-06-11 18:34:30','2026-06-11 18:34:30'),(7,'核事故案例分析','通过典型核事故案例理解核安全的重要性。','https://example.com/course7.jpg',3,'2小时40分',1,'2026-06-11 18:34:30','2026-06-11 18:34:30'),(8,'反应堆类型基础','介绍压水堆、沸水堆、快堆等常见反应堆类型。','https://example.com/course8.jpg',3,'3小时',1,'2026-06-11 18:34:30','2026-06-11 18:34:30'),(9,'核废料处理入门','讲解核废料分类、储存和处理的基本思路。','https://example.com/course9.jpg',3,'2小时20分',1,'2026-06-11 18:34:30','2026-06-11 18:34:30'),(10,'核能与环境保护','分析核能在减排、能源转型中的作用与争议。','https://example.com/course10.jpg',3,'2小时',1,'2026-06-11 18:34:30','2026-06-11 18:34:30'),(11,'聚变能源前沿','了解可控核聚变的原理、难点和最新方向。','https://example.com/course11.jpg',3,'2小时55分',1,'2026-06-11 18:34:30','2026-06-11 18:34:30'),(12,'核电站岗位认知','面向初学者介绍核电站常见岗位与职责分工。','https://example.com/course12.jpg',3,'1小时40分',1,'2026-06-11 18:34:30','2026-06-11 18:34:30');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_chapter`
--

DROP TABLE IF EXISTS `course_chapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_chapter` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `course_id` bigint NOT NULL,
  `title` varchar(100) NOT NULL,
  `content` longtext,
  `sort` int NOT NULL DEFAULT '0',
  `status` tinyint NOT NULL DEFAULT '1',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_chapter`
--

LOCK TABLES `course_chapter` WRITE;
/*!40000 ALTER TABLE `course_chapter` DISABLE KEYS */;
INSERT INTO `course_chapter` VALUES (1,1,'第一章 核能是什么','<h2>核能简介</h2><p>核能是原子核发生变化时释放出的能量，主要包括核裂变和核聚变两种形式。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E8%83%BD%20%E5%9F%BA%E7%A1%80%20%E8%AF%BE%E7%A8%8B\" target=\"_blank\">在 Bilibili 搜索“核能 基础 课程”</a></p>',1,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(2,1,'第二章 原子结构基础','<h2>原子结构</h2><p>原子由原子核和核外电子组成，原子核由质子和中子构成。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E8%83%BD%20%E5%9F%BA%E7%A1%80%20%E8%AF%BE%E7%A8%8B\" target=\"_blank\">在 Bilibili 搜索“核能 基础 课程”</a></p>',2,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(3,1,'第三章 核裂变初步认识','<h2>核裂变</h2><p>某些重原子核在吸收中子后会分裂，并释放大量能量。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E8%83%BD%20%E5%9F%BA%E7%A1%80%20%E8%AF%BE%E7%A8%8B\" target=\"_blank\">在 Bilibili 搜索“核能 基础 课程”</a></p>',3,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(4,2,'第一章 辐射的基本概念','<h2>辐射定义</h2><p>辐射是能量以波或粒子的形式向外传播的现象。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E8%BE%90%E5%B0%84%E9%98%B2%E6%8A%A4%20%E8%AF%BE%E7%A8%8B\" target=\"_blank\">在 Bilibili 搜索“辐射防护 课程”</a></p>',1,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(5,2,'第二章 常见防护方法','<h2>三原则</h2><p>辐射防护通常遵循时间、距离、屏蔽三项基本原则。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E8%BE%90%E5%B0%84%E9%98%B2%E6%8A%A4%20%E8%AF%BE%E7%A8%8B\" target=\"_blank\">在 Bilibili 搜索“辐射防护 课程”</a></p>',2,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(6,2,'第三章 日常安全规范','<h2>安全规范</h2><p>进入相关区域应佩戴剂量计并遵守操作流程。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E8%BE%90%E5%B0%84%E9%98%B2%E6%8A%A4%20%E8%AF%BE%E7%A8%8B\" target=\"_blank\">在 Bilibili 搜索“辐射防护 课程”</a></p>',3,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(7,3,'第一章 核电站总体结构','<h2>总体结构</h2><p>核电站通常由反应堆系统、蒸汽系统和发电系统组成。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E7%94%B5%E7%AB%99%20%E5%B7%A5%E4%BD%9C%E5%8E%9F%E7%90%86\" target=\"_blank\">在 Bilibili 搜索“核电站 工作原理”</a></p>',1,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(8,3,'第二章 蒸汽与发电过程','<h2>能量转换</h2><p>反应堆产生热量，加热水生成蒸汽驱动汽轮机发电。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E7%94%B5%E7%AB%99%20%E5%B7%A5%E4%BD%9C%E5%8E%9F%E7%90%86\" target=\"_blank\">在 Bilibili 搜索“核电站 工作原理”</a></p>',2,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(9,3,'第三章 安全系统简介','<h2>安全系统</h2><p>核电站配有多重安全保护系统来降低风险。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E7%94%B5%E7%AB%99%20%E5%B7%A5%E4%BD%9C%E5%8E%9F%E7%90%86\" target=\"_blank\">在 Bilibili 搜索“核电站 工作原理”</a></p>',3,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(10,4,'第一章 铀资源与开采','<h2>铀资源</h2><p>核燃料循环的起点通常是天然铀矿的开采与提炼。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E7%87%83%E6%96%99%E5%BE%AA%E7%8E%AF%20%E8%AF%BE%E7%A8%8B\" target=\"_blank\">在 Bilibili 搜索“核燃料循环 课程”</a></p>',1,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(11,4,'第二章 燃料加工','<h2>燃料加工</h2><p>铀经过转化、浓缩和制备后形成核燃料组件。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E7%87%83%E6%96%99%E5%BE%AA%E7%8E%AF%20%E8%AF%BE%E7%A8%8B\" target=\"_blank\">在 Bilibili 搜索“核燃料循环 课程”</a></p>',2,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(12,4,'第三章 后处理与处置','<h2>后处理</h2><p>乏燃料可以储存、后处理或最终处置。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E7%87%83%E6%96%99%E5%BE%AA%E7%8E%AF%20%E8%AF%BE%E7%A8%8B\" target=\"_blank\">在 Bilibili 搜索“核燃料循环 课程”</a></p>',3,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(13,5,'第一章 核医学基础','<h2>核医学</h2><p>核医学利用放射性核素进行诊断和治疗。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E6%8A%80%E6%9C%AF%20%E5%8C%BB%E5%AD%A6%E5%BA%94%E7%94%A8%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核技术 医学应用 科普”</a></p>',1,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(14,5,'第二章 常见检查技术','<h2>影像技术</h2><p>PET 和 SPECT 是核医学中常见的功能显像技术。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E6%8A%80%E6%9C%AF%20%E5%8C%BB%E5%AD%A6%E5%BA%94%E7%94%A8%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核技术 医学应用 科普”</a></p>',2,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(15,5,'第三章 放疗应用简介','<h2>治疗应用</h2><p>某些放射性药物可用于肿瘤治疗。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E6%8A%80%E6%9C%AF%20%E5%8C%BB%E5%AD%A6%E5%BA%94%E7%94%A8%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核技术 医学应用 科普”</a></p>',3,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(16,6,'第一章 核电起步阶段','<h2>早期发展</h2><p>世界核电发展始于20世纪中期的和平利用探索。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',1,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(17,6,'第二章 商业化扩张','<h2>商业化</h2><p>多个国家在能源需求推动下建设商用核电站。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',2,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(18,6,'第三章 新时代趋势','<h2>发展趋势</h2><p>当前核电更加关注安全、经济性和低碳转型。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',3,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(19,7,'第一章 典型事故回顾','<h2>案例回顾</h2><p>通过典型事故可以认识技术和管理上的薄弱环节。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',1,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(20,7,'第二章 事故原因分析','<h2>原因分析</h2><p>事故往往由设备、人员和制度问题共同导致。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',2,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(21,7,'第三章 安全启示','<h2>经验教训</h2><p>持续改进安全文化是核工业发展的关键。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',3,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(22,8,'第一章 压水堆简介','<h2>压水堆</h2><p>压水堆是当前应用最广泛的商用反应堆类型之一。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',1,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(23,8,'第二章 沸水堆简介','<h2>沸水堆</h2><p>沸水堆允许水在堆内直接沸腾产生蒸汽。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',2,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(24,8,'第三章 快堆与先进堆型','<h2>先进堆型</h2><p>快堆和高温气冷堆等属于重要的先进反应堆方向。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',3,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(25,9,'第一章 核废料分类','<h2>分类方法</h2><p>核废料通常按放射性水平和寿命进行分类。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',1,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(26,9,'第二章 暂存与运输','<h2>暂存运输</h2><p>核废料需要在专门条件下进行储存和运输。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',2,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(27,9,'第三章 最终处置思路','<h2>最终处置</h2><p>深地质处置是高放废物的重要候选方案之一。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',3,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(28,10,'第一章 核能的低碳属性','<h2>低碳特点</h2><p>核能发电过程中二氧化碳排放较低。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',1,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(29,10,'第二章 环境影响讨论','<h2>环境影响</h2><p>核能在环境方面既有优势，也伴随风险管理要求。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',2,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(30,10,'第三章 能源转型中的角色','<h2>能源转型</h2><p>核能在稳定供电和减排方面具有一定价值。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',3,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(31,11,'第一章 聚变基本原理','<h2>聚变原理</h2><p>轻原子核结合成较重原子核时会释放巨大能量。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',1,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(32,11,'第二章 工程实现难点','<h2>工程难点</h2><p>高温等离子体约束和材料问题是重要挑战。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',2,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(33,11,'第三章 未来发展展望','<h2>未来展望</h2><p>聚变被视为潜力巨大的长期能源方向。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',3,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(34,12,'第一章 核电站常见岗位','<h2>岗位介绍</h2><p>核电站包括运行、检修、安保、辐射防护等岗位。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',1,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(35,12,'第二章 岗位协作关系','<h2>协作关系</h2><p>不同岗位通过严格流程配合保障机组安全运行。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',2,1,'2026-06-11 18:34:53','2026-06-18 13:19:12'),(36,12,'第三章 学习与成长路径','<h2>成长路径</h2><p>从基础理论到现场实践，岗位能力需要逐步积累。</p><p><strong>B站学习链接：</strong><a href=\"https://search.bilibili.com/all?keyword=%E6%A0%B8%E5%AE%89%E5%85%A8%20%E6%A0%B8%E4%BA%8B%E6%95%85%20%E7%A7%91%E6%99%AE\" target=\"_blank\">在 Bilibili 搜索“核安全 核事故 科普”</a></p>',3,1,'2026-06-11 18:34:53','2026-06-18 13:19:12');
/*!40000 ALTER TABLE `course_chapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_chapter_progress`
--

DROP TABLE IF EXISTS `course_chapter_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_chapter_progress` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `course_id` bigint NOT NULL COMMENT '课程ID',
  `chapter_id` bigint NOT NULL COMMENT '章节ID',
  `progress` int NOT NULL DEFAULT '0' COMMENT '章节进度，0-100',
  `completed` tinyint NOT NULL DEFAULT '0' COMMENT '是否完成：0否 1是',
  `study_minutes` int NOT NULL DEFAULT '0' COMMENT '本章节累计学习分钟数',
  `last_study_time` datetime DEFAULT NULL COMMENT '最近学习时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_chapter` (`user_id`,`chapter_id`),
  KEY `idx_user_course` (`user_id`,`course_id`),
  KEY `idx_chapter_id` (`chapter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户课程章节进度表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_chapter_progress`
--

LOCK TABLES `course_chapter_progress` WRITE;
/*!40000 ALTER TABLE `course_chapter_progress` DISABLE KEYS */;
INSERT INTO `course_chapter_progress` VALUES (1,10,1,1,100,1,5,'2026-06-18 13:24:55','2026-06-18 13:24:55','2026-06-18 13:24:55'),(2,12,2,5,100,1,5,'2026-06-18 20:29:50','2026-06-18 20:29:50','2026-06-18 20:29:50'),(3,12,2,6,100,1,5,'2026-06-18 20:29:51','2026-06-18 20:29:51','2026-06-18 20:29:51'),(4,12,2,4,100,1,5,'2026-06-18 20:29:52','2026-06-18 20:29:52','2026-06-18 20:29:52'),(5,15,1,3,100,1,5,'2026-06-18 20:57:12','2026-06-18 20:57:12','2026-06-18 20:57:12'),(6,15,1,1,100,1,5,'2026-06-18 20:57:14','2026-06-18 20:57:14','2026-06-18 20:57:14'),(7,15,1,2,100,1,5,'2026-06-18 20:57:15','2026-06-18 20:57:15','2026-06-18 20:57:15'),(8,16,1,2,100,1,5,'2026-06-18 21:12:03','2026-06-18 21:12:03','2026-06-18 21:12:03'),(9,16,1,3,100,1,5,'2026-06-18 21:12:04','2026-06-18 21:12:04','2026-06-18 21:12:04'),(10,16,1,1,100,1,5,'2026-06-18 21:12:05','2026-06-18 21:12:05','2026-06-18 21:12:05');
/*!40000 ALTER TABLE `course_chapter_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_study_record`
--

DROP TABLE IF EXISTS `course_study_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_study_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `course_id` bigint NOT NULL COMMENT '课程ID',
  `progress` int NOT NULL DEFAULT '0' COMMENT '课程总进度，0-100',
  `current_chapter_id` bigint DEFAULT NULL COMMENT '当前学习到的章节ID',
  `completed_chapter_count` int NOT NULL DEFAULT '0' COMMENT '已完成章节数',
  `study_minutes` int NOT NULL DEFAULT '0' COMMENT '累计学习分钟数',
  `last_study_time` datetime DEFAULT NULL COMMENT '最近学习时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_course` (`user_id`,`course_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_course_id` (`course_id`),
  KEY `idx_last_study_time` (`last_study_time`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户课程学习记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_study_record`
--

LOCK TABLES `course_study_record` WRITE;
/*!40000 ALTER TABLE `course_study_record` DISABLE KEYS */;
INSERT INTO `course_study_record` VALUES (1,10,1,100,1,1,5,'2026-06-18 13:24:56','2026-06-18 13:24:56','2026-06-18 13:24:56'),(2,12,2,100,4,3,15,'2026-06-18 20:29:53','2026-06-18 20:29:50','2026-06-18 20:29:53'),(5,15,1,100,2,3,15,'2026-06-18 20:57:16','2026-06-18 20:57:13','2026-06-18 20:57:16'),(8,16,1,100,1,3,15,'2026-06-18 21:12:05','2026-06-18 21:12:04','2026-06-18 21:12:05');
/*!40000 ALTER TABLE `course_study_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knowledge_article`
--

DROP TABLE IF EXISTS `knowledge_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_article` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `title` varchar(100) NOT NULL COMMENT '文章标题',
  `summary` varchar(300) DEFAULT NULL COMMENT '文章摘要',
  `content` longtext NOT NULL COMMENT '文章正文',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `cover_image` varchar(255) DEFAULT NULL COMMENT '封面图地址',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态：0草稿，1已发布，2已下架',
  `author_id` bigint DEFAULT NULL COMMENT '作者用户ID',
  `view_count` int NOT NULL DEFAULT '0' COMMENT '浏览量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_status` (`status`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='知识文章表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_article`
--

LOCK TABLES `knowledge_article` WRITE;
/*!40000 ALTER TABLE `knowledge_article` DISABLE KEYS */;
INSERT INTO `knowledge_article` VALUES (1,'什么是核辐射','核辐射的基础介绍','<h2>核辐射的定义</h2><p>核辐射是原子核变化过程中释放出的能量或粒子。</p>',1,NULL,1,NULL,0,'2026-06-06 15:01:38','2026-06-06 15:01:38'),(2,'核电站如何发电','简单了解核电站发电原理','<h2>核电站发电原理</h2><p>核电站通过核裂变产生热量，再推动汽轮机发电。</p>',2,NULL,1,NULL,0,'2026-06-06 15:01:38','2026-06-06 15:01:38'),(3,'日常辐射防护常识','了解生活中的基础辐射防护方法','<h2>辐射防护</h2><p>日常生活中应理性认识辐射，避免不必要暴露。</p>',3,NULL,1,NULL,0,'2026-06-06 15:01:38','2026-06-06 15:01:38'),(4,'核能是什么','用通俗语言介绍核能的基本概念','<h2>核能是什么</h2><p>核能是原子核发生变化时释放出的能量，常见形式包括核裂变和核聚变。</p>',1,NULL,1,NULL,0,'2026-06-06 17:25:45','2026-06-06 17:25:45'),(5,'什么是放射性','介绍放射性的来源和基本特点','<h2>什么是放射性</h2><p>放射性是某些不稳定原子核自发释放射线的现象。</p>',1,NULL,1,NULL,0,'2026-06-06 17:25:45','2026-06-06 17:25:45'),(6,'天然辐射从哪里来','了解生活中常见的天然辐射来源','<h2>天然辐射</h2><p>天然辐射可能来自宇宙射线、土壤、岩石以及人体自身。</p>',1,NULL,1,NULL,0,'2026-06-06 17:25:45','2026-06-06 17:25:45'),(7,'核电站如何发电','介绍核裂变产生热量并转化为电能的过程','<h2>核电站如何发电</h2><p>核电站利用核裂变释放热量，加热水产生蒸汽，推动汽轮机发电。</p>',2,NULL,1,NULL,0,'2026-06-06 17:25:45','2026-06-06 17:25:45'),(8,'核裂变的基本原理','了解铀-235等重核裂变释放能量的过程','<h2>核裂变</h2><p>核裂变是重原子核分裂成较轻原子核，并释放能量的过程。</p>',2,NULL,1,NULL,0,'2026-06-06 17:25:45','2026-06-06 17:25:45'),(9,'核电站的主要系统','简单介绍反应堆、冷却系统和发电系统','<h2>核电站系统</h2><p>核电站通常包括反应堆系统、冷却系统、蒸汽发生系统和发电系统。</p>',2,NULL,1,NULL,0,'2026-06-06 17:25:45','2026-06-06 17:25:45'),(10,'核能与火电有什么不同','对比核电和传统火电的能量来源','<h2>核能与火电</h2><p>核电依靠核裂变释放能量，火电主要依靠燃烧煤炭等燃料释放化学能。</p>',2,NULL,1,NULL,0,'2026-06-06 17:25:45','2026-06-06 17:25:45'),(11,'辐射防护三原则','介绍时间、距离、屏蔽三种基本防护原则','<h2>辐射防护三原则</h2><p>减少照射时间、增大距离、使用屏蔽材料，是辐射防护的基本方法。</p>',3,NULL,1,NULL,0,'2026-06-06 17:25:45','2026-06-06 17:25:45'),(12,'生活中的辐射安全吗','正确认识日常生活中的辐射风险','<h2>生活中的辐射</h2><p>生活中存在天然辐射和人工辐射，大多数日常辐射水平处于安全范围。</p>',3,NULL,1,NULL,0,'2026-06-06 17:25:45','2026-06-06 17:25:45'),(13,'如何看懂辐射剂量单位','介绍常见的辐射剂量单位 Sv 和 mSv','<h2>辐射剂量单位</h2><p>希沃特 Sv 是衡量辐射对人体影响的单位，日常更常见的是毫希沃特 mSv。</p>',3,NULL,1,NULL,0,'2026-06-06 17:25:45','2026-06-06 17:25:45');
/*!40000 ALTER TABLE `knowledge_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knowledge_category`
--

DROP TABLE IF EXISTS `knowledge_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序值，越小越靠前',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：0禁用，1启用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='知识分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_category`
--

LOCK TABLES `knowledge_category` WRITE;
/*!40000 ALTER TABLE `knowledge_category` DISABLE KEYS */;
INSERT INTO `knowledge_category` VALUES (1,'基础常识',1,1,'2026-06-06 15:01:37','2026-06-06 15:01:37'),(2,'核电原理',2,1,'2026-06-06 15:01:37','2026-06-06 15:01:37'),(3,'辐射防护',3,1,'2026-06-06 15:01:37','2026-06-06 15:01:37');
/*!40000 ALTER TABLE `knowledge_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knowledge_study_record`
--

DROP TABLE IF EXISTS `knowledge_study_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knowledge_study_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `article_id` bigint NOT NULL COMMENT '文章ID',
  `progress` int NOT NULL DEFAULT '0' COMMENT '阅读进度，0-100',
  `study_minutes` int NOT NULL DEFAULT '0' COMMENT '累计学习分钟数',
  `last_study_time` datetime DEFAULT NULL COMMENT '最近学习时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_article` (`user_id`,`article_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_article_id` (`article_id`),
  KEY `idx_last_study_time` (`last_study_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户知识文章学习记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knowledge_study_record`
--

LOCK TABLES `knowledge_study_record` WRITE;
/*!40000 ALTER TABLE `knowledge_study_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledge_study_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nuclear_facility`
--

DROP TABLE IF EXISTS `nuclear_facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nuclear_facility` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '设施ID',
  `name` varchar(200) NOT NULL COMMENT '设施名称',
  `facility_type` varchar(50) NOT NULL COMMENT '设施类型，如power_plant/historical/monitoring',
  `lat` decimal(10,6) NOT NULL COMMENT '纬度',
  `lng` decimal(10,6) NOT NULL COMMENT '经度',
  `status` varchar(50) NOT NULL COMMENT '状态，如operating/monitoring/decommissioned',
  `summary` varchar(500) DEFAULT NULL COMMENT '简短介绍',
  `detail` text COMMENT '详细介绍',
  `map_url` varchar(500) DEFAULT NULL COMMENT '地图链接',
  `news_url` varchar(500) DEFAULT NULL COMMENT '新闻链接',
  `gradient` varchar(255) DEFAULT NULL COMMENT '前端展示渐变背景',
  `map_x` decimal(5,2) DEFAULT NULL COMMENT '地图横向百分比位置',
  `map_y` decimal(5,2) DEFAULT NULL COMMENT '地图纵向百分比位置',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序号',
  `enabled` tinyint NOT NULL DEFAULT '1' COMMENT '是否启用：1启用 0禁用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_enabled_sort` (`enabled`,`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=1007 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='核设施表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nuclear_facility`
--

LOCK TABLES `nuclear_facility` WRITE;
/*!40000 ALTER TABLE `nuclear_facility` DISABLE KEYS */;
INSERT INTO `nuclear_facility` VALUES (1001,'大亚湾核电站','power_plant',22.596400,114.542500,'operating','中国首座大型商用核电站，位于广东深圳大鹏新区。','大亚湾核电站采用压水堆技术，是中国商业核电发展的重要起点，长期保持稳定运行。','https://www.google.com/maps?q=22.5964,114.5425','https://www.baidu.com/s?wd=大亚湾核电站','linear-gradient(135deg, #0d9488 0%, #14b8a6 100%)',74.00,48.00,1,1,'2026-06-18 13:19:13','2026-06-18 13:19:13'),(1002,'秦山核电站','power_plant',30.434400,120.957200,'operating','中国大陆第一座自行设计、建造和运营的核电站。','秦山核电站位于浙江海盐，是中国核电自主化发展的标志性工程。','https://www.google.com/maps?q=30.4344,120.9572','https://www.baidu.com/s?wd=秦山核电站','linear-gradient(135deg, #2563eb 0%, #3b82f6 100%)',77.00,38.00,2,1,'2026-06-18 13:19:13','2026-06-18 13:19:13'),(1003,'福岛第一核电站','historical',37.421100,141.032800,'decommissioned','2011年地震海啸后发生严重核事故，现处于退役处理中。','福岛第一核电站事故推动了全球核电站极端自然灾害防护和应急体系再评估。','https://www.google.com/maps?q=37.4211,141.0328','https://www.baidu.com/s?wd=福岛第一核电站事故','linear-gradient(135deg, #0c3547 0%, #1a6b8a 100%)',82.00,30.00,3,1,'2026-06-18 13:19:13','2026-06-18 13:19:13'),(1004,'切尔诺贝利核电站','historical',51.389400,30.098800,'decommissioned','1986年发生严重核事故，周边区域长期受到影响。','切尔诺贝利事故是核安全史上的重要案例，深刻影响了反应堆安全设计和应急管理。','https://www.google.com/maps?q=51.3894,30.0988','https://www.baidu.com/s?wd=切尔诺贝利核事故','linear-gradient(135deg, #1a1a2e 0%, #0f3460 100%)',54.00,28.00,4,1,'2026-06-18 13:19:13','2026-06-18 13:19:13'),(1005,'三里岛核电站','historical',40.153700,-76.724400,'decommissioned','1979年发生美国商业核电史上重要事故。','三里岛事故虽未造成大规模放射性后果，但显著改变了核电行业的运行管理和公众沟通方式。','https://www.google.com/maps?q=40.1537,-76.7244','https://www.baidu.com/s?wd=三里岛核事故','linear-gradient(135deg, #991b1b 0%, #dc2626 100%)',25.00,32.00,5,1,'2026-06-18 13:19:13','2026-06-18 13:19:13'),(1006,'国际原子能机构','monitoring',48.235000,16.415000,'monitoring','国际原子能机构推动核安全、核安保与和平利用核能。','IAEA 通过安全标准、同行评审和监测合作支持各国提升核与辐射安全水平。','https://www.google.com/maps?q=48.235,16.415','https://www.iaea.org/','linear-gradient(135deg, #b45309 0%, #f59e0b 100%)',52.00,26.00,6,1,'2026-06-18 13:19:13','2026-06-18 13:19:13');
/*!40000 ALTER TABLE `nuclear_facility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz`
--

DROP TABLE IF EXISTS `quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '测验ID',
  `title` varchar(100) NOT NULL COMMENT '测验标题',
  `description` varchar(500) DEFAULT NULL COMMENT '测验简介',
  `question_count` int NOT NULL DEFAULT '0' COMMENT '题目数量',
  `time_limit` int NOT NULL DEFAULT '0' COMMENT '限时，单位分钟',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：1启用 0禁用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=1011 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='测验表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz`
--

LOCK TABLES `quiz` WRITE;
/*!40000 ALTER TABLE `quiz` DISABLE KEYS */;
INSERT INTO `quiz` VALUES (1001,'核辐射基础知识测验','测试核辐射类型、单位和基础防护知识。',10,15,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(1002,'核电站安全知识测验','检验核电站工作原理、安全屏障和事故认知。',10,15,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(1003,'核技术应用测验','了解核技术在医学、工业和能源中的应用。',10,15,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(1004,'辐射防护实用测验','围绕时间、距离、屏蔽和个人防护展开练习。',10,15,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(1005,'核燃料循环测验','覆盖铀矿、燃料制造、反应堆使用和乏燃料管理。',10,15,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(1006,'核安全与应急测验','测试核事故分级、应急响应和公众防护知识。',10,15,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(1007,'反应堆物理入门测验','面向中子、临界、慢化和反应性等基础概念。',10,15,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(1008,'核电设备与系统测验','识别核电站主要系统、设备和功能。',10,15,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(1009,'环境与公众沟通测验','关注环境监测、公众风险认知和信息沟通。',10,15,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(1010,'综合进阶测验','综合考察核能、辐射、防护和安全管理。',10,15,1,'2026-06-18 13:35:42','2026-06-18 13:35:42');
/*!40000 ALTER TABLE `quiz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_answer_record`
--

DROP TABLE IF EXISTS `quiz_answer_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_answer_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `quiz_record_id` bigint NOT NULL COMMENT '测验记录ID',
  `question_id` bigint NOT NULL COMMENT '题目ID',
  `user_answer` varchar(100) DEFAULT NULL COMMENT '用户答案',
  `correct_answer` varchar(100) DEFAULT NULL COMMENT '正确答案',
  `is_correct` tinyint NOT NULL DEFAULT '0' COMMENT '是否答对：0否 1是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_quiz_record_id` (`quiz_record_id`),
  KEY `idx_question_id` (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='测验答题明细表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_answer_record`
--

LOCK TABLES `quiz_answer_record` WRITE;
/*!40000 ALTER TABLE `quiz_answer_record` DISABLE KEYS */;
INSERT INTO `quiz_answer_record` VALUES (1,1,10001,'C','C',1,'2026-06-18 13:24:51'),(2,1,10002,'A','A',1,'2026-06-18 13:24:51'),(3,1,10003,'A,C','A,C',1,'2026-06-18 13:24:51'),(4,1,10004,'C','C',1,'2026-06-18 13:24:51'),(5,1,10005,'A,B,C','A,B,C',1,'2026-06-18 13:24:51'),(6,2,10091,'C','A',0,'2026-06-18 13:46:42'),(7,2,10092,'B','A',0,'2026-06-18 13:46:42'),(8,2,10093,'B','A',0,'2026-06-18 13:46:42'),(9,2,10094,'A','A',1,'2026-06-18 13:46:42'),(10,2,10095,'B','A',0,'2026-06-18 13:46:42'),(11,2,10096,'C','A',0,'2026-06-18 13:46:42'),(12,2,10097,'B','A',0,'2026-06-18 13:46:42'),(13,2,10098,'B','A',0,'2026-06-18 13:46:42'),(14,2,10099,'B','A',0,'2026-06-18 13:46:42'),(15,2,10100,'B','A',0,'2026-06-18 13:46:42'),(16,3,10001,'B','A',1,'2026-06-18 13:57:11'),(17,3,10002,'A','A',1,'2026-06-18 13:57:11'),(18,3,10003,'A','A',1,'2026-06-18 13:57:11'),(19,3,10004,'A','A',1,'2026-06-18 13:57:11'),(20,3,10005,'A','A',1,'2026-06-18 13:57:11'),(21,3,10006,'A','A',1,'2026-06-18 13:57:11'),(22,3,10007,'A','A',1,'2026-06-18 13:57:11'),(23,3,10008,'A','A',1,'2026-06-18 13:57:11'),(24,3,10009,'A','A',1,'2026-06-18 13:57:11'),(25,3,10010,'A','A',1,'2026-06-18 13:57:11'),(26,4,10001,'B','A',1,'2026-06-18 13:57:38'),(27,4,10002,'A','A',1,'2026-06-18 13:57:38'),(28,4,10003,'A','A',1,'2026-06-18 13:57:38'),(29,4,10004,'A','A',1,'2026-06-18 13:57:38'),(30,4,10005,'A','A',1,'2026-06-18 13:57:38'),(31,4,10006,'A','A',1,'2026-06-18 13:57:38'),(32,4,10007,'A','A',1,'2026-06-18 13:57:38'),(33,4,10008,'A','A',1,'2026-06-18 13:57:38'),(34,4,10009,'A','A',1,'2026-06-18 13:57:38'),(35,4,10010,'A','A',1,'2026-06-18 13:57:38'),(36,5,10091,'A','A',1,'2026-06-18 17:03:29'),(37,5,10092,'A','A',1,'2026-06-18 17:03:29'),(38,5,10093,'A','A',1,'2026-06-18 17:03:29'),(39,5,10094,'A','A',1,'2026-06-18 17:03:29'),(40,5,10095,'A','A',1,'2026-06-18 17:03:29'),(41,5,10096,'A','A',1,'2026-06-18 17:03:29'),(42,5,10097,'A','A',1,'2026-06-18 17:03:29'),(43,5,10098,'A','A',1,'2026-06-18 17:03:29'),(44,5,10099,'A','A',1,'2026-06-18 17:03:29'),(45,5,10100,'A','A',1,'2026-06-18 17:03:29'),(46,6,10091,'B','A',0,'2026-06-18 19:51:30'),(47,6,10092,'B','A',0,'2026-06-18 19:51:30'),(48,6,10093,'B','A',0,'2026-06-18 19:51:30'),(49,6,10094,'C','A',0,'2026-06-18 19:51:30'),(50,6,10095,'C','A',0,'2026-06-18 19:51:30'),(51,6,10096,'C','A',0,'2026-06-18 19:51:30'),(52,6,10097,'A','A',1,'2026-06-18 19:51:30'),(53,6,10098,'C','A',0,'2026-06-18 19:51:30'),(54,6,10099,'C','A',0,'2026-06-18 19:51:30'),(55,6,10100,'D','A',0,'2026-06-18 19:51:30'),(56,7,10071,'A','A',1,'2026-06-18 20:10:27'),(57,7,10072,'A','A',1,'2026-06-18 20:10:27'),(58,7,10073,'D','A',0,'2026-06-18 20:10:27'),(59,7,10074,'C','A',0,'2026-06-18 20:10:27'),(60,7,10075,'A','A',1,'2026-06-18 20:10:27'),(61,7,10076,'A','A',1,'2026-06-18 20:10:27'),(62,7,10077,'A','A',1,'2026-06-18 20:10:27'),(63,7,10078,'C','A',0,'2026-06-18 20:10:27'),(64,7,10079,'B','A',0,'2026-06-18 20:10:27'),(65,7,10080,'B','A',0,'2026-06-18 20:10:27'),(66,8,10041,'C','A',0,'2026-06-18 20:18:12'),(67,8,10042,'A','A',1,'2026-06-18 20:18:12'),(68,8,10043,'A','A',1,'2026-06-18 20:18:12'),(69,8,10044,'A','A',1,'2026-06-18 20:18:12'),(70,8,10045,'A','A',1,'2026-06-18 20:18:12'),(71,8,10046,'B','A',0,'2026-06-18 20:18:12'),(72,8,10047,'C','A',0,'2026-06-18 20:18:12'),(73,8,10048,'C','A',0,'2026-06-18 20:18:12'),(74,8,10049,'A','A',1,'2026-06-18 20:18:12'),(75,8,10050,'A','A',1,'2026-06-18 20:18:12'),(76,9,10051,'B','A',0,'2026-06-18 20:45:01'),(77,9,10052,'A','A',1,'2026-06-18 20:45:01'),(78,9,10053,'A','A',1,'2026-06-18 20:45:01'),(79,9,10054,'A','A',1,'2026-06-18 20:45:01'),(80,9,10055,'B','A',0,'2026-06-18 20:45:01'),(81,9,10056,'C','A',0,'2026-06-18 20:45:01'),(82,9,10057,'A','A',1,'2026-06-18 20:45:01'),(83,9,10058,'B','A',0,'2026-06-18 20:45:01'),(84,9,10059,'D','A',0,'2026-06-18 20:45:01'),(85,9,10060,'D','A',0,'2026-06-18 20:45:01'),(86,10,10081,'A','A',1,'2026-06-18 20:49:59'),(87,10,10082,'B','A',0,'2026-06-18 20:49:59'),(88,10,10083,'A','A',1,'2026-06-18 20:49:59'),(89,10,10084,'B','A',0,'2026-06-18 20:49:59'),(90,10,10085,'B','A',0,'2026-06-18 20:49:59'),(91,10,10086,'B','A',0,'2026-06-18 20:49:59'),(92,10,10087,'B','A',0,'2026-06-18 20:49:59'),(93,10,10088,'A','A',1,'2026-06-18 20:49:59'),(94,10,10089,'A','A',1,'2026-06-18 20:49:59'),(95,10,10090,'B','A',0,'2026-06-18 20:49:59'),(96,11,10081,'B','A',0,'2026-06-18 20:51:34'),(97,11,10082,'C','A',0,'2026-06-18 20:51:34'),(98,11,10083,'A','A',1,'2026-06-18 20:51:34'),(99,11,10084,'B','A',0,'2026-06-18 20:51:34'),(100,11,10085,'B','A',0,'2026-06-18 20:51:34'),(101,11,10086,'B','A',0,'2026-06-18 20:51:34'),(102,11,10087,'B','A',0,'2026-06-18 20:51:34'),(103,11,10088,'B','A',0,'2026-06-18 20:51:34'),(104,11,10089,'B','A',0,'2026-06-18 20:51:34'),(105,11,10090,'C','A',0,'2026-06-18 20:51:34'),(106,12,10091,'A','A',1,'2026-06-18 21:12:39'),(107,12,10092,'B','A',0,'2026-06-18 21:12:39'),(108,12,10093,'B','A',0,'2026-06-18 21:12:39'),(109,12,10094,'A','A',1,'2026-06-18 21:12:39'),(110,12,10095,'C','A',0,'2026-06-18 21:12:39'),(111,12,10096,'D','A',0,'2026-06-18 21:12:39'),(112,12,10097,'B','A',0,'2026-06-18 21:12:39'),(113,12,10098,'C','A',0,'2026-06-18 21:12:39'),(114,12,10099,'D','A',0,'2026-06-18 21:12:39'),(115,12,10100,'C','A',0,'2026-06-18 21:12:39');
/*!40000 ALTER TABLE `quiz_answer_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_option`
--

DROP TABLE IF EXISTS `quiz_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_option` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `question_id` bigint NOT NULL COMMENT '题目ID',
  `option_key` varchar(10) NOT NULL COMMENT '选项标识，如A/B/C/D',
  `option_text` varchar(500) NOT NULL COMMENT '选项内容',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_question_option` (`question_id`,`option_key`),
  KEY `idx_question_sort` (`question_id`,`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=100401 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='测验选项表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_option`
--

LOCK TABLES `quiz_option` WRITE;
/*!40000 ALTER TABLE `quiz_option` DISABLE KEYS */;
INSERT INTO `quiz_option` VALUES (100001,10001,'A','α射线由氦原子核组成，穿透力较弱但电离能力较强。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100002,10001,'B','它与辐射基础没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100003,10001,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100004,10001,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100005,10002,'A','β射线本质上是高速电子或正电子，穿透力强于α射线。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100006,10002,'B','它与辐射基础没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100007,10002,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100008,10002,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100009,10003,'A','γ射线是高能电磁波，通常需要铅、混凝土等材料屏蔽。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100010,10003,'B','它与辐射基础没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100011,10003,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100012,10003,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100013,10004,'A','中子不带电，穿透能力较强，常用含氢材料慢化。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100014,10004,'B','它与辐射基础没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100015,10004,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100016,10004,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100017,10005,'A','电离辐射能使物质原子或分子发生电离。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100018,10005,'B','它与辐射基础没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100019,10005,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100020,10005,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100021,10006,'A','可见光和无线电波通常属于非电离辐射。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100022,10006,'B','它与辐射基础没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100023,10006,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100024,10006,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100025,10007,'A','贝可勒尔用于表示放射性活度，即单位时间衰变次数。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100026,10007,'B','它与辐射基础没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100027,10007,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100028,10007,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100029,10008,'A','希沃特用于描述辐射对人体造成的生物效应。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100030,10008,'B','它与辐射基础没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100031,10008,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100032,10008,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100033,10009,'A','天然本底辐射来自宇宙射线、土壤和人体内部核素等。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100034,10009,'B','它与辐射基础没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100035,10009,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100036,10009,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100037,10010,'A','半衰期是放射性核素数量衰减到原来一半所需的时间。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100038,10010,'B','它与辐射基础没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100039,10010,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100040,10010,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100041,10011,'A','压水堆通过高压水把堆芯热量带到蒸汽发生器。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100042,10011,'B','它与核电安全没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100043,10011,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100044,10011,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100045,10012,'A','沸水堆中堆芯产生的蒸汽可以直接推动汽轮机。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100046,10012,'B','它与核电安全没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100047,10012,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100048,10012,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100049,10013,'A','控制棒能吸收中子，用于调节或停止链式反应。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100050,10013,'B','它与核电安全没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100051,10013,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100052,10013,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100053,10014,'A','安全壳是防止放射性物质外泄的重要工程屏障。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100054,10014,'B','它与核电安全没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100055,10014,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100056,10014,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100057,10015,'A','应急堆芯冷却系统用于事故时带走堆芯余热。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100058,10015,'B','它与核电安全没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100059,10015,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100060,10015,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100061,10016,'A','纵深防御强调用多层措施预防和缓解核事故。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100062,10016,'B','它与核电安全没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100063,10016,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100064,10016,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100065,10017,'A','核岛主要包括反应堆及与核安全相关的重要系统。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100066,10017,'B','它与核电安全没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100067,10017,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100068,10017,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100069,10018,'A','常规岛负责把蒸汽热能转换为机械能和电能。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100070,10018,'B','它与核电安全没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100071,10018,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100072,10018,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100073,10019,'A','乏燃料池用于冷却和屏蔽刚卸出的乏燃料。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100074,10019,'B','它与核电安全没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100075,10019,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100076,10019,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100077,10020,'A','核电站运行期间需要持续开展环境辐射监测。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100078,10020,'B','它与核电安全没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100079,10020,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100080,10020,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100081,10021,'A','核医学显像利用示踪剂在体内分布形成诊断图像。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100082,10021,'B','它与核技术应用没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100083,10021,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100084,10021,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100085,10022,'A','放射治疗利用辐射杀伤肿瘤细胞，同时保护正常组织。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100086,10022,'B','它与核技术应用没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100087,10022,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100088,10022,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100089,10023,'A','工业射线探伤能在不破坏工件的情况下发现内部缺陷。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100090,10023,'B','它与核技术应用没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100091,10023,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100092,10023,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100093,10024,'A','食品辐照可杀菌、杀虫并延长保存时间。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100094,10024,'B','它与核技术应用没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100095,10024,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100096,10024,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100097,10025,'A','同位素示踪可用于研究物质迁移和代谢过程。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100098,10025,'B','它与核技术应用没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100099,10025,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100100,10025,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100101,10026,'A','部分烟雾报警器使用微量放射源探测烟雾颗粒。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100102,10026,'B','它与核技术应用没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100103,10026,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100104,10026,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100105,10027,'A','核能可通过热电联供等方式参与城市供热。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100106,10027,'B','它与核技术应用没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100107,10027,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100108,10027,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100109,10028,'A','辐照育种通过诱发变异筛选优良品种。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100110,10028,'B','它与核技术应用没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100111,10028,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100112,10028,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100113,10029,'A','放射源需要登记、屏蔽、储存和全生命周期管理。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100114,10029,'B','它与核技术应用没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100115,10029,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100116,10029,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100117,10030,'A','涉放射源或射线装置的活动通常需要依法许可。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100118,10030,'B','它与核技术应用没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100119,10030,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100120,10030,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100121,10031,'A','减少在辐射场中的停留时间可以降低受照剂量。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100122,10031,'B','它与辐射防护没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100123,10031,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100124,10031,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100125,10032,'A','远离点状辐射源通常能明显降低剂量率。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100126,10032,'B','它与辐射防护没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100127,10032,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100128,10032,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100129,10033,'A','根据射线类型选择合适屏蔽材料是重要防护方法。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100130,10033,'B','它与辐射防护没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100131,10033,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100132,10033,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100133,10034,'A','个人剂量计用于记录工作人员累计受照剂量。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100134,10034,'B','它与辐射防护没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100135,10034,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100136,10034,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100137,10035,'A','控制区是需要专门防护措施和进入管理的区域。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100138,10035,'B','它与辐射防护没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100139,10035,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100140,10035,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100141,10036,'A','监督区通常需要监测，但管控强度低于控制区。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100142,10036,'B','它与辐射防护没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100143,10036,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100144,10036,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100145,10037,'A','铅常用于屏蔽X射线和γ射线。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100146,10037,'B','它与辐射防护没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100147,10037,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100148,10037,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100149,10038,'A','水既能冷却也能对部分辐射起屏蔽作用。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100150,10038,'B','它与辐射防护没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100151,10038,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100152,10038,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100153,10039,'A','ALARA要求在合理可行范围内尽量降低辐射剂量。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100154,10039,'B','它与辐射防护没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100155,10039,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100156,10039,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100157,10040,'A','离开放射性污染区域前应进行表面污染监测。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100158,10040,'B','它与辐射防护没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100159,10040,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100160,10040,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100161,10041,'A','铀矿开采是核燃料循环前端的重要环节。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100162,10041,'B','它与核燃料循环没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100163,10041,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100164,10041,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100165,10042,'A','铀浓缩用于提高铀-235在核燃料中的比例。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100166,10042,'B','它与核燃料循环没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100167,10042,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100168,10042,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100169,10043,'A','燃料组件由许多燃料棒按结构要求组装而成。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100170,10043,'B','它与核燃料循环没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100171,10043,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100172,10043,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100173,10044,'A','燃耗反映核燃料在堆内释放能量的程度。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100174,10044,'B','它与核燃料循环没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100175,10044,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100176,10044,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100177,10045,'A','核电站会按计划更换部分已使用燃料。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100178,10045,'B','它与核燃料循环没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100179,10045,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100180,10045,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100181,10046,'A','乏燃料仍有放射性和余热，需要冷却与屏蔽。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100182,10046,'B','它与核燃料循环没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100183,10046,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100184,10046,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100185,10047,'A','后处理可回收乏燃料中的部分有用核材料。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100186,10047,'B','它与核燃料循环没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100187,10047,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100188,10047,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100189,10048,'A','高放废物需要长期隔离和安全处置。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100190,10048,'B','它与核燃料循环没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100191,10048,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100192,10048,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100193,10049,'A','深地质处置是高放废物长期管理的重要方案。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100194,10049,'B','它与核燃料循环没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100195,10049,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100196,10049,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100197,10050,'A','核材料衡算用于防止核材料丢失或非法转移。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100198,10050,'B','它与核燃料循环没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100199,10050,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100200,10050,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100201,10051,'A','INES用于描述核与辐射事件的安全重要性。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100202,10051,'B','它与核应急没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100203,10051,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100204,10051,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100205,10052,'A','核设施周边会根据风险设置应急计划区域。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100206,10052,'B','它与核应急没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100207,10052,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100208,10052,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100209,10053,'A','事故早期公众可按指令进入室内隐蔽减少受照。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100210,10053,'B','它与核应急没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100211,10053,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100212,10053,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100213,10054,'A','稳定碘片只能在官方指令下用于特定放射性碘风险。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100214,10054,'B','它与核应急没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100215,10054,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100216,10054,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100217,10055,'A','撤离是降低公众受照的重要应急防护行动。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100218,10055,'B','它与核应急没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100219,10055,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100220,10055,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100221,10056,'A','去污用于减少人员、物品或环境表面的放射性污染。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100222,10056,'B','它与核应急没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100223,10056,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100224,10056,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100225,10057,'A','核应急中及时、准确的信息发布能减少恐慌。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100226,10057,'B','它与核应急没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100227,10057,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100228,10057,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100229,10058,'A','源项描述事故中可能释放的放射性物质种类和数量。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100230,10058,'B','它与核应急没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100231,10058,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100232,10058,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100233,10059,'A','剂量评估用于判断防护行动是否必要。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100234,10059,'B','它与核应急没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100235,10059,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100236,10059,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100237,10060,'A','定期应急演练能检验预案和协同能力。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100238,10060,'B','它与核应急没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100239,10060,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100240,10060,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100241,10061,'A','链式反应依靠裂变产生的中子继续引发新的裂变。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100242,10061,'B','它与反应堆物理没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100243,10061,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100244,10061,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100245,10062,'A','临界状态表示反应堆功率在理想情况下保持稳定。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100246,10062,'B','它与反应堆物理没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100247,10062,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100248,10062,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100249,10063,'A','次临界状态下中子数量总体会逐代减少。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100250,10063,'B','它与反应堆物理没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100251,10063,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100252,10063,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100253,10064,'A','超临界状态下反应堆功率有上升趋势。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100254,10064,'B','它与反应堆物理没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100255,10064,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100256,10064,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100257,10065,'A','慢化剂能降低中子能量，提高某些核素裂变概率。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100258,10065,'B','它与反应堆物理没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100259,10065,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100260,10065,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100261,10066,'A','反射层可把部分逃逸中子反射回堆芯。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100262,10066,'B','它与反应堆物理没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100263,10066,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100264,10066,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100265,10067,'A','反应性反映反应堆偏离临界状态的程度。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100266,10067,'B','它与反应堆物理没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100267,10067,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100268,10067,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100269,10068,'A','中子毒物会吸收中子并影响反应堆反应性。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100270,10068,'B','它与反应堆物理没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100271,10068,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100272,10068,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100273,10069,'A','裂变产物是重核裂变后生成的较轻核素。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100274,10069,'B','它与反应堆物理没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100275,10069,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100276,10069,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100277,10070,'A','停堆后裂变产物衰变仍会产生余热。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100278,10070,'B','它与反应堆物理没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100279,10070,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100280,10070,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100281,10071,'A','反应堆压力容器承载堆芯和高压冷却剂。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100282,10071,'B','它与核电设备没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100283,10071,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100284,10071,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100285,10072,'A','蒸汽发生器把一回路热量传递给二回路产生蒸汽。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100286,10072,'B','它与核电设备没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100287,10072,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100288,10072,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100289,10073,'A','主泵推动一回路冷却剂循环流动。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100290,10073,'B','它与核电设备没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100291,10073,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100292,10073,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100293,10074,'A','稳压器用于调节压水堆一回路压力。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100294,10074,'B','它与核电设备没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100295,10074,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100296,10074,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100297,10075,'A','汽轮机把蒸汽热能转换为机械旋转能。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100298,10075,'B','它与核电设备没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100299,10075,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100300,10075,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100301,10076,'A','发电机把机械能转换为电能。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100302,10076,'B','它与核电设备没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100303,10076,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100304,10076,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100305,10077,'A','冷凝器把汽轮机排汽冷凝成水。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100306,10077,'B','它与核电设备没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100307,10077,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100308,10077,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100309,10078,'A','安全注入系统可在事故时向堆芯补水。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100310,10078,'B','它与核电设备没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100311,10078,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100312,10078,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100313,10079,'A','应急柴油发电机用于失去外电时供电。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100314,10079,'B','它与核电设备没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100315,10079,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100316,10079,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100317,10080,'A','仪控系统负责监测、控制和保护核电机组。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100318,10080,'B','它与核电设备没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100319,10080,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100320,10080,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100321,10081,'A','环境本底调查用于掌握设施运行前的辐射水平。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100322,10081,'B','它与环境沟通没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100323,10081,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100324,10081,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100325,10082,'A','气溶胶监测可评估空气中颗粒态放射性物质。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100326,10082,'B','它与环境沟通没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100327,10082,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100328,10082,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100329,10083,'A','水样监测用于掌握水体中放射性核素情况。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100330,10083,'B','它与环境沟通没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100331,10083,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100332,10083,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100333,10084,'A','食物链监测关注放射性物质进入农产品和食品的路径。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100334,10084,'B','它与环境沟通没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100335,10084,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100336,10084,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100337,10085,'A','公众剂量评价用于判断设施运行对公众影响。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100338,10085,'B','它与环境沟通没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100339,10085,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100340,10085,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100341,10086,'A','风险沟通需要清楚说明风险、证据和不确定性。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100342,10086,'B','它与环境沟通没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100343,10086,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100344,10086,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100345,10087,'A','谣言澄清应基于公开数据和权威解释。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100346,10087,'B','它与环境沟通没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100347,10087,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100348,10087,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100349,10088,'A','公众参与有助于提升核项目决策透明度。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100350,10088,'B','它与环境沟通没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100351,10088,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100352,10088,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100353,10089,'A','监测数据公开能增强公众信任。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100354,10089,'B','它与环境沟通没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100355,10089,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100356,10089,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100357,10090,'A','持续科普教育能帮助公众理性认识核能。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100358,10090,'B','它与环境沟通没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100359,10090,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100360,10090,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100361,10091,'A','核裂变释放能量来自原子核结合能变化。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100362,10091,'B','它与综合进阶没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100363,10091,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100364,10091,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100365,10092,'A','核聚变发电仍面临等离子体约束和工程材料挑战。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100366,10092,'B','它与综合进阶没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100367,10092,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100368,10092,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100369,10093,'A','小型模块化反应堆强调模块化制造和灵活部署。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100370,10093,'B','它与综合进阶没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100371,10093,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100372,10093,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100373,10094,'A','第四代反应堆追求更高安全性、经济性和资源利用率。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100374,10094,'B','它与综合进阶没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100375,10094,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100376,10094,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100377,10095,'A','核安保关注防范核材料和核设施遭受恶意行为。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100378,10095,'B','它与综合进阶没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100379,10095,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100380,10095,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100381,10096,'A','核保障用于确认核材料不被转用于核武器目的。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100382,10096,'B','它与综合进阶没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100383,10096,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100384,10096,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100385,10097,'A','安全文化强调组织和个人把安全放在优先位置。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100386,10097,'B','它与综合进阶没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100387,10097,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100388,10097,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100389,10098,'A','经验反馈能把事件教训转化为改进措施。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100390,10098,'B','它与综合进阶没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100391,10098,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100392,10098,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100393,10099,'A','概率安全分析用于系统评估事故序列和风险贡献。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100394,10099,'B','它与综合进阶没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100395,10099,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100396,10099,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100397,10100,'A','核设施生命周期管理覆盖设计、建造、运行和退役。',1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100398,10100,'B','它与综合进阶没有实际关系。',2,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100399,10100,'C','它表示任何情况下都完全没有风险。',3,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(100400,10100,'D','它只存在于科幻作品中，现实中没有应用。',4,'2026-06-18 13:35:42','2026-06-18 13:35:42');
/*!40000 ALTER TABLE `quiz_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_question`
--

DROP TABLE IF EXISTS `quiz_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_question` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '题目ID',
  `quiz_id` bigint NOT NULL COMMENT '所属测验ID',
  `title` varchar(500) NOT NULL COMMENT '题目标题',
  `question_type` varchar(20) NOT NULL COMMENT '题型：single/multi/judge',
  `answer` varchar(100) NOT NULL COMMENT '正确答案，单选如A，多选如A,C',
  `explanation` text COMMENT '题目解析',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序号',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态：1启用 0禁用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_quiz_id` (`quiz_id`),
  KEY `idx_quiz_sort` (`quiz_id`,`sort`)
) ENGINE=InnoDB AUTO_INCREMENT=10101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='测验题目表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_question`
--

LOCK TABLES `quiz_question` WRITE;
/*!40000 ALTER TABLE `quiz_question` DISABLE KEYS */;
INSERT INTO `quiz_question` VALUES (10001,1001,'关于[α射线]，下列说法正确的是？','single','A','α射线由氦原子核组成，穿透力较弱但电离能力较强。',1,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10002,1001,'关于[β射线]，下列说法正确的是？','single','A','β射线本质上是高速电子或正电子，穿透力强于α射线。',2,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10003,1001,'关于[γ射线]，下列说法正确的是？','single','A','γ射线是高能电磁波，通常需要铅、混凝土等材料屏蔽。',3,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10004,1001,'关于[中子辐射]，下列说法正确的是？','single','A','中子不带电，穿透能力较强，常用含氢材料慢化。',4,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10005,1001,'关于[电离辐射]，下列说法正确的是？','single','A','电离辐射能使物质原子或分子发生电离。',5,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10006,1001,'关于[非电离辐射]，下列说法正确的是？','single','A','可见光和无线电波通常属于非电离辐射。',6,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10007,1001,'关于[贝可勒尔]，下列说法正确的是？','single','A','贝可勒尔用于表示放射性活度，即单位时间衰变次数。',7,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10008,1001,'关于[希沃特]，下列说法正确的是？','single','A','希沃特用于描述辐射对人体造成的生物效应。',8,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10009,1001,'关于[天然本底辐射]，下列说法正确的是？','single','A','天然本底辐射来自宇宙射线、土壤和人体内部核素等。',9,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10010,1001,'关于[半衰期]，下列说法正确的是？','single','A','半衰期是放射性核素数量衰减到原来一半所需的时间。',10,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10011,1002,'关于[压水堆]，下列说法正确的是？','single','A','压水堆通过高压水把堆芯热量带到蒸汽发生器。',1,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10012,1002,'关于[沸水堆]，下列说法正确的是？','single','A','沸水堆中堆芯产生的蒸汽可以直接推动汽轮机。',2,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10013,1002,'关于[控制棒]，下列说法正确的是？','single','A','控制棒能吸收中子，用于调节或停止链式反应。',3,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10014,1002,'关于[安全壳]，下列说法正确的是？','single','A','安全壳是防止放射性物质外泄的重要工程屏障。',4,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10015,1002,'关于[应急堆芯冷却]，下列说法正确的是？','single','A','应急堆芯冷却系统用于事故时带走堆芯余热。',5,1,'2026-06-18 13:19:13','2026-06-18 13:35:42'),(10016,1002,'关于[纵深防御]，下列说法正确的是？','single','A','纵深防御强调用多层措施预防和缓解核事故。',6,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10017,1002,'关于[核岛]，下列说法正确的是？','single','A','核岛主要包括反应堆及与核安全相关的重要系统。',7,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10018,1002,'关于[常规岛]，下列说法正确的是？','single','A','常规岛负责把蒸汽热能转换为机械能和电能。',8,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10019,1002,'关于[乏燃料池]，下列说法正确的是？','single','A','乏燃料池用于冷却和屏蔽刚卸出的乏燃料。',9,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10020,1002,'关于[环境监测]，下列说法正确的是？','single','A','核电站运行期间需要持续开展环境辐射监测。',10,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10021,1003,'关于[核医学显像]，下列说法正确的是？','single','A','核医学显像利用示踪剂在体内分布形成诊断图像。',1,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10022,1003,'关于[放射治疗]，下列说法正确的是？','single','A','放射治疗利用辐射杀伤肿瘤细胞，同时保护正常组织。',2,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10023,1003,'关于[工业探伤]，下列说法正确的是？','single','A','工业射线探伤能在不破坏工件的情况下发现内部缺陷。',3,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10024,1003,'关于[食品辐照]，下列说法正确的是？','single','A','食品辐照可杀菌、杀虫并延长保存时间。',4,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10025,1003,'关于[同位素示踪]，下列说法正确的是？','single','A','同位素示踪可用于研究物质迁移和代谢过程。',5,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10026,1003,'关于[烟雾报警器]，下列说法正确的是？','single','A','部分烟雾报警器使用微量放射源探测烟雾颗粒。',6,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10027,1003,'关于[核电供热]，下列说法正确的是？','single','A','核能可通过热电联供等方式参与城市供热。',7,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10028,1003,'关于[辐照育种]，下列说法正确的是？','single','A','辐照育种通过诱发变异筛选优良品种。',8,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10029,1003,'关于[放射源管理]，下列说法正确的是？','single','A','放射源需要登记、屏蔽、储存和全生命周期管理。',9,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10030,1003,'关于[核技术利用许可]，下列说法正确的是？','single','A','涉放射源或射线装置的活动通常需要依法许可。',10,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10031,1004,'关于[时间防护]，下列说法正确的是？','single','A','减少在辐射场中的停留时间可以降低受照剂量。',1,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10032,1004,'关于[距离防护]，下列说法正确的是？','single','A','远离点状辐射源通常能明显降低剂量率。',2,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10033,1004,'关于[屏蔽防护]，下列说法正确的是？','single','A','根据射线类型选择合适屏蔽材料是重要防护方法。',3,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10034,1004,'关于[个人剂量计]，下列说法正确的是？','single','A','个人剂量计用于记录工作人员累计受照剂量。',4,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10035,1004,'关于[控制区]，下列说法正确的是？','single','A','控制区是需要专门防护措施和进入管理的区域。',5,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10036,1004,'关于[监督区]，下列说法正确的是？','single','A','监督区通常需要监测，但管控强度低于控制区。',6,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10037,1004,'关于[铅屏蔽]，下列说法正确的是？','single','A','铅常用于屏蔽X射线和γ射线。',7,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10038,1004,'关于[水屏蔽]，下列说法正确的是？','single','A','水既能冷却也能对部分辐射起屏蔽作用。',8,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10039,1004,'关于[ALARA原则]，下列说法正确的是？','single','A','ALARA要求在合理可行范围内尽量降低辐射剂量。',9,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10040,1004,'关于[污染监测]，下列说法正确的是？','single','A','离开放射性污染区域前应进行表面污染监测。',10,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10041,1005,'关于[铀矿开采]，下列说法正确的是？','single','A','铀矿开采是核燃料循环前端的重要环节。',1,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10042,1005,'关于[铀浓缩]，下列说法正确的是？','single','A','铀浓缩用于提高铀-235在核燃料中的比例。',2,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10043,1005,'关于[燃料组件]，下列说法正确的是？','single','A','燃料组件由许多燃料棒按结构要求组装而成。',3,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10044,1005,'关于[燃耗]，下列说法正确的是？','single','A','燃耗反映核燃料在堆内释放能量的程度。',4,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10045,1005,'关于[换料]，下列说法正确的是？','single','A','核电站会按计划更换部分已使用燃料。',5,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10046,1005,'关于[乏燃料]，下列说法正确的是？','single','A','乏燃料仍有放射性和余热，需要冷却与屏蔽。',6,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10047,1005,'关于[后处理]，下列说法正确的是？','single','A','后处理可回收乏燃料中的部分有用核材料。',7,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10048,1005,'关于[高放废物]，下列说法正确的是？','single','A','高放废物需要长期隔离和安全处置。',8,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10049,1005,'关于[地质处置]，下列说法正确的是？','single','A','深地质处置是高放废物长期管理的重要方案。',9,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10050,1005,'关于[核材料衡算]，下列说法正确的是？','single','A','核材料衡算用于防止核材料丢失或非法转移。',10,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10051,1006,'关于[INES分级]，下列说法正确的是？','single','A','INES用于描述核与辐射事件的安全重要性。',1,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10052,1006,'关于[应急计划区]，下列说法正确的是？','single','A','核设施周边会根据风险设置应急计划区域。',2,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10053,1006,'关于[隐蔽防护]，下列说法正确的是？','single','A','事故早期公众可按指令进入室内隐蔽减少受照。',3,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10054,1006,'关于[碘片服用]，下列说法正确的是？','single','A','稳定碘片只能在官方指令下用于特定放射性碘风险。',4,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10055,1006,'关于[撤离]，下列说法正确的是？','single','A','撤离是降低公众受照的重要应急防护行动。',5,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10056,1006,'关于[去污]，下列说法正确的是？','single','A','去污用于减少人员、物品或环境表面的放射性污染。',6,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10057,1006,'关于[信息发布]，下列说法正确的是？','single','A','核应急中及时、准确的信息发布能减少恐慌。',7,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10058,1006,'关于[源项]，下列说法正确的是？','single','A','源项描述事故中可能释放的放射性物质种类和数量。',8,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10059,1006,'关于[剂量评估]，下列说法正确的是？','single','A','剂量评估用于判断防护行动是否必要。',9,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10060,1006,'关于[应急演练]，下列说法正确的是？','single','A','定期应急演练能检验预案和协同能力。',10,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10061,1007,'关于[链式反应]，下列说法正确的是？','single','A','链式反应依靠裂变产生的中子继续引发新的裂变。',1,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10062,1007,'关于[临界状态]，下列说法正确的是？','single','A','临界状态表示反应堆功率在理想情况下保持稳定。',2,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10063,1007,'关于[次临界]，下列说法正确的是？','single','A','次临界状态下中子数量总体会逐代减少。',3,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10064,1007,'关于[超临界]，下列说法正确的是？','single','A','超临界状态下反应堆功率有上升趋势。',4,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10065,1007,'关于[慢化剂]，下列说法正确的是？','single','A','慢化剂能降低中子能量，提高某些核素裂变概率。',5,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10066,1007,'关于[反射层]，下列说法正确的是？','single','A','反射层可把部分逃逸中子反射回堆芯。',6,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10067,1007,'关于[反应性]，下列说法正确的是？','single','A','反应性反映反应堆偏离临界状态的程度。',7,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10068,1007,'关于[中子毒物]，下列说法正确的是？','single','A','中子毒物会吸收中子并影响反应堆反应性。',8,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10069,1007,'关于[裂变产物]，下列说法正确的是？','single','A','裂变产物是重核裂变后生成的较轻核素。',9,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10070,1007,'关于[余热]，下列说法正确的是？','single','A','停堆后裂变产物衰变仍会产生余热。',10,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10071,1008,'关于[反应堆压力容器]，下列说法正确的是？','single','A','反应堆压力容器承载堆芯和高压冷却剂。',1,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10072,1008,'关于[蒸汽发生器]，下列说法正确的是？','single','A','蒸汽发生器把一回路热量传递给二回路产生蒸汽。',2,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10073,1008,'关于[主泵]，下列说法正确的是？','single','A','主泵推动一回路冷却剂循环流动。',3,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10074,1008,'关于[稳压器]，下列说法正确的是？','single','A','稳压器用于调节压水堆一回路压力。',4,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10075,1008,'关于[汽轮机]，下列说法正确的是？','single','A','汽轮机把蒸汽热能转换为机械旋转能。',5,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10076,1008,'关于[发电机]，下列说法正确的是？','single','A','发电机把机械能转换为电能。',6,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10077,1008,'关于[冷凝器]，下列说法正确的是？','single','A','冷凝器把汽轮机排汽冷凝成水。',7,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10078,1008,'关于[安全注入系统]，下列说法正确的是？','single','A','安全注入系统可在事故时向堆芯补水。',8,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10079,1008,'关于[柴油发电机]，下列说法正确的是？','single','A','应急柴油发电机用于失去外电时供电。',9,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10080,1008,'关于[仪控系统]，下列说法正确的是？','single','A','仪控系统负责监测、控制和保护核电机组。',10,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10081,1009,'关于[环境本底调查]，下列说法正确的是？','single','A','环境本底调查用于掌握设施运行前的辐射水平。',1,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10082,1009,'关于[气溶胶监测]，下列说法正确的是？','single','A','气溶胶监测可评估空气中颗粒态放射性物质。',2,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10083,1009,'关于[水样监测]，下列说法正确的是？','single','A','水样监测用于掌握水体中放射性核素情况。',3,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10084,1009,'关于[食物链监测]，下列说法正确的是？','single','A','食物链监测关注放射性物质进入农产品和食品的路径。',4,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10085,1009,'关于[公众剂量]，下列说法正确的是？','single','A','公众剂量评价用于判断设施运行对公众影响。',5,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10086,1009,'关于[风险沟通]，下列说法正确的是？','single','A','风险沟通需要清楚说明风险、证据和不确定性。',6,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10087,1009,'关于[谣言澄清]，下列说法正确的是？','single','A','谣言澄清应基于公开数据和权威解释。',7,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10088,1009,'关于[公众参与]，下列说法正确的是？','single','A','公众参与有助于提升核项目决策透明度。',8,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10089,1009,'关于[监测数据公开]，下列说法正确的是？','single','A','监测数据公开能增强公众信任。',9,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10090,1009,'关于[科普教育]，下列说法正确的是？','single','A','持续科普教育能帮助公众理性认识核能。',10,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10091,1010,'关于[核裂变能量来源]，下列说法正确的是？','single','A','核裂变释放能量来自原子核结合能变化。',1,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10092,1010,'关于[核聚变研发]，下列说法正确的是？','single','A','核聚变发电仍面临等离子体约束和工程材料挑战。',2,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10093,1010,'关于[小型模块化反应堆]，下列说法正确的是？','single','A','小型模块化反应堆强调模块化制造和灵活部署。',3,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10094,1010,'关于[第四代反应堆]，下列说法正确的是？','single','A','第四代反应堆追求更高安全性、经济性和资源利用率。',4,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10095,1010,'关于[核安保]，下列说法正确的是？','single','A','核安保关注防范核材料和核设施遭受恶意行为。',5,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10096,1010,'关于[核保障]，下列说法正确的是？','single','A','核保障用于确认核材料不被转用于核武器目的。',6,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10097,1010,'关于[安全文化]，下列说法正确的是？','single','A','安全文化强调组织和个人把安全放在优先位置。',7,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10098,1010,'关于[经验反馈]，下列说法正确的是？','single','A','经验反馈能把事件教训转化为改进措施。',8,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10099,1010,'关于[概率安全分析]，下列说法正确的是？','single','A','概率安全分析用于系统评估事故序列和风险贡献。',9,1,'2026-06-18 13:35:42','2026-06-18 13:35:42'),(10100,1010,'关于[生命周期管理]，下列说法正确的是？','single','A','核设施生命周期管理覆盖设计、建造、运行和退役。',10,1,'2026-06-18 13:35:42','2026-06-18 13:35:42');
/*!40000 ALTER TABLE `quiz_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_record`
--

DROP TABLE IF EXISTS `quiz_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quiz_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '测验记录ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `quiz_id` bigint NOT NULL COMMENT '测验ID',
  `score` int NOT NULL DEFAULT '0' COMMENT '得分',
  `correct_count` int NOT NULL DEFAULT '0' COMMENT '答对题数',
  `total_count` int NOT NULL DEFAULT '0' COMMENT '总题数',
  `submit_duration_seconds` int NOT NULL DEFAULT '0' COMMENT '提交用时，秒',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_quiz_id` (`quiz_id`),
  KEY `idx_user_quiz` (`user_id`,`quiz_id`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户测验记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_record`
--

LOCK TABLES `quiz_record` WRITE;
/*!40000 ALTER TABLE `quiz_record` DISABLE KEYS */;
INSERT INTO `quiz_record` VALUES (1,10,1001,100,5,5,0,'2026-06-18 13:24:54','2026-06-18 13:24:54'),(2,1,1010,10,1,10,0,'2026-06-18 13:46:44','2026-06-18 13:46:44'),(3,10,1001,90,9,10,0,'2026-06-18 13:57:14','2026-06-18 13:57:14'),(4,10,1001,90,9,10,0,'2026-06-18 13:57:41','2026-06-18 13:57:41'),(5,4,1010,100,10,10,0,'2026-06-18 17:03:29','2026-06-18 17:03:29'),(6,11,1010,10,1,10,0,'2026-06-18 19:51:30','2026-06-18 19:51:30'),(7,11,1008,50,5,10,0,'2026-06-18 20:10:26','2026-06-18 20:10:26'),(8,11,1005,60,6,10,0,'2026-06-18 20:18:12','2026-06-18 20:18:12'),(9,13,1006,40,4,10,0,'2026-06-18 20:45:00','2026-06-18 20:45:00'),(10,14,1009,40,4,10,0,'2026-06-18 20:49:59','2026-06-18 20:49:59'),(11,15,1009,10,1,10,0,'2026-06-18 20:51:33','2026-06-18 20:51:33'),(12,16,1010,20,2,10,0,'2026-06-18 21:12:39','2026-06-18 21:12:39');
/*!40000 ALTER TABLE `quiz_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色编码',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `role_code` (`role_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'普通用户','USER','2026-04-24 14:35:05','2026-04-24 14:35:05'),(2,'管理员','ADMIN','2026-04-24 14:35:14','2026-04-24 14:35:14');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '加密后的密码',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '默认用户' COMMENT '昵称',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '手机号',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邮箱',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1正常 0禁用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'admin','$2a$10$9dTLwPh2Q/0dU7uYJ2/Bbu3V4sPRT9E3Gn2KmesHtSvVa8tZNXkpy','管理员','1980001','11145@iye.com',1,'2026-04-24 18:33:00','2026-04-24 18:33:00'),(2,'user1','$2a$10$9dTLwPh2Q/0dU7uYJ2/Bbu3V4sPRT9E3Gn2KmesHtSvVa8tZNXkpy','普通用户1',NULL,NULL,1,'2026-04-24 18:33:17','2026-04-24 18:33:17'),(3,'testUser','$2a$10$6nI2lR05RZYemlvOkWtCLu18rNHlhT.0o9vbryYZgntLnuWhYTJbi','测试用户1',NULL,'test@114514.com',1,'2026-05-11 13:57:45','2026-05-11 13:57:45'),(4,'donk','$2a$10$Dsc0XqR6CXSOszZH/2gBuewICPChyYGUBZ5RK1FiBNslNlp26J5Yy','测试用户2',NULL,'test@114514.com',1,'2026-05-11 14:02:54','2026-05-11 14:02:54'),(5,'niko','$2a$10$6Y50Et9lEYMsAw9YkO8gOO6t.2cJtTDbtyivg3LbnJUjjUctTLYiC','测试用户3','1145141980','test@114514.com',1,'2026-05-11 14:05:20','2026-05-11 14:05:20'),(7,'donk666','$2a$10$V11jy88ut35og2Fua5N9BOMTdws4S8QQ293MLG/TR5lsT5G3wWfTC','测试用户4','1145141980','test@114514.com',1,'2026-05-11 17:16:09','2026-05-11 17:16:09'),(8,'donk777','$2a$10$Gw9g0vX3jqUdS3ZTUu0bEOu8WhOfbX2wSNkWLf9FWm5K7mabmwyhy','测试用户4','1145141980','test@114514.com',1,'2026-05-11 17:19:40','2026-05-11 17:19:40'),(9,'liandiao','$2a$10$9bkY4hXcXQWiXURaFEOeLO6ajWa2mmezd1dnT1V82rBxXD.Eqx/CS','联调001','14520541550','oooo@163.com',1,'2026-06-06 13:11:41','2026-06-06 13:11:41'),(10,'codex_api_test','$2a$10$HIurbts.rKgcdJnNL0qWxewZlnHFthhLd1q3.Z9Bk5jt3V/ftvX2e','接口测试用户','13900000001','codex_api_test@example.com',1,'2026-06-18 13:24:53','2026-06-18 13:24:53'),(11,'222','$2a$10$m/x/Pm.O4p4vd76hFPTZne34gbU8v.DbmcNbuypehWOO5oBuRpxCG','222','18386236162','55555@qq.com',1,'2026-06-18 19:50:37','2026-06-18 19:50:37'),(12,'1122','$2a$10$v402ostS5nO3ee3/ySEct.ls3okrFI0vTIYGnuDc2R5NP1YhC2JYC','1122','18386236162','6322@qq.com',1,'2026-06-18 19:53:33','2026-06-18 19:53:33'),(13,'1212','$2a$10$5qOzqHI/NldOd5bxB2l8DenSAgeVPZ9ZI7S0QR9Yz9gWVwT5jDTPe','1212','13354473516','3174657340@qq.com',1,'2026-06-18 20:43:11','2026-06-18 20:43:11'),(14,'111','$2a$10$gdeKex01hbY4BaZ8Uw7R8.rkDiJYgyKJskkugIxS14jFkJxt15WSC','111','18386236162','22255@qq.com',1,'2026-06-18 20:49:19','2026-06-18 20:49:19'),(15,'123123','$2a$10$TxN4a26MN/OUpMJoowyyfeONJH5.Ffo5FqxAsNSg.i7E8/1H25pe6','123123','13354473516','3174657340@qq.com',1,'2026-06-18 20:50:54','2026-06-18 20:50:54'),(16,'555','$2a$10$s78.rDXhrVKJNzc11CGswu3eGXk/PYiK7hgBy5ed2/JMIGSxDvpRu','555','18386236162','9665@qq.com',1,'2026-06-18 21:11:34','2026-06-18 21:11:34');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='用户角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1,2),(3,7,1),(4,8,1),(5,1,1),(6,3,1),(19,2,1),(20,2,2),(21,9,1),(22,10,1),(23,11,1),(24,12,1),(25,13,1),(26,14,1),(27,15,1),(28,16,1);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upload_file`
--

DROP TABLE IF EXISTS `upload_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upload_file` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `user_id` bigint NOT NULL COMMENT '上传用户ID',
  `biz_type` varchar(50) NOT NULL DEFAULT 'avatar' COMMENT '业务类型，如avatar',
  `original_name` varchar(255) NOT NULL COMMENT '原始文件名',
  `stored_name` varchar(255) NOT NULL COMMENT '服务器保存文件名',
  `file_path` varchar(500) NOT NULL COMMENT '服务器保存路径',
  `file_url` varchar(500) NOT NULL COMMENT '文件访问URL',
  `file_size` bigint NOT NULL DEFAULT '0' COMMENT '文件大小，字节',
  `content_type` varchar(100) DEFAULT NULL COMMENT '文件MIME类型',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_biz_type` (`biz_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='上传文件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload_file`
--

LOCK TABLES `upload_file` WRITE;
/*!40000 ALTER TABLE `upload_file` DISABLE KEYS */;
INSERT INTO `upload_file` VALUES (1,10,'avatar','codex-upload-test.txt','e5a05968-d520-4c2f-9f3d-2369aab2c82b.txt','D:\\java\\nuclearEnergy\\backend\\uploads\\avatar\\e5a05968-d520-4c2f-9f3d-2369aab2c82b.txt','/uploads/avatar/e5a05968-d520-4c2f-9f3d-2369aab2c82b.txt',16,'text/plain','2026-06-18 13:25:40');
/*!40000 ALTER TABLE `upload_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'nuclear_energy'
--

--
-- Dumping routines for database 'nuclear_energy'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-19 15:46:35
