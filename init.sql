/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33)
 Source Host           : localhost:3306
 Source Schema         : ry-vue

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33)
 File Encoding         : 65001

 Date: 24/04/2025 18:49:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-04-15 13:23:58', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-04-15 13:23:58', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-04-15 13:23:58', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2025-04-15 13:23:58', 'admin', '2025-04-15 14:08:26', '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-04-15 13:23:58', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-04-15 13:23:58', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1912733410169270352 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-15 13:23:57', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-15 13:23:57', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-15 13:23:57', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-15 13:23:57', 'admin', '2025-04-17 15:51:54');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2025-04-15 13:23:57', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-15 13:23:57', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-15 13:23:57', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-15 13:23:57', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-15 13:23:57', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-04-15 13:23:57', '', NULL);
INSERT INTO `sys_dept` VALUES (1667350079897980929, 0, '0', '镇江长兴酒精有限公司', 1, '镇江长兴酒精有限公司', '', '', '0', '0', 'admin', '2025-04-17 18:37:12', 'admin', '2025-04-18 11:02:42');
INSERT INTO `sys_dept` VALUES (1668503278763757569, 1667350079897980929, '0,1667350079897980929', '安环部', 2, '安环部', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668503376847556609, 1667350079897980929, '0,1667350079897980929', '财务部', 3, '财务部', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668507433901346818, 1667350079897980929, '0,1667350079897980929', '储运部', 4, '储运部', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668507622464671746, 1667350079897980929, '0,1667350079897980929', '董事长', 5, '董事长', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668507712747065345, 1667350079897980929, '0,1667350079897980929', '副总经理', 6, '副总经理', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668508591839629313, 1667350079897980929, '0,1667350079897980929', '总经理', 7, '总经理', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668508725042335746, 1667350079897980929, '0,1667350079897980929', '生产部', 8, '生产部', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668508841421688834, 1667350079897980929, '0,1667350079897980929', '综合办', 9, '综合办', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668508934136778754, 1667350079897980929, '0,1667350079897980929', '设备部', 10, '设备部', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668509022233939970, 1667350079897980929, '0,1667350079897980929', '销售部', 11, '销售部', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668509289851506689, 1668508934136778754, '0,1667350079897980929,1668508934136778754', '机修班', 1001, '机修班', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668509583918354434, 1668508725042335746, '0,1667350079897980929,1668508725042335746', '仓库', 801, '仓库', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668509702638129154, 1668508725042335746, '0,1667350079897980929,1668508725042335746', '化验室', 802, '化验室', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668509827657748481, 1668508725042335746, '0,1667350079897980929,1668508725042335746', '发酵工段', 803, '发酵工段', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668509928362987522, 1668508725042335746, '0,1667350079897980929,1668508725042335746', '环保工段', 804, '环保工段', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668510031458979842, 1668508725042335746, '0,1667350079897980929,1668508725042335746', '磅房', 805, '磅房', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668510159901151233, 1668508725042335746, '0,1667350079897980929,1668508725042335746', '糖化粉碎工段', 806, '糖化粉碎工段', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668510251588636673, 1668508725042335746, '0,1667350079897980929,1668508725042335746', '蒸馏工段', 807, '蒸馏工段', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668510336787533826, 1668508725042335746, '0,1667350079897980929,1668508725042335746', '装卸', 808, '装卸', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668510442261696514, 1668508725042335746, '0,1667350079897980929,1668508725042335746', '装卸车', 809, '装卸车', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1668510606099599362, 1668508725042335746, '0,1667350079897980929,1668508725042335746', '锅炉工段', 810, '锅炉工段', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');
INSERT INTO `sys_dept` VALUES (1912733410169270273, 1668503278763757569, '0,1667350079897980929,1668503278763757569', '测啊', 1, '11', '', '', '0', '0', 'admin', '2025-04-17 18:40:39', 'admin', '2025-04-18 09:12:43');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-04-15 13:23:58', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-04-15 13:23:58', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-04-15 13:23:58', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-04-15 13:23:58', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 235 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, '林雪', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-15 13:47:17');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-15 13:47:31');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-15 13:48:24');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '验证码错误', '2025-04-15 13:48:36');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '验证码错误', '2025-04-15 13:48:38');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-15 13:48:41');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-15 14:08:30');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-15 14:08:42');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-15 14:08:49');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-15 15:40:12');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-15 15:40:16');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-15 17:43:44');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-15 17:44:00');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-15 17:44:17');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-15 17:47:16');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-15 17:47:24');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-15 17:51:20');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-15 17:55:11');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-15 17:55:26');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-15 17:55:33');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-15 18:02:06');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-15 18:02:12');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-15 18:02:46');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-15 18:04:28');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-15 18:04:58');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-15 18:05:03');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-16 09:45:30');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 10:01:49');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-16 10:01:52');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 10:02:13');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-16 10:36:22');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 10:36:27');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-16 10:55:02');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 10:59:38');
INSERT INTO `sys_logininfor` VALUES (134, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 11:38:49');
INSERT INTO `sys_logininfor` VALUES (135, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 11:41:05');
INSERT INTO `sys_logininfor` VALUES (136, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 11:41:30');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-16 11:41:33');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 11:41:55');
INSERT INTO `sys_logininfor` VALUES (139, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 11:42:01');
INSERT INTO `sys_logininfor` VALUES (140, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 11:43:35');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 11:44:00');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 11:44:22');
INSERT INTO `sys_logininfor` VALUES (143, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 11:44:39');
INSERT INTO `sys_logininfor` VALUES (144, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 11:45:00');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-16 11:45:33');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-16 13:08:23');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 13:08:31');
INSERT INTO `sys_logininfor` VALUES (148, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 13:08:51');
INSERT INTO `sys_logininfor` VALUES (149, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 13:10:29');
INSERT INTO `sys_logininfor` VALUES (150, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 13:10:38');
INSERT INTO `sys_logininfor` VALUES (151, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 13:54:39');
INSERT INTO `sys_logininfor` VALUES (152, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 14:04:25');
INSERT INTO `sys_logininfor` VALUES (153, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 14:04:38');
INSERT INTO `sys_logininfor` VALUES (154, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 14:14:22');
INSERT INTO `sys_logininfor` VALUES (155, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 14:14:29');
INSERT INTO `sys_logininfor` VALUES (156, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 14:14:34');
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 14:14:48');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 14:39:25');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 15:13:15');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 15:39:12');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 15:40:03');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 15:49:16');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 15:49:29');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 15:49:34');
INSERT INTO `sys_logininfor` VALUES (165, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 15:49:52');
INSERT INTO `sys_logininfor` VALUES (166, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 15:50:20');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-16 15:50:25');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 15:51:57');
INSERT INTO `sys_logininfor` VALUES (169, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 15:52:05');
INSERT INTO `sys_logininfor` VALUES (170, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 15:55:18');
INSERT INTO `sys_logininfor` VALUES (171, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 15:55:41');
INSERT INTO `sys_logininfor` VALUES (172, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 15:57:52');
INSERT INTO `sys_logininfor` VALUES (173, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 15:57:57');
INSERT INTO `sys_logininfor` VALUES (174, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 15:58:02');
INSERT INTO `sys_logininfor` VALUES (175, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 15:58:08');
INSERT INTO `sys_logininfor` VALUES (176, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 15:58:14');
INSERT INTO `sys_logininfor` VALUES (177, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 15:58:35');
INSERT INTO `sys_logininfor` VALUES (178, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 15:59:28');
INSERT INTO `sys_logininfor` VALUES (179, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 16:27:13');
INSERT INTO `sys_logininfor` VALUES (180, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 16:27:59');
INSERT INTO `sys_logininfor` VALUES (181, 'zzy', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 16:33:32');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 16:33:45');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 16:42:34');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 16:42:44');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-16 16:57:18');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-16 16:57:32');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-04-17 09:11:00');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 09:11:52');
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 09:12:09');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 09:26:59');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 09:27:08');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 09:39:47');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 09:39:55');
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 09:41:03');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 09:41:12');
INSERT INTO `sys_logininfor` VALUES (196, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 09:43:59');
INSERT INTO `sys_logininfor` VALUES (197, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 09:44:16');
INSERT INTO `sys_logininfor` VALUES (198, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 09:50:43');
INSERT INTO `sys_logininfor` VALUES (199, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 09:51:01');
INSERT INTO `sys_logininfor` VALUES (200, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 09:51:50');
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 09:52:11');
INSERT INTO `sys_logininfor` VALUES (202, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 09:56:36');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 09:56:53');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 10:25:27');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 10:32:30');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 10:38:42');
INSERT INTO `sys_logininfor` VALUES (207, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 10:38:54');
INSERT INTO `sys_logininfor` VALUES (208, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 10:46:57');
INSERT INTO `sys_logininfor` VALUES (209, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 10:47:10');
INSERT INTO `sys_logininfor` VALUES (210, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 10:52:41');
INSERT INTO `sys_logininfor` VALUES (211, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 10:52:56');
INSERT INTO `sys_logininfor` VALUES (212, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 11:12:26');
INSERT INTO `sys_logininfor` VALUES (213, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 11:12:39');
INSERT INTO `sys_logininfor` VALUES (214, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 11:15:30');
INSERT INTO `sys_logininfor` VALUES (215, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 11:16:01');
INSERT INTO `sys_logininfor` VALUES (216, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 11:33:09');
INSERT INTO `sys_logininfor` VALUES (217, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 13:02:49');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 14:33:03');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 15:07:25');
INSERT INTO `sys_logininfor` VALUES (220, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 15:08:36');
INSERT INTO `sys_logininfor` VALUES (221, 'admin', '192.168.100.107', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 15:12:45');
INSERT INTO `sys_logininfor` VALUES (222, 'admin', '192.168.100.128', '内网IP', 'Chrome 13', 'Linux', '0', 'BladeX单点登录成功', '2025-04-17 15:23:58');
INSERT INTO `sys_logininfor` VALUES (223, 'admin', '192.168.100.128', '内网IP', 'Chrome 13', 'Linux', '0', 'BladeX单点登录成功', '2025-04-17 15:30:20');
INSERT INTO `sys_logininfor` VALUES (224, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 17:32:23');
INSERT INTO `sys_logininfor` VALUES (225, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 17:32:46');
INSERT INTO `sys_logininfor` VALUES (226, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 18:19:00');
INSERT INTO `sys_logininfor` VALUES (227, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 18:19:23');
INSERT INTO `sys_logininfor` VALUES (228, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-04-17 18:28:22');
INSERT INTO `sys_logininfor` VALUES (229, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-17 18:28:37');
INSERT INTO `sys_logininfor` VALUES (230, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-18 09:01:37');
INSERT INTO `sys_logininfor` VALUES (231, 'admin', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-18 11:59:00');
INSERT INTO `sys_logininfor` VALUES (232, '金胜友', '192.168.100.106', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-18 13:33:03');
INSERT INTO `sys_logininfor` VALUES (233, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-24 09:44:33');
INSERT INTO `sys_logininfor` VALUES (234, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', 'BladeX单点登录成功', '2025-04-24 11:22:34');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-04-15 13:23:57', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-04-15 13:23:57', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-04-15 13:23:57', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-04-15 13:23:57', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-04-15 13:23:57', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-04-15 13:23:57', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-04-15 13:23:57', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-04-15 13:23:57', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-04-15 13:23:57', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-04-15 13:23:57', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-04-15 13:23:57', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-04-15 13:23:57', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-04-15 13:23:57', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-04-15 13:23:57', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-04-15 13:23:57', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-04-15 13:23:57', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-04-15 13:23:57', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-04-15 13:23:57', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-04-15 13:23:57', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-04-15 13:23:57', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-04-15 13:23:57', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-04-15 13:23:57', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-04-15 13:23:57', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, 'blade接口测试', 0, 8, 'blade', 'blade/apiTest/index', NULL, '', 1, 0, 'C', '0', '0', 'system:user', 'edit', 'zzy', '2025-04-16 14:14:00', 'admin', '2025-04-16 15:31:45', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-04-15 13:23:58', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-04-15 13:23:58', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 430 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1672788343064743939 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '首席执行官', 1, '0', 'admin', '2025-04-15 13:23:57', 'admin', '2025-04-18 12:13:12', '岗位类型：高层');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-04-15 13:23:57', '', NULL, '');
INSERT INTO `sys_post` VALUES (1668511092202655745, '2', '磅房', 2, '0', 'admin', '2025-04-18 09:39:01', 'admin', '2025-04-18 12:13:12', '岗位类型：中层');
INSERT INTO `sys_post` VALUES (1668511304900005890, '4', '董事长', 4, '0', 'admin', '2025-04-18 09:39:01', 'admin', '2025-04-18 12:13:12', '岗位类型：高层');
INSERT INTO `sys_post` VALUES (1668512122244026370, '5', '发货工段', 5, '0', 'admin', '2025-04-18 09:39:01', 'admin', '2025-04-18 12:13:12', '岗位类型：中层');
INSERT INTO `sys_post` VALUES (1668512174760906754, '6', '发酵工段', 6, '0', 'admin', '2025-04-18 09:39:01', 'admin', '2025-04-18 12:13:12', '岗位类型：中层');
INSERT INTO `sys_post` VALUES (1668512228775153666, '7', '化验室', 7, '0', 'admin', '2025-04-18 09:39:01', 'admin', '2025-04-18 12:13:12', '岗位类型：基层');
INSERT INTO `sys_post` VALUES (1668512331598516226, '8', '环保工段', 8, '0', 'admin', '2025-04-18 09:39:01', 'admin', '2025-04-18 12:13:12', '岗位类型：中层');
INSERT INTO `sys_post` VALUES (1668512405778976769, '9', '机修班', 9, '0', 'admin', '2025-04-18 09:39:01', 'admin', '2025-04-18 12:13:12', '岗位类型：中层');
INSERT INTO `sys_post` VALUES (1668512531075420161, '10', '生产部管理岗位', 10, '0', 'admin', '2025-04-18 09:39:01', 'admin', '2025-04-18 12:13:12', '岗位类型：中层');
INSERT INTO `sys_post` VALUES (1668512652890591234, '11', '糖化工段', 11, '0', 'admin', '2025-04-18 09:39:01', 'admin', '2025-04-18 12:13:12', '岗位类型：中层');
INSERT INTO `sys_post` VALUES (1668512750919864322, '12', '行政', 12, '0', 'admin', '2025-04-18 09:39:01', '', NULL, '岗位类型：其他');
INSERT INTO `sys_post` VALUES (1668512829940551681, '13', '蒸馏工段', 13, '0', 'admin', '2025-04-18 09:39:01', '', NULL, '岗位类型：中层');
INSERT INTO `sys_post` VALUES (1668512897116524545, '14', '职员', 14, '0', 'admin', '2025-04-18 09:39:01', '', NULL, '岗位类型：其他');
INSERT INTO `sys_post` VALUES (1668512960194662402, '15', '装卸班', 15, '0', 'admin', '2025-04-18 09:39:01', '', NULL, '岗位类型：中层');
INSERT INTO `sys_post` VALUES (1668513081183555585, '16', '装卸车班', 16, '0', 'admin', '2025-04-18 09:39:01', '', NULL, '岗位类型：中层');
INSERT INTO `sys_post` VALUES (1668513135415906305, '3', '总经理', 3, '0', 'admin', '2025-04-18 09:39:01', '', NULL, '岗位类型：高层');
INSERT INTO `sys_post` VALUES (1672788049211805697, 'CXJJ001', '安环部', 17, '0', 'admin', '2025-04-18 09:39:01', '', NULL, '岗位类型：高层');
INSERT INTO `sys_post` VALUES (1672788206338822145, 'CXJJ002', '设备部', 18, '0', 'admin', '2025-04-18 09:39:01', '', NULL, '岗位类型：中层');
INSERT INTO `sys_post` VALUES (1672788271220510722, 'CXJJ003', '生产部', 19, '0', 'admin', '2025-04-18 09:39:01', '', NULL, '岗位类型：中层');
INSERT INTO `sys_post` VALUES (1672788343064743938, 'CXJJ004', '主要负责人', 20, '0', 'admin', '2025-04-18 09:39:01', '', NULL, '岗位类型：中层');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-04-15 13:23:57', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-04-15 13:23:57', 'admin', '2025-04-16 15:51:53', '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (2, 2000);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1693536684601888770 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-04-24 11:22:34', 'admin', '2025-04-15 13:23:57', '', '2025-04-24 11:22:34', '管理员');
INSERT INTO `sys_user` VALUES (2, 101, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-04-15 13:23:57', 'admin', '2025-04-15 13:23:57', 'admin', '2025-04-18 10:58:47', '测试员');
INSERT INTO `sys_user` VALUES (100, 1668503376847556609, 'zzy', 'zzy', '00', '', '', '0', '', '$2a$10$SfQ5JYcgNJwdcDGUPAzyAO.fqLAjjapUwO5U29yAd/nLn0dHUMmQK', '0', '0', '192.168.100.106', '2025-04-16 16:28:00', 'admin', '2025-04-16 10:56:48', 'admin', '2025-04-18 11:07:14', NULL);
INSERT INTO `sys_user` VALUES (1672881689347084290, 1668510336787533826, '胡恒勇', '胡恒勇', '00', '', '186****2801', '1', '', '$2a$10$qOSQDAmUSb600rTTz4UhnOylSw8DHm6szTGjFuwOOXuoI01ghwmFq', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:20', 'admin', '2025-04-18 12:10:37', NULL);
INSERT INTO `sys_user` VALUES (1672881689426776065, 1668509022233939970, '曾广鹏', '曾广鹏', '00', '', '158****0629', '2', '', '$2a$10$UcsKF/dk2rW7US7CNpbL9etVbxEY1jMAVFvPIdzUiFbV18v5Sfjru', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:21', 'admin', '2025-04-18 12:10:37', NULL);
INSERT INTO `sys_user` VALUES (1672881689531633666, 1668503278763757569, '孙秀艳', '孙秀艳', '00', '', '139****5761', '2', '', '$2a$10$VauOjYRlf8mLBoktf4mnfejHYbu/WLV8vDGZS4F1fX3avvsK58yry', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:21', 'admin', '2025-04-18 12:10:37', NULL);
INSERT INTO `sys_user` VALUES (1672881689607131137, 1668509928362987522, '臧定云', '臧定云', '00', '', '158****3858', '2', '', '$2a$10$rlUp6r1eA2yrX/jITcNc1uRtoxkZxJmtSHxdzDW.NkR1o1KsxiNQy', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:22', 'admin', '2025-04-18 12:10:37', NULL);
INSERT INTO `sys_user` VALUES (1672881689657462786, 1668509928362987522, '陈先华', '陈先华', '00', '', '138****0376', '2', '', '$2a$10$NUeEX7JhRu2Jc1MJQkUxV.l9gklLUqLMTmRLmVTzAu9uvFA2vJvm.', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:22', 'admin', '2025-04-18 12:10:38', NULL);
INSERT INTO `sys_user` VALUES (1672881689745543169, 1668508725042335746, '吕一鸣', '吕一鸣', '00', '', '131****6691', '2', '', '$2a$10$IWWSf4M6ly4Oa4IIm9edceMzLaINHeO3M/1b5IAkxOXtyubGIxVfW', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:22', 'admin', '2025-04-18 12:10:38', NULL);
INSERT INTO `sys_user` VALUES (1672881689795874817, 1668508725042335746, '吕九子', '吕九子', '00', '', '131****6681', '2', '', '$2a$10$wCq.akzXi3NCu1.vFzU2NOFv/2QQhCzESmPX8lDldHm/DF8hOFwQ2', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:23', 'admin', '2025-04-18 12:10:38', NULL);
INSERT INTO `sys_user` VALUES (1672881689846206465, 1668508725042335746, '王双全', '王双全', '00', '', '131****3016', '2', '', '$2a$10$GGI6w/P0DfbXmsGYQdgLe.iwcbyU/jcMpIG88L9vtLS3EoR1wJEza', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:23', 'admin', '2025-04-18 12:10:39', NULL);
INSERT INTO `sys_user` VALUES (1672881689896538113, 1668508725042335746, '朱康健', '朱康健', '00', '', '151****5590', '2', '', '$2a$10$0onDEWwdaGA.W8iwPROtQOSOx1D2Jw7wT5Ze6fsp2zxEdQRHne9Xm', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:24', 'admin', '2025-04-18 12:10:39', NULL);
INSERT INTO `sys_user` VALUES (1672881689942675458, 1668508725042335746, '徐荣平', '徐荣平', '00', '', '158****1797', '2', '', '$2a$10$n6agBiE/AMWRb1xRwPkntuazRwLJ.BzlXJbcOUcP9CiJlt8l1cmH.', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:24', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881689993007105, 1668508725042335746, '吴伟庆', '吴伟庆', '00', '', '151****5490', '2', '', '$2a$10$4AHDtORwL99NUEDF96qA9uKyLVHD415US8D4z0LFzn.JXd7pMFD7.', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:25', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881690043338754, 1668503278763757569, '赵敬中', '赵敬中', '00', '', '137****8662', '2', '', '$2a$10$7pDvOweoddpMWEJf0dYWtumwOKu2KLWNNPmCXnGReyiwyRwy49dBS', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:25', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881690123030529, 1668508725042335746, '卜荣兴', '卜荣兴', '00', '', '182****8772', '2', '', '$2a$10$9lFNVkn0AwvGkxCz1kzjpOvAqD3YsBxyFwg9SxIHYup5Qfk50.W0S', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:25', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881690198528002, 1668508725042335746, '朱国庆', '朱国庆', '00', '', '138****2862', '2', '', '$2a$10$c5lGo4KeksB85eq8qjHjX.pfVgAcoGq4a4P31pyuyC6FbNwAfee.S', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:26', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881690274025474, 1668508725042335746, '田兴国', '田兴国', '00', '', '181****4576', '2', '', '$2a$10$LoiGDWwh8RIJFnD5.sdCT.zlSwP04EqHRln6TVS85E.8x3qyZ0eAi', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:26', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881690378883073, 1668507622464671746, '黄虎平', '黄虎平', '00', '', '136****3888', '2', '', '$2a$10$rzVMNwL5a4B4aN/BpwXUSOnWXVdn3NkI6fd1w2dP.GHovFgxPYdgW', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:27', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881690437603330, 1668508725042335746, '郑平', '郑平', '00', '', '150****6621', '2', '', '$2a$10$hxxhV6pafsJu4a0QvKxAKOylsQr560N3Nn2W4Izo25URP2xiCwKWK', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:27', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881690517295106, 1668508725042335746, '翟天福', '翟天福', '00', '', '150****1809', '2', '', '$2a$10$fFlKHaIWb9PGRW9bKyZUY.lyPc6fmc7ZNdX6m16M4EdTwHh2erDp.', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:27', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881690634735617, 1668508934136778754, '蒋群伟', '蒋群伟', '00', '', '136****3777', '2', '', '$2a$10$XHGvUQELzbuRAGCkwuy73.rIXoyRc6oh/ZaVQINCQB4TqPTQ3f2S6', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:27', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881690710233090, 1668503376847556609, '赵建祥', '赵建祥', '00', '', '135****9729', '2', '', '$2a$10$7O.zOtapHM9U0rwEfJqkc.v4ft2Xcz5CCBZqrtsgwS4tjjn7oAzEq', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:28', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881690785730562, 1668508725042335746, '王发荣', '王发荣', '00', '', '138****6753', '2', '', '$2a$10$yWIhrIXm.gQXTIG/ALRlauMuhsmyBnNRi88BfgZ7H63rjyg9ndf.C', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:28', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881690836062210, 1668508725042335746, '胡忠祥', '胡忠祥', '00', '', '139****2589', '2', '', '$2a$10$efwnWy6qbQCvZdZr0JJN7OSRCzYAD5cofJyjHoPryqq52U7Lco7c2', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:28', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881690886393857, 1668508725042335746, '赵德新', '赵德新', '00', '', '151****8381', '2', '', '$2a$10$ZAcrXDVxYQo/y8Ow8/FcZOds870SYpZspfg9hsNLDPAh/wBhQabUq', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:28', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881690961891329, 1668508725042335746, '解九林', '解九林', '00', '', '159****6178', '2', '', '$2a$10$kfHfHOsR5.N4bs7uG7LmVu6LdR18o6szhiynH0gXNHzvRFU4zxeSy', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:29', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691012222977, 1668503278763757569, '陈兵', '陈兵', '00', '', '159****6629', '2', '', '$2a$10$MRcOsE3k1g0nW9KVwjfP.OYl0ghgYbsEcJyZ3aQaKoYpFT7mkoI9i', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:29', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691066748930, 1668508725042335746, '蒋奇志', '蒋奇志', '00', '', '136****8910', '2', '', '$2a$10$gTbbreXO8huwwBW8VhDyiOVuLtENFXMT/Ns5EUj5fCa9OGslqQXo6', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:29', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691154829313, 1668508725042335746, '解斌生', '解斌生', '00', '', '151****8658', '2', '', '$2a$10$5HYjfL9a4umrUp0V69LbI.ZqbwmuVKMnwzy697LSYtSJyunLRuUTu', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:29', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691205160962, 1668503376847556609, '王习芳', '王习芳', '00', '', '159****0100', '2', '', '$2a$10$jdFjeznxXhL6OZdO6YF/HOP7uVNRMkIWt2xQeKPz4KTQWJFpG38ky', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:30', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691255492609, 1668508725042335746, '翟正高', '翟正高', '00', '', '132****7501', '2', '', '$2a$10$ADBaRmalAZ9jmpV70wNtJ.4YG55b53ECW68xVYMEy1tfcYTLOtAay', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:30', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691305824258, 1668508725042335746, '唐勇', '唐勇', '00', '', '138****4220', '2', '', '$2a$10$9rVAtCm2/LCI.hYM/nlkPuKkuQ6FpkgLfxR6DVHIYIvG4RTRecdRO', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:30', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691385516034, 1668508725042335746, '张丰', '张丰', '00', '', '150****5420', '2', '', '$2a$10$McJJ3WCvkjzwcpyaAFUj1OXn4Snw/Jz.4F200qeU2gChUi/dnNxFW', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:31', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691486179329, 1668508841421688834, '赵火泉', '赵火泉', '00', '', '189****1976', '2', '', '$2a$10$YpsmYFZZW12rdqH9ECSBWuOFPdRQRHRD65eMUgt2SqXfdsfqCcV3C', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:31', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691549093890, 1668508725042335746, '刘珠红', '刘珠红', '00', '', '188****9008', '2', '', '$2a$10$0vjToQic6bLnzV2FjccbSe3NlXNFqH2ez5dOg6My77tt7CuCK5XKu', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:31', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691599425537, 1668508725042335746, '潘小华', '潘小华', '00', '', '158****9343', '2', '', '$2a$10$Shxhl/nRtPATosaxjSa/Xumsbk7nHIDirqT9kJQRRoAHuz9HS8Pke', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:31', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691645562882, 1668508725042335746, '徐剑', '徐剑', '00', '', '183****9554', '2', '', '$2a$10$auTaEGm7njh8l.wqfel2bOYqEZT8hHMazzKmLtzteftPT0oC2MZCS', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:31', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691695894529, 1668508725042335746, '徐敏龙', '徐敏龙', '00', '', '150****7253', '2', '', '$2a$10$u3GnMmBABG8QZE2s2p5Mo.7NWxtSxFVuce2VfuV7FBNU0vnQ/itqe', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:32', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691775586305, 1668508725042335746, '王昌梅', '王昌梅', '00', '', '139****8804', '2', '', '$2a$10$WkhKsweY7AYGIZu.wrmmLeY7ycvTAcGlo8tmH/kVmBj7j2swqxFl.', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:32', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691825917953, 1668508934136778754, '吕国兴', '吕国兴', '00', '', '130****6533', '2', '', '$2a$10$1nNXX2R.gzSs8sLwxniY3Oaf88V3wEdeh01cpqTmEs.KbM3O.fjXe', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:32', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691876249602, 1668508725042335746, '嵇荣叶', '嵇荣叶', '00', '', '139****7380', '2', '', '$2a$10$yFUxt5nqEYFEi0SwNgwGfuKOz3Ducj6TLlM8r8tfx84PZC9xQ4LJ.', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:32', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881691926581249, 1668508934136778754, '张贵生', '张贵生', '00', '', '189****4605', '2', '', '$2a$10$iJmYRuDg95b1mOAhRJKUeeQlezXy1LWyLL9OshQwqtsFKbcWf/y/m', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:32', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881692006273025, 1668508725042335746, '赵德提', '赵德提', '00', '', '139****6941', '2', '', '$2a$10$MXRS/Ox13MSmcqlAkcKx6.OzVHmLhUWe1zxfJLzDPiD5k0/zjOPKy', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:32', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881692085964801, 1668508725042335746, '李文奎', '李文奎', '00', '', '158****1242', '2', '', '$2a$10$RXe2lyZlSIqiGPi4hmxOXOz1WySWOoDvRWV8Nk/lNAk2ZC5qh3BNK', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:33', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881692136296450, 1668508725042335746, '许德明', '许德明', '00', '', '138****1510', '2', '', '$2a$10$JijaHUsWTo.FElQzifpaXuD7RFX75Tfgaz8ln2RE/Sq3UhH9KepZW', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:33', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881692186628098, 1668508725042335746, '吕素梅', '吕素梅', '00', '', '136****7920', '2', '', '$2a$10$nTi.LT8Ab48e57tMtGEZR.vMI.6fncAH6k9s0odXG2Z02WwT2lNoS', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:33', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881692266319874, 1668508725042335746, '李锡功', '李锡功', '00', '', '136****1566', '2', '', '$2a$10$nDkfGSgQsZScmasBf8zZlOSGauqwDN8t.74wfejOsK5X58h/p6nDy', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:33', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881692316651522, 1668508725042335746, '王业林', '王业林', '00', '', '180****9050', '2', '', '$2a$10$3A.NH8U.gll7LY/Om5Hffu3HbhoSS4xLrCOdv4d6IWX1bLqIOGYy2', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:33', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881692362788866, 1668508725042335746, '张克彦', '张克彦', '00', '', '183****0376', '2', '', '$2a$10$wmtUkFACD6eGx1ExYO5vAOrMCSKOxzCcpbEr/ayEC3dr.RyeMQLS6', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:34', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881692438286337, 1668508725042335746, '吴昌俊', '吴昌俊', '00', '', '138****3781', '2', '', '$2a$10$lwjLesHErVYhNtxbVTsrn.EAJcatcSkALzMPjDyFKXQmntWAHGWsy', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:34', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881692501200897, 1668508934136778754, '赵文强', '赵文强', '00', '', '158****5296', '2', '', '$2a$10$qvajcjLw9IQyEABB8JofTepKU3tCmr9adFvP59k6rVjAe1Jaf6DkK', '0', '0', '', NULL, 'admin', '2025-04-18 12:00:34', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881693809823745, 1667350079897980929, '唐建武', '唐建武', '00', '295144796@qq.com', '13734563102', '2', '', '$2a$10$3hG9qcy.SBLbPVudKlS.SetYK9VevvUzR21FWjo23s2yZe3BCMU4a', '0', '0', '', NULL, 'admin', '2025-04-18 10:02:04', 'admin', '2025-04-18 11:07:36', NULL);
INSERT INTO `sys_user` VALUES (1672881693855961090, 1668508725042335746, '金胜友', '金胜友', '00', '', '183****2604', '2', '', '$2a$10$YdUQB2zBTEyPWBLRoDpK0eEQbViYlt6iMLP9kYQV9HJZzW8Aa1x7a', '0', '0', '192.168.100.106', '2025-04-18 13:33:04', 'admin', '2025-04-18 10:02:04', '', '2025-04-18 13:33:03', NULL);
INSERT INTO `sys_user` VALUES (1672881693906292737, 1668508841421688834, '邵其娟', '邵其娟', '00', '', '139****0566', '2', '', '$2a$10$HeGRYaZq44/PXONoaD9J2uaE58JSUnuqKFSjS2iI05PD.qPCB1Lci', '0', '0', '', NULL, 'admin', '2025-04-18 10:02:04', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881693981790209, 1668509289851506689, '朱军民', '朱军民', '00', '', '136****4589', '2', '', '$2a$10$R/HvgO367H4GM2BWnKlGse.GjWwrT8LcCoE2KUMpcoxMbb7K.azF2', '0', '0', '', NULL, 'admin', '2025-04-18 10:02:05', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881694032121857, 1668507433901346818, '刘来发', '刘来发', '00', '', '150****5745', '2', '', '$2a$10$uYLDEcTGrxUEqb2/bg0ZVuvTtf3KyYehCswLssPRsRvB4ie1IpvQu', '0', '0', '', NULL, 'admin', '2025-04-18 10:02:05', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881694136979457, 1668508591839629313, '蒋勤', '蒋勤', '00', '', '159****2888', '2', '', '$2a$10$1zTcdOdg2IJO.GJMOIi/zuueCTu1zGc8fRoVoKcn3mfs/vpJzt6cm', '0', '0', '', NULL, 'admin', '2025-04-18 10:02:05', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1672881694187311106, 1668503278763757569, '李大鹏', '李大鹏', '00', '', '188****2791', '2', '', '$2a$10$cljB.PRrdKJ/J9bpyVctO.Sfqm6VpQLn9P.kcQEZFZqFnDuKe8Ubq', '0', '0', '', NULL, 'admin', '2025-04-18 10:02:05', '', NULL, NULL);
INSERT INTO `sys_user` VALUES (1693536684601888769, 1667350079897980929, '长兴酒精', '长兴酒精', '00', '', '156****6799', '2', '', '$2a$10$sBS5UDwpezPve2ActdE2U.psPIZizWl3I.GsABTfw6yUuxcGnJHD.', '0', '0', '', NULL, 'admin', '2025-04-18 10:02:05', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);
INSERT INTO `sys_user_post` VALUES (1672881689347084290, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881689426776065, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881689531633666, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881689607131137, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881689657462786, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881689745543169, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881689795874817, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881689846206465, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881689896538113, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881689942675458, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881689993007105, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881690437603330, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881690517295106, 1668512331598516226);
INSERT INTO `sys_user_post` VALUES (1672881690710233090, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881690836062210, 1668512331598516226);
INSERT INTO `sys_user_post` VALUES (1672881690886393857, 1668512331598516226);
INSERT INTO `sys_user_post` VALUES (1672881690961891329, 1668512652890591234);
INSERT INTO `sys_user_post` VALUES (1672881691012222977, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881691066748930, 1668511092202655745);
INSERT INTO `sys_user_post` VALUES (1672881691154829313, 1668512829940551681);
INSERT INTO `sys_user_post` VALUES (1672881691205160962, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881691255492609, 1668512331598516226);
INSERT INTO `sys_user_post` VALUES (1672881691305824258, 1668512829940551681);
INSERT INTO `sys_user_post` VALUES (1672881691385516034, 1668512960194662402);
INSERT INTO `sys_user_post` VALUES (1672881691549093890, 1668511092202655745);
INSERT INTO `sys_user_post` VALUES (1672881691599425537, 1668512331598516226);
INSERT INTO `sys_user_post` VALUES (1672881691645562882, 1668512652890591234);
INSERT INTO `sys_user_post` VALUES (1672881691775586305, 1668512228775153666);
INSERT INTO `sys_user_post` VALUES (1672881691825917953, 1668512405778976769);
INSERT INTO `sys_user_post` VALUES (1672881691876249602, 1668512228775153666);
INSERT INTO `sys_user_post` VALUES (1672881691926581249, 1668512405778976769);
INSERT INTO `sys_user_post` VALUES (1672881692186628098, 1668512228775153666);
INSERT INTO `sys_user_post` VALUES (1672881692316651522, 1668512960194662402);
INSERT INTO `sys_user_post` VALUES (1672881692362788866, 1668512331598516226);
INSERT INTO `sys_user_post` VALUES (1672881692501200897, 1668512405778976769);
INSERT INTO `sys_user_post` VALUES (1672881693809823745, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881693809823745, 1672788049211805697);
INSERT INTO `sys_user_post` VALUES (1672881693855961090, 1668512960194662402);
INSERT INTO `sys_user_post` VALUES (1672881693906292737, 1668512750919864322);
INSERT INTO `sys_user_post` VALUES (1672881693981790209, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881694032121857, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1672881694136979457, 1668513135415906305);
INSERT INTO `sys_user_post` VALUES (1672881694187311106, 1668512897116524545);
INSERT INTO `sys_user_post` VALUES (1693536684601888769, 1668511304900005890);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 2);

SET FOREIGN_KEY_CHECKS = 1;
