-- phpMyAdmin SQL Dump
-- version 3.0.1.1
-- http://www.phpmyadmin.net
--
-- 服务器版本: 5.1.29
-- PHP 版本: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a'); 

CREATE TABLE IF NOT EXISTS `t_userInfo` (
  `user_name` varchar(30)  NOT NULL COMMENT 'user_name',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `userPhoto` varchar(60)  NOT NULL COMMENT '用户照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `email` varchar(50)  NOT NULL COMMENT '邮箱',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  `regTime` varchar(20)  NULL COMMENT '注册时间',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_oldMan` (
  `oldManId` int(11) NOT NULL AUTO_INCREMENT COMMENT '老人编号',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `sex` varchar(4)  NOT NULL COMMENT '性别',
  `age` int(11) NOT NULL COMMENT '年龄',
  `manPhoto` varchar(60)  NOT NULL COMMENT '老人照片',
  `manDesc` varchar(5000)  NULL COMMENT '老人介绍',
  `userObj` varchar(30)  NOT NULL COMMENT '登记用户',
  `addTime` varchar(20)  NULL COMMENT '登记时间',
  PRIMARY KEY (`oldManId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_roomType` (
  `typeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '房间类型id',
  `typeName` varchar(20)  NOT NULL COMMENT '房间类型名称',
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_room` (
  `roomNo` varchar(20)  NOT NULL COMMENT 'roomNo',
  `roomTypeObj` int(11) NOT NULL COMMENT '房间类型',
  `roomName` varchar(20)  NOT NULL COMMENT '房间名称',
  `mainPhoto` varchar(60)  NOT NULL COMMENT '房间主图',
  `price` float NOT NULL COMMENT '房间价格',
  `roomDesc` varchar(5000)  NULL COMMENT '房间详情',
  `roomState` varchar(20)  NOT NULL COMMENT '房间状态',
  PRIMARY KEY (`roomNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_roomOrder` (
  `orderId` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `roomObj` varchar(20)  NOT NULL COMMENT '入住房间',
  `oldManObj` int(11) NOT NULL COMMENT '入住老人',
  `liveDate` varchar(20)  NULL COMMENT '入住日期',
  `monthNum` int(11) NOT NULL COMMENT '入住时间',
  `orderMoney` float NOT NULL COMMENT '订单总金额',
  `orderState` varchar(20)  NOT NULL COMMENT '订单状态',
  `orderDesc` varchar(5000)  NULL COMMENT '订单费用明细',
  `orderTime` varchar(20)  NULL COMMENT '订单时间',
  PRIMARY KEY (`orderId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_nurse` (
  `nurseId` int(11) NOT NULL AUTO_INCREMENT COMMENT '记录id',
  `nurseType` varchar(20)  NOT NULL COMMENT '信息类别',
  `title` varchar(80)  NOT NULL COMMENT '信息标题',
  `content` varchar(5000)  NOT NULL COMMENT '信息内容',
  `publishDate` varchar(20)  NULL COMMENT '发布时间',
  PRIMARY KEY (`nurseId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_reception` (
  `receptionId` int(11) NOT NULL AUTO_INCREMENT COMMENT '接待记录id',
  `receptType` varchar(20)  NOT NULL COMMENT '接待类别',
  `title` varchar(20)  NOT NULL COMMENT '接待主题',
  `content` varchar(5000)  NULL COMMENT '接待内容',
  `receptDate` varchar(20)  NULL COMMENT '接待日期',
  PRIMARY KEY (`receptionId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_department` (
  `departmentId` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门编号',
  `departName` varchar(20)  NOT NULL COMMENT '部门名称',
  `bornDate` varchar(20)  NULL COMMENT '成立日期',
  `mainPerson` varchar(20)  NOT NULL COMMENT '负责人',
  PRIMARY KEY (`departmentId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `t_employee` (
  `employeeNo` varchar(30)  NOT NULL COMMENT 'employeeNo',
  `password` varchar(30)  NOT NULL COMMENT '登录密码',
  `departmentObj` int(11) NOT NULL COMMENT '所在部门',
  `name` varchar(20)  NOT NULL COMMENT '姓名',
  `gender` varchar(4)  NOT NULL COMMENT '性别',
  `birthDate` varchar(20)  NULL COMMENT '出生日期',
  `employeePhoto` varchar(60)  NOT NULL COMMENT '员工照片',
  `telephone` varchar(20)  NOT NULL COMMENT '联系电话',
  `address` varchar(80)  NULL COMMENT '家庭地址',
  PRIMARY KEY (`employeeNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `t_salary` (
  `salaryId` int(11) NOT NULL AUTO_INCREMENT COMMENT '工资id',
  `employeeObj` varchar(30)  NOT NULL COMMENT '员工',
  `year` int(11) NOT NULL COMMENT '工资年份',
  `month` int(11) NOT NULL COMMENT '工资月份',
  `salaryMoney` float NOT NULL COMMENT '工资金额',
  `giveDate` varchar(20)  NULL COMMENT '发放日期',
  `salaryMemo` varchar(500)  NULL COMMENT '工资备注',
  PRIMARY KEY (`salaryId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

ALTER TABLE t_oldMan ADD CONSTRAINT FOREIGN KEY (userObj) REFERENCES t_userInfo(user_name);
ALTER TABLE t_room ADD CONSTRAINT FOREIGN KEY (roomTypeObj) REFERENCES t_roomType(typeId);
ALTER TABLE t_roomOrder ADD CONSTRAINT FOREIGN KEY (roomObj) REFERENCES t_room(roomNo);
ALTER TABLE t_roomOrder ADD CONSTRAINT FOREIGN KEY (oldManObj) REFERENCES t_oldMan(oldManId);
ALTER TABLE t_employee ADD CONSTRAINT FOREIGN KEY (departmentObj) REFERENCES t_department(departmentId);
ALTER TABLE t_salary ADD CONSTRAINT FOREIGN KEY (employeeObj) REFERENCES t_employee(employeeNo);


