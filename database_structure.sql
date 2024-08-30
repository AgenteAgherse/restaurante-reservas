CREATE DATABASE  IF NOT EXISTS `reservas_restaurante` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `reservas_restaurante`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: reservas_restaurante
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `hora` varchar(45) NOT NULL,
  `huso_horario` varchar(10) NOT NULL,
  `descripcion` text NOT NULL,
  `categoria` enum('entrada','salida','correo','reserva') NOT NULL,
  `empleado` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_logs_usuarios1_idx` (`empleado`),
  CONSTRAINT `fk_logs_usuarios1` FOREIGN KEY (`empleado`) REFERENCES `usuarios` (`identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mesas`
--

DROP TABLE IF EXISTS `mesas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mesas` (
  `idmesa` int NOT NULL AUTO_INCREMENT,
  `numero_mesa` int NOT NULL,
  `capacidad` int NOT NULL,
  `estado` enum('ocupada','disponible') NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `restaurante` int NOT NULL,
  PRIMARY KEY (`idmesa`),
  KEY `fk_mesas_restaurantes1_idx` (`restaurante`),
  CONSTRAINT `fk_mesas_restaurantes1` FOREIGN KEY (`restaurante`) REFERENCES `restaurantes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mesas`
--

LOCK TABLES `mesas` WRITE;
/*!40000 ALTER TABLE `mesas` DISABLE KEYS */;
/*!40000 ALTER TABLE `mesas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mesas_reserva`
--

DROP TABLE IF EXISTS `mesas_reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mesas_reserva` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reserva` int NOT NULL,
  `mesa` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_mesas_reserva_reservas1_idx` (`reserva`),
  KEY `fk_mesas_reserva_mesas1_idx` (`mesa`),
  CONSTRAINT `fk_mesas_reserva_mesas1` FOREIGN KEY (`mesa`) REFERENCES `mesas` (`idmesa`),
  CONSTRAINT `fk_mesas_reserva_reservas1` FOREIGN KEY (`reserva`) REFERENCES `reservas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mesas_reserva`
--

LOCK TABLES `mesas_reserva` WRITE;
/*!40000 ALTER TABLE `mesas_reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `mesas_reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificaciones`
--

DROP TABLE IF EXISTS `notificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` text NOT NULL,
  `descripcion` text NOT NULL,
  `logo` text NOT NULL,
  `restaurante` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notificaciones_restaurantes_idx` (`restaurante`),
  CONSTRAINT `fk_notificaciones_restaurantes` FOREIGN KEY (`restaurante`) REFERENCES `restaurantes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificaciones`
--

LOCK TABLES `notificaciones` WRITE;
/*!40000 ALTER TABLE `notificaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `notificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parametros_generales`
--

DROP TABLE IF EXISTS `parametros_generales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parametros_generales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `parametro` text NOT NULL,
  `valor` text,
  `categoria` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parametros_generales`
--

LOCK TABLES `parametros_generales` WRITE;
/*!40000 ALTER TABLE `parametros_generales` DISABLE KEYS */;
INSERT INTO `parametros_generales` VALUES (1,'Correo electrónico del restaurante',NULL,'Información Restaurante'),(2,'Contraseña segura de la cuenta de google',NULL,'Información Restaurante'),(3,'Enviar email faltando','3,6,9,12','Emails'),(4,'Definir tipo periodo de envío de email en ','horas, dias, semanas','Emails');
/*!40000 ALTER TABLE `parametros_generales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personas` (
  `identificacion` varchar(20) NOT NULL,
  `tipo_identificacion` varchar(10) NOT NULL,
  `nombre` text NOT NULL,
  `apellido` text NOT NULL,
  `email` text NOT NULL,
  `codigo_postal` varchar(20) NOT NULL,
  `direccion_residencia` text NOT NULL,
  PRIMARY KEY (`identificacion`),
  UNIQUE KEY `identificacion_UNIQUE` (`identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservas`
--

DROP TABLE IF EXISTS `reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dia` date NOT NULL,
  `hora` time NOT NULL,
  `huso_horario` varchar(10) NOT NULL,
  `precio` double(20,2) NOT NULL,
  `estado` enum('proximamente','en curso','finalizado') DEFAULT NULL,
  `restaurante` int NOT NULL,
  `cliente` varchar(20) NOT NULL,
  `empleado` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_reservas_restaurantes1_idx` (`restaurante`),
  KEY `fk_reservas_personas1_idx` (`cliente`),
  KEY `fk_reservas_usuarios1_idx` (`empleado`),
  CONSTRAINT `fk_reservas_personas1` FOREIGN KEY (`cliente`) REFERENCES `personas` (`identificacion`),
  CONSTRAINT `fk_reservas_restaurantes1` FOREIGN KEY (`restaurante`) REFERENCES `restaurantes` (`id`),
  CONSTRAINT `fk_reservas_usuarios1` FOREIGN KEY (`empleado`) REFERENCES `usuarios` (`identificacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservas`
--

LOCK TABLES `reservas` WRITE;
/*!40000 ALTER TABLE `reservas` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurantes`
--

DROP TABLE IF EXISTS `restaurantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurantes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` text NOT NULL,
  `contacto` varchar(45) NOT NULL,
  `ciudad` varchar(100) NOT NULL,
  `codigo_postal` varchar(10) NOT NULL,
  `direccion` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurantes`
--

LOCK TABLES `restaurantes` WRITE;
/*!40000 ALTER TABLE `restaurantes` DISABLE KEYS */;
/*!40000 ALTER TABLE `restaurantes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `restaurantes_AFTER_INSERT` AFTER INSERT ON `restaurantes` FOR EACH ROW BEGIN
	INSERT INTO vlr_p_generales(valor, id_p_general, restaurante) VALUES ('agus.hdez2011@gmail.com', 1, NEW.id);
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `identificacion` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(20) NOT NULL,
  `contrasenia` text NOT NULL,
  `estado` enum('activo','inactivo') NOT NULL,
  `restaurante` int NOT NULL,
  `persona` varchar(20) NOT NULL,
  PRIMARY KEY (`identificacion`),
  KEY `fk_usuarios_restaurantes1_idx` (`restaurante`),
  KEY `fk_usuarios_personas1_idx` (`persona`),
  CONSTRAINT `fk_usuarios_personas1` FOREIGN KEY (`persona`) REFERENCES `personas` (`identificacion`),
  CONSTRAINT `fk_usuarios_restaurantes1` FOREIGN KEY (`restaurante`) REFERENCES `restaurantes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vlr_p_generales`
--

DROP TABLE IF EXISTS `vlr_p_generales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vlr_p_generales` (
  `id` int NOT NULL AUTO_INCREMENT,
  `valor` varchar(45) NOT NULL,
  `id_p_general` int NOT NULL,
  `restaurante` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vlr_p_generales_parametros_generales1_idx` (`id_p_general`),
  KEY `fk_vlr_p_generales_restaurantes1_idx` (`restaurante`),
  CONSTRAINT `fk_vlr_p_generales_parametros_generales1` FOREIGN KEY (`id_p_general`) REFERENCES `parametros_generales` (`id`),
  CONSTRAINT `fk_vlr_p_generales_restaurantes1` FOREIGN KEY (`restaurante`) REFERENCES `restaurantes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vlr_p_generales`
--

LOCK TABLES `vlr_p_generales` WRITE;
/*!40000 ALTER TABLE `vlr_p_generales` DISABLE KEYS */;
/*!40000 ALTER TABLE `vlr_p_generales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'reservas_restaurante'
--

--
-- Dumping routines for database 'reservas_restaurante'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-30 15:00:54
