-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 20-Jun-2023 às 12:31
-- Versão do servidor: 8.0.31
-- versão do PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `academia`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `alunos`
--

DROP TABLE IF EXISTS `alunos`;
CREATE TABLE IF NOT EXISTS `alunos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `data_nasc` varchar(15) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `num` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `alunos`
--

INSERT INTO `alunos` (`id`, `nome`, `data_nasc`, `email`, `num`) VALUES
(1, 'marta', '27/10/2001', 'reidelas@gmail.com', '4002-8922'),
(3, 'Luis', '10/01/2001', 'luis@teste.com', '(86)  40028922'),
(5, 'Nome', '23/12/2011', 'meta@teste', '32312-2312'),
(11, 'gustavo', '25/10/2001', 'teste@testecom', '40028922'),
(12, 'rildo', '25/10/2001', 'teste123@testecom', '40028922'),
(13, 'genils', '24/10/2001', 'genils@testecom', '53232423423'),
(14, 'gusta', '21/10/2001', 'salva@testecom', '21412412124'),
(15, 'cristiano', '20/01/2000', 'cristia123@teste.com', '40028922'),
(16, 'cristianinho', '20/01/2000', 'cristianinho@teste.com', '32222121'),
(17, 'Marcos Vinicius', '25/10/2001', 'teste@teste.com', '(86) 99599-9999'),
(18, 'Genielson Silva', '25/10/2000', 'teste@gmail.com', '4002-8922'),
(19, 'Martinha', '20/01/2015', 'marta@teste.com', '3222-2121'),
(20, 'Gustavo', '21/11/2003', 'gustxvogomxs@gmail.com', '86999999999'),
(21, 'Mestre de Obras', '03/02/1999', 'asdsad@gmail.com', '325432324234'),
(22, 'maquina', '10/02/1998', 'aluno@teste.com', '86 95943-3421');

-- --------------------------------------------------------

--
-- Estrutura da tabela `aulas`
--

DROP TABLE IF EXISTS `aulas`;
CREATE TABLE IF NOT EXISTS `aulas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) DEFAULT NULL,
  `instrutor` varchar(15) DEFAULT NULL,
  `horario` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `aulas`
--

INSERT INTO `aulas` (`id`, `nome`, `instrutor`, `horario`) VALUES
(1, 'zumba', 'marcus', '10-11 hrs'),
(4, 'funcional', 'Genielson', '09-10 hrs'),
(3, 'dança', 'alex', '08-09 hrs'),
(5, 'Calistenia', 'fabiana', '10-12 hrs');

-- --------------------------------------------------------

--
-- Estrutura da tabela `frequencia`
--

DROP TABLE IF EXISTS `frequencia`;
CREATE TABLE IF NOT EXISTS `frequencia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idaluno` int DEFAULT NULL,
  `datafreq` varchar(15) DEFAULT NULL,
  `presenca` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idaluno` (`idaluno`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `frequencia`
--

INSERT INTO `frequencia` (`id`, `idaluno`, `datafreq`, `presenca`) VALUES
(1, 1, '25102023', 's'),
(2, 20, '19/06/2023', 's'),
(3, 17, '14-06-2023', 's'),
(4, 18, '14-06-2023', 's'),
(5, 21, '14/06/2023', 's'),
(6, 19, '14/06/2023', 'n');

-- --------------------------------------------------------

--
-- Estrutura da tabela `planos`
--

DROP TABLE IF EXISTS `planos`;
CREATE TABLE IF NOT EXISTS `planos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `descricao` varchar(30) DEFAULT NULL,
  `preco` float(4,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `planos`
--

INSERT INTO `planos` (`id`, `nome`, `descricao`, `preco`) VALUES
(1, 'hipertrofia', 'onde_o_musculo_cresce', 60.00);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
