-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        10.6.3-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- galleryboard 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `galleryboard` /*!40100 DEFAULT CHARACTER SET utf8mb3 */;
USE `galleryboard`;

-- 테이블 galleryboard.spring_session 구조 내보내기
CREATE TABLE IF NOT EXISTS `spring_session` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint(20) NOT NULL,
  `LAST_ACCESS_TIME` bigint(20) NOT NULL,
  `MAX_INACTIVE_INTERVAL` int(11) NOT NULL,
  `EXPIRY_TIME` bigint(20) NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 galleryboard.spring_session:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `spring_session` DISABLE KEYS */;
INSERT INTO `spring_session` (`PRIMARY_ID`, `SESSION_ID`, `CREATION_TIME`, `LAST_ACCESS_TIME`, `MAX_INACTIVE_INTERVAL`, `EXPIRY_TIME`, `PRINCIPAL_NAME`) VALUES
	('aaf24aec-b7f5-4e19-9c17-fee3e50d9e63', 'cea6b82b-f3ac-4c8e-9c4d-b41d0abedc3f', 1638836344354, 1638844850399, 7200, 1638852050399, 'user');
/*!40000 ALTER TABLE `spring_session` ENABLE KEYS */;

-- 테이블 galleryboard.spring_session_attributes 구조 내보내기
CREATE TABLE IF NOT EXISTS `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- 테이블 데이터 galleryboard.spring_session_attributes:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `spring_session_attributes` DISABLE KEYS */;
INSERT INTO `spring_session_attributes` (`SESSION_PRIMARY_ID`, `ATTRIBUTE_NAME`, `ATTRIBUTE_BYTES`) VALUES
	('aaf24aec-b7f5-4e19-9c17-fee3e50d9e63', 'SPRING_SECURITY_CONTEXT', _binary 0xaced00057372003d6f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e636f6e746578742e5365637572697479436f6e74657874496d706c00000000000002300200014c000e61757468656e7469636174696f6e7400324c6f72672f737072696e676672616d65776f726b2f73656375726974792f636f72652f41757468656e7469636174696f6e3b78707372004f6f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e557365726e616d6550617373776f726441757468656e7469636174696f6e546f6b656e00000000000002300200024c000b63726564656e7469616c737400124c6a6176612f6c616e672f4f626a6563743b4c00097072696e636970616c71007e0004787200476f72672e737072696e676672616d65776f726b2e73656375726974792e61757468656e7469636174696f6e2e416273747261637441757468656e7469636174696f6e546f6b656ed3aa287e6e47640e0200035a000d61757468656e746963617465644c000b617574686f7269746965737400164c6a6176612f7574696c2f436f6c6c656374696f6e3b4c000764657461696c7371007e0004787001737200266a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c654c697374fc0f2531b5ec8e100200014c00046c6973747400104c6a6176612f7574696c2f4c6973743b7872002c6a6176612e7574696c2e436f6c6c656374696f6e7324556e6d6f6469666961626c65436f6c6c656374696f6e19420080cb5ef71e0200014c00016371007e00067870737200136a6176612e7574696c2e41727261794c6973747881d21d99c7619d03000149000473697a65787000000001770400000001737200426f72672e737072696e676672616d65776f726b2e73656375726974792e636f72652e617574686f726974792e53696d706c654772616e746564417574686f7269747900000000000002300200014c0004726f6c657400124c6a6176612f6c616e672f537472696e673b7870740009524f4c455f555345527871007e000d737200486f72672e737072696e676672616d65776f726b2e73656375726974792e7765622e61757468656e7469636174696f6e2e57656241757468656e7469636174696f6e44657461696c7300000000000002300200024c000d72656d6f74654164647265737371007e000f4c000973657373696f6e496471007e000f787074000f303a303a303a303a303a303a303a3174002435363138353831662d356638342d343461392d623235642d303665363534653662363963707372001c636f6d2e67616c6c657279626f6172642e646f6d61696e2e55736572000000000000000102000a5a001369734163636f756e744e6f6e457870697265645a001269734163636f756e744e6f6e4c6f636b65645a0017697343726564656e7469616c734e6f6e457870697265645a00096973456e61626c65644c00046175746871007e000f4c000b617574686f72697469657371007e00064c00046e616d6571007e000f4c000870617373776f726471007e000f4c000c7265676973746572446174657400154c6a6176612f74696d652f4c6f63616c446174653b4c0008757365726e616d6571007e000f787001010101707371007e000c0000000177040000000171007e001078740009ec9db4eca784ec889874003c24326124313024365a4f336462786c4e334c59684f517071583741484f58787a353848506652486645724c436455594b45587139654b51644d574b537372000d6a6176612e74696d652e536572955d84ba1b2248b20c00007870770703000007e50c027874000475736572);
/*!40000 ALTER TABLE `spring_session_attributes` ENABLE KEYS */;

-- 테이블 galleryboard.tb_attach 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_attach` (
  `idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '파일번호(PK)',
  `board_idx` int(11) NOT NULL COMMENT '속한 게시글번호',
  `original_name` varchar(250) NOT NULL COMMENT '원본 파일명',
  `save_name` varchar(50) NOT NULL COMMENT '저장 파일명',
  `size` int(11) NOT NULL COMMENT '사이즈',
  `delete_yn` enum('Y','N') DEFAULT 'N' COMMENT '삭제여부',
  `insert_time` datetime DEFAULT current_timestamp() COMMENT '등록일',
  `delete_time` datetime DEFAULT NULL COMMENT '삭제일',
  PRIMARY KEY (`idx`),
  KEY `board_idx` (`board_idx`),
  CONSTRAINT `tb_attach_ibfk_1` FOREIGN KEY (`board_idx`) REFERENCES `tb_board` (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 galleryboard.tb_attach:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_attach` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_attach` ENABLE KEYS */;

-- 테이블 galleryboard.tb_auth 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_auth` (
  `id` varchar(20) NOT NULL,
  `auth` varchar(200) NOT NULL,
  PRIMARY KEY (`id`,`auth`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 galleryboard.tb_auth:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_auth` DISABLE KEYS */;
INSERT INTO `tb_auth` (`id`, `auth`) VALUES
	('user', 'ROLE_USER');
/*!40000 ALTER TABLE `tb_auth` ENABLE KEYS */;

-- 테이블 galleryboard.tb_board 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_board` (
  `idx` int(11) NOT NULL AUTO_INCREMENT COMMENT '번호(PK)',
  `title` varchar(100) DEFAULT NULL COMMENT '제목',
  `content` varchar(3000) DEFAULT NULL COMMENT '내용',
  `writer` varchar(20) NOT NULL COMMENT '작성자',
  `view_cnt` int(11) DEFAULT 0 COMMENT '조회수',
  `delete_yn` enum('Y','N') DEFAULT 'N' COMMENT '삭제여부',
  `insert_time` datetime DEFAULT current_timestamp() COMMENT '등록일',
  `update_time` datetime DEFAULT NULL COMMENT '수정일',
  `delete_time` datetime DEFAULT NULL COMMENT '삭제일',
  `title_img` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idx`),
  KEY `writer` (`writer`),
  CONSTRAINT `tb_board_ibfk_1` FOREIGN KEY (`writer`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 galleryboard.tb_board:~1 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_board` DISABLE KEYS */;
INSERT INTO `tb_board` (`idx`, `title`, `content`, `writer`, `view_cnt`, `delete_yn`, `insert_time`, `update_time`, `delete_time`, `title_img`) VALUES
	(1, 'weqwe', 'qweqwe', 'user', 0, 'N', '2021-12-06 10:56:41', NULL, NULL, NULL);
/*!40000 ALTER TABLE `tb_board` ENABLE KEYS */;

-- 테이블 galleryboard.tb_comment 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_comment` (
  `idx` int(11) NOT NULL AUTO_INCREMENT,
  `board_idx` int(11) NOT NULL,
  `content` varchar(3000) DEFAULT NULL,
  `writer` varchar(20) NOT NULL,
  `ref` int(10) NOT NULL DEFAULT 1,
  `step` int(10) NOT NULL DEFAULT 1,
  `level` int(10) NOT NULL DEFAULT 1,
  `delete_yn` enum('Y','N') NOT NULL DEFAULT 'N',
  `insert_time` datetime DEFAULT current_timestamp(),
  `update_time` datetime DEFAULT NULL,
  `delete_time` datetime DEFAULT NULL,
  PRIMARY KEY (`idx`),
  KEY `board_idx` (`board_idx`),
  CONSTRAINT `tb_comment_ibfk_1` FOREIGN KEY (`board_idx`) REFERENCES `tb_board` (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 galleryboard.tb_comment:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_comment` DISABLE KEYS */;
INSERT INTO `tb_comment` (`idx`, `board_idx`, `content`, `writer`, `ref`, `step`, `level`, `delete_yn`, `insert_time`, `update_time`, `delete_time`) VALUES
	(10, 1, '수정하는거입니다.', 'user', 1, 0, 0, 'N', '2021-12-07 09:53:37', '2021-12-07 11:40:37', NULL),
	(11, 1, '1451345', 'user', 2, 0, 0, 'Y', '2021-12-07 09:53:58', NULL, NULL),
	(12, 1, '등록입니다.', 'user', 3, 0, 0, 'N', '2021-12-07 11:40:49', NULL, NULL);
/*!40000 ALTER TABLE `tb_comment` ENABLE KEYS */;

-- 테이블 galleryboard.tb_user 구조 내보내기
CREATE TABLE IF NOT EXISTS `tb_user` (
  `id` varchar(20) NOT NULL COMMENT '아이디',
  `password` varchar(200) DEFAULT NULL COMMENT '비밀번호',
  `name` varchar(20) DEFAULT NULL COMMENT '이름',
  `register_date` date DEFAULT current_timestamp() COMMENT '가입일',
  `isAccountNonExpired` tinyint(4) DEFAULT NULL COMMENT '계정 만료여부',
  `isAccountNonLocked` tinyint(4) DEFAULT NULL COMMENT '패스워드 만료여부',
  `isCredentialsNonExpired` tinyint(4) DEFAULT NULL COMMENT '계정 잠김여부',
  `isEnabled` tinyint(4) DEFAULT NULL COMMENT '계정 유효여부',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 테이블 데이터 galleryboard.tb_user:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `tb_user` DISABLE KEYS */;
INSERT INTO `tb_user` (`id`, `password`, `name`, `register_date`, `isAccountNonExpired`, `isAccountNonLocked`, `isCredentialsNonExpired`, `isEnabled`) VALUES
	('user', '$2a$10$6ZO3dbxlN3LYhOQpqX7AHOXxz58HPfRHfErLCdUYKEXq9eKQdMWKS', '이진수', '2021-12-02', 1, 1, 1, 1);
/*!40000 ALTER TABLE `tb_user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
