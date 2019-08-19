-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: localhost    Database: xforum
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
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('ccc2cd17ffa6');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bbs_category`
--

DROP TABLE IF EXISTS `bbs_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bbs_category` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `classname` varchar(60) NOT NULL,
  `parentid` int(11) NOT NULL,
  `replycount` int(11) NOT NULL,
  `motifcount` int(11) NOT NULL,
  `compere` varchar(10) DEFAULT NULL,
  `classpic` varchar(255) NOT NULL,
  `description` text,
  `orderby` smallint(6) NOT NULL,
  `lastpost` varchar(255) DEFAULT NULL,
  `namestyle` varchar(10) DEFAULT NULL,
  `ispass` smallint(6) NOT NULL,
  `classpath` int(11) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bbs_category`
--

LOCK TABLES `bbs_category` WRITE;
/*!40000 ALTER TABLE `bbs_category` DISABLE KEYS */;
INSERT INTO `bbs_category` VALUES (1,'PHP技术交流',0,2,3,NULL,'1',NULL,1,NULL,NULL,1,0),(2,'程序人生',0,4,6,NULL,'1',NULL,1,NULL,NULL,1,0),(3,'求婚头条',0,4,8,NULL,'1','',1,NULL,NULL,1,0),(7,'内核源码',1,6,63,NULL,'3','',2,NULL,NULL,1,1),(8,'PHP框架',1,4,3,NULL,'3',NULL,2,NULL,NULL,1,1),(9,'开源产品',1,3,2,NULL,'3',NULL,2,NULL,NULL,1,1),(10,'进阶讨论',1,2,3,NULL,'3',NULL,3,NULL,NULL,1,1),(11,'求职招聘',1,3,4,NULL,'4',NULL,3,NULL,NULL,1,2),(12,'经验分享',1,3,4,NULL,'4',NULL,3,NULL,NULL,1,2),(13,'名人故事',1,3,3,NULL,'3',NULL,3,NULL,NULL,1,2),(14,'大同的姑娘贼好看',1,3,2,NULL,'2',NULL,2,NULL,NULL,1,3),(15,'大同的后生贼帅气',1,3,2,NULL,'2',NULL,2,NULL,NULL,1,3),(16,'吕梁的马志伟贼六',1,3,2,NULL,'2',NULL,2,NULL,NULL,1,3),(17,'吉林小伙真帅',1,3,2,NULL,'2',NULL,2,NULL,NULL,1,3);
/*!40000 ALTER TABLE `bbs_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bbs_closeip`
--

DROP TABLE IF EXISTS `bbs_closeip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bbs_closeip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ip` int(11) NOT NULL,
  `addtime` int(11) NOT NULL,
  `overtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bbs_closeip`
--

LOCK TABLES `bbs_closeip` WRITE;
/*!40000 ALTER TABLE `bbs_closeip` DISABLE KEYS */;
/*!40000 ALTER TABLE `bbs_closeip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bbs_details`
--

DROP TABLE IF EXISTS `bbs_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bbs_details` (
  `first` smallint(6) NOT NULL,
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `authorid` int(11) DEFAULT NULL,
  `title` varchar(600) NOT NULL,
  `content` text NOT NULL,
  `addtime` datetime DEFAULT NULL,
  `classid` int(11) DEFAULT NULL,
  `hits` int(11) DEFAULT NULL,
  `rate` smallint(6) NOT NULL,
  `replycount` int(11) DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bbs_details`
--

LOCK TABLES `bbs_details` WRITE;
/*!40000 ALTER TABLE `bbs_details` DISABLE KEYS */;
INSERT INTO `bbs_details` VALUES (1,2,2,'蜀道难\r\n\r\n唐代：李白','噫吁嚱，危乎高哉！\r\n蜀道之难，难于上青天！\r\n蚕丛及鱼凫，开国何茫然！\r\n尔来四万八千岁，不与秦塞通人烟。\r\n西当太白有鸟道，可以横绝峨眉巅。\r\n地崩山摧壮士死，然后天梯石栈相钩连。\r\n上有六龙回日之高标，下有冲波逆折之回川。\r\n黄鹤之飞尚不得过，猿猱欲度愁攀援。(攀援 一作：攀缘)\r\n青泥何盘盘，百步九折萦岩峦。\r\n扪参历井仰胁息，以手抚膺坐长叹。\r\n问君西游何时还？畏途巉岩不可攀。\r\n但见悲鸟号古木，雄飞雌从绕林间。\r\n又闻子规啼夜月，愁空山。\r\n蜀道之难,难于上青天，使人听此凋朱颜！\r\n连峰去天不盈尺，枯松倒挂倚绝壁。\r\n飞湍瀑流争喧豗，砯崖转石万壑雷。\r\n其险也如此，嗟尔远道之人胡为乎来哉！(也如此 一作：也若此)\r\n剑阁峥嵘而崔嵬，一夫当关，万夫莫开。\r\n所守或匪亲，化为狼与豺。\r\n朝避猛虎，夕避长蛇；磨牙吮血，杀人如麻。\r\n锦城虽云乐，不如早还家。\r\n蜀道之难,难于上青天，侧身西望长咨嗟！\r\n','2019-06-17 09:58:43',8,11,0,NULL),(1,3,3,'观刈麦\r\n\r\n唐代：白居易','田家少闲月，五月人倍忙。\r\n夜来南风起，小麦覆陇黄。\r\n妇姑荷箪食，童稚携壶浆，\r\n相随饷田去，丁壮在南冈。\r\n足蒸暑土气，背灼炎天光，\r\n力尽不知热，但惜夏日长。\r\n复有贫妇人，抱子在其旁，\r\n右手秉遗穗，左臂悬敝筐。\r\n听其相顾言，闻者为悲伤。\r\n家田输税尽，拾此充饥肠。\r\n今我何功德？曾不事农桑。\r\n吏禄三百石，岁晏有余粮，\r\n念此私自愧，尽日不能忘。','2019-06-17 09:58:45',9,8,0,NULL),(1,4,1,'水调歌头·明月几时有\r\n\r\n宋代：苏轼','丙辰中秋，欢饮达旦，大醉，作此篇，兼怀子由。\r\n\r\n明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间？(何似 一作：何时；又恐 一作：惟 / 唯恐)\r\n转朱阁，低绮户，照无眠。不应有恨，何事长向别时圆？人有悲欢离合，月有阴晴圆缺，此事古难全。但愿人长久，千里共婵娟。(长向 一作：偏向)\r\n\r\n','2019-06-17 09:58:46',7,35,2,2),(1,5,2,'茅屋为秋风所破歌\r\n\r\n唐代：杜甫','八月秋高风怒号，卷我屋上三重茅。茅飞渡江洒江郊，高者挂罥长林梢，下者飘转沉塘坳。\r\n南村群童欺我老无力，忍能对面为盗贼。公然抱茅入竹去，唇焦口燥呼不得，归来倚杖自叹息。\r\n俄顷风定云墨色，秋天漠漠向昏黑。布衾多年冷似铁，娇儿恶卧踏里裂。床头屋漏无干处，雨脚如麻未断绝。自经丧乱少睡眠，长夜沾湿何由彻?\r\n安得广厦千万间，大庇天下寒士俱欢颜，风雨不动安如山。呜呼！何时眼前突兀见此屋，吾庐独破受冻死亦足！','2019-06-17 09:58:50',7,25,0,NULL),(0,6,3,'库斯库斯开始看','法蒙娜丽莎的你们谁发的呢','2019-06-17 09:58:52',1,1,0,NULL),(0,7,1,'立刻就是发动机今儿我就','了开发商的考虑范围看记录付完款','2019-06-17 09:58:53',1,1,0,NULL),(1,8,2,'发发发反反复复','滚滚滚滚滚滚滚滚滚','2019-06-18 20:33:40',8,4,2,2),(1,9,3,'呃呃呃鹅鹅鹅鹅鹅鹅饿','呃呃呃呃呃呃呃呃呃','2019-06-18 20:34:13',8,5,2,2),(1,10,3,'呜呜呜呜呜呜呜呜无无无无','呜呜呜呜呜呜呜呜无无无无','2019-06-19 08:57:53',7,24,2,2),(1,11,3,'马志伟  想要个娃','马志伟  想要个娃\r\n马志伟  想要个娃\r\n马志伟  想要个娃\r\n马志伟  想要个娃\r\n马志伟  想要个娃\r\n马志伟  想要个娃','2019-06-19 08:59:24',7,18,3,3),(0,12,3,'','近段时间就是打开加拉斯科技阿萨德考虑萨卡拉是','2019-06-19 16:48:16',1,1,0,0),(0,14,4,'','到货时间的时间','2019-06-19 21:26:17',4,0,0,0),(0,15,4,'','我的速度所','2019-06-19 21:26:23',4,0,0,0),(0,17,3,'','家电家具下定决心佛幸福','2019-06-20 17:50:14',1,0,0,0),(0,18,3,'','洗洗洗洗洗洗洗洗洗洗洗洗洗洗洗洗洗iiiiiiiii','2019-06-20 17:50:31',1,0,0,0),(0,19,3,'','1','2019-06-20 20:24:49',11,0,0,0),(1,20,3,'记得记得静静地记得记得记得','几点几点几点几点见','2019-06-20 21:36:50',7,15,2,3);
/*!40000 ALTER TABLE `bbs_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bbs_link`
--

DROP TABLE IF EXISTS `bbs_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bbs_link` (
  `lid` smallint(6) NOT NULL AUTO_INCREMENT,
  `displayorder` smallint(6) NOT NULL,
  `name` varchar(20) NOT NULL,
  `url` varchar(255) NOT NULL,
  `description` text,
  `logo` varchar(255) DEFAULT NULL,
  `addtime` int(11) NOT NULL,
  PRIMARY KEY (`lid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bbs_link`
--

LOCK TABLES `bbs_link` WRITE;
/*!40000 ALTER TABLE `bbs_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `bbs_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bbs_order`
--

DROP TABLE IF EXISTS `bbs_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bbs_order` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  `addtime` int(11) NOT NULL,
  `ispay` smallint(6) NOT NULL,
  PRIMARY KEY (`oid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bbs_order`
--

LOCK TABLES `bbs_order` WRITE;
/*!40000 ALTER TABLE `bbs_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `bbs_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bbs_user`
--

DROP TABLE IF EXISTS `bbs_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bbs_user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(16) NOT NULL,
  `password` varchar(32) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `udertype` smallint(6) DEFAULT NULL,
  `regtime` int(11) DEFAULT NULL,
  `lasttime` int(11) DEFAULT NULL,
  `regip` int(11) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `grade` int(11) DEFAULT NULL,
  `problem` varchar(200) DEFAULT NULL,
  `result` varchar(200) DEFAULT NULL,
  `realname` varchar(50) DEFAULT NULL,
  `sex` smallint(6) DEFAULT NULL,
  `birthday` varchar(20) DEFAULT NULL,
  `place` varchar(50) DEFAULT NULL,
  `qq` varchar(13) DEFAULT NULL,
  `autograph` varchar(500) DEFAULT NULL,
  `allowlogin` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bbs_user`
--

LOCK TABLES `bbs_user` WRITE;
/*!40000 ALTER TABLE `bbs_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `bbs_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(15) NOT NULL,
  `password` varchar(200) NOT NULL,
  `udertype` smallint(6) DEFAULT NULL,
  `grade` int(11) DEFAULT NULL,
  `picture` varchar(1000) DEFAULT NULL,
  `regtime` datetime DEFAULT NULL,
  `phone` char(11) NOT NULL,
  `problem` varchar(200) DEFAULT NULL,
  `result` varchar(200) DEFAULT NULL,
  `place` varchar(50) DEFAULT NULL,
  `qq` varchar(13) DEFAULT NULL,
  `sex` smallint(6) DEFAULT NULL,
  `autograph` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `problem` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'马志伟','pbkdf2:sha256:150000$9ycS8PZY$a5aac7c715f06a33363cfb9ef4934013d45c033300e488b7cf470fbdd3ddc0ca',0,50,'index/images/xixi.jpg','2019-06-16 11:31:12','15110738723',NULL,NULL,NULL,NULL,NULL,NULL),(2,'嘻嘻','pbkdf2:sha256:150000$AHN9jyGH$55fd863005d647e39ab8b6bbb8aa60a7bc452e630d5d5f2fd5a18730ae86fdeb',1,0,'index/images/xixi.jpg','2019-06-17 11:41:16','12345678911',NULL,NULL,NULL,NULL,NULL,NULL),(3,'刘悄悄','pbkdf2:sha256:150000$kBEsHnSh$187c39a9850f747b4057478535ef44e4a69eadcc2e13ed3cd54ceac0143945cd',1,0,'upload/timg.gif','2019-06-17 11:44:26','','保持原有的安全提问和答案','','天津市','55555555555',2,'签名'),(21,'www','pbkdf2:sha256:150000$9xcPcmn7$6d9d9ae61110444736c7f6b8ad720b1cc22e611d96ed4245b6e44ff3db4d4552',1,0,'upload/46f0fdfaaf51f3deb67c2b2c9aeef01f38297996.jpg','2019-06-22 13:42:12','51615615665',NULL,NULL,NULL,NULL,1,NULL),(22,'sss','pbkdf2:sha256:150000$63gYGK9D$6e035bd586a748a6a31b52aa63de29261f31e97f979e1b97246310585f038178',1,0,'index/images/xixi.jpg','2019-06-22 13:44:31','15546156661',NULL,NULL,NULL,NULL,1,NULL),(23,'rrr','pbkdf2:sha256:150000$6OEJoHMv$d94ec47192f8b8aeef4d98e52ad7443a0118c0595db4ff3b06a9eaa9b0bd458a',1,0,'index/images/timg.gif','2019-06-22 13:46:53','554121512',NULL,NULL,NULL,NULL,1,NULL),(24,'aas','pbkdf2:sha256:150000$1nNJL9yH$273f736e26c9d9dadb4ba27f28fa6f7cf1b3c2a7d884e93f208af410a7a6fe95',1,0,'index/images/timg.gif','2019-06-22 13:49:08','12151513',NULL,NULL,NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-07-30 22:12:04
