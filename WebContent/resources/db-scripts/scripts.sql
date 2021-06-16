-- MySQL dump 10.13  Distrib 5.1.33, for Win32 (ia32)
--
-- Host: localhost    Database: almox
-- ------------------------------------------------------
-- Server version	5.1.33-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `entrada_item`
--

DROP TABLE IF EXISTS `entrada_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrada_item` (
  `id_entrada` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `fornecedor` varchar(65) DEFAULT NULL,
  `contrato` varchar(20) DEFAULT NULL,
  `quantidade` int(5) DEFAULT NULL,
  `valor_total` double(9,2) DEFAULT NULL,
  `custo_unitario` double(6,2) DEFAULT NULL,
  `data_recebimento` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_entrada`),
  KEY `item_id` (`item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrada_item`
--

LOCK TABLES `entrada_item` WRITE;
/*!40000 ALTER TABLE `entrada_item` DISABLE KEYS */;
INSERT INTO `entrada_item` VALUES (1,1,'SPM','00-00-2021',13,100.00,7.69,'2021-05-10 13:39:29'),(2,1,'SPM','00-00-2021',5,50.00,10.00,'2021-05-10 13:43:07'),(3,1,'SPM','00-00-2021',5,50.00,10.00,'2021-05-10 13:43:57'),(7,3,'SPM','00-00-2021',5,100.00,20.00,'2021-05-10 15:16:06'),(6,2,'SPM','00-00-2021',13,100.00,7.69,'2021-05-10 13:51:28'),(8,3,'SPM','00-00-2021',5,100.00,20.00,'2021-05-10 15:16:55'),(9,4,'SPM','00-00-2021',13,100.00,7.69,'2021-05-10 15:17:19'),(10,3,'ABC','2021-00-02',5,70.00,14.00,'2021-05-12 13:50:20'),(11,5,'ABC','2021-00-02',13,100.00,7.69,'2021-05-13 12:21:32'),(12,6,'XPTO','2021-01-00',5,100.00,20.00,'2021-05-13 12:22:48'),(13,1,'XPTO','2021-00-02',1,10.00,10.00,'2021-05-13 13:41:17'),(14,1,'XPTO','2021-00-02',2,20.00,10.00,'2021-05-13 13:42:23'),(15,3,'XPTO','2021-00-02',2,20.00,10.00,'2021-05-13 13:43:09'),(16,7,'ABC','2021-00-03',5,77.00,15.40,'2021-05-13 14:10:26'),(17,9,'SERVIÇOS TORNEAMENTOS LTDA','2021-00-04',7,560.00,80.00,'2021-05-22 13:42:10'),(18,9,'SERVIÇOS TORNEAMENTOS LTDA','2021-00-03',1,70.00,70.00,'2021-05-22 13:43:25'),(19,7,'XPTO','00-00-2021',5,100.00,20.00,'2021-05-22 15:33:06'),(20,7,'XPTO','2021-00-02',5,100.00,20.00,'2021-06-03 09:59:23'),(21,7,'SPM','00-00-2021',2,20.00,10.00,'2021-06-15 13:41:48'),(22,3,'SPM','00-00-2021',2,18.00,9.00,'2021-06-15 13:42:40'),(23,1,'SPM','00-00-2021',1,10.00,10.00,'2021-06-16 10:45:18'),(24,1,'XPTO','2021-00-02',10,100.00,10.00,'2021-06-16 11:29:47');
/*!40000 ALTER TABLE `entrada_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TRG_EntradaItem_AI` AFTER INSERT ON `entrada_item` 
FOR EACH ROW 
BEGIN 
CALL SP_AtualizaEstoque (new.item_id, new.quantidade, new.valor_total, new.custo_unitario); 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `estoque`
--

DROP TABLE IF EXISTS `estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estoque` (
  `id_estoque` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `custo_unitario` double(6,2) DEFAULT NULL,
  `valor_total` double(9,2) DEFAULT NULL,
  PRIMARY KEY (`id_estoque`),
  KEY `item_id` (`item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque`
--

LOCK TABLES `estoque` WRITE;
/*!40000 ALTER TABLE `estoque` DISABLE KEYS */;
INSERT INTO `estoque` VALUES (1,1,22,10.00,219.97),(3,2,13,7.69,100.00),(4,3,10,14.07,140.67),(5,4,13,7.69,100.00),(6,5,11,7.69,84.62),(7,6,3,20.00,60.00),(8,7,10,18.41,184.09),(9,9,6,78.75,472.50);
/*!40000 ALTER TABLE `estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itens`
--

DROP TABLE IF EXISTS `itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itens` (
  `id_item` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `codigo_erp` varchar(10) NOT NULL,
  `part_number` varchar(65) DEFAULT NULL,
  `fabricante` varchar(65) DEFAULT NULL,
  `maquina` varchar(30) DEFAULT NULL,
  `dimensoes` varchar(65) DEFAULT NULL,
  `posicao_almox` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_item`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itens`
--

LOCK TABLES `itens` WRITE;
/*!40000 ALTER TABLE `itens` DISABLE KEYS */;
INSERT INTO `itens` VALUES (1,'CORREIA PLANA','TC0049','AS-004-BD-77-MM','NPI','DBCS','12x123x2345','21.B.08'),(2,'CORREIA REDONDA','TC0081','12-FF-03-XX','TESTE','OVIS','12x10x189','21.C.07'),(3,'ROLAMENTO Z6204','TR0040','XX-Z09-BG-34','WEG','Crisplant','','22.C.09'),(4,'PARAFUSO M10','M1100','AA-11-BB-CC','TESTE','Crossbelt','10mm','22.X.8'),(5,'PARAFUSO M20','M2109','PP-XXX-ABC-01','CASA DOS PARAFUSOS','Crisplant','20mm','21.B.08'),(6,'ROLAMENTO Z6305','TR0041','XX-Z05-AA-BB','WEG','Crossbelt','','21.C.07'),(7,'REBIMBOCA DA PARAFUSETA','M5469','123-ABC-456-XYZ','TESTE','OVIS','','21.B.09'),(9,'ROLDANA DE 7 POL','TM0789','XX-Z09-BG-34','NPI','DBCS','10 pol','22.C.09');
/*!40000 ALTER TABLE `itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saida_item`
--

DROP TABLE IF EXISTS `saida_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `saida_item` (
  `id_saida` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `solicitante` varchar(65) DEFAULT NULL,
  `quantidade` int(5) DEFAULT NULL,
  `finalidade` varchar(10) DEFAULT NULL,
  `valor_total` double(9,2) DEFAULT NULL,
  `custo_unitario` double(6,2) DEFAULT NULL,
  `observacao` text,
  `data_saida` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_saida`),
  KEY `item_id` (`item_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saida_item`
--

LOCK TABLES `saida_item` WRITE;
/*!40000 ALTER TABLE `saida_item` DISABLE KEYS */;
INSERT INTO `saida_item` VALUES (1,1,'TESTE',3,'os',23.07,7.69,'','2021-05-10 13:39:51'),(2,1,'TESTE',2,'transf',24.62,12.31,'','2021-05-10 13:41:37'),(3,1,'TESTE',8,'os',98.48,12.31,'','2021-05-10 13:42:40'),(4,1,'TESTE',1,'os',10.00,10.00,'OS 112233','2021-05-10 13:45:15'),(5,3,'TESTE',5,'transf',100.00,20.00,'','2021-05-10 15:16:29'),(6,3,'JOSÃ© TESTE',1,'manut',20.00,20.00,'TESTANDO SAÃ­DA DE MATERIAIS','2021-05-12 13:31:31'),(7,5,'MARIA RITA',1,'os',7.69,7.69,'OS 221133','2021-05-13 12:36:48'),(8,6,'MARIA RITA',1,'os',20.00,20.00,'OS 221133','2021-05-13 12:39:07'),(9,3,'RIBAMAR DE SOUZA',1,'os',16.67,16.67,'OS 221134','2021-05-13 12:41:25'),(10,6,'RIBAMAR DE SOUZA',1,'os',20.00,20.00,'OS 221135','2021-05-13 13:47:51'),(11,5,'JOÃ£O SILVA',1,'os',7.69,7.69,'OS 221136','2021-05-13 14:07:50'),(12,9,'ADERBAL',1,'os',78.75,78.75,'OS. 445566','2021-05-22 15:27:07'),(13,3,'ADERBAL',2,'os',30.66,15.33,'OS. 445566','2021-05-22 15:30:18'),(14,7,'ADERBAL',6,'manut',92.40,15.40,'','2021-05-22 15:31:43'),(15,9,'ADERBAL',1,'manut',78.75,78.75,'TROCA DE ROLAMENTO','2021-05-24 10:56:46'),(16,7,'ADERBAL',1,'Empr?stimo',20.51,20.51,'','2021-06-03 10:01:05'),(17,1,'ADERBAL',1,'Manutenção',10.00,10.00,'','2021-06-16 10:30:16');
/*!40000 ALTER TABLE `saida_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TRG_SaidaItem_AI` AFTER INSERT ON `saida_item` 
FOR EACH ROW 
BEGIN 
CALL SP_AtualizaEstoque (new.item_id, new.quantidade * -1, new.valor_total * -1, new.custo_unitario); 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(65) NOT NULL,
  `matricula` varchar(20) NOT NULL,
  `email` varchar(65) NOT NULL,
  `senha` varchar(32) NOT NULL,
  `perfil` varchar(20) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `matricula` (`matricula`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'RIBAMAR DE SOUZA','2323423','ribamar@email.com','202cb962ac59075b964b07152d234b70','admin',1),(2,'PEDRO TESTE','112233','pedro@email.teste','202cb962ac59075b964b07152d234b70','user',0),(3,'MARIA RITA','332211','maria.rita@email.teste','202cb962ac59075b964b07152d234b70','user',1),(4,'BÃ¡RBARA SILVA','443322','barbara@email.teste','202cb962ac59075b964b07152d234b70','user',0),(5,'JOÃ£O SILVA','221133','joao@silva.email','202cb962ac59075b964b07152d234b70','user',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios_java`
--

DROP TABLE IF EXISTS `usuarios_java`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios_java` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(65) NOT NULL,
  `matricula` varchar(20) DEFAULT NULL,
  `email` varchar(65) NOT NULL,
  `senha` varchar(255) DEFAULT NULL,
  `perfil` varchar(20) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `matricula` (`matricula`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios_java`
--

LOCK TABLES `usuarios_java` WRITE;
/*!40000 ALTER TABLE `usuarios_java` DISABLE KEYS */;
INSERT INTO `usuarios_java` VALUES (3,'RIBAMAR DE SOUZA','2323423','ribamar@email.com','ICy5YqxZB1uWSwcVLSNLcA','admin',1),(5,'MARIA RITA','443322','maria.rita@email.teste','kAFQmDzST7DWlj99KOF/cg','admin',1),(4,'PEDRO TESTE','332211','pedro@email.teste','ICy5YqxZB1uWSwcVLSNLcA','user',0),(8,'JOÃO SILVA','112233','joao@silva.email','ICy5YqxZB1uWSwcVLSNLcA','user',0),(7,'BÁRBARA SILVA','221133','barbara@email.teste','ICy5YqxZB1uWSwcVLSNLcA','user',1);
/*!40000 ALTER TABLE `usuarios_java` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-16 13:08:49
