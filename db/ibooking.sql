/*
 Navicat Premium Data Transfer

 Source Server         : ibooking
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : 10.177.21.118:3308
 Source Schema         : ibooking

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 04/06/2024 20:56:59
*/

create database if not exists `ibooking`;
use `ibooking`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` (`name`, `value`, `type`) VALUES ('user', 'el-icon-user', 'icon');
INSERT INTO `sys_dict` (`name`, `value`, `type`) VALUES ('house', 'el-icon-house', 'icon');
INSERT INTO `sys_dict` (`name`, `value`, `type`) VALUES ('menu', 'el-icon-menu', 'icon');
INSERT INTO `sys_dict` (`name`, `value`, `type`) VALUES ('s-custom', 'el-icon-s-custom', 'icon');
INSERT INTO `sys_dict` (`name`, `value`, `type`) VALUES ('s-grid', 'el-icon-s-grid', 'icon');
INSERT INTO `sys_dict` (`name`, `value`, `type`) VALUES ('document', 'el-icon-document', 'icon');
INSERT INTO `sys_dict` (`name`, `value`, `type`) VALUES ('coffee', 'el-icon-coffee\r\n', 'icon');
INSERT INTO `sys_dict` (`name`, `value`, `type`) VALUES ('s-marketing', 'el-icon-s-marketing', 'icon');
COMMIT;

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `size` bigint DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `md5` varchar(255) NOT NULL,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `enable` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
BEGIN;
INSERT INTO `sys_file` (`id`, `name`, `type`, `size`, `url`, `md5`, `is_delete`, `enable`) VALUES (27, 'avatar1.jpg', 'jpg', 104, 'http://10.177.21.118:8090/file/32cf0764916d4d339135546610a918cd.jpg', '6e8f2c0892e1b92f28d965e47718442d', 0, 1);
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `description` text,
  `pid` int DEFAULT NULL,
  `page_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` (`id`, `name`, `path`, `icon`, `description`, `pid`, `page_path`) VALUES (1, '主页', '/home', 'el-icon-house', '', NULL, 'Home');
INSERT INTO `sys_menu` (`id`, `name`, `path`, `icon`, `description`, `pid`, `page_path`) VALUES (2, '系统管理', '', 'el-icon-s-grid', '', NULL, NULL);
INSERT INTO `sys_menu` (`id`, `name`, `path`, `icon`, `description`, `pid`, `page_path`) VALUES (3, '用户管理', '/user', 'el-icon-user', NULL, 2, 'User');
INSERT INTO `sys_menu` (`id`, `name`, `path`, `icon`, `description`, `pid`, `page_path`) VALUES (4, '角色管理', '/role', 'el-icon-s-custom', NULL, 2, 'Role');
INSERT INTO `sys_menu` (`id`, `name`, `path`, `icon`, `description`, `pid`, `page_path`) VALUES (5, '教室管理', '/room', 'el-icon-house', NULL, 2, 'Room');
INSERT INTO `sys_menu` (`id`, `name`, `path`, `icon`, `description`, `pid`, `page_path`) VALUES (6, '菜单管理', '/menu', 'el-icon-menu', NULL, 2, 'Menu');
INSERT INTO `sys_menu` (`id`, `name`, `path`, `icon`, `description`, `pid`, `page_path`) VALUES (7, '我的预约', '/MyReserve', 'el-icon-house', NULL, NULL, 'MyReserve');
INSERT INTO `sys_menu` (`id`, `name`, `path`, `icon`, `description`, `pid`, `page_path`) VALUES (8, '座位预定', '/NewReserve', 'el-icon-house', NULL, NULL, 'NewReserve');
INSERT INTO `sys_menu` (`id`, `name`, `path`, `icon`, `description`, `pid`, `page_path`) VALUES (9, '文件管理', '/file', 'el-icon-house', NULL, 2, 'File');
INSERT INTO `sys_menu` (`id`, `name`, `path`, `icon`, `description`, `pid`, `page_path`) VALUES (10, '聊天室', '/chat', 'el-icon-house', NULL, NULL, 'Chat');
COMMIT;

-- ----------------------------
-- Table structure for sys_reserve
-- ----------------------------
DROP TABLE IF EXISTS `sys_reserve`;
CREATE TABLE `sys_reserve` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `room_id` int NOT NULL,
  `sit_id` int NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `reserved_time` datetime DEFAULT NULL,
  `break_contract` tinyint(1) NOT NULL DEFAULT '0',
  `check_in_time` tinyint(1) NOT NULL DEFAULT '0',
  `cancle` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_reserve
-- ----------------------------
BEGIN;
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (42, 'xwc', 19, 16, '2023-05-26 07:00:00', '2023-05-26 11:00:00', '2023-05-25 17:10:37', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (43, 'xwc', 20, 41, '2023-05-25 19:00:00', '2023-05-25 22:00:00', '2023-05-25 17:10:54', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (44, 'xwc', 20, 41, '2023-06-18 16:00:00', '2023-06-18 17:00:00', '2023-06-18 07:21:47', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (45, 'xwc', 19, 16, '2023-06-18 16:00:00', '2023-06-18 17:00:00', '2023-06-18 07:22:09', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (46, 'xwc', 19, 21, '2023-06-18 18:00:00', '2023-06-18 20:00:00', '2023-06-18 07:23:11', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (47, 'xwc', 19, 21, '2023-06-21 16:00:00', '2023-06-21 19:00:00', '2023-06-18 07:23:49', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (48, 'xwc', 22, 90, '2023-06-19 08:00:00', '2023-06-19 09:00:00', '2023-06-18 07:24:37', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (49, 'xwc', 19, 16, '2023-06-18 15:30:00', '2023-06-18 17:00:00', '2023-06-18 07:24:58', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (50, 'wrs', 19, 26, '2024-04-08 15:00:00', '2024-04-08 16:00:00', NULL, 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (51, 'wrs', 19, 20, '2024-04-08 15:00:00', '2024-04-08 16:00:00', '2024-04-08 14:53:47', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (52, 'admin', 20, 39, '2024-04-08 15:00:00', '2024-04-08 17:00:00', '2024-04-08 15:06:48', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (53, 'admin', 19, 21, '2024-04-11 15:00:00', '2024-04-11 16:00:00', '2024-04-11 14:45:10', 1, 0, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (54, 'admin', 19, 25, '2024-04-11 14:00:00', '2024-04-11 15:00:00', '2024-04-11 14:45:53', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (55, 'tyf', 19, 20, '2024-04-11 14:00:00', '2024-04-11 15:00:00', '2024-04-11 14:47:13', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (56, 'tyf', 19, 20, '2024-04-11 15:00:00', '2024-04-11 16:00:00', '2024-04-11 14:54:19', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (57, 'admin', 19, 13, '2024-04-18 10:00:00', '2024-04-18 11:00:00', NULL, 1, 0, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (58, 'tyf', 19, 13, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:52:01', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (59, 'tyf', 19, 13, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:52:01', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (60, 'tyf', 19, 16, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:52:40', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (61, 'tyf', 19, 20, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:55:50', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (62, 'tyf', 19, 20, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:55:50', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (63, 'tyf', 19, 20, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:56:08', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (64, 'tyf', 19, 21, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:56:50', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (65, 'tyf', 19, 21, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:56:50', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (66, 'wrs', 25, 138, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:58:31', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (67, 'wrs', 25, 138, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:58:31', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (68, 'wrs', 25, 140, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:58:39', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (69, 'wrs', 19, 19, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:59:49', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (70, 'wrs', 19, 31, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:59:52', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (71, 'wrs', 19, 31, '2024-05-09 14:00:00', '2024-05-09 15:00:00', '2024-05-09 13:59:52', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (72, 'wrs', 20, 39, '2024-05-09 15:00:00', '2024-05-09 16:00:00', '2024-05-09 14:09:34', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (73, 'wrs', 20, 40, '2024-05-09 15:00:00', '2024-05-09 16:00:00', '2024-05-09 14:09:36', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (74, 'wrs', 20, 41, '2024-05-09 15:00:00', '2024-05-09 16:00:00', '2024-05-09 14:09:44', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (75, 'wrs', 20, 41, '2024-05-09 15:00:00', '2024-05-09 16:00:00', '2024-05-09 14:09:44', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (76, 'wrs', 20, 40, '2024-05-09 14:00:00', '2024-05-09 17:00:00', '2024-05-09 14:15:36', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (77, 'tyf', 19, 24, '2024-05-09 14:00:00', '2024-05-09 16:00:00', '2024-05-09 14:16:18', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (78, 'tyf', 22, 79, '2024-05-09 15:00:00', '2024-05-09 16:00:00', '2024-05-09 14:19:57', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (79, 'admin', 19, 21, '2024-05-09 15:00:00', '2024-05-09 16:00:00', '2024-05-09 14:49:00', 1, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (80, 'gxy', 19, 13, '2024-05-10 16:00:00', '2024-05-10 17:00:00', '2024-05-10 15:27:12', 0, 0, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (81, 'tyf', 20, 40, '2024-05-10 16:00:00', '2024-05-10 17:00:00', '2024-05-10 15:27:33', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (82, 'tyf', 19, 20, '2024-05-10 16:00:00', '2024-05-10 17:00:00', '2024-05-10 15:46:27', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (83, 'tyf', 19, 14, '2024-05-10 16:00:00', '2024-05-10 17:00:00', '2024-05-10 15:58:48', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (84, 'tyf', 19, 15, '2024-05-10 17:00:00', '2024-05-10 18:00:00', '2024-05-10 16:22:08', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (85, 'tyf', 19, 13, '2024-05-10 17:00:00', '2024-05-10 18:00:00', '2024-05-10 16:47:41', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (86, 'tyf', 19, 15, '2024-05-15 17:00:00', '2024-05-15 18:00:00', '2024-05-15 16:41:19', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (87, 'tyf', 19, 25, '2024-05-16 13:00:00', '2024-05-16 15:00:00', '2024-05-16 13:21:21', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (88, 'tyf', 19, 19, '2024-05-16 13:00:00', '2024-05-16 17:00:00', '2024-05-16 13:38:25', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (89, 'tyf', 19, 20, '2024-05-16 14:00:00', '2024-05-16 15:00:00', '2024-05-16 13:56:00', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (90, 'tyf', 19, 16, '2024-05-16 14:00:00', '2024-05-16 17:00:00', '2024-05-16 14:02:00', 0, 1, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (91, 'tyf', 19, 20, '2024-05-16 15:00:00', '2024-05-16 16:00:00', '2024-05-16 14:16:12', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (92, 'tyf', 19, 20, '2024-05-16 15:00:00', '2024-05-16 16:00:00', '2024-05-16 14:16:12', 0, 0, 1);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (93, 'tyf', 19, 12, '2024-05-30 15:00:00', '2024-05-30 16:00:00', '2024-05-30 14:59:50', 0, 0, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (94, 'tyf', 19, 12, '2024-05-30 16:00:00', '2024-05-30 17:00:00', '2024-05-30 15:09:52', 0, 0, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (95, 'tyf', 29, 228, '2024-05-30 16:00:00', '2024-05-30 17:00:00', '2024-05-30 15:25:58', 0, 0, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (96, 'admin', 19, 14, '2024-06-03 11:00:00', '2024-06-03 12:00:00', NULL, 0, 0, 0);
INSERT INTO `sys_reserve` (`id`, `username`, `room_id`, `sit_id`, `start_time`, `end_time`, `reserved_time`, `break_contract`, `check_in_time`, `cancle`) VALUES (97, 'admin', 19, 14, '2024-06-03 16:00:00', '2024-06-03 17:00:00', NULL, 0, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `flag` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`id`, `name`, `description`, `flag`) VALUES (1, '管理员', '管理员', 'ROLE_ADMIN');
INSERT INTO `sys_role` (`id`, `name`, `description`, `flag`) VALUES (2, '普通用户', '用户', 'ROLE_USER');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` int NOT NULL,
  `menu_id` int NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 4);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 5);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 6);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 7);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 8);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 7);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 8);
COMMIT;

-- ----------------------------
-- Table structure for sys_room
-- ----------------------------
DROP TABLE IF EXISTS `sys_room`;
CREATE TABLE `sys_room` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `available` tinyint(1) NOT NULL,
  `open_time` time NOT NULL,
  `close_time` time NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_room
-- ----------------------------
BEGIN;
INSERT INTO `sys_room` (`id`, `name`, `type`, `available`, `open_time`, `close_time`) VALUES (19, '小教室 A-101', '0', 1, '06:00:00', '22:00:00');
INSERT INTO `sys_room` (`id`, `name`, `type`, `available`, `open_time`, `close_time`) VALUES (20, '小教室 A-102', '0', 1, '07:00:00', '23:00:00');
INSERT INTO `sys_room` (`id`, `name`, `type`, `available`, `open_time`, `close_time`) VALUES (21, '小教室 A-103', '0', 1, '07:00:00', '22:00:00');
INSERT INTO `sys_room` (`id`, `name`, `type`, `available`, `open_time`, `close_time`) VALUES (22, '小教室 A-104', '0', 1, '08:00:00', '00:00:00');
INSERT INTO `sys_room` (`id`, `name`, `type`, `available`, `open_time`, `close_time`) VALUES (23, '大教室 B-101', '1', 0, '07:00:00', '22:00:00');
INSERT INTO `sys_room` (`id`, `name`, `type`, `available`, `open_time`, `close_time`) VALUES (24, '大教室 B-102', '1', 1, '08:00:00', '23:00:00');
INSERT INTO `sys_room` (`id`, `name`, `type`, `available`, `open_time`, `close_time`) VALUES (25, '大教室 B-103', '1', 1, '00:00:00', '00:00:00');
INSERT INTO `sys_room` (`id`, `name`, `type`, `available`, `open_time`, `close_time`) VALUES (26, '大教室 B-104', '1', 1, '05:00:00', '23:00:00');
INSERT INTO `sys_room` (`id`, `name`, `type`, `available`, `open_time`, `close_time`) VALUES (27, '阅览室 C-101', '2', 1, '08:00:00', '22:00:00');
INSERT INTO `sys_room` (`id`, `name`, `type`, `available`, `open_time`, `close_time`) VALUES (28, '阅览室 C-102', '2', 0, '08:00:00', '21:00:00');
INSERT INTO `sys_room` (`id`, `name`, `type`, `available`, `open_time`, `close_time`) VALUES (29, '图书馆 D-1', '3', 1, '08:00:00', '22:00:00');
INSERT INTO `sys_room` (`id`, `name`, `type`, `available`, `open_time`, `close_time`) VALUES (30, '图书馆', '3', 1, '08:00:00', '22:00:00');
COMMIT;

-- ----------------------------
-- Table structure for sys_sit
-- ----------------------------
DROP TABLE IF EXISTS `sys_sit`;
CREATE TABLE `sys_sit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `room_id` int NOT NULL,
  `chargeport` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=272 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_sit
-- ----------------------------
BEGIN;
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (12, 19, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (13, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (14, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (15, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (16, 19, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (17, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (18, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (19, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (20, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (21, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (22, 19, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (23, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (24, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (25, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (26, 19, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (27, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (28, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (29, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (30, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (31, 19, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (32, 20, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (33, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (34, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (35, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (36, 20, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (37, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (38, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (39, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (40, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (41, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (42, 20, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (43, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (44, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (45, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (46, 20, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (47, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (48, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (49, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (50, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (51, 20, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (52, 21, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (53, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (54, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (55, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (56, 21, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (57, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (58, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (59, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (60, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (61, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (62, 21, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (63, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (64, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (65, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (66, 21, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (67, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (68, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (69, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (70, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (71, 21, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (72, 22, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (73, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (74, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (75, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (76, 22, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (77, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (78, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (79, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (80, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (81, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (82, 22, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (83, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (84, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (85, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (86, 22, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (87, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (88, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (89, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (90, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (91, 22, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (92, 23, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (93, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (94, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (95, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (96, 23, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (97, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (98, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (99, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (100, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (101, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (102, 23, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (103, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (104, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (105, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (106, 23, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (107, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (108, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (109, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (110, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (111, 23, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (112, 24, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (113, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (114, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (115, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (116, 24, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (117, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (118, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (119, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (120, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (121, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (122, 24, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (123, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (124, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (125, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (126, 24, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (127, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (128, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (129, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (130, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (131, 24, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (132, 25, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (133, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (134, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (135, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (136, 25, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (137, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (138, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (139, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (140, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (141, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (142, 25, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (143, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (144, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (145, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (146, 25, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (147, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (148, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (149, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (150, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (151, 25, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (152, 26, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (153, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (154, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (155, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (156, 26, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (157, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (158, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (159, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (160, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (161, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (162, 26, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (163, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (164, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (165, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (166, 26, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (167, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (168, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (169, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (170, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (171, 26, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (172, 27, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (173, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (174, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (175, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (176, 27, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (177, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (178, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (179, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (180, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (181, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (182, 27, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (183, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (184, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (185, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (186, 27, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (187, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (188, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (189, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (190, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (191, 27, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (192, 28, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (193, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (194, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (195, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (196, 28, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (197, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (198, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (199, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (200, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (201, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (202, 28, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (203, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (204, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (205, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (206, 28, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (207, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (208, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (209, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (210, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (211, 28, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (212, 29, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (213, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (214, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (215, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (216, 29, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (217, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (218, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (219, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (220, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (221, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (222, 29, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (223, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (224, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (225, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (226, 29, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (227, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (228, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (229, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (230, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (231, 29, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (232, 30, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (233, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (234, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (235, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (236, 30, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (237, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (238, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (239, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (240, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (241, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (242, 30, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (243, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (244, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (245, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (246, 30, 1);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (247, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (248, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (249, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (250, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (251, 30, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (252, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (253, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (254, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (255, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (256, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (257, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (258, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (259, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (260, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (261, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (262, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (263, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (264, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (265, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (266, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (267, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (268, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (269, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (270, 31, 0);
INSERT INTO `sys_sit` (`id`, `room_id`, `chargeport`) VALUES (271, 31, 0);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `defaults` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` (`id`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `create_time`, `avatar_url`, `role`, `defaults`) VALUES (1, 'admin', 'admin', '管理员', 'admin@qq.com', '13988888888', '复旦大学', '2023-04-14 13:36:46', 'http://localhost:8090/file/2355ecc3fed54895bcc29da5d9a2e090.png', 'ROLE_ADMIN', 3);
INSERT INTO `sys_user` (`id`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `create_time`, `avatar_url`, `role`, `defaults`) VALUES (5, 'xuzheng', '123456', '徐铮', '23210240335@m.fudan.edu.cn', '13413413413', '复旦大学', '2023-01-10 15:56:56', NULL, 'ROLE_USER', 0);
INSERT INTO `sys_user` (`id`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `create_time`, `avatar_url`, `role`, `defaults`) VALUES (11, 'wrs', '123456', '王睿思', '23210240326@m.fudan.edu.cn', '13124141341', '复旦大学计算机', '2023-08-17 17:21:42', NULL, 'ROLE_USER', 0);
INSERT INTO `sys_user` (`id`, `username`, `password`, `nickname`, `email`, `phone`, `address`, `create_time`, `avatar_url`, `role`, `defaults`) VALUES (15, 'tyf', '123456', '田逸凡', '23212010026@m.fudan.edu.cn', '15380338027', '复旦大学', '2023-06-18 08:14:10', NULL, 'ROLE_USER', NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
