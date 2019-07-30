-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: localhost    Database: yushu
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add book',7,'add_book'),(20,'Can change book',7,'change_book'),(21,'Can delete book',7,'delete_book'),(22,'Can add gifts',8,'add_gifts'),(23,'Can change gifts',8,'change_gifts'),(24,'Can delete gifts',8,'delete_gifts'),(25,'Can add pending',9,'add_pending'),(26,'Can change pending',9,'change_pending'),(27,'Can delete pending',9,'delete_pending'),(28,'Can add 用户',10,'add_user'),(29,'Can change 用户',10,'change_user'),(30,'Can delete 用户',10,'delete_user'),(31,'Can add wish',11,'add_wish'),(32,'Can change wish',11,'change_wish'),(33,'Can delete wish',11,'delete_wish'),(34,'Can add captcha store',12,'add_captchastore'),(35,'Can change captcha store',12,'change_captchastore'),(36,'Can delete captcha store',12,'delete_captchastore');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bname` varchar(50) NOT NULL,
  `author` varchar(300) NOT NULL,
  `publisher` varchar(50) NOT NULL,
  `pubdate` varchar(50) NOT NULL,
  `jingz` varchar(20) DEFAULT NULL,
  `price` double NOT NULL,
  `pages` int(11) NOT NULL,
  `isbn` varchar(15) DEFAULT NULL,
  `intro` varchar(1000) NOT NULL,
  `image` varchar(100) NOT NULL,
  `date` datetime(6) NOT NULL,
  `uid` int(11) NOT NULL,
  `isdel` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `book_uid_f666edcd_fk_User_id` (`uid`),
  CONSTRAINT `book_uid_f666edcd_fk_User_id` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (44,'C程序设计语言','（美）Brian W. Kernighan、（美）Dennis M. Ritchie','机械工业出版社',' 2004-1','平装',30,258,'9787111128069','在计算机发展的历史上，没有哪一种程序设计语言像C语言这样应用广泛。本书原著即为C语言的设计者之一Dennis M.Ritchie和著名计算机科学家Brian W.Kernighan合著的一本介绍C语言的权威经典著作。','s1106934.jpg','2019-07-12 17:08:06.082092',8,1),(46,'鬼吹灯之龙岭迷窟','天下霸唱','安徽文艺出版社','2006-11','平装',25,242,'9787539628226','《鬼吹灯》是部奇书，小说中作者首创历史上四大盗墓门派——摸金、卸岭、发丘、搬山，其中摸金是技术含量最高，规矩最多的门派。“人点烛，鬼吹灯”是传说中摸金派的不传之秘，意为进入古墓之中先在东南角点燃一支蜡烛才能开棺，如果蜡烛熄灭，须速速退出，不可取一物。相传这是祖师爷所定的一条活人与死人的契约，千年传承，不得破。有谚为证：发丘印，摸金符，搬山卸岭寻龙诀；人点蜡，鬼吹灯，勘舆倒斗觅星峰；水银癍，养明器，龙楼宝殿去无数；窨沉棺，青铜椁，八字不硬莫近前。\\n故事以一本家传的秘书残卷为引，讲述三位当代摸金校尉，为解开部族消失的千古之谜，利用风水秘术，解读天下大山大川的脉搏，寻找一处处失落在大地深处的龙楼宝殿。','s1890264.jpg','2019-07-12 17:08:00.905240',8,0),(49,'三体Ⅱ','刘慈欣','重庆出版社','2008-5','平装',32,470,'9787536693968','三体人在利用魔法般的科技锁死了地球人的科学之后，庞大的宇宙舰队杀气腾腾地直扑太阳系，意欲清除地球文明。\\n面对前所未有的危局，经历过无数磨难的地球人组建起同样庞大的太空舰队，同时，利用三体人思维透明的致命缺陷，制订了神秘莫测的“面壁计划”，精选出四位“面壁者”。秘密展开对三体人的反击。\\n三体人自身虽然无法识破人类的诡谲计谋，却依靠由地球人中的背叛者挑选出的“破壁人”，与“面壁者”展开智慧博弈……\\n“面壁计划”究竟能否成功？地球人究竟能否在这场你死我活的文明生存竞争中战而胜之？神秘的\\n“黑暗森林”究竟意味着什么？','s3078482.jpg','2019-07-12 10:48:50.621023',8,1),(51,'Effective java 中文版（第2版）',' [美]JoshuaBloch','机械工业出版社','2009-1-1','平装',52,287,'9787111255833','本书介绍了在Java编程中78条极具实用价值的经验规则，这些经验规则涵盖了大多数开发人员每天所面临的问题的解决方案。通过对Java平台设计专家所使用的技术的全面描述，揭示了应该做什么，不应该做什么才能产生清晰、健壮和高效的代码。\\n本书中的每条规则都以简短、独立的小文章形式出现，并通过例子代码加以进一步说明。本书内容全面，结构清晰，讲解详细。可作为技术人员的参考用书。','s3479802.jpg','2019-07-12 16:08:03.609284',8,1),(53,'佐贺的超级阿嬷','[日]岛田洋七','南海出版公司','2007-3','平装',20,256,'9787544234726','因为无力扶养，母亲将年仅八岁的昭广寄养到佐贺乡下的外婆家，没想到迎接他的却是一间破烂茅屋！在那物质匮乏的日子里，乐观的外婆却总有神奇的办法让生活过下去，始终让家里洋溢着笑声和温暖……','s3922462.jpg','2019-07-12 16:08:08.439597',8,1),(55,'盗墓笔记','南派三叔','中国友谊出版公司','2007-1','平装',26.8,265,'9787505722835','五十年前，一群长沙土夫子（盗墓贼）挖到一部战国帛书，残篇中记载了一座奇特的战国古墓的位置，但那群土夫子在地下碰上了诡异事件，几乎全部身亡。\\n五十年后，其中一个土夫子的孙子在先人笔记中发现了这个秘密，他纠集了一批经验丰富的盗墓高手前去寻宝。但谁也没有想到，这个古墓中竟然有着这么多诡异的事物：七星疑棺、青眼狐尸、九头蛇柏……\\n这神秘的墓主人到底是谁，他们到底能不能找到真正的棺椁？为什么墓中还有那么多谜团无法破解？后来发现的海底诡异船墓、秦岭上的万年神木以及崇山峻岭中的天宫雪墓与这座古墓又有着怎样的关系？','s4442295.jpg','2019-07-12 10:44:31.760415',8,0),(56,'活着','余华','南海出版公司','1998-5','平装',12,195,'9787544210966','地主少爷福贵嗜赌成性，终于赌光了家业一贫如洗，穷困之中的福贵因为母亲生病前去求医，没想到半路上被国民党部队抓了壮丁，后被解放军所俘虏，回到家乡他才知道母亲已经去世，妻子家珍含辛茹苦带大了一双儿女，但女儿不幸变成了聋哑人，儿子机灵活泼……\\n然而，真正的悲剧从此才开始渐次上演，每读一页，都让我们止不住泪湿双眼，因为生命里难得的温情将被一次次死亡撕扯得粉碎，只剩得老了的福贵伴随着一头老牛在阳光下回忆。','s23836852.jpg','2019-07-12 10:44:33.495756',8,0),(57,'三体Ⅲ','刘慈欣','重庆出版社','2010-11','平装',38,513,'9787229030933','与三体文明的战争使人类第一次看到了宇宙黑暗的真相，地球文明像一个恐惧的孩子，熄灭了寻友的篝火，在暗夜中发抖。自以为历经沧桑，其实刚刚蹒跚学步；自以为悟出了生存竞争的秘密，其实还远没有竞争的资格。\\n使两个文明命悬一线的黑暗森林打击，不过是宇宙战场上一个微不足道的插曲。真正的星际战争没人见过，也不可能见到，因为战争的方式和武器已经远远超出人类的想象，目睹战场之日，即是灭亡之时。\\n宇宙的田园时代已经远去，昙花一现的终极之美最终变成任何智慧体都无法做出的梦，变成游吟诗人缥缈的残歌；宇宙的物竞天择已到了最惨烈的时刻，在亿万光年暗无天日的战场上，深渊最底层的毁灭力量被唤醒，太空变成了死神广阔的披风。\\n太阳系中的人们永远不会知道这一切，最后直面真相的，只有两双眼睛。\n','s26012674.jpg','2019-07-12 10:47:08.110047',8,0),(58,'深入理解C++11','Michael Wong、IBM XL编译器中国开发团队','机械工业出版社','2013-6','None',69,328,'978711142668','《深入理解C++11:C++11新特性解析与应用》内容简介：国内首本全面深入解读C++11新标准的专著，由C++标准委员会代表和IBM XL编译器中国开发团队共同撰写。不仅详细阐述了C++11标准的设计原则，而且系统地讲解了C++11新标准中的所有新语言特性、新标准库特性、对原有特性的改进，以及如何应用所有这些新特性。\\n《深入理解C++11:C++11新特性解析与应用》一共8章：第1章从设计思维和应用范畴两个维度对C++11新标准中的所有特性进行了分类，呈现了C++11新特性的原貌；第2章讲解了在保证与C语言和旧版C++标准充分兼容的原则下增加的一些新特性；第3章讲解了具有广泛可用性、能与其他已有的或者新增的特性结合起来使用的、具有普适性的一些新特性；第4章讲解了C++11新标准对原有一些语言特性的改进，这些特性不仅能让C++变得更强大，还能提升程序员编写代码的效率；','s26689304.jpg','2019-07-12 10:47:08.994582',8,0),(59,'C程序设计语言','（美）Brian W. Kernighan、（美）Dennis M. Ritchie','机械工业出版社',' 2004-1','平装',30,258,'978711112809','在计算机发展的历史上，没有哪一种程序设计语言像C语言这样应用广泛。本书原著即为C语言的设计者之一Dennis M.Ritchie和著名计算机科学家Brian W.Kernighan合著的一本介绍C语言的权威经典著作。','s1106934.jpg','2019-07-12 10:47:09.446374',8,0),(60,'深入理解计算机系统','Randal E.Bryant、David O\'Hallaron','中国电力出版社','2004-5-1','平装',85,873,'978750832172','从程序员的视角，看计算机系统！\\n本书适用于那些想要写出更快、更可靠程序的程序员。通过掌握程序是如何映射到系统上，以及程序是如何执行的，读者能够更好的理解程序的行为为什么是这样的，以及效率低下是如何造成的。粗略来看，计算机系统包括处理器和存储器硬件、编译器、操作系统和网络互连环境。而通过程序员的视角，读者可以清晰地明白学习计算机系统的内部工作原理会对他们今后作为计算机科学研究者和工程师的工作有进一步的帮助。它还有助于为进一步学习计算机体系结构、操作系统、编译器和网络互连做好准备。\\n本书的主要论题包括：数据表示、C程序的机器级表示、处理器结构，程序优化、存储器层次结构、链接、异常控制流、虚拟存储器和存储器管理、系统级I/O、网络编程和并发编程。书中所覆盖的内容主要是这些方面是如何影响应用和系统程序员的。','s1470003.jpg','2019-07-12 10:47:09.607984',8,0),(61,'鬼吹灯之龙岭迷窟','天下霸唱','安徽文艺出版社','2006-11','平装',25,242,'978753962826','《鬼吹灯》是部奇书，小说中作者首创历史上四大盗墓门派——摸金、卸岭、发丘、搬山，其中摸金是技术含量最高，规矩最多的门派。“人点烛，鬼吹灯”是传说中摸金派的不传之秘，意为进入古墓之中先在东南角点燃一支蜡烛才能开棺，如果蜡烛熄灭，须速速退出，不可取一物。相传这是祖师爷所定的一条活人与死人的契约，千年传承，不得破。有谚为证：发丘印，摸金符，搬山卸岭寻龙诀；人点蜡，鬼吹灯，勘舆倒斗觅星峰；水银癍，养明器，龙楼宝殿去无数；窨沉棺，青铜椁，八字不硬莫近前。\\n故事以一本家传的秘书残卷为引，讲述三位当代摸金校尉，为解开部族消失的千古之谜，利用风水秘术，解读天下大山大川的脉搏，寻找一处处失落在大地深处的龙楼宝殿。','s1890264.jpg','2019-07-12 10:47:11.214786',8,0),(62,'麦田里的守望者','J·D·塞林格','译林出版社','1997-2','平装',7.8,198,' 97878057135','霍尔顿是出身于富裕中产阶级的十六岁少年，在第四次被开除出学校之后，不敢贸然回家，只身在美国最繁华的纽约城游荡了一天两夜，住小客店，逛夜总会，滥交女友，酗酒……他看到了资本主义社会的种种丑恶，接触了各式各样的人物，其中大部分是“假模假式的”伪君子。\\n霍尔顿几乎看不惯周围发生的一切，他甚至想逃离这个现实世界，到穷乡僻壤去假装一个又聋又哑的人，但要真正这样做，又是不可能的，结果他只能生活在矛盾之中：他这一辈子最痛恨电影，但百无聊赖中又不得不在电影院里消磨时间；他厌恶没有爱情的性关系，却又糊里糊涂地叫来了妓女；他讨厌虚荣庸俗的女友萨丽，却又迷恋她的美色，情不自禁地与她搂搂抱抱。\\n因此，他尽管看不惯世道，却只好苦闷、彷惶，用种种不切实际的幻想安慰自己，自欺欺人，最后仍不免对现实社会妥协，成不了真正的叛逆，这可以说是作者塞林格和他笔下人物霍尔顿的悲剧所在。','s2738366.jpg','2019-07-12 10:40:29.958080',8,1),(63,'白水煮一切','大张伟','长江文艺出版社','2008','平装',19,147,'978753546702','这是一本纯粹的当整个世界给你冷脸子时，嘻嘻哈哈迎向你的书\\n大张伟在《白水煮一切》中讲述了103个发生在自己和朋友身上的故事，在每个段子后面他还发表了点评式的心得。','s3046564.jpg','2019-07-12 10:40:30.127627',8,1),(64,'三体Ⅱ','刘慈欣','重庆出版社','2008-5','平装',32,470,'978753663968','三体人在利用魔法般的科技锁死了地球人的科学之后，庞大的宇宙舰队杀气腾腾地直扑太阳系，意欲清除地球文明。\\n面对前所未有的危局，经历过无数磨难的地球人组建起同样庞大的太空舰队，同时，利用三体人思维透明的致命缺陷，制订了神秘莫测的“面壁计划”，精选出四位“面壁者”。秘密展开对三体人的反击。\\n三体人自身虽然无法识破人类的诡谲计谋，却依靠由地球人中的背叛者挑选出的“破壁人”，与“面壁者”展开智慧博弈……\\n“面壁计划”究竟能否成功？地球人究竟能否在这场你死我活的文明生存竞争中战而胜之？神秘的\\n“黑暗森林”究竟意味着什么？','s3078482.jpg','2019-07-12 10:40:30.307146',8,1),(65,'遇见未知的自己','张德芬','华夏出版社','2008-1','平装',29,249,'978750044019','故事从“冬天的雨夜，在荒郊野外的山区，一个没有手机、没有汽油的孤单女人”开始。\\n若菱，自名校毕业，拥有令人羡慕的工作，但心中却不时的自问：为什么我不能拥有想要的生活？为什么我不快乐？我该如何当自己生命的主人？ 在一个下雨的冬夜，若菱巧遇一名智慧老者，在与智者数度交谈的过程中，她渐渐填补不快乐、挫败的心灵缺口，寻回最真实勇敢的自我…… 你会不会担心和若菱一样，让身体的疲惫失控于华丽的业绩之中？ 你是否也想遇见在你心中的智慧老者，穿越心事的重重黑纱，遇见全新的自己？','s3403254.jpg','2019-07-12 10:40:30.625296',8,1),(67,'Effective java 中文版（第2版）',' [美]JoshuaBloch','机械工业出版社','2009-1-1','平装',52,287,'978711255833','本书介绍了在Java编程中78条极具实用价值的经验规则，这些经验规则涵盖了大多数开发人员每天所面临的问题的解决方案。通过对Java平台设计专家所使用的技术的全面描述，揭示了应该做什么，不应该做什么才能产生清晰、健壮和高效的代码。\\n本书中的每条规则都以简短、独立的小文章形式出现，并通过例子代码加以进一步说明。本书内容全面，结构清晰，讲解详细。可作为技术人员的参考用书。','s3479802.jpg','2019-07-12 10:40:31.134868',8,1),(68,'朗读者','[德]本哈德·施林克','译林出版社','2009-2','平装',22,197,' 978754470923','战后的德国萧条破败，一个15岁的少年在电车上病倒了，他独自下车，行走在滂沱大雨中，最后在一个逼仄的过道里吐得一塌糊涂，一个36岁的陌生女人帮助了他……\\n3个月后，少年伯格从突如其来的猩红热侵袭中恢复过来，他只是为了去感谢那个曾经在他生病时给予过他帮助的女人，但是，情欲，或者是爱情，在15岁的少年伯格心中渐渐燃烧起来。\\n电车售票员汉娜总是让伯格为她朗读，《荷马史诗》、《带小狗的女人》、《战争与和平》，在伯格的朗读中，汉娜像个孩子似的时而痛哭，时而大笑，那个夏天，是他们一生中最短暂最快乐并最终影响了后来岁月的时光……','s3628415.jpg','2019-07-12 10:40:31.296388',8,1),(69,'佐贺的超级阿嬷','[日]岛田洋七','南海出版公司','2007-3','平装',20,256,'978754424726','因为无力扶养，母亲将年仅八岁的昭广寄养到佐贺乡下的外婆家，没想到迎接他的却是一间破烂茅屋！在那物质匮乏的日子里，乐观的外婆却总有神奇的办法让生活过下去，始终让家里洋溢着笑声和温暖……','s3922462.jpg','2019-07-12 10:40:31.593594',8,1),(70,'Spring揭秘','王福强','人民邮电出版社','2009.8','平装',99,680,'978711520929','没有教程似的训导，更多的是说故事般的娓娓道来，本书是作者在多年的工作中积累的第一手Spring框架使用经验的总结，深入剖析了Spring框架各个模块的功能、出现的背景、设计理念和设计原理，揭开了Spring框架的神秘面纱，使你“知其然，更知其所以然”。每部分的扩展篇帮助读者活学活用Spring框架的方方面面，同时可以触类旁通，衍生出新的思路和解决方案。\\n本书内容全面，论述深刻入理，必将成为每个Java专业开发人员必备的Spring图书。','s3949449.jpg','2019-07-12 10:40:31.774139',8,1),(71,'盗墓笔记','南派三叔','中国友谊出版公司','2007-1','平装',26.8,265,'978750572835','五十年前，一群长沙土夫子（盗墓贼）挖到一部战国帛书，残篇中记载了一座奇特的战国古墓的位置，但那群土夫子在地下碰上了诡异事件，几乎全部身亡。\\n五十年后，其中一个土夫子的孙子在先人笔记中发现了这个秘密，他纠集了一批经验丰富的盗墓高手前去寻宝。但谁也没有想到，这个古墓中竟然有着这么多诡异的事物：七星疑棺、青眼狐尸、九头蛇柏……\\n这神秘的墓主人到底是谁，他们到底能不能找到真正的棺椁？为什么墓中还有那么多谜团无法破解？后来发现的海底诡异船墓、秦岭上的万年神木以及崇山峻岭中的天宫雪墓与这座古墓又有着怎样的关系？','s4442295.jpg','2019-07-12 10:40:31.933684',8,1),(72,'活着','余华','南海出版公司','1998-5','平装',12,195,'978754421066','地主少爷福贵嗜赌成性，终于赌光了家业一贫如洗，穷困之中的福贵因为母亲生病前去求医，没想到半路上被国民党部队抓了壮丁，后被解放军所俘虏，回到家乡他才知道母亲已经去世，妻子家珍含辛茹苦带大了一双儿女，但女儿不幸变成了聋哑人，儿子机灵活泼……\\n然而，真正的悲剧从此才开始渐次上演，每读一页，都让我们止不住泪湿双眼，因为生命里难得的温情将被一次次死亡撕扯得粉碎，只剩得老了的福贵伴随着一头老牛在阳光下回忆。','s23836852.jpg','2019-07-12 10:40:32.244874',8,1),(73,'三体Ⅲ','刘慈欣','重庆出版社','2010-11','平装',38,513,'978722903933','与三体文明的战争使人类第一次看到了宇宙黑暗的真相，地球文明像一个恐惧的孩子，熄灭了寻友的篝火，在暗夜中发抖。自以为历经沧桑，其实刚刚蹒跚学步；自以为悟出了生存竞争的秘密，其实还远没有竞争的资格。\\n使两个文明命悬一线的黑暗森林打击，不过是宇宙战场上一个微不足道的插曲。真正的星际战争没人见过，也不可能见到，因为战争的方式和武器已经远远超出人类的想象，目睹战场之日，即是灭亡之时。\\n宇宙的田园时代已经远去，昙花一现的终极之美最终变成任何智慧体都无法做出的梦，变成游吟诗人缥缈的残歌；宇宙的物竞天择已到了最惨烈的时刻，在亿万光年暗无天日的战场上，深渊最底层的毁灭力量被唤醒，太空变成了死神广阔的披风。\\n太阳系中的人们永远不会知道这一切，最后直面真相的，只有两双眼睛。\n','s26012674.jpg','2019-07-12 10:40:32.573004',8,1),(74,'深入理解C++11','Michael Wong、IBM XL编译器中国开发团队','机械工业出版社','2013-6','None',69,328,'978711142608','《深入理解C++11:C++11新特性解析与应用》内容简介：国内首本全面深入解读C++11新标准的专著，由C++标准委员会代表和IBM XL编译器中国开发团队共同撰写。不仅详细阐述了C++11标准的设计原则，而且系统地讲解了C++11新标准中的所有新语言特性、新标准库特性、对原有特性的改进，以及如何应用所有这些新特性。\\n《深入理解C++11:C++11新特性解析与应用》一共8章：第1章从设计思维和应用范畴两个维度对C++11新标准中的所有特性进行了分类，呈现了C++11新特性的原貌；第2章讲解了在保证与C语言和旧版C++标准充分兼容的原则下增加的一些新特性；第3章讲解了具有广泛可用性、能与其他已有的或者新增的特性结合起来使用的、具有普适性的一些新特性；第4章讲解了C++11新标准对原有一些语言特性的改进，这些特性不仅能让C++变得更强大，还能提升程序员编写代码的效率；','s26689304.jpg','2019-07-12 10:40:32.932043',8,1),(76,'C程序设计语言','（美）Brian W. Kernighan、（美）Dennis M. Ritchie','机械工业出版社',' 2004-1','平装',30,258,'97871128069','在计算机发展的历史上，没有哪一种程序设计语言像C语言这样应用广泛。本书原著即为C语言的设计者之一Dennis M.Ritchie和著名计算机科学家Brian W.Kernighan合著的一本介绍C语言的权威经典著作。','s1106934.jpg','2019-07-12 10:40:33.665702',8,1),(77,'深入理解计算机系统','Randal E.Bryant、David O\'Hallaron','中国电力出版社','2004-5-1','平装',85,873,'97875021752','从程序员的视角，看计算机系统！\\n本书适用于那些想要写出更快、更可靠程序的程序员。通过掌握程序是如何映射到系统上，以及程序是如何执行的，读者能够更好的理解程序的行为为什么是这样的，以及效率低下是如何造成的。粗略来看，计算机系统包括处理器和存储器硬件、编译器、操作系统和网络互连环境。而通过程序员的视角，读者可以清晰地明白学习计算机系统的内部工作原理会对他们今后作为计算机科学研究者和工程师的工作有进一步的帮助。它还有助于为进一步学习计算机体系结构、操作系统、编译器和网络互连做好准备。\\n本书的主要论题包括：数据表示、C程序的机器级表示、处理器结构，程序优化、存储器层次结构、链接、异常控制流、虚拟存储器和存储器管理、系统级I/O、网络编程和并发编程。书中所覆盖的内容主要是这些方面是如何影响应用和系统程序员的。','s1470003.jpg','2019-07-12 10:40:33.835248',8,1),(78,'鬼吹灯之龙岭迷窟','天下霸唱','安徽文艺出版社','2006-11','平装',25,242,'97875328226','《鬼吹灯》是部奇书，小说中作者首创历史上四大盗墓门派——摸金、卸岭、发丘、搬山，其中摸金是技术含量最高，规矩最多的门派。“人点烛，鬼吹灯”是传说中摸金派的不传之秘，意为进入古墓之中先在东南角点燃一支蜡烛才能开棺，如果蜡烛熄灭，须速速退出，不可取一物。相传这是祖师爷所定的一条活人与死人的契约，千年传承，不得破。有谚为证：发丘印，摸金符，搬山卸岭寻龙诀；人点蜡，鬼吹灯，勘舆倒斗觅星峰；水银癍，养明器，龙楼宝殿去无数；窨沉棺，青铜椁，八字不硬莫近前。\\n故事以一本家传的秘书残卷为引，讲述三位当代摸金校尉，为解开部族消失的千古之谜，利用风水秘术，解读天下大山大川的脉搏，寻找一处处失落在大地深处的龙楼宝殿。','s1890264.jpg','2019-07-12 10:40:34.068624',8,1),(79,'麦田里的守望者','J·D·塞林格','译林出版社','1997-2','平装',7.8,198,'978705676135','霍尔顿是出身于富裕中产阶级的十六岁少年，在第四次被开除出学校之后，不敢贸然回家，只身在美国最繁华的纽约城游荡了一天两夜，住小客店，逛夜总会，滥交女友，酗酒……他看到了资本主义社会的种种丑恶，接触了各式各样的人物，其中大部分是“假模假式的”伪君子。\\n霍尔顿几乎看不惯周围发生的一切，他甚至想逃离这个现实世界，到穷乡僻壤去假装一个又聋又哑的人，但要真正这样做，又是不可能的，结果他只能生活在矛盾之中：他这一辈子最痛恨电影，但百无聊赖中又不得不在电影院里消磨时间；他厌恶没有爱情的性关系，却又糊里糊涂地叫来了妓女；他讨厌虚荣庸俗的女友萨丽，却又迷恋她的美色，情不自禁地与她搂搂抱抱。\\n因此，他尽管看不惯世道，却只好苦闷、彷惶，用种种不切实际的幻想安慰自己，自欺欺人，最后仍不免对现实社会妥协，成不了真正的叛逆，这可以说是作者塞林格和他笔下人物霍尔顿的悲剧所在。','s2738366.jpg','2019-07-12 10:40:34.427691',8,1),(80,'白水煮一切','大张伟','长江文艺出版社','2008','平装',19,147,'97875353702','这是一本纯粹的当整个世界给你冷脸子时，嘻嘻哈哈迎向你的书\\n大张伟在《白水煮一切》中讲述了103个发生在自己和朋友身上的故事，在每个段子后面他还发表了点评式的心得。','s3046564.jpg','2019-07-12 10:40:34.779722',8,1),(81,'三体Ⅱ','刘慈欣','重庆出版社','2008-5','平装',32,470,'97875363968','三体人在利用魔法般的科技锁死了地球人的科学之后，庞大的宇宙舰队杀气腾腾地直扑太阳系，意欲清除地球文明。\\n面对前所未有的危局，经历过无数磨难的地球人组建起同样庞大的太空舰队，同时，利用三体人思维透明的致命缺陷，制订了神秘莫测的“面壁计划”，精选出四位“面壁者”。秘密展开对三体人的反击。\\n三体人自身虽然无法识破人类的诡谲计谋，却依靠由地球人中的背叛者挑选出的“破壁人”，与“面壁者”展开智慧博弈……\\n“面壁计划”究竟能否成功？地球人究竟能否在这场你死我活的文明生存竞争中战而胜之？神秘的\\n“黑暗森林”究竟意味着什么？','s3078482.jpg','2019-07-12 10:40:34.935306',8,1),(82,'遇见未知的自己','张德芬','华夏出版社','2008-1','平装',29,249,'97875044019','故事从“冬天的雨夜，在荒郊野外的山区，一个没有手机、没有汽油的孤单女人”开始。\\n若菱，自名校毕业，拥有令人羡慕的工作，但心中却不时的自问：为什么我不能拥有想要的生活？为什么我不快乐？我该如何当自己生命的主人？ 在一个下雨的冬夜，若菱巧遇一名智慧老者，在与智者数度交谈的过程中，她渐渐填补不快乐、挫败的心灵缺口，寻回最真实勇敢的自我…… 你会不会担心和若菱一样，让身体的疲惫失控于华丽的业绩之中？ 你是否也想遇见在你心中的智慧老者，穿越心事的重重黑纱，遇见全新的自己？','s3403254.jpg','2019-07-12 10:40:35.138762',8,1),(83,'Effective java 中文版（第2版）',' [美]JoshuaBloch','机械工业出版社','2009-1-1','平装',52,287,'97871255833','本书介绍了在Java编程中78条极具实用价值的经验规则，这些经验规则涵盖了大多数开发人员每天所面临的问题的解决方案。通过对Java平台设计专家所使用的技术的全面描述，揭示了应该做什么，不应该做什么才能产生清晰、健壮和高效的代码。\\n本书中的每条规则都以简短、独立的小文章形式出现，并通过例子代码加以进一步说明。本书内容全面，结构清晰，讲解详细。可作为技术人员的参考用书。','s3479802.jpg','2019-07-12 10:40:35.317286',8,1),(84,'朗读者','[德]本哈德·施林克','译林出版社','2009-2','平装',22,197,'787544707923','战后的德国萧条破败，一个15岁的少年在电车上病倒了，他独自下车，行走在滂沱大雨中，最后在一个逼仄的过道里吐得一塌糊涂，一个36岁的陌生女人帮助了他……\\n3个月后，少年伯格从突如其来的猩红热侵袭中恢复过来，他只是为了去感谢那个曾经在他生病时给予过他帮助的女人，但是，情欲，或者是爱情，在15岁的少年伯格心中渐渐燃烧起来。\\n电车售票员汉娜总是让伯格为她朗读，《荷马史诗》、《带小狗的女人》、《战争与和平》，在伯格的朗读中，汉娜像个孩子似的时而痛哭，时而大笑，那个夏天，是他们一生中最短暂最快乐并最终影响了后来岁月的时光……','s3628415.jpg','2019-07-12 10:40:35.485834',8,1),(85,'佐贺的超级阿嬷','[日]岛田洋七','南海出版公司','2007-3','平装',20,256,'97844234726','因为无力扶养，母亲将年仅八岁的昭广寄养到佐贺乡下的外婆家，没想到迎接他的却是一间破烂茅屋！在那物质匮乏的日子里，乐观的外婆却总有神奇的办法让生活过下去，始终让家里洋溢着笑声和温暖……','s3922462.jpg','2019-07-12 10:40:35.664357',8,1),(86,'Spring揭秘','王福强','人民邮电出版社','2009.8','平装',99,680,'97115209429','没有教程似的训导，更多的是说故事般的娓娓道来，本书是作者在多年的工作中积累的第一手Spring框架使用经验的总结，深入剖析了Spring框架各个模块的功能、出现的背景、设计理念和设计原理，揭开了Spring框架的神秘面纱，使你“知其然，更知其所以然”。每部分的扩展篇帮助读者活学活用Spring框架的方方面面，同时可以触类旁通，衍生出新的思路和解决方案。\\n本书内容全面，论述深刻入理，必将成为每个Java专业开发人员必备的Spring图书。','s3949449.jpg','2019-07-12 10:40:35.851855',8,1),(87,'盗墓笔记','南派三叔','中国友谊出版公司','2007-1','平装',26.8,265,'97875722835','五十年前，一群长沙土夫子（盗墓贼）挖到一部战国帛书，残篇中记载了一座奇特的战国古墓的位置，但那群土夫子在地下碰上了诡异事件，几乎全部身亡。\\n五十年后，其中一个土夫子的孙子在先人笔记中发现了这个秘密，他纠集了一批经验丰富的盗墓高手前去寻宝。但谁也没有想到，这个古墓中竟然有着这么多诡异的事物：七星疑棺、青眼狐尸、九头蛇柏……\\n这神秘的墓主人到底是谁，他们到底能不能找到真正的棺椁？为什么墓中还有那么多谜团无法破解？后来发现的海底诡异船墓、秦岭上的万年神木以及崇山峻岭中的天宫雪墓与这座古墓又有着怎样的关系？','s4442295.jpg','2019-07-12 10:40:36.031376',8,1),(88,'活着','余华','南海出版公司','1998-5','平装',12,195,'97875410966','地主少爷福贵嗜赌成性，终于赌光了家业一贫如洗，穷困之中的福贵因为母亲生病前去求医，没想到半路上被国民党部队抓了壮丁，后被解放军所俘虏，回到家乡他才知道母亲已经去世，妻子家珍含辛茹苦带大了一双儿女，但女儿不幸变成了聋哑人，儿子机灵活泼……\\n然而，真正的悲剧从此才开始渐次上演，每读一页，都让我们止不住泪湿双眼，因为生命里难得的温情将被一次次死亡撕扯得粉碎，只剩得老了的福贵伴随着一头老牛在阳光下回忆。','s23836852.jpg','2019-07-12 10:40:36.226853',8,1),(89,'三体Ⅲ','刘慈欣','重庆出版社','2010-11','平装',38,513,'97872230933','与三体文明的战争使人类第一次看到了宇宙黑暗的真相，地球文明像一个恐惧的孩子，熄灭了寻友的篝火，在暗夜中发抖。自以为历经沧桑，其实刚刚蹒跚学步；自以为悟出了生存竞争的秘密，其实还远没有竞争的资格。\\n使两个文明命悬一线的黑暗森林打击，不过是宇宙战场上一个微不足道的插曲。真正的星际战争没人见过，也不可能见到，因为战争的方式和武器已经远远超出人类的想象，目睹战场之日，即是灭亡之时。\\n宇宙的田园时代已经远去，昙花一现的终极之美最终变成任何智慧体都无法做出的梦，变成游吟诗人缥缈的残歌；宇宙的物竞天择已到了最惨烈的时刻，在亿万光年暗无天日的战场上，深渊最底层的毁灭力量被唤醒，太空变成了死神广阔的披风。\\n太阳系中的人们永远不会知道这一切，最后直面真相的，只有两双眼睛。\n','s26012674.jpg','2019-07-12 10:40:36.682313',8,1),(90,'深入理解C++11','Michael Wong、IBM XL编译器中国开发团队','机械工业出版社','2013-6','None',69,328,'9787142668','《深入理解C++11:C++11新特性解析与应用》内容简介：国内首本全面深入解读C++11新标准的专著，由C++标准委员会代表和IBM XL编译器中国开发团队共同撰写。不仅详细阐述了C++11标准的设计原则，而且系统地讲解了C++11新标准中的所有新语言特性、新标准库特性、对原有特性的改进，以及如何应用所有这些新特性。\\n《深入理解C++11:C++11新特性解析与应用》一共8章：第1章从设计思维和应用范畴两个维度对C++11新标准中的所有特性进行了分类，呈现了C++11新特性的原貌；第2章讲解了在保证与C语言和旧版C++标准充分兼容的原则下增加的一些新特性；第3章讲解了具有广泛可用性、能与其他已有的或者新增的特性结合起来使用的、具有普适性的一些新特性；第4章讲解了C++11新标准对原有一些语言特性的改进，这些特性不仅能让C++变得更强大，还能提升程序员编写代码的效率；','s26689304.jpg','2019-07-12 10:40:36.853855',8,1),(91,'C程序设计语言','（美）Brian W. Kernighan、（美）Dennis M. Ritchie','机械工业出版社',' 2004-1','平装',30,258,'9787112809','在计算机发展的历史上，没有哪一种程序设计语言像C语言这样应用广泛。本书原著即为C语言的设计者之一Dennis M.Ritchie和著名计算机科学家Brian W.Kernighan合著的一本介绍C语言的权威经典著作。','s1106934.jpg','2019-07-12 10:40:37.095408',8,1),(92,'深入理解计算机系统','Randal E.Bryant、David O\'Hallaron','中国电力出版社','2004-5-1','平装',85,873,'9787532172','从程序员的视角，看计算机系统！\\n本书适用于那些想要写出更快、更可靠程序的程序员。通过掌握程序是如何映射到系统上，以及程序是如何执行的，读者能够更好的理解程序的行为为什么是这样的，以及效率低下是如何造成的。粗略来看，计算机系统包括处理器和存储器硬件、编译器、操作系统和网络互连环境。而通过程序员的视角，读者可以清晰地明白学习计算机系统的内部工作原理会对他们今后作为计算机科学研究者和工程师的工作有进一步的帮助。它还有助于为进一步学习计算机体系结构、操作系统、编译器和网络互连做好准备。\\n本书的主要论题包括：数据表示、C程序的机器级表示、处理器结构，程序优化、存储器层次结构、链接、异常控制流、虚拟存储器和存储器管理、系统级I/O、网络编程和并发编程。书中所覆盖的内容主要是这些方面是如何影响应用和系统程序员的。','s1470003.jpg','2019-07-12 10:40:37.270938',8,1),(93,'鬼吹灯之龙岭迷窟','天下霸唱','安徽文艺出版社','2006-11','平装',25,242,'9787532826','《鬼吹灯》是部奇书，小说中作者首创历史上四大盗墓门派——摸金、卸岭、发丘、搬山，其中摸金是技术含量最高，规矩最多的门派。“人点烛，鬼吹灯”是传说中摸金派的不传之秘，意为进入古墓之中先在东南角点燃一支蜡烛才能开棺，如果蜡烛熄灭，须速速退出，不可取一物。相传这是祖师爷所定的一条活人与死人的契约，千年传承，不得破。有谚为证：发丘印，摸金符，搬山卸岭寻龙诀；人点蜡，鬼吹灯，勘舆倒斗觅星峰；水银癍，养明器，龙楼宝殿去无数；窨沉棺，青铜椁，八字不硬莫近前。\\n故事以一本家传的秘书残卷为引，讲述三位当代摸金校尉，为解开部族消失的千古之谜，利用风水秘术，解读天下大山大川的脉搏，寻找一处处失落在大地深处的龙楼宝殿。','s1890264.jpg','2019-07-12 10:40:37.450460',8,1),(94,'麦田里的守望者','J·D·塞林格','译林出版社','1997-2','平装',7.8,198,' 978057135','霍尔顿是出身于富裕中产阶级的十六岁少年，在第四次被开除出学校之后，不敢贸然回家，只身在美国最繁华的纽约城游荡了一天两夜，住小客店，逛夜总会，滥交女友，酗酒……他看到了资本主义社会的种种丑恶，接触了各式各样的人物，其中大部分是“假模假式的”伪君子。\\n霍尔顿几乎看不惯周围发生的一切，他甚至想逃离这个现实世界，到穷乡僻壤去假装一个又聋又哑的人，但要真正这样做，又是不可能的，结果他只能生活在矛盾之中：他这一辈子最痛恨电影，但百无聊赖中又不得不在电影院里消磨时间；他厌恶没有爱情的性关系，却又糊里糊涂地叫来了妓女；他讨厌虚荣庸俗的女友萨丽，却又迷恋她的美色，情不自禁地与她搂搂抱抱。\\n因此，他尽管看不惯世道，却只好苦闷、彷惶，用种种不切实际的幻想安慰自己，自欺欺人，最后仍不免对现实社会妥协，成不了真正的叛逆，这可以说是作者塞林格和他笔下人物霍尔顿的悲剧所在。','s2738366.jpg','2019-07-12 10:40:37.634965',8,1),(95,'白水煮一切','大张伟','长江文艺出版社','2008','平装',19,147,'9787536702','这是一本纯粹的当整个世界给你冷脸子时，嘻嘻哈哈迎向你的书\\n大张伟在《白水煮一切》中讲述了103个发生在自己和朋友身上的故事，在每个段子后面他还发表了点评式的心得。','s3046564.jpg','2019-07-12 10:40:37.820469',8,1),(96,'三体Ⅲ','刘慈欣','重庆出版社','2010-11','平装',38,513,'978722933','与三体文明的战争使人类第一次看到了宇宙黑暗的真相，地球文明像一个恐惧的孩子，熄灭了寻友的篝火，在暗夜中发抖。自以为历经沧桑，其实刚刚蹒跚学步；自以为悟出了生存竞争的秘密，其实还远没有竞争的资格。\\n使两个文明命悬一线的黑暗森林打击，不过是宇宙战场上一个微不足道的插曲。真正的星际战争没人见过，也不可能见到，因为战争的方式和武器已经远远超出人类的想象，目睹战场之日，即是灭亡之时。\\n宇宙的田园时代已经远去，昙花一现的终极之美最终变成任何智慧体都无法做出的梦，变成游吟诗人缥缈的残歌；宇宙的物竞天择已到了最惨烈的时刻，在亿万光年暗无天日的战场上，深渊最底层的毁灭力量被唤醒，太空变成了死神广阔的披风。\\n太阳系中的人们永远不会知道这一切，最后直面真相的，只有两双眼睛。\n','s26012674.jpg','2019-07-12 10:40:37.997994',8,1),(97,'深入理解C++11','Michael Wong、IBM XL编译器中国开发团队','机械工业出版社','2013-6','None',69,328,'97872668','《深入理解C++11:C++11新特性解析与应用》内容简介：国内首本全面深入解读C++11新标准的专著，由C++标准委员会代表和IBM XL编译器中国开发团队共同撰写。不仅详细阐述了C++11标准的设计原则，而且系统地讲解了C++11新标准中的所有新语言特性、新标准库特性、对原有特性的改进，以及如何应用所有这些新特性。\\n《深入理解C++11:C++11新特性解析与应用》一共8章：第1章从设计思维和应用范畴两个维度对C++11新标准中的所有特性进行了分类，呈现了C++11新特性的原貌；第2章讲解了在保证与C语言和旧版C++标准充分兼容的原则下增加的一些新特性；第3章讲解了具有广泛可用性、能与其他已有的或者新增的特性结合起来使用的、具有普适性的一些新特性；第4章讲解了C++11新标准对原有一些语言特性的改进，这些特性不仅能让C++变得更强大，还能提升程序员编写代码的效率；','s26689304.jpg','2019-07-12 10:40:38.353083',8,1);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `captcha_captchastore`
--

DROP TABLE IF EXISTS `captcha_captchastore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `captcha_captchastore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge` varchar(32) NOT NULL,
  `response` varchar(32) NOT NULL,
  `hashkey` varchar(40) NOT NULL,
  `expiration` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=InnoDB AUTO_INCREMENT=265 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha_captchastore`
--

LOCK TABLES `captcha_captchastore` WRITE;
/*!40000 ALTER TABLE `captcha_captchastore` DISABLE KEYS */;
/*!40000 ALTER TABLE `captcha_captchastore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(12,'captcha','captchastore'),(5,'contenttypes','contenttype'),(6,'sessions','session'),(7,'User','book'),(8,'User','gifts'),(9,'User','pending'),(10,'User','user'),(11,'User','wish');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'User','0001_initial','2019-07-06 20:40:03.761662'),(2,'contenttypes','0001_initial','2019-07-06 20:40:04.077210'),(3,'auth','0001_initial','2019-07-06 20:40:08.149691'),(4,'admin','0001_initial','2019-07-06 20:40:09.095705'),(5,'admin','0002_logentry_remove_auto_add','2019-07-06 20:40:09.149565'),(6,'contenttypes','0002_remove_content_type_name','2019-07-06 20:40:09.810850'),(7,'auth','0002_alter_permission_name_max_length','2019-07-06 20:40:10.213889'),(8,'auth','0003_alter_user_email_max_length','2019-07-06 20:40:10.658697'),(9,'auth','0004_alter_user_username_opts','2019-07-06 20:40:10.706568'),(10,'auth','0005_alter_user_last_login_null','2019-07-06 20:40:11.033828'),(11,'auth','0006_require_contenttypes_0002','2019-07-06 20:40:11.058773'),(12,'auth','0007_alter_validators_add_error_messages','2019-07-06 20:40:11.110659'),(13,'auth','0008_alter_user_username_max_length','2019-07-06 20:40:12.047526'),(14,'auth','0009_alter_user_last_name_max_length','2019-07-06 20:40:12.464409'),(15,'captcha','0001_initial','2019-07-06 20:40:12.665380'),(16,'sessions','0001_initial','2019-07-06 20:40:12.950404'),(17,'User','0002_auto_20190708_1912','2019-07-08 19:12:40.680758'),(18,'User','0003_auto_20190708_2017','2019-07-08 20:17:09.179391'),(19,'User','0004_auto_20190709_1932','2019-07-09 19:32:33.574489'),(20,'User','0005_auto_20190711_2225','2019-07-11 22:25:31.092573');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3enwnsmd3ubwn2zgl24l93mnb2h2dtx4','YTEyYjczNGRjYjlkZDA2MTk5YjA4OTdiNGQ5ZDk5ZGIzMTRjZWFmMDp7ImlzX2xvZ2luIjp0cnVlLCJ1c2VyX2lkIjo5LCJ1c2VyX25hbWUiOiJcdTU2M2JcdTU2M2IiLCJoZWFkX3Bob3RvIjoidXBsb2FkL2hlYWRfcGhvdG8vMjAxOS8wNy8xMlxcMTgwMjAxOTA3MTIxNjU3Mzg5MjUuanBnIn0=','2019-07-26 17:07:40.647756'),('huig99hg99ot72wg01ghcgz8v5twr85j','YjVhYmJkY2VlNmY5MDkyZjhiNWMxMjc0NzE3OWFkNWI2OWZjYWJjZTp7ImlzX2xvZ2luIjp0cnVlLCJ1c2VyX2lkIjo5LCJ1c2VyX25hbWUiOiJcdTU2M2JcdTU2M2IiLCJoZWFkX3Bob3RvIjoidXBsb2FkL2hlYWRfcGhvdG8vMjAxOS8wNy8xMVxcMzEyMDE5MDcxMTIwMjY1MTc3OS5qcGcifQ==','2019-07-26 12:11:39.415579'),('j0bft2h4jpes101b43q0gu1rk1olvfsq','OTI2MzNhNzk2OWU0Nzc3NWQyMjAwY2RmYjFiYzkyYmYwMmRiNGM5Zjp7ImlzX2xvZ2luIjp0cnVlLCJ1c2VyX2lkIjo5LCJ1c2VyX25hbWUiOiJcdTU2M2JcdTU2M2IiLCJoZWFkX3Bob3RvIjoidXBsb2FkL2hlYWRfcGhvdG8vdGltZy5naWYifQ==','2019-07-25 13:05:43.365512'),('nlt34xjy734uc2ki5fwc2bgx7azeqjbj','ZmY4YjRmZmI2ODllNDNjZTY2YzcyNmFkMzAwMTRkYjE4MjI4NDgzMTp7ImlzX2xvZ2luIjp0cnVlLCJ1c2VyX2lkIjo5LCJ1c2VyX25hbWUiOiJcdTU2M2JcdTU2M2IiLCJoZWFkX3Bob3RvIjoidXBsb2FkL2hlYWRfcGhvdG8vMjAxOS8wNy8xMVxcdT0xMDIwMTkwNzExMTcwNTM5NTQzLmpwZyJ9','2019-07-25 17:05:39.148779'),('vgq40dgh609slq79wqswa9oor538kz4i','YTEyYjczNGRjYjlkZDA2MTk5YjA4OTdiNGQ5ZDk5ZGIzMTRjZWFmMDp7ImlzX2xvZ2luIjp0cnVlLCJ1c2VyX2lkIjo5LCJ1c2VyX25hbWUiOiJcdTU2M2JcdTU2M2IiLCJoZWFkX3Bob3RvIjoidXBsb2FkL2hlYWRfcGhvdG8vMjAxOS8wNy8xMlxcMTgwMjAxOTA3MTIxNjU3Mzg5MjUuanBnIn0=','2019-07-26 16:57:38.638395'),('xa30f9uz8kvxqw5ybcy0jiqan4ze8zhj','OTI2MzNhNzk2OWU0Nzc3NWQyMjAwY2RmYjFiYzkyYmYwMmRiNGM5Zjp7ImlzX2xvZ2luIjp0cnVlLCJ1c2VyX2lkIjo5LCJ1c2VyX25hbWUiOiJcdTU2M2JcdTU2M2IiLCJoZWFkX3Bob3RvIjoidXBsb2FkL2hlYWRfcGhvdG8vdGltZy5naWYifQ==','2019-07-24 22:21:22.102290');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gifts`
--

DROP TABLE IF EXISTS `gifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `gifts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `launched` int(11) NOT NULL,
  `date` datetime(6) NOT NULL,
  `bookid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `gifts_bookid_2ece788b_fk_book_id` (`bookid`),
  KEY `gifts_uid_accb1241_fk_User_id` (`uid`),
  CONSTRAINT `gifts_bookid_2ece788b_fk_book_id` FOREIGN KEY (`bookid`) REFERENCES `book` (`id`),
  CONSTRAINT `gifts_uid_accb1241_fk_User_id` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gifts`
--

LOCK TABLES `gifts` WRITE;
/*!40000 ALTER TABLE `gifts` DISABLE KEYS */;
INSERT INTO `gifts` VALUES (4,0,'2019-07-05 17:13:10.797001',44,8),(16,0,'2019-07-09 16:40:15.741669',46,9),(20,0,'2019-07-12 11:58:26.868016',49,9),(21,0,'2019-07-12 11:58:43.549946',53,9),(23,0,'2019-07-12 11:58:58.069249',51,9),(24,0,'2019-07-12 17:02:58.077063',70,9);
/*!40000 ALTER TABLE `gifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pending`
--

DROP TABLE IF EXISTS `pending`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `pending` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipients` varchar(128) NOT NULL,
  `phone` varchar(19) NOT NULL,
  `address` varchar(2000) NOT NULL,
  `message` varchar(2000) DEFAULT NULL,
  `times` datetime(6) NOT NULL,
  `state` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `bookid` int(11) NOT NULL,
  `tuid` varchar(20) NOT NULL,
  `tname` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pending_bookid_424b63b2_fk_book_id` (`bookid`),
  KEY `pending_uid_752cc46b_fk_User_id` (`uid`),
  CONSTRAINT `pending_bookid_424b63b2_fk_book_id` FOREIGN KEY (`bookid`) REFERENCES `book` (`id`),
  CONSTRAINT `pending_uid_752cc46b_fk_User_id` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pending`
--

LOCK TABLES `pending` WRITE;
/*!40000 ALTER TABLE `pending` DISABLE KEYS */;
INSERT INTO `pending` VALUES (16,'嘻嘻','15110738956','日日日日日日日日日日日日日日日日日日日','日日日日日日日日日日日日日日日日日日日','2019-07-11 11:34:58.123597',0,9,44,'8','马志伟'),(17,'嘻嘻','15110738956','哈哈哈哈哈哈哈哈哈哈哈哈','哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈','2019-07-11 11:46:27.966383',1,9,44,'8','马志伟'),(20,'嘻嘻','15110738956','呃呃呃呃呃呃呃呃呃呃呃呃呃呃呃呃呃呃呃','呃呃呃呃呃呃呃呃呃呃呃呃呃呃呃呃呃呃','2019-07-11 16:34:38.488524',1,9,44,'8','马志伟'),(23,'嘻嘻','15110738956','uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu','uuuuuuuuuuuuuuuuuuuu','2019-07-11 20:16:40.486401',1,9,44,'8','马志伟'),(24,'夏尔','13833333333','陕西省吕梁市离市区东关街道北巷36号','gkd','2019-07-12 16:07:19.330715',1,8,46,'9','嘻嘻'),(25,'小李','13888888888','打撒见鬼十法DAU三段跳士大夫阿杜','gkd\r\n','2019-07-12 16:51:51.747411',1,8,51,'9','嘻嘻'),(26,'抠破盘口瓶囧了很快就被好借好还','13812111111','斤斤计较军军军军军军军军军军军军军军',';;;;;;;;;;;嘎嘎嘎嘎嘎过过过过过过过过过','2019-07-12 16:53:22.042665',0,8,53,'9','嘻嘻'),(27,'哈哈哈','13812111111','几句话过过付付付付付付付付付付付付付付','哈哈哈哈哈','2019-07-12 16:54:11.904121',0,8,53,'9','嘻嘻'),(28,'嘻嘻','13833333333','嘎嘎嘎嘎嘎过过过过过过过过过过过过','是是是','2019-07-12 17:06:11.439986',1,8,51,'9','嘻嘻');
/*!40000 ALTER TABLE `pending` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `email` varchar(254) NOT NULL,
  `sex` varchar(32) NOT NULL,
  `c_time` datetime(6) NOT NULL,
  `beans` double NOT NULL,
  `send_counter` int(11) NOT NULL,
  `receive_counter` int(11) NOT NULL,
  `head_photo` varchar(5000) NOT NULL,
  `allowlogin` int(11) NOT NULL,
  `usertype` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (8,'马志伟','6faff4859d871a4198679e0d48a0b719fe56391e4dec3b2a8df68f793f995303','13834574393@163.com','male','2019-06-26 20:51:38.371724',5.5,2,0,'upload/head_photo/2019/07/11\\3120190711223143229.jpg',0,1),(9,'嘻嘻','6faff4859d871a4198679e0d48a0b719fe56391e4dec3b2a8df68f793f995303','15110738723@163.com','male','2019-07-01 23:55:27.806359',4.5,3,0,'upload/head_photo/2019/07/12\\18020190712165738925.jpg',1,0),(10,'a123456789','6faff4859d871a4198679e0d48a0b719fe56391e4dec3b2a8df68f793f995303','15110738720@163.com','female','2019-07-09 15:58:50.169718',0,0,0,'upload/head_photo/timg.gif',0,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wish`
--

DROP TABLE IF EXISTS `wish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `wish` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `launched` int(11) NOT NULL,
  `date` datetime(6) NOT NULL,
  `bookid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `wish_bookid_54a7d3d1_fk_book_id` (`bookid`),
  KEY `wish_uid_8237e770_fk_User_id` (`uid`),
  CONSTRAINT `wish_bookid_54a7d3d1_fk_book_id` FOREIGN KEY (`bookid`) REFERENCES `book` (`id`),
  CONSTRAINT `wish_uid_8237e770_fk_User_id` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wish`
--

LOCK TABLES `wish` WRITE;
/*!40000 ALTER TABLE `wish` DISABLE KEYS */;
INSERT INTO `wish` VALUES (6,1,'2019-07-12 16:35:19.310241',44,9),(9,0,'2019-07-05 21:41:17.419398',63,9),(10,0,'2019-07-05 21:42:29.739737',71,9),(11,0,'2019-07-05 21:42:38.669392',72,9),(14,0,'2019-07-12 11:44:58.019088',49,8),(15,0,'2019-07-12 11:45:12.121216',51,8),(17,0,'2019-07-12 11:45:27.431655',53,8),(18,1,'2019-07-12 17:03:34.438675',46,8),(19,0,'2019-07-12 16:50:12.205383',62,8),(20,0,'2019-07-12 17:02:44.248524',83,9);
/*!40000 ALTER TABLE `wish` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-07-20 17:33:18
