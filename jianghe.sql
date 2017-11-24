/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.6.31 : Database - jianghe
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`jianghe` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `jianghe`;

/*Table structure for table `address` */

DROP TABLE IF EXISTS `address`;

CREATE TABLE `address` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ch_alias` varchar(100) NOT NULL DEFAULT '',
  `area_code` varchar(20) NOT NULL DEFAULT '',
  `parent_code` varchar(20) NOT NULL DEFAULT '',
  `area_name` varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `areaCode` (`area_code`),
  KEY `parentCode` (`parent_code`)
) ENGINE=InnoDB AUTO_INCREMENT=46950 DEFAULT CHARSET=utf8;

/*Data for the table `address` */


/*Table structure for table `id_gen` */

DROP TABLE IF EXISTS `id_gen`;

CREATE TABLE `id_gen` (
  `id_key` varchar(100) NOT NULL DEFAULT '',
  `used_max_id` bigint(20) NOT NULL,
  `gmt_create` datetime DEFAULT NULL,
  `gmt_modify` datetime DEFAULT NULL,
  PRIMARY KEY (`id_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `id_gen` */

/*Table structure for table `lb_bank_card` */

DROP TABLE IF EXISTS `lb_bank_card`;

CREATE TABLE `lb_bank_card` (
  `card_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `out_merchant_id` int(11) NOT NULL COMMENT '外部商户号',
  `bank_code` varchar(32) DEFAULT '' COMMENT '银行代码',
  `bank_card_no` varchar(60) NOT NULL DEFAULT '' COMMENT '银行卡号',
  `bank_cert_name` varchar(256) DEFAULT '' COMMENT '当商户类型是“01 自然人”、“02 个人工商户”时，开户人与须与负责人名称一致；当商户类型是“03 企业商户”时，须与企业法人名称一致。',
  `account_type` varchar(20) NOT NULL DEFAULT '' COMMENT '账户类型 01对私账户 02对公账户',
  `contact_line` varchar(20) DEFAULT NULL COMMENT '联行号。备注：全国联行号表',
  `branch_name` varchar(200) DEFAULT NULL COMMENT '开户支行名称',
  `branch_province` varchar(20) DEFAULT NULL COMMENT '开户行所在省份',
  `branch_city` varchar(20) DEFAULT NULL COMMENT '开户行所在市',
  `cert_type` varchar(20) DEFAULT NULL COMMENT '持卡人证件类型 01 身份证，对公账户可不填',
  `cert_no` varchar(200) DEFAULT NULL COMMENT '证件号',
  `card_holder_addr` varchar(200) DEFAULT NULL COMMENT '持卡人地址',
  `status` varchar(20) DEFAULT '' COMMENT '卡在系统中的状态 01正常 02弃用',
  `ext_prop` varchar(200) DEFAULT NULL COMMENT '扩展字段',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lb_bank_card` */

/*Table structure for table `lb_bill` */

DROP TABLE IF EXISTS `lb_bill`;

CREATE TABLE `lb_bill` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `trade_id` int(11) DEFAULT NULL COMMENT '外部商户订单号',
  `trade_num` varchar(100) DEFAULT NULL COMMENT '第三方平台的交易号',
  `biz_type` int(11) DEFAULT NULL COMMENT '业务类型：1 交易 2 退款',
  `goods_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
  `trade_amount` int(11) DEFAULT NULL COMMENT '订单金额',
  `receive_amount` int(11) DEFAULT NULL COMMENT '交易实收金额',
  `discount_amount` int(11) DEFAULT NULL COMMENT '优惠金额',
  `hb_discount` int(11) DEFAULT NULL COMMENT '红包抵扣',
  `fee_amount` int(11) DEFAULT NULL COMMENT '服务费',
  `card_amount` int(11) DEFAULT NULL COMMENT '卡消费金额',
  `trade_create_time` datetime DEFAULT NULL COMMENT '交易创建时间',
  `trade_time` datetime DEFAULT NULL COMMENT '交易完成时间',
  `jfb_discount` int(11) DEFAULT NULL COMMENT '集分宝抵扣',
  `refund_num` varchar(11) DEFAULT NULL COMMENT '退款批次号',
  `fenrun` int(11) DEFAULT NULL COMMENT '分润',
  `operator_id` varchar(20) DEFAULT NULL COMMENT '操作员id',
  `buyer_account` varchar(100) DEFAULT NULL COMMENT '对方账号',
  `store_name` varchar(100) DEFAULT NULL COMMENT '交易门店',
  `terminal_id` varchar(11) DEFAULT NULL COMMENT '终端号',
  `quan_amount` int(11) DEFAULT NULL COMMENT '券核销金额',
  `merchant_hb_amount` int(11) DEFAULT NULL COMMENT '商家红包金额',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lb_bill` */

/*Table structure for table `lb_bill_config` */

DROP TABLE IF EXISTS `lb_bill_config`;

CREATE TABLE `lb_bill_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL COMMENT '账单名称',
  `config` varchar(1024) DEFAULT NULL COMMENT 'json格式，配置了每个字段，及该字段来源哪个模型：商户，交易，业务账单',
  `status` varchar(20) NOT NULL COMMENT 'ACTIVE 正常  DELETE 删除 DEACTIVE 暂停',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='清算账单配置表';

/*Data for the table `lb_bill_config` */

/*Table structure for table `lb_bill_merchant` */

DROP TABLE IF EXISTS `lb_bill_merchant`;

CREATE TABLE `lb_bill_merchant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bill_date` date NOT NULL COMMENT '清算日期',
  `merchant_id` varchar(255) NOT NULL DEFAULT '' COMMENT '系统商户号',
  `bank_merchant_id` varchar(255) NOT NULL DEFAULT '' COMMENT '银行商户号',
  `trade_count` int(11) NOT NULL DEFAULT '0' COMMENT '交易量',
  `trade_amount` int(11) DEFAULT NULL COMMENT '交易金额',
  `refund_count` int(11) DEFAULT NULL COMMENT '退款量',
  `refund_amount` int(11) DEFAULT NULL COMMENT '退款金额',
  `service_amount` int(11) DEFAULT NULL COMMENT '服务费',
  `bill_amount` int(11) DEFAULT NULL COMMENT '清算金额',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `bill_date` (`bill_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商户清算资金表';

/*Data for the table `lb_bill_merchant` */

/*Table structure for table `lb_bill_order` */

DROP TABLE IF EXISTS `lb_bill_order`;

CREATE TABLE `lb_bill_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bill_date` date NOT NULL COMMENT '清算日期',
  `merchant_id` varchar(255) NOT NULL DEFAULT '' COMMENT '系统商户号',
  `bank_merchant_id` varchar(255) NOT NULL DEFAULT '' COMMENT '银行商户号',
  `trade_id` varchar(128) NOT NULL COMMENT '商户交易号',
  `out_trade_id` varchar(128) DEFAULT NULL COMMENT '第三方平台的交易号',
  `pay_client` varchar(20) NOT NULL DEFAULT '' COMMENT '支付渠道 ALIPAY 支付宝 WECHAT微信',
  `biz_type` varchar(20) NOT NULL DEFAULT '' COMMENT '业务类型：1 交易 2 退款',
  `trade_time` datetime DEFAULT NULL COMMENT '交易完成时间',
  `trade_amount` varchar(20) DEFAULT NULL COMMENT '订单金额',
  `receive_amount` varchar(20) DEFAULT NULL COMMENT '交易实收金额',
  `discount_amount` varchar(20) DEFAULT NULL COMMENT '优惠金额',
  `fee_amount` varchar(20) DEFAULT NULL COMMENT '服务费',
  `fenrun` varchar(20) DEFAULT NULL COMMENT '分润',
  `pay_fee_rate` varchar(20) DEFAULT NULL COMMENT '银行服务费率',
  `refund_num` varchar(11) DEFAULT NULL COMMENT '退款批次号',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商户清算订单表';

/*Data for the table `lb_bill_order` */

/*Table structure for table `lb_bill_trace` */

DROP TABLE IF EXISTS `lb_bill_trace`;

CREATE TABLE `lb_bill_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bill_date` date NOT NULL COMMENT '清算日期',
  `status` varchar(20) NOT NULL DEFAULT '' COMMENT '清算单状态。 WAIT:待清算，SUCCESS:成功，FAIL:清算失败，REC_FAIL:对账失败，NO_TRADE:当日无交易',
  `retry_flag` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可以重新生成。T：可以 F：不可以',
  `file_path` varchar(256) NOT NULL DEFAULT '' COMMENT '账单SFTP文件名',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `bill_date` (`bill_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='清算单生成表';

/*Data for the table `lb_bill_trace` */

/*Table structure for table `lb_bill_trace_line` */

DROP TABLE IF EXISTS `lb_bill_trace_line`;

CREATE TABLE `lb_bill_trace_line` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bill_trace_id` bigint(20) NOT NULL COMMENT '清算单生成号,外键依赖bill_trace的主键',
  `bill_config_id` int(11) NOT NULL COMMENT '清算单配置号',
  `bill_date` date NOT NULL COMMENT '清算日期',
  `status` varchar(20) NOT NULL DEFAULT '' COMMENT '清算单状态。 01:可下载，02:已经删除',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='清算流水表';

/*Data for the table `lb_bill_trace_line` */

/*Table structure for table `lb_fee_config` */

DROP TABLE IF EXISTS `lb_fee_config`;

CREATE TABLE `lb_fee_config` (
  `fee_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '费率id',
  `out_merchant_id` int(11) NOT NULL COMMENT '外部商户号',
  `channel_type` varchar(20) NOT NULL DEFAULT '' COMMENT '支付渠道 01 支付宝 02微信',
  `fee_value` varchar(20) NOT NULL DEFAULT '' COMMENT '费率，如 0.006',
  `fee_type` varchar(20) DEFAULT NULL COMMENT '01 T0收单手续费  02 T1收单手续费',
  `ext_prop` varchar(200) DEFAULT NULL COMMENT '扩展字段',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`fee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lb_fee_config` */

/*Table structure for table `lb_merchant` */

DROP TABLE IF EXISTS `lb_merchant`;

CREATE TABLE `lb_merchant` (
  `out_merchant_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '外部商户号',
  `mybank_qid` varchar(100) DEFAULT '' COMMENT '网商进件查询id',
  `merchant_id` varchar(100) DEFAULT '' COMMENT '第三方支付公司返回的商户号',
  `merchant_type` varchar(20) NOT NULL DEFAULT '' COMMENT '商户类型：01：自然人，02：个体工商户，03：企业商户',
  `merchant_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商户名称',
  `merchant_alias` varchar(255) NOT NULL DEFAULT '',
  `deal_type` varchar(20) DEFAULT NULL COMMENT '商户经营类型。可选值：01:实体特约商户  02:网络特约商户 03:实体兼网络特约商户',
  `support_prepayment` varchar(20) DEFAULT NULL COMMENT '商户清算资金是否支持T+0到账。可选值：Y：支持 (企业商户暂不支持垫资) N：不支持 ',
  `settle_mode` varchar(20) DEFAULT NULL COMMENT '结算方式',
  `pay_channel` varchar(20) DEFAULT NULL COMMENT '支持支付渠道列表。该商户能支持的第三方支付渠道。多个用逗号隔开。可选值 01 支付宝 02 微信',
  `denied_pay` varchar(20) DEFAULT NULL COMMENT '禁用支付方式 逗号隔开 可选值：02：信用卡 03：花呗 仅支付宝，微信支付刷卡支付模式无法禁用信用卡支付。',
  `principal_antid` varchar(100) NOT NULL DEFAULT '' COMMENT '商户老板的支付宝账号id',
  `principal_person` varchar(100) NOT NULL DEFAULT '' COMMENT '老板姓名',
  `principal_mobile` varchar(50) NOT NULL DEFAULT '',
  `trade_type` varchar(20) DEFAULT NULL COMMENT '支付方式：01正扫交易 02 反扫交易 03 退款交易 ，逗号隔开',
  `status` varchar(20) NOT NULL DEFAULT '' COMMENT '商户状态。 01:申请中，02正常  03 停用',
  `mcc` varchar(100) NOT NULL DEFAULT '' COMMENT '经营类目',
  `ext_prop` varchar(500) DEFAULT NULL COMMENT '扩展字段',
  `source_id` varchar(100) DEFAULT NULL COMMENT '商户来源标识id，入驻支付宝ISV分润需要',
  `operator_id` int(11) DEFAULT NULL COMMENT '银行/isv 操作者id。',
  `enable_refund` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否开启退款',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`out_merchant_id`),
  UNIQUE KEY `name` (`merchant_name`),
  UNIQUE KEY `principal` (`principal_mobile`,`principal_person`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lb_merchant` */

/*Table structure for table `lb_merchant_detail` */

DROP TABLE IF EXISTS `lb_merchant_detail`;

CREATE TABLE `lb_merchant_detail` (
  `out_merchant_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '外部商户号',
  `merchant_name` varchar(255) NOT NULL DEFAULT '' COMMENT '商户名',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT '商户简称',
  `contact_name` varchar(100) DEFAULT NULL COMMENT '商户联系人姓名',
  `contact_mobile` varchar(20) DEFAULT '' COMMENT '联系人电话号码',
  `contact_email` varchar(100) DEFAULT NULL COMMENT '联系人邮箱',
  `contact_type` varchar(20) DEFAULT NULL COMMENT '支付宝入驻需要 01 法人，02 负责人，03 代理人 04 其他',
  `contact_phone` varchar(20) DEFAULT NULL COMMENT '联系人手机',
  `address` varchar(200) DEFAULT NULL COMMENT '商户地址',
  `province` varchar(20) DEFAULT NULL COMMENT '省份',
  `city` varchar(20) DEFAULT NULL COMMENT '城市',
  `district` varchar(20) DEFAULT NULL COMMENT '区或者县code',
  `service_phone` varchar(20) DEFAULT NULL COMMENT '客服电话',
  `legal_person` varchar(50) DEFAULT NULL COMMENT '法人姓名，自然人或个人工商户无须上送。',
  `principal_person` varchar(50) DEFAULT NULL COMMENT '负责人姓名，企业可不上送',
  `principal_mobile` varchar(20) DEFAULT NULL COMMENT '负责人电话号码',
  `principal_cert_type` varchar(20) DEFAULT NULL COMMENT '负责人证件类型：01身份证',
  `principal_cert_no` varchar(100) DEFAULT NULL COMMENT '证件号',
  `cert_photo_a` varchar(500) DEFAULT NULL COMMENT '证件正面照url',
  `cert_photo_b` varchar(500) DEFAULT NULL COMMENT '证件反面照url',
  `cert_org_code` varchar(200) DEFAULT NULL COMMENT '组织机构代码证号',
  `other_bank_card_no` varchar(100) DEFAULT NULL COMMENT '结算到余利宝时，二类户开通绑定的银行卡号',
  `buss_license_type` varchar(20) DEFAULT NULL COMMENT '商户证件类型',
  `buss_auth_num` varchar(200) DEFAULT NULL COMMENT '营业执照工商注册号。若商户类型为“自然人”无需上送。',
  `license_photo` varchar(500) DEFAULT NULL COMMENT '营业执照图片，自然人无需上送',
  `prg_photo` varchar(500) DEFAULT NULL COMMENT '组织机构代码证图片，自然人无需上送',
  `industry_license_photo` varchar(500) DEFAULT NULL COMMENT '开户许可证照片，自然人无需上送',
  `shop_photo` varchar(500) DEFAULT NULL COMMENT '门头照',
  `ext_prop` varchar(200) DEFAULT NULL COMMENT '扩展字段',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`out_merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lb_merchant_detail` */

/*Table structure for table `lb_mybank_business_trans` */

DROP TABLE IF EXISTS `lb_mybank_business_trans`;

CREATE TABLE `lb_mybank_business_trans` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `out_merchant_id` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT 'ISV为商户生成的外部商户号',
  `trade_no` varchar(128) CHARACTER SET utf8 NOT NULL COMMENT '外部交易号',
  `business_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '业务类型：\n1. 网商银行开户\n2. 商户进件\n3. 余利宝开通\n4. 余利宝交易\n5. 换手机\n6. 换银行卡\n7. 商户开启\n8. 商户关闭',
  `result` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '业务办理结果S/F',
  `result_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '结果码',
  `result_code_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '结果描述',
  `create_person` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Data for the table `lb_mybank_business_trans` */

/*Table structure for table `lb_mybank_yulibao_trade_order` */

DROP TABLE IF EXISTS `lb_mybank_yulibao_trade_order`;

CREATE TABLE `lb_mybank_yulibao_trade_order` (
  `id` bigint(10) NOT NULL AUTO_INCREMENT COMMENT '系统内部业务号（自增）',
  `merchant_id` varchar(64) NOT NULL COMMENT '网商银行生成的商户号',
  `trade_no` varchar(64) NOT NULL COMMENT '系统订单号',
  `order_no` varchar(64) DEFAULT NULL COMMENT '网商银行业务流水号',
  `fund_code` varchar(32) NOT NULL DEFAULT '001529' COMMENT '基金代码\n只有001592',
  `amount` int(15) NOT NULL COMMENT '申购金额。消费币种的最小货币单位（分）',
  `currency` varchar(32) NOT NULL COMMENT '消费金额的币种。只支持人民币：CNY。',
  `type` varchar(32) NOT NULL COMMENT '业务类型：\n1. 申购\n2. 赎回',
  `status` varchar(64) NOT NULL COMMENT '业务状态\n1. 受理成功\n2. 受理中\n3. 受理失败',
  `remark` varchar(64) DEFAULT NULL COMMENT '受理结果备注',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='余利宝交易表';

/*Data for the table `lb_mybank_yulibao_trade_order` */

/*Table structure for table `lb_operate_log` */

DROP TABLE IF EXISTS `lb_operate_log`;

CREATE TABLE `lb_operate_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '操作类型 01 商户入驻 02 商户修改 03 商户关闭 04 商户开启 05 交易修改',
  `mod_content` text NOT NULL COMMENT '修改内容',
  `operator_id` varchar(50) NOT NULL DEFAULT '' COMMENT '操作员id',
  `mod_target_id` varchar(50) NOT NULL DEFAULT '' COMMENT '操作对象的id',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lb_operate_log` */

/*Table structure for table `lb_staff` */

DROP TABLE IF EXISTS `lb_staff`;

CREATE TABLE `lb_staff` (
  `staff_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '员工id',
  `staff_name` varchar(100) NOT NULL DEFAULT '' COMMENT '员工姓名',
  `role` varchar(20) NOT NULL DEFAULT '' COMMENT '员工角色 01 负责人 02 小二',
  `out_merchant_id` int(11) NOT NULL COMMENT '外部商户号',
  `store_id` int(11) DEFAULT NULL COMMENT '门店id',
  `permissions` varchar(100) DEFAULT NULL COMMENT '赋有的权限。01 退款权限',
  `ant_account` varchar(100) NOT NULL DEFAULT '' COMMENT '支付宝账号',
  `ant_id` varchar(100) NOT NULL DEFAULT '' COMMENT '支付宝id',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `status` varchar(20) NOT NULL DEFAULT '' COMMENT '01 申请加入 02 加入门店 ',
  `ext_prop` varchar(200) DEFAULT NULL COMMENT '扩展字段',
  `deleted` varchar(20) DEFAULT NULL COMMENT '被删除了！状态位! 0-未删除 1-已删除',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lb_staff` */

/*Table structure for table `lb_store` */

DROP TABLE IF EXISTS `lb_store`;

CREATE TABLE `lb_store` (
  `store_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '门店id',
  `store_name` varchar(200) NOT NULL DEFAULT '' COMMENT '门店名称',
  `out_merchant_id` int(11) NOT NULL COMMENT '外部商户号',
  `cashier_qrcode` varchar(1000) DEFAULT NULL COMMENT '门店收银码信息',
  `ext_prop` varchar(200) DEFAULT NULL COMMENT '扩展字段',
  `deleted` varchar(20) DEFAULT NULL COMMENT '被删除了！状态位! 0-未删除 1-已删除',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lb_store` */

/*Table structure for table `lb_sys_config` */

DROP TABLE IF EXISTS `lb_sys_config`;

CREATE TABLE `lb_sys_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `app_id` varchar(100) NOT NULL DEFAULT '' COMMENT '第三方平台创建的应用id',
  `pid` varchar(100) DEFAULT NULL COMMENT '蚂蚁开放平台需要的商家PID',
  `secret_key` text NOT NULL COMMENT '数据加签时使用的私钥',
  `public_key` text COMMENT '数据验签时使用的平台的公钥',
  `ext_prop` varchar(200) DEFAULT NULL COMMENT '扩展字段',
  `isv_org_id` varchar(100) DEFAULT NULL COMMENT '网商版使用',
  `type` varchar(20) DEFAULT NULL COMMENT '01：银行 02：ISV  03：网商',
  `create_person` varchar(128) DEFAULT '' COMMENT '创建操作人',
  `modified_person` varchar(128) DEFAULT '' COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `config_type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lb_sys_config` */

/*Table structure for table `lb_trade_alipay_bill` */

DROP TABLE IF EXISTS `lb_trade_alipay_bill`;

CREATE TABLE `lb_trade_alipay_bill` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `trade_id` varchar(100) DEFAULT NULL COMMENT '外部商户订单号',
  `ant_trade_id` varchar(100) DEFAULT NULL COMMENT '第三方平台的交易号',
  `biz_type` varchar(20) DEFAULT NULL COMMENT '业务类型：1 交易 2 退款',
  `goods_name` varchar(2000) DEFAULT NULL COMMENT '商品名称',
  `trade_amount` varchar(50) DEFAULT NULL COMMENT '订单金额',
  `receive_amount` varchar(50) DEFAULT NULL COMMENT '交易实收金额',
  `discount_amount` varchar(50) DEFAULT NULL COMMENT '优惠金额',
  `hb_discount` varchar(50) DEFAULT NULL COMMENT '支付宝红包抵扣',
  `fee_amount` varchar(50) DEFAULT NULL COMMENT '服务费',
  `card_amount` varchar(50) DEFAULT NULL COMMENT '卡消费金额',
  `trade_create_time` datetime DEFAULT NULL COMMENT '交易创建时间',
  `trade_time` datetime DEFAULT NULL COMMENT '交易完成时间',
  `jfb_discount` varchar(50) DEFAULT NULL COMMENT '集分宝抵扣',
  `refund_num` varchar(50) DEFAULT NULL COMMENT '退款批次号',
  `fenrun` varchar(50) DEFAULT NULL COMMENT '分润',
  `operator_id` varchar(20) DEFAULT NULL COMMENT '操作员id',
  `buyer_account` varchar(100) DEFAULT NULL COMMENT '对方账号',
  `store_id` varchar(50) DEFAULT NULL COMMENT '门店编号',
  `store_name` varchar(100) DEFAULT NULL COMMENT '交易门店',
  `terminal_id` varchar(50) DEFAULT NULL COMMENT '终端号',
  `quan_amount` varchar(50) DEFAULT NULL COMMENT '券核销金额',
  `quan_name` varchar(200) DEFAULT NULL COMMENT '券名称',
  `merchant_hb_amount` varchar(50) DEFAULT NULL COMMENT '商家红包金额',
  `merchant_discount_amount` varchar(50) DEFAULT NULL COMMENT '商家优惠',
  `comment` varchar(2000) DEFAULT NULL COMMENT '备注',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支付宝下载的业务账单表';

/*Data for the table `lb_trade_alipay_bill` */

/*Table structure for table `lb_trade_invoke_api_record` */

DROP TABLE IF EXISTS `lb_trade_invoke_api_record`;

CREATE TABLE `lb_trade_invoke_api_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint(20) NOT NULL COMMENT '订单号',
  `request_no` varchar(256) DEFAULT NULL COMMENT '请求号（只有退款有）',
  `invoke_type` varchar(256) DEFAULT NULL COMMENT '接口调用类型（支付、退款、撤销）',
  `invoke_state` varchar(256) DEFAULT NULL COMMENT '接口调用状态（未调用、调用成功、调用失败、调用异常）',
  `remark` varchar(2048) DEFAULT NULL COMMENT '备注信息',
  `create_person` varchar(128) DEFAULT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) DEFAULT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易外部接口调用日志，出现单边账时用来做异常对账';

/*Data for the table `lb_trade_invoke_api_record` */

/*Table structure for table `lb_trade_money_trace` */

DROP TABLE IF EXISTS `lb_trade_money_trace`;

CREATE TABLE `lb_trade_money_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '流水主键',
  `order_id` bigint(20) NOT NULL COMMENT '订单号',
  `trade_no` varchar(128) DEFAULT NULL COMMENT '商户交易号',
  `request_no` varchar(256) DEFAULT NULL COMMENT '请求号（只有退款有）',
  `trace_type` varchar(256) DEFAULT NULL COMMENT '流水类型（付款、退款）',
  `change_amount` int(11) NOT NULL DEFAULT '0' COMMENT '变动金额（单位：分）',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金流水表';

/*Data for the table `lb_trade_money_trace` */

/*Table structure for table `lb_trade_mybank_bill` */

DROP TABLE IF EXISTS `lb_trade_mybank_bill`;

CREATE TABLE `lb_trade_mybank_bill` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `mybank_merchant_id` varchar(100) DEFAULT '' COMMENT '网商银行的商户号',
  `mybank_trade_no` varchar(128) DEFAULT NULL COMMENT '网商银行的订单号',
  `trade_no` varchar(128) DEFAULT NULL COMMENT '商户订单号',
  `biz_type` varchar(20) DEFAULT NULL COMMENT '交易类型：交易 退款',
  `currency_type` varchar(128) DEFAULT NULL COMMENT '货币种类',
  `rade_amount` varchar(50) DEFAULT NULL COMMENT '交易金额',
  `pay_fee_rate` varchar(50) DEFAULT NULL COMMENT '手续费费率',
  `fee_amount` varchar(50) DEFAULT NULL COMMENT '手续费',
  `clear_amount` varchar(50) DEFAULT NULL COMMENT '清算金额',
  `origin_mybank_trade_no` varchar(128) DEFAULT NULL COMMENT '原网商银行的订单号',
  `trade_finish_time` datetime DEFAULT NULL COMMENT '订单完成时间',
  `comment` varchar(2000) DEFAULT NULL COMMENT '备注',
  `settle_type` varchar(20) DEFAULT NULL COMMENT '分账类型：T0 T1',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网商银行下载的业务账单表';

/*Data for the table `lb_trade_mybank_bill` */

/*Table structure for table `lb_trade_order` */

DROP TABLE IF EXISTS `lb_trade_order`;

CREATE TABLE `lb_trade_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `trade_no` varchar(128) DEFAULT NULL COMMENT '商户交易号',
  `third_party_trade_no` varchar(128) DEFAULT NULL COMMENT '第三方支付平台订单号',
  `mybank_order_no` varchar(128) DEFAULT NULL COMMENT '网商平台订单号',
  `product_name` varchar(256) DEFAULT NULL COMMENT '商品名称',
  `order_state` varchar(32) DEFAULT NULL COMMENT '订单状态',
  `refund_state` varchar(32) NOT NULL COMMENT '退款状态',
  `out_merchant_id` varchar(128) NOT NULL COMMENT '商户标识号',
  `merchant_name` varchar(128) NOT NULL COMMENT '商户名称',
  `sub_merchant_id` varchar(128) NOT NULL COMMENT '支付宝子商户号',
  `store_id` varchar(128) NOT NULL COMMENT '店铺标识号',
  `store_name` varchar(128) NOT NULL COMMENT '店铺名称',
  `order_payer` varchar(128) DEFAULT NULL COMMENT '订单付款方',
  `original_amount` int(11) NOT NULL DEFAULT '0' COMMENT '交易原始金额（单位：分）',
  `pay_client` varchar(32) DEFAULT NULL COMMENT '支付扫码端',
  `pay_amount` int(11) NOT NULL DEFAULT '0' COMMENT '实际支付金额（单位：分）',
  `pay_fee_rate` decimal(5,3) NOT NULL DEFAULT '0.000' COMMENT '支付费率',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `already_refund_amount` int(11) NOT NULL DEFAULT '0' COMMENT '已退款金额（单位：分）',
  `last_refund_time` datetime DEFAULT NULL COMMENT '退款时间',
  `check_bill_state` varchar(32) DEFAULT NULL COMMENT '对账状态',
  `check_bill_remark` varchar(32) DEFAULT NULL COMMENT '对账备注',
  `settle_type` varchar(32) DEFAULT NULL COMMENT '清算方式',
  `order_type` varchar(32) DEFAULT NULL,
  `device_create_ip` varchar(256) DEFAULT NULL COMMENT '订单生成的机器IP',
  `ext_prop` varchar(2048) DEFAULT NULL COMMENT '扩展字段',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `trade_no` (`trade_no`),
  KEY `idx_trade_order_trade_no` (`trade_no`),
  KEY `idx_trade_order_merchant_name` (`merchant_name`),
  KEY `idx_trade_order_out_merchant_id` (`out_merchant_id`),
  KEY `idx_trade_order_store_id` (`store_id`),
  KEY `idx_trade_order_order_state` (`order_state`),
  KEY `idx_trade_order_refund_state` (`refund_state`),
  KEY `idx_trade_order_pay_client` (`pay_client`),
  KEY `idx_trade_order_pay_time` (`pay_time`),
  KEY `idx_trade_order_gmt_create` (`gmt_create`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';

/*Data for the table `lb_trade_order` */

/*Table structure for table `lb_trade_stat_info` */

DROP TABLE IF EXISTS `lb_trade_stat_info`;

CREATE TABLE `lb_trade_stat_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `out_merchant_id` varchar(256) NOT NULL COMMENT '商户号',
  `store_id` varchar(256) NOT NULL COMMENT '门店号',
  `stat_date` datetime NOT NULL COMMENT '统计日',
  `order_num` int(11) NOT NULL DEFAULT '0' COMMENT '订单数量',
  `paid_amount` int(11) NOT NULL DEFAULT '0' COMMENT '支付成功订单总金额',
  `create_person` varchar(128) DEFAULT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) DEFAULT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易信息统计表';

/*Data for the table `lb_trade_stat_info` */

/*Table structure for table `lb_user` */

DROP TABLE IF EXISTS `lb_user`;

CREATE TABLE `lb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `username` varchar(128) NOT NULL COMMENT '用户名 唯一',
  `password` varchar(128) NOT NULL COMMENT '密码，MD5值',
  `role` varchar(128) DEFAULT NULL COMMENT '角色 1：技术人员，2：业务人员',
  `permission` varchar(128) DEFAULT NULL COMMENT '附加权限',
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否可用',
  `create_person` varchar(128) NOT NULL COMMENT '创建操作人',
  `modified_person` varchar(128) NOT NULL COMMENT '修改操作人',
  `gmt_create` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uni_key_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `lb_user` */

insert  into `lb_user`(`id`,`username`,`password`,`role`,`permission`,`enabled`,`create_person`,`modified_person`,`gmt_create`,`gmt_modified`) values (1,'chark','9UbdA+Z/61HB5yOu8s0b/A==','ADMIN',NULL,1,'SYSTEM','SYSTEM','2017-06-22 15:10:50','2017-07-20 16:58:10'),(2,'hope','9UbdA+Z/61HB5yOu8s0b/A==','TEC',NULL,1,'SYSTEM','SYSTEM','2017-06-22 15:15:26','2017-07-19 14:47:12'),(3,'simon','H1wd3V3YcDbYv0hucYZ7NA==','BIZ',NULL,1,'SYSTEM','SYSTEM','2017-06-26 18:29:46','2017-07-20 18:20:18'),(4,'tttt','OcfGSfd2UymJ7rWmb8V34g==','ADMIN',NULL,1,'SYSTEM','SYSTEM','2017-06-22 15:15:26','2017-07-20 17:18:02'),(8,'sage','08WYUQiSdrPIuuSp6xuwZA==','ADMIN',NULL,1,'SYSTEM','SYSTEM','2017-07-21 15:10:28','2017-07-21 15:10:28'),(9,'tech','9UbdA+Z/61HB5yOu8s0b/A==','TEC',NULL,1,'SYSTEM','SYSTEM','2017-07-24 09:58:01','2017-07-24 09:58:16'),(10,'test1','9UbdA+Z/61HB5yOu8s0b/A==','BIZ',NULL,1,'SYSTEM','SYSTEM','2017-07-24 10:13:53','2017-07-24 10:14:06'),(11,'test2','9UbdA+Z/61HB5yOu8s0b/A==','BIZ',NULL,1,'SYSTEM','SYSTEM','2017-07-24 10:13:53','2017-07-24 10:14:06'),(12,'test3','9UbdA+Z/61HB5yOu8s0b/A==','BIZ',NULL,1,'SYSTEM','SYSTEM','2017-07-24 10:13:53','2017-07-24 10:14:06'),(13,'test4','9UbdA+Z/61HB5yOu8s0b/A==','BIZ',NULL,1,'SYSTEM','SYSTEM','2017-07-24 10:14:31','2017-07-24 10:14:47'),(14,'test5','9UbdA+Z/61HB5yOu8s0b/A==','BIZ',NULL,1,'SYSTEM','SYSTEM','2017-07-24 10:14:31','2017-07-24 10:14:47'),(15,'test6','9UbdA+Z/61HB5yOu8s0b/A==','BIZ',NULL,1,'SYSTEM','SYSTEM','2017-07-24 10:14:31','2017-07-24 10:14:47'),(16,'test8','9UbdA+Z/61HB5yOu8s0b/A==','BIZ',NULL,1,'SYSTEM','SYSTEM','2017-07-24 10:15:09','2017-07-24 10:15:33'),(17,'test7','9UbdA+Z/61HB5yOu8s0b/A==','BIZ',NULL,1,'SYSTEM','SYSTEM','2017-07-24 10:14:31','2017-07-24 10:14:47'),(18,'test9','9UbdA+Z/61HB5yOu8s0b/A==','BIZ',NULL,1,'SYSTEM','SYSTEM','2017-07-24 10:14:31','2017-07-24 10:14:47'),(19,'test10','Tr+kBTTAoDv5/J2Nw031rA==','BIZ',NULL,1,'SYSTEM','SYSTEM','2017-07-24 10:14:31','2017-07-27 14:40:46'),(20,'testTrans','9UbdA+Z/61HB5yOu8s0b/A==','BIZ',NULL,1,'SYSTEM','SYSTEM','2017-07-26 18:01:43','2017-07-26 18:01:43');

/*Table structure for table `link` */

DROP TABLE IF EXISTS `link`;

CREATE TABLE `link` (
  `linkId` varchar(50) NOT NULL,
  `linkClass` varchar(100) DEFAULT NULL COMMENT '链接分类，表示该链接是属于哪个功能模块的\n\n信息系统  \\  成绩查询  \\  友情链接',
  `linkName` varchar(100) DEFAULT NULL,
  `linkContent` varchar(1000) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`linkId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='链接管理';

/*Data for the table `link` */

insert  into `link`(`linkId`,`linkClass`,`linkName`,`linkContent`,`updatetime`) values ('0822b06d-c1cd-11e6-956b-00ac7dc2f176','成绩查询','aao.neu.edu.cn/','本科生成绩查询','2016-12-14 15:15:03'),('098a5c8f-c1cc-11e6-956b-00ac7dc2f176','友情链接','http://neu.edu.cn','东北大学官网','2016-12-14 15:07:56'),('0ef31455-f255-11e6-8689-005056bf3cd7','友情链接','http://music.163.com/#/playlist?id=68090512','G000000D','2017-02-14 09:30:13'),('146e0fab-f256-11e6-8689-005056bf3cd7','友情链接','http://aao.neu.edu.cn/','东北大学教务处','2017-02-14 09:37:32'),('1c5ec273-f254-11e6-8689-005056bf3cd7','友情链接','http://www.eeeetop.com/','E拓建筑网','2017-02-14 09:23:26'),('2fe29eb6-f256-11e6-8689-005056bf3cd7','友情链接','http://www.archdaily.com/','ArchiDaily','2017-02-14 09:38:18'),('34bba6a9-f255-11e6-8689-005056bf3cd7','友情链接','http://www.eeeetop.com/','E拓建筑网','2017-02-14 09:31:16'),('4543ff4f-f255-11e6-8689-005056bf3cd7','友情链接','http://music.163.com/#/playlist?id=68090512','G000000D','2017-02-14 09:31:44'),('502a9798-f256-11e6-8689-005056bf3cd7','友情链接','http://page.renren.com/601067753?checked=true','设计e周','2017-02-14 09:39:12'),('5e7c7496-f255-11e6-8689-005056bf3cd7','友情链接','http://www.graduate.neu.edu.cn/','东北大学研招网','2017-02-14 09:32:27'),('64e0ed3e-f199-11e6-8689-005056bf3cd7','信息系统','http://219.216.96.73/pyxx/login.aspx','东北大学研究生管理信息系统-学生服务端','2017-02-13 11:06:52'),('682204c4-f256-11e6-8689-005056bf3cd7','友情链接','http://www.foldcity.com/','褶子城市','2017-02-14 09:39:52'),('75957e07-f256-11e6-8689-005056bf3cd7','友情链接','http://www.archdaily.com/','ArchiDaily','2017-02-14 09:40:15'),('79f73c51-f255-11e6-8689-005056bf3cd7','友情链接','http://www.abbs.com.cn/bbs/','ABBS论坛','2017-02-14 09:33:13'),('80737839-f199-11e6-8689-005056bf3cd7','信息系统','http://219.216.96.73/gmis/login.aspx','东北大学研究生管理信息系统-教师服务端','2017-02-13 11:07:38'),('8ac24d9c-f256-11e6-8689-005056bf3cd7','友情链接','http://page.renren.com/601067753?checked=true','设计e周','2017-02-14 09:40:50'),('9b7c28ae-f256-11e6-8689-005056bf3cd7','友情链接','http://page.renren.com/601067753?checked=true','设计e周','2017-02-14 09:41:18'),('a0fc1792-f255-11e6-8689-005056bf3cd7','友情链接','http://www.abbs.com.cn/bbs/','建筑学院','2017-02-14 09:34:18'),('a7626dde-f256-11e6-8689-005056bf3cd7','友情链接','http://www.foldcity.com/','褶子城市','2017-02-14 09:41:38'),('a9b714f4-f71b-11e6-827e-005056bf3cd7','成绩查询','219.216.96.73/pyxx/login.aspx','研究生成绩查询','2017-02-20 11:21:33'),('ad7ffd10-f256-11e6-8689-005056bf3cd7','友情链接','http://www.foldcity.com/','褶子城市','2017-02-14 09:41:49'),('be419a8d-f255-11e6-8689-005056bf3cd7','友情链接','http://www.anzyu.com/','安之语','2017-02-14 09:35:07'),('cbd6886b-f254-11e6-8689-005056bf3cd7','友情链接','http://music.163.com/#/playlist?id=68090512','G000000D','2017-02-14 09:28:20'),('d0ea9f9c-f255-11e6-8689-005056bf3cd7','友情链接','http://www.abbs.com.cn/bbs/','ABBS论坛','2017-02-14 09:35:39'),('e1d2b6fd-f255-11e6-8689-005056bf3cd7','友情链接','http://219.216.96.25:8080/views/admin/login.form#','建筑学院','2017-02-14 09:36:07'),('ec6754d2-f255-11e6-8689-005056bf3cd7','友情链接','http://www.anzyu.com/','安之语','2017-02-14 09:36:25'),('eff82e62-f254-11e6-8689-005056bf3cd7','友情链接','http://jz.zhulong.com/','筑龙建筑网','2017-02-14 09:29:21'),('f3f9492d-f255-11e6-8689-005056bf3cd7','友情链接','http://www.anzyu.com/','安之语','2017-02-14 09:36:37'),('fcc01700-f254-11e6-8689-005056bf3cd7','友情链接','http://jz.zhulong.com/','筑龙建筑网','2017-02-14 09:29:43'),('fcec869e-f255-11e6-8689-005056bf3cd7','友情链接','http://219.216.96.25:8080/views/admin/login.form#','建筑学院','2017-02-14 09:36:52');

/*Table structure for table `modeltype` */

DROP TABLE IF EXISTS `modeltype`;

CREATE TABLE `modeltype` (
  `modelId` varchar(50) NOT NULL,
  `modelName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`modelId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='模块对应ID';

/*Data for the table `modeltype` */

insert  into `modeltype`(`modelId`,`modelName`) values ('029d3282-c03a-11e6-9c1a-00ac7dc2f176','人才引进管理'),('051e0cde-c343-11e6-99a5-00ac7dc2f176','图片轮播管理'),('0841f577-c03a-11e6-9c1a-00ac7dc2f176','学科建设管理'),('0b6dd167-0d3e-11e6-b867-0025b6dd0800','角色权限管理'),('0d4d30a9-0a0e-11e6-8cac-0025b6dd0800','系统用户管理'),('0f455850-c03a-11e6-9c1a-00ac7dc2f176','活动预告管理'),('10ba2215-c10e-11e6-a722-00ac7dc2f176','党委工作'),('11c805bb-c1a4-11e6-956b-00ac7dc2f176','本科生教学通知'),('172cfc68-c10e-11e6-a722-00ac7dc2f176','工会工作'),('19a94b63-c1a4-11e6-956b-00ac7dc2f176','本科生办事指南'),('1e18a75a-c10e-11e6-a722-00ac7dc2f176','教育管理'),('209a5989-c1a4-11e6-956b-00ac7dc2f176','本科生教学活动'),('20d06f13-c04e-11e6-9c1a-00ac7dc2f176','本科生培养'),('236cd752-c33b-11e6-af95-00ac7dc2f176','新闻图片修改'),('28fc0e36-c1a4-11e6-956b-00ac7dc2f176','本科生教学成果'),('2c659331-0d1a-11e6-b867-0025b6dd0800','菜单根目录'),('2e985dcf-c10e-11e6-a722-00ac7dc2f176','素质拓展管理'),('31aa405b-c1a4-11e6-956b-00ac7dc2f176','本科生优秀作业'),('399ca065-c10e-11e6-a722-00ac7dc2f176','指导服务管理'),('3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176','研究生培养'),('410f027e-c10e-11e6-a722-00ac7dc2f176','信息系统管理'),('4282d668-c1cb-11e6-956b-00ac7dc2f176','研究中心管理'),('4413ab1e-0a0e-11e6-8cac-0025b6dd0800','系统菜单管理'),('49471ece-c10e-11e6-a722-00ac7dc2f176','国际交流管理'),('4a3501b6-c1a5-11e6-956b-00ac7dc2f176','研究生教学活动'),('4a736c08-c04e-11e6-9c1a-00ac7dc2f176','成绩查询管理'),('4b444879-c1cb-11e6-956b-00ac7dc2f176','研究实验室管理'),('4fdbcf03-c10e-11e6-a722-00ac7dc2f176','国内交流管理'),('5103a139-c1a5-11e6-956b-00ac7dc2f176','研究生教学成果'),('561e0774-0a0d-11e6-8cac-0025b6dd0800','系统功能'),('57645378-c1a5-11e6-956b-00ac7dc2f176','研究生优秀作业'),('5c725a25-c10e-11e6-a722-00ac7dc2f176','校友交流管理'),('5db0147a-0a0e-11e6-8cac-0025b6dd0800','建筑学院管理'),('6920f298-c10e-11e6-a722-00ac7dc2f176','管理下载'),('7136725f-c10e-11e6-a722-00ac7dc2f176','教学下载'),('7386cd02-c04e-11e6-9c1a-00ac7dc2f176','学术委员会管理'),('75eefbdf-c031-11e6-9c1a-00ac7dc2f176','学院概况管理'),('76880a70-c266-11e6-b526-00ac7dc2f176','研究机构管理'),('76947a93-0d1a-11e6-b867-0025b6dd0800','系统角色管理'),('78828e95-c10e-11e6-a722-00ac7dc2f176','学术下载'),('7e5ecace-c031-11e6-9c1a-00ac7dc2f176','师资队伍管理'),('85d7b3be-c031-11e6-9c1a-00ac7dc2f176','教育教学管理'),('8c8b6966-c111-11e6-a722-00ac7dc2f176','表单模块管理'),('8d69760f-c031-11e6-9c1a-00ac7dc2f176','学术研究管理'),('8eafd5ae-c04e-11e6-9c1a-00ac7dc2f176','研究项目管理'),('9aca0083-c04e-11e6-9c1a-00ac7dc2f176','研究成果管理'),('9cc3727d-c031-11e6-9c1a-00ac7dc2f176','党群工作'),('9ed74c16-c1a4-11e6-956b-00ac7dc2f176','研究生教学通知'),('a36caad6-c037-11e6-9c1a-00ac7dc2f176','历史沿革管理'),('a3ebafec-c031-11e6-9c1a-00ac7dc2f176','学生工作'),('a5ab7b0a-c1a4-11e6-956b-00ac7dc2f176','研究生办事指南'),('ac16dcef-c031-11e6-9c1a-00ac7dc2f176','交流合作'),('b24c6336-c031-11e6-9c1a-00ac7dc2f176','下载专区管理'),('bc50fa33-fff6-11e6-9450-38d547ab495f','基层组织介绍'),('bd8ed368-c037-11e6-9c1a-00ac7dc2f176','学院简介沿革'),('cf031dce-8dec-11e6-b52b-085700e51ea8','专栏管理'),('d6447c13-c037-11e6-9c1a-00ac7dc2f176','学院领导管理'),('d763ea25-c1ca-11e6-956b-00ac7dc2f176','友情链接管理'),('d78fff10-c10c-11e6-a722-00ac7dc2f176','专职教师管理'),('db6bb42e-c42d-11e6-b626-00ac7dc2f176','教工信息填写'),('e3df07f5-c039-11e6-9c1a-00ac7dc2f176','通知公告管理'),('e4c2f87e-c037-11e6-9c1a-00ac7dc2f176','组织机构管理'),('e66b6864-c445-11e6-b626-00ac7dc2f176','教师信息管理'),('e91e9e81-c04d-11e6-9c1a-00ac7dc2f176','学位委员会管理'),('effbb7ef-c10c-11e6-a722-00ac7dc2f176','教工信息审核'),('f18f1f50-c039-11e6-9c1a-00ac7dc2f176','学院新闻管理'),('f4d9dac1-c446-11e6-b626-00ac7dc2f176','兼职教师管理'),('f51a61c8-c037-11e6-9c1a-00ac7dc2f176','大事记管理'),('f9f94fe6-c039-11e6-9c1a-00ac7dc2f176','学术活动管理'),('fb3e5125-c04d-11e6-9c1a-00ac7dc2f176','专业概况管理');

/*Table structure for table `news` */

DROP TABLE IF EXISTS `news`;

CREATE TABLE `news` (
  `newsId` varchar(45) CHARACTER SET utf8mb4 NOT NULL,
  `moduleType` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '新闻所属模块',
  `newsTitle` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '新闻标题/教师姓名',
  `newsClass` varchar(100) DEFAULT NULL COMMENT '新闻分类，某些模块下没有分类，则该字段为空',
  `newsDate` datetime DEFAULT NULL COMMENT '新闻日期',
  `newsIcon` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '新闻缩略图/教师照片',
  `newsAuthor` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '新闻作者',
  `newsDescribe` varchar(200) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '新闻描述',
  `isDelete` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '是否启用;是/否',
  `isTop` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '是否置顶:是/否',
  `newsContent` text CHARACTER SET utf8mb4 COMMENT '新闻内容/教师经历',
  `createMan` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `updateMan` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL,
  `updateDate` datetime DEFAULT NULL,
  `newsFile` varchar(2000) DEFAULT NULL COMMENT '下载专区的文件名称，其它新闻模块不需要该属性\n可以保存多个文件名，中间用 |  间隔开',
  `newsLevel` varchar(45) DEFAULT NULL COMMENT '级别\n按照学术论文、学术专著、科研奖励 等进行分类 有新新闻分类下没有再分类的就空着',
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='新闻';

/*Data for the table `news` */


/*Table structure for table `newsimg` */

DROP TABLE IF EXISTS `newsimg`;

CREATE TABLE `newsimg` (
  `id` varchar(60) NOT NULL,
  `imgLink` varchar(200) DEFAULT NULL COMMENT '图片链接',
  `imgName` varchar(200) DEFAULT NULL COMMENT '图片名字',
  `imgSort` varchar(200) DEFAULT NULL COMMENT '左 中 右',
  `updatetime` datetime DEFAULT NULL COMMENT '更改日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `newsimg` */

insert  into `newsimg`(`id`,`imgLink`,`imgName`,`imgSort`,`updatetime`) values ('0','img1_07.png','通知公告','左','2016-12-16 11:05:04'),('1','img2_07.png','学院新闻','中','2016-12-16 11:05:21'),('2','img3_07.png','学术活动','右','2016-12-16 11:05:29');

/*Table structure for table `organization` */

DROP TABLE IF EXISTS `organization`;

CREATE TABLE `organization` (
  `organizationId` varchar(50) NOT NULL COMMENT '组织ID',
  `organizationName` varchar(100) DEFAULT NULL COMMENT '组织名称',
  `organizationParentId` varchar(45) DEFAULT NULL COMMENT '父级组织ID',
  `organizationSort` int(11) DEFAULT NULL COMMENT '组织排序',
  PRIMARY KEY (`organizationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='组织机构';

/*Data for the table `organization` */

insert  into `organization`(`organizationId`,`organizationName`,`organizationParentId`,`organizationSort`) values ('00a63365-c297-11e6-b526-00ac7dc2f176','建筑系','cc63fb12-c279-11e6-b526-00ac7dc2f176',1),('045104b9-c297-11e6-b526-00ac7dc2f176','城乡规划系','cc63fb12-c279-11e6-b526-00ac7dc2f176',1),('081938cf-c297-11e6-b526-00ac7dc2f176','实验中心','cc63fb12-c279-11e6-b526-00ac7dc2f176',1),('0b458454-c297-11e6-b526-00ac7dc2f176','东亚城市与建筑研究中心','ee3fe800-c279-11e6-b526-00ac7dc2f176',1),('0e35d086-c297-11e6-b526-00ac7dc2f176','生态城镇与绿色建筑研究中心','ee3fe800-c279-11e6-b526-00ac7dc2f176',1),('2c659331-0d1a-11e6-b867-0025b6dd0800','江河建筑学院','',1),('4c3ac8c8-c290-11e6-b526-00ac7dc2f176','学院机关','2c659331-0d1a-11e6-b867-0025b6dd0800',1),('cc63fb12-c279-11e6-b526-00ac7dc2f176','基层学术组织','2c659331-0d1a-11e6-b867-0025b6dd0800',1),('ee3fe800-c279-11e6-b526-00ac7dc2f176','科研机构','2c659331-0d1a-11e6-b867-0025b6dd0800',1),('f77413fa-c296-11e6-b526-00ac7dc2f176','综合办公室','4c3ac8c8-c290-11e6-b526-00ac7dc2f176',1),('fd1e8917-c296-11e6-b526-00ac7dc2f176','学生工作办公室','4c3ac8c8-c290-11e6-b526-00ac7dc2f176',1);

/*Table structure for table `production` */

DROP TABLE IF EXISTS `production`;

CREATE TABLE `production` (
  `productionId` varchar(50) NOT NULL,
  `productionClass` varchar(50) DEFAULT NULL COMMENT '作品分类：设计、摄影、绘画、测绘',
  `moduleType` varchar(100) DEFAULT NULL COMMENT '作者类型：本科生、研究生',
  `productionAuthor` varchar(100) DEFAULT NULL COMMENT '作者',
  `productionName` varchar(100) DEFAULT NULL COMMENT '作品名称',
  `productionMemo` varchar(1000) DEFAULT NULL COMMENT '作品说明',
  `productionLink` varchar(100) DEFAULT NULL COMMENT '作品链接  （图片的文件名称）',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`productionId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生作品';

/*Data for the table `production` */

insert  into `production`(`productionId`,`productionClass`,`moduleType`,`productionAuthor`,`productionName`,`productionMemo`,`productionLink`,`createDate`) values ('07ef305b-f1af-11e6-8689-005056bf3cd7','摄影','31aa405b-c1a4-11e6-956b-00ac7dc2f176','马晓辉','生命馆','','20170213134145_814.jpg','2017-02-13 13:41:45'),('3a33fd0f-f1af-11e6-8689-005056bf3cd7','摄影','31aa405b-c1a4-11e6-956b-00ac7dc2f176','陈阳','文管楼','','20170213134309_669.jpg','2017-02-13 13:43:09'),('6809c8ef-f1ae-11e6-8689-005056bf3cd7','摄影','31aa405b-c1a4-11e6-956b-00ac7dc2f176','李清','东门丽影','','20170213133716_470.png','2017-02-13 13:37:17'),('9eabfced-c270-11e6-b526-00ac7dc2f176','摄影','57645378-c1a5-11e6-956b-00ac7dc2f176','韩思颖','摄影大赛',' 恭喜我院建筑系的学生韩思颖，在摄影大赛中获得第一名。','20170213141116_43.jpg','2016-12-15 10:46:03'),('9fbec0d3-c269-11e6-b526-00ac7dc2f176','设计','57645378-c1a5-11e6-956b-00ac7dc2f176','王萌萌','研究生数学建模',' 第十一届“华为杯”全国研究生数学建模竞赛在今年九月顺利举行，经评审委员会全体委员并特邀有关专家教授200人经过网上和集中评审两个阶段一个半月的评审，评选出拟获全国一、二、三等奖的参赛队，现予以公布。（名单见附件）\r\n现对有关事项作如下说明：\r\n一、请各校尽快核对学校名、队号和姓名，如果有误，请通过E-mail报gmcm@vip.163.com和zhudyseu@vip.163.com，以免奖状上出现错误。\r\n二、本次竞赛有4900研究生队提交论文，按竞赛章程，评选出一等奖120队（获奖比例为2.45%，队数已经随竞赛规模扩大，比去年增加20%），二等奖860队，(获一、二等奖队数总和占总参赛队数的20%)，三等奖1104队，总计2084队，获奖比例42.53%，其他队获成功参赛奖。\r\n三、自公布之日起十天内为公示期，接受举报和申诉，根据竞赛章程，举报应使用真实姓名、工作单位，一般不受理要求提高获奖级别的申诉。有关信件请寄天津大学研究生院或发邮件至zhudyseu@vip.163.com。\r\n四、全国研究生数学建模竞赛的宗旨是提高我国研究生的培养质量，增强研究生解决实际问题的能力，培养研究生在工作中的科学态度和严谨的学风。评审中我们发现个别论文有雷同现象，为严肃竞赛纪律，杜绝此类事件再次发生，特决定这几个队不予参加评奖。同时我们要求E题获一、二等奖研究生队检验自己的程序，其他各题拟获一等奖的参赛队在公示开始起十天之内对自己的论文进行复核，并将复核结果用邮件发到zhudyseuee@vip.163.com。邮件发送要求：若论文（包括程序）有细微变动，请将变动后的论文发送至zhudyseuee@vip.163.com（邮件主题格式：队号+题号+有变动；变动后的论文以附件形式发送），变动之处请以醒目形式突出以便专家复审；若论文（包括程序）无变动，也请回复至此邮箱zhudyseuee@vip.163.com（邮件主题格式：队号+题号+无变动）。\r\n全国研究生数学建模竞赛专家委员会\r\n2014年11月16日\r\n拟获奖名单全.xls\r\n','20170213141339_485.jpg','2016-12-15 09:55:58'),('b537a19b-f1ae-11e6-8689-005056bf3cd7','设计','31aa405b-c1a4-11e6-956b-00ac7dc2f176','王帅','江河建筑','','20170213133926_816.jpg','2017-02-13 13:39:26');

/*Table structure for table `qrtz_blob_triggers` */

DROP TABLE IF EXISTS `qrtz_blob_triggers`;

CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_blob_triggers` */

/*Table structure for table `qrtz_calendars` */

DROP TABLE IF EXISTS `qrtz_calendars`;

CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_calendars` */

/*Table structure for table `qrtz_cron_triggers` */

DROP TABLE IF EXISTS `qrtz_cron_triggers`;

CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_cron_triggers` */

/*Table structure for table `qrtz_fired_triggers` */

DROP TABLE IF EXISTS `qrtz_fired_triggers`;

CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_fired_triggers` */

/*Table structure for table `qrtz_job_details` */

DROP TABLE IF EXISTS `qrtz_job_details`;

CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_job_details` */

/*Table structure for table `qrtz_locks` */

DROP TABLE IF EXISTS `qrtz_locks`;

CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_locks` */

/*Table structure for table `qrtz_paused_trigger_grps` */

DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;

CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_paused_trigger_grps` */

/*Table structure for table `qrtz_scheduler_state` */

DROP TABLE IF EXISTS `qrtz_scheduler_state`;

CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_scheduler_state` */

/*Table structure for table `qrtz_simple_triggers` */

DROP TABLE IF EXISTS `qrtz_simple_triggers`;

CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_simple_triggers` */

/*Table structure for table `qrtz_simprop_triggers` */

DROP TABLE IF EXISTS `qrtz_simprop_triggers`;

CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_simprop_triggers` */

/*Table structure for table `qrtz_triggers` */

DROP TABLE IF EXISTS `qrtz_triggers`;

CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `qrtz_triggers` */

/*Table structure for table `statistics` */

DROP TABLE IF EXISTS `statistics`;

CREATE TABLE `statistics` (
  `statisticsId` varchar(45) NOT NULL COMMENT '页面ID',
  `statisticsName` varchar(45) DEFAULT NULL COMMENT '中文名称',
  `count` int(11) DEFAULT NULL COMMENT '访问次数',
  PRIMARY KEY (`statisticsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='页面统计表';

/*Data for the table `statistics` */

insert  into `statistics`(`statisticsId`,`statisticsName`,`count`) values ('categoryNewsList','新闻三级列表页',188),('detail','新闻单页',1053),('index','首页',638),('login','登录页',215),('newsList','新闻列表页',1320),('organization','组织机构页',145),('schoolLeader','学院领导页',135),('showStuworks','学生作品页',11);

/*Table structure for table `sysmenu` */

DROP TABLE IF EXISTS `sysmenu`;

CREATE TABLE `sysmenu` (
  `sysmenu_id` varchar(50) NOT NULL,
  `sysmenu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `sysmenu_url` varchar(500) DEFAULT NULL COMMENT '菜单的地址',
  `parent_menuid` varchar(50) DEFAULT NULL COMMENT '父级菜单ID',
  `is_sysmanage_menu` varchar(45) DEFAULT NULL COMMENT '是否是系统菜单',
  `sort` int(11) DEFAULT NULL COMMENT '菜单顺序号',
  `create_date` datetime DEFAULT NULL,
  `create_man` varchar(50) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_man` varchar(50) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`sysmenu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统菜单表';

/*Data for the table `sysmenu` */

insert  into `sysmenu`(`sysmenu_id`,`sysmenu_name`,`sysmenu_url`,`parent_menuid`,`is_sysmanage_menu`,`sort`,`create_date`,`create_man`,`update_date`,`update_man`,`remark`) values ('029d3282-c03a-11e6-9c1a-00ac7dc2f176','人才引进管理','TalentIntroductionManage.form','cf031dce-8dec-11e6-b52b-085700e51ea8','否',4,'2016-12-12 15:10:06','sysadmin','2016-12-12 15:21:32','sysadmin',''),('051e0cde-c343-11e6-99a5-00ac7dc2f176','图片轮播管理','wheelimgmanage.form','a3950c2b-d3f0-11e6-8cda-00ac7dc2f176','否',1,'2016-12-16 11:52:09','sysadmin','2017-01-06 17:17:23','sysadmin',''),('0841f577-c03a-11e6-9c1a-00ac7dc2f176','学科建设管理','SubjectConstructionManage.form','cf031dce-8dec-11e6-b52b-085700e51ea8','否',5,'2016-12-12 15:10:16','sysadmin','2016-12-12 15:21:41','sysadmin',''),('0b6dd167-0d3e-11e6-b867-0025b6dd0800','角色权限管理','sysroleauthoritymanage.form','561e0774-0a0d-11e6-8cac-0025b6dd0800','是',4,'2016-04-28 20:38:01','neunavy','2016-04-28 20:38:25','neunavy',''),('0d4d30a9-0a0e-11e6-8cac-0025b6dd0800','系统用户管理','sysusermanage.form','561e0774-0a0d-11e6-8cac-0025b6dd0800','是',3,'2016-04-24 19:16:55','伯亮','2016-05-04 20:49:32','neunavy',''),('0f455850-c03a-11e6-9c1a-00ac7dc2f176','活动预告管理','ActivityAnnouncedManage.form','cf031dce-8dec-11e6-b52b-085700e51ea8','否',6,'2016-12-12 15:10:27','sysadmin','2016-12-12 15:21:49','sysadmin',''),('10ba2215-c10e-11e6-a722-00ac7dc2f176','党委工作','partycommitteeJobManage.form','9cc3727d-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-13 16:28:04','sysadmin','2016-12-14 11:07:30','sysadmin',''),('11c805bb-c1a4-11e6-956b-00ac7dc2f176','本科生教学通知','undergraduateEduManage.form','20d06f13-c04e-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-14 10:21:49','sysadmin','2016-12-14 15:43:25','sysadmin',''),('120be153-02eb-11e7-9b3c-d8cb8ab8c894','城乡规划系教授','layoutprofession.form','8eee86f2-02ea-11e7-9b3c-d8cb8ab8c894','否',1,'2017-03-07 12:03:50','sysadmin',NULL,NULL,''),('172cfc68-c10e-11e6-a722-00ac7dc2f176','工会工作','unionJobManage.form','9cc3727d-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-13 16:28:14','sysadmin','2016-12-14 14:20:05','sysadmin',''),('19a94b63-c1a4-11e6-956b-00ac7dc2f176','本科生办事指南','undergraduateComManage.form','20d06f13-c04e-11e6-9c1a-00ac7dc2f176','否',2,'2016-12-14 10:22:03','sysadmin','2016-12-15 09:20:35','sysadmin',''),('1e18a75a-c10e-11e6-a722-00ac7dc2f176','教育管理','stueducationManage.form','a3ebafec-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-13 16:28:26','sysadmin','2016-12-15 09:43:14','sysadmin',''),('209a5989-c1a4-11e6-956b-00ac7dc2f176','本科生教学活动','undergraduateActManage.form','20d06f13-c04e-11e6-9c1a-00ac7dc2f176','否',3,'2016-12-14 10:22:14','sysadmin','2016-12-15 09:20:40','sysadmin',''),('20d06f13-c04e-11e6-9c1a-00ac7dc2f176','本科生培养','','85d7b3be-c031-11e6-9c1a-00ac7dc2f176','否',4,'2016-12-12 17:34:07','sysadmin','2016-12-14 10:43:53','sysadmin','教育教学管理——本科生培养'),('236cd752-c33b-11e6-af95-00ac7dc2f176','新闻图片修改','newsimagemanage.form','a3950c2b-d3f0-11e6-8cda-00ac7dc2f176','否',1,'2016-12-16 10:55:44','sysadmin','2017-01-06 17:17:35','sysadmin',''),('27f9b203-02eb-11e7-9b3c-d8cb8ab8c894','城乡规划系副教授','layoutadprofession.form','8eee86f2-02ea-11e7-9b3c-d8cb8ab8c894','否',2,'2017-03-07 12:04:26','sysadmin',NULL,NULL,''),('28fc0e36-c1a4-11e6-956b-00ac7dc2f176','本科生教学成果','undergraduateAchManage.form','20d06f13-c04e-11e6-9c1a-00ac7dc2f176','否',4,'2016-12-14 10:22:28','sysadmin','2016-12-15 09:20:51','sysadmin',''),('2c659331-0d1a-11e6-b867-0025b6dd0800','菜单根目录','','','是',1,'2016-04-28 16:21:15','伯亮',NULL,NULL,' '),('2e985dcf-c10e-11e6-a722-00ac7dc2f176','素质拓展管理','stuqualityManage.form','a3ebafec-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-13 16:28:54','sysadmin','2016-12-15 09:43:51','sysadmin',''),('31aa405b-c1a4-11e6-956b-00ac7dc2f176','本科生优秀作业','undergraduateOpeManage.form','20d06f13-c04e-11e6-9c1a-00ac7dc2f176','否',5,'2016-12-14 10:22:43','sysadmin','2016-12-15 09:20:55','sysadmin',''),('399ca065-c10e-11e6-a722-00ac7dc2f176','指导服务管理','stuserveManage.form','a3ebafec-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-13 16:29:12','sysadmin','2016-12-15 09:44:05','sysadmin',''),('3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176','研究生培养','','85d7b3be-c031-11e6-9c1a-00ac7dc2f176','否',4,'2016-12-12 17:34:50','sysadmin',NULL,NULL,'教育教学管理——研究生培养'),('410f027e-c10e-11e6-a722-00ac7dc2f176','信息系统管理','stuinformsystemManage.form','a3ebafec-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-13 16:29:25','sysadmin','2016-12-15 09:44:17','sysadmin',''),('4282d668-c1cb-11e6-956b-00ac7dc2f176','研究中心管理','researchCenterManage.form','76880a70-c266-11e6-b526-00ac7dc2f176','否',1,'2016-12-14 15:02:22','sysadmin','2016-12-15 09:33:52','sysadmin',''),('4413ab1e-0a0e-11e6-8cac-0025b6dd0800','系统菜单管理','sysmenumanage.form','561e0774-0a0d-11e6-8cac-0025b6dd0800','是',1,'2016-04-24 19:18:26','伯亮',NULL,NULL,''),('47ffc8b3-02eb-11e7-9b3c-d8cb8ab8c894','城乡规划系讲师、助教','layoutlector.form','8eee86f2-02ea-11e7-9b3c-d8cb8ab8c894','否',3,'2017-03-07 12:05:20','sysadmin','2017-03-07 12:22:32','sysadmin',''),('49471ece-c10e-11e6-a722-00ac7dc2f176','国际交流管理','internationalExchangeManage.form','ac16dcef-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-13 16:29:38','sysadmin','2016-12-14 15:31:41','sysadmin',''),('4a3501b6-c1a5-11e6-956b-00ac7dc2f176','研究生教学活动','graduateActManage.form','3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176','否',3,'2016-12-14 10:30:34','sysadmin','2016-12-15 09:22:13','sysadmin',''),('4a736c08-c04e-11e6-9c1a-00ac7dc2f176','成绩查询管理','TranscriptManage.form','85d7b3be-c031-11e6-9c1a-00ac7dc2f176','否',3,'2016-12-12 17:35:17','sysadmin','2016-12-14 14:56:40','sysadmin','教育教学管理——成绩查询管理'),('4b444879-c1cb-11e6-956b-00ac7dc2f176','研究实验室管理','studyLabManage.form','76880a70-c266-11e6-b526-00ac7dc2f176','否',1,'2016-12-14 15:02:37','sysadmin','2016-12-15 09:34:04','sysadmin',''),('4fdbcf03-c10e-11e6-a722-00ac7dc2f176','国内交流管理','inlandExchangeManage.form','ac16dcef-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-13 16:29:49','sysadmin','2016-12-14 15:31:54','sysadmin',''),('5103a139-c1a5-11e6-956b-00ac7dc2f176','研究生教学成果','graduateAchManage.form','3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176','否',4,'2016-12-14 10:30:45','sysadmin','2016-12-15 09:22:19','sysadmin',''),('561e0774-0a0d-11e6-8cac-0025b6dd0800','系统功能','','2c659331-0d1a-11e6-b867-0025b6dd0800','是',3,'2016-04-24 19:11:47','伯亮','2017-01-06 17:19:25','sysadmin',''),('57645378-c1a5-11e6-956b-00ac7dc2f176','研究生优秀作业','graduateOpeManage.form','3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176','否',5,'2016-12-14 10:30:56','sysadmin','2016-12-15 09:22:30','sysadmin',''),('5c725a25-c10e-11e6-a722-00ac7dc2f176','校友交流管理','alumnusExchangeManage.form','ac16dcef-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-13 16:30:11','sysadmin','2016-12-14 15:32:17','sysadmin',''),('5db0147a-0a0e-11e6-8cac-0025b6dd0800','建筑学院管理','','2c659331-0d1a-11e6-b867-0025b6dd0800','是',1,'2016-04-24 19:19:09','伯亮','2016-12-12 14:08:29','sysadmin',''),('6920f298-c10e-11e6-a722-00ac7dc2f176','管理下载','ManagementDownload.form','b24c6336-c031-11e6-9c1a-00ac7dc2f176','否',2,'2016-12-13 16:30:32','sysadmin','2016-12-14 15:39:34','sysadmin',''),('7136725f-c10e-11e6-a722-00ac7dc2f176','教学下载','TeachingDownload.form','b24c6336-c031-11e6-9c1a-00ac7dc2f176','否',3,'2016-12-13 16:30:45','sysadmin','2016-12-14 15:39:30','sysadmin',''),('7386cd02-c04e-11e6-9c1a-00ac7dc2f176','学术委员会管理','collegeIntoevolution.form','8d69760f-c031-11e6-9c1a-00ac7dc2f176','否',5,'2016-12-12 17:36:26','sysadmin','2017-03-18 17:49:36','sysadmin','学术研究管理——学术委员会管理'),('75eefbdf-c031-11e6-9c1a-00ac7dc2f176','学院概况管理','','5db0147a-0a0e-11e6-8cac-0025b6dd0800','否',2,'2016-12-12 14:08:54','sysadmin','2016-12-12 14:13:42','sysadmin',''),('76880a70-c266-11e6-b526-00ac7dc2f176','研究机构管理','','8d69760f-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-15 09:33:21','sysadmin',NULL,NULL,''),('76947a93-0d1a-11e6-b867-0025b6dd0800','系统角色管理','sysrolemanage.form','561e0774-0a0d-11e6-8cac-0025b6dd0800','是',2,'2016-04-28 16:23:19','伯亮','2016-04-28 20:49:31','neunavy',' '),('78828e95-c10e-11e6-a722-00ac7dc2f176','学术下载','ScienceDownload.form','b24c6336-c031-11e6-9c1a-00ac7dc2f176','否',4,'2016-12-13 16:30:58','sysadmin','2016-12-14 15:39:26','sysadmin',''),('7e5ecace-c031-11e6-9c1a-00ac7dc2f176','师资队伍管理','','5db0147a-0a0e-11e6-8cac-0025b6dd0800','否',1,'2016-12-12 14:09:08','sysadmin','2016-12-12 17:51:35','sysadmin',''),('800e8cf3-02ea-11e7-9b3c-d8cb8ab8c894','建筑系','','7e5ecace-c031-11e6-9c1a-00ac7dc2f176','否',3,'2017-03-07 11:59:45','sysadmin',NULL,NULL,''),('85d7b3be-c031-11e6-9c1a-00ac7dc2f176','教育教学管理','','5db0147a-0a0e-11e6-8cac-0025b6dd0800','否',2,'2016-12-12 14:09:21','sysadmin','2016-12-12 14:13:50','sysadmin',''),('8c8b6966-c111-11e6-a722-00ac7dc2f176','表单模块管理','ModeTypeManage.form','561e0774-0a0d-11e6-8cac-0025b6dd0800','否',1,'2016-12-13 16:53:00','sysadmin','2016-12-15 16:06:52','sysadmin',''),('8d69760f-c031-11e6-9c1a-00ac7dc2f176','学术研究管理','','5db0147a-0a0e-11e6-8cac-0025b6dd0800','否',2,'2016-12-12 14:09:33','sysadmin','2016-12-12 14:13:53','sysadmin',''),('8eafd5ae-c04e-11e6-9c1a-00ac7dc2f176','研究项目管理','studyProjectManage.form','8d69760f-c031-11e6-9c1a-00ac7dc2f176','否',3,'2016-12-12 17:37:11','sysadmin','2016-12-14 15:34:38','sysadmin','学术研究管理——研究项目管理'),('8eee86f2-02ea-11e7-9b3c-d8cb8ab8c894','城乡规划系','','7e5ecace-c031-11e6-9c1a-00ac7dc2f176','否',4,'2017-03-07 12:00:10','sysadmin',NULL,NULL,''),('9aca0083-c04e-11e6-9c1a-00ac7dc2f176','研究成果管理','studyAchievementManage.form','8d69760f-c031-11e6-9c1a-00ac7dc2f176','否',4,'2016-12-12 17:37:32','sysadmin','2016-12-14 15:34:54','sysadmin','学术研究管理——研究成果管理'),('9cc3727d-c031-11e6-9c1a-00ac7dc2f176','党群工作','','5db0147a-0a0e-11e6-8cac-0025b6dd0800','否',1,'2016-12-12 14:09:59','sysadmin',NULL,NULL,''),('9ed74c16-c1a4-11e6-956b-00ac7dc2f176','研究生教学通知','graduateEduManage.form','3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-14 10:25:46','sysadmin','2016-12-15 09:20:00','sysadmin',''),('a36caad6-c037-11e6-9c1a-00ac7dc2f176','历史沿革管理','historyEvolutionManage.form','75eefbdf-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-12 14:53:07','sysadmin','2016-12-14 15:03:46','sysadmin','学院概况管理——历史沿革管理'),('a3950c2b-d3f0-11e6-8cda-00ac7dc2f176','其他功能管理','','2c659331-0d1a-11e6-b867-0025b6dd0800','否',2,'2017-01-06 17:15:17','sysadmin','2017-01-06 17:19:18','sysadmin',''),('a3ebafec-c031-11e6-9c1a-00ac7dc2f176','学生工作','','5db0147a-0a0e-11e6-8cac-0025b6dd0800','否',1,'2016-12-12 14:10:11','sysadmin',NULL,NULL,''),('a5ab7b0a-c1a4-11e6-956b-00ac7dc2f176','研究生办事指南','graduateComManage.form','3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176','否',2,'2016-12-14 10:25:58','sysadmin','2016-12-15 09:22:24','sysadmin',''),('ac16dcef-c031-11e6-9c1a-00ac7dc2f176','交流合作','','5db0147a-0a0e-11e6-8cac-0025b6dd0800','否',1,'2016-12-12 14:10:25','sysadmin',NULL,NULL,''),('b1513d06-02eb-11e7-9b3c-d8cb8ab8c894','实验中心','','7e5ecace-c031-11e6-9c1a-00ac7dc2f176','否',5,'2017-03-07 12:08:17','sysadmin',NULL,NULL,''),('b24c6336-c031-11e6-9c1a-00ac7dc2f176','下载专区管理','','5db0147a-0a0e-11e6-8cac-0025b6dd0800','否',1,'2016-12-12 14:10:35','sysadmin','2016-12-12 17:51:44','sysadmin',''),('bb81e35a-02eb-11e7-9b3c-d8cb8ab8c894','实验中心实验员','Experionmentpeople.form','b1513d06-02eb-11e7-9b3c-d8cb8ab8c894','否',1,'2017-03-07 12:08:34','sysadmin','2017-03-07 12:08:48','sysadmin',''),('bc50fa33-fff6-11e6-9450-38d547ab495f','基层组织介绍','OrganitionIntroduceManage.form','75eefbdf-c031-11e6-9c1a-00ac7dc2f176','否',1000,'2017-03-03 17:49:49','sysadmin',NULL,NULL,''),('bd8ed368-c037-11e6-9c1a-00ac7dc2f176','学院简介管理','collegeIntoevolution.form','75eefbdf-c031-11e6-9c1a-00ac7dc2f176','否',2,'2016-12-12 14:53:51','sysadmin','2016-12-14 15:04:25','sysadmin','学院概况管理——学院简介沿革'),('c07f12b3-02ea-11e7-9b3c-d8cb8ab8c894','建筑系教授','Architectorprofession.form','800e8cf3-02ea-11e7-9b3c-d8cb8ab8c894','否',1,'2017-03-07 12:01:33','sysadmin',NULL,NULL,''),('cf031dce-8dec-11e6-b52b-085700e51ea8','专栏管理','','5db0147a-0a0e-11e6-8cac-0025b6dd0800','否',1,'2016-10-09 14:51:30','sysadmin','2016-12-12 14:08:38','sysadmin',''),('d18f7189-d3f0-11e6-8cda-00ac7dc2f176','访问次数查看','showstatistics.form','a3950c2b-d3f0-11e6-8cda-00ac7dc2f176','否',1,'2017-01-06 17:16:34','sysadmin',NULL,NULL,''),('d6447c13-c037-11e6-9c1a-00ac7dc2f176','学院领导管理','collegeLeadManage.form','75eefbdf-c031-11e6-9c1a-00ac7dc2f176','否',3,'2016-12-12 14:54:33','sysadmin','2016-12-14 15:04:39','sysadmin','学院概况管理——学院领导管理'),('d763ea25-c1ca-11e6-956b-00ac7dc2f176','友情链接管理','blogroll.form','a3950c2b-d3f0-11e6-8cda-00ac7dc2f176','否',1,'2016-12-14 14:59:22','sysadmin','2017-01-06 17:17:53','sysadmin',''),('d78fff10-c10c-11e6-a722-00ac7dc2f176','专职教师管理','teacherinfoManage_1.form','7e5ecace-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-13 16:19:18','sysadmin','2016-12-17 18:52:28','sysadmin',''),('d8c88b88-02ea-11e7-9b3c-d8cb8ab8c894','建筑系副教授','Architectoradprofession.form','800e8cf3-02ea-11e7-9b3c-d8cb8ab8c894','否',2,'2017-03-07 12:02:14','sysadmin',NULL,NULL,''),('db6bb42e-c42d-11e6-b626-00ac7dc2f176','教工信息填写','teacherinfoApply.form','e66b6864-c445-11e6-b626-00ac7dc2f176','否',1,'2016-12-17 15:53:11','sysadmin','2016-12-17 18:46:28','sysadmin',''),('e3df07f5-c039-11e6-9c1a-00ac7dc2f176','通知公告管理','NotificationManage.form','cf031dce-8dec-11e6-b52b-085700e51ea8','否',1,'2016-12-12 15:09:15','sysadmin','2016-12-12 15:24:07','sysadmin',''),('e4c2f87e-c037-11e6-9c1a-00ac7dc2f176','组织机构管理','organizationManage.form','75eefbdf-c031-11e6-9c1a-00ac7dc2f176','否',4,'2016-12-12 14:54:57','sysadmin','2016-12-14 15:05:23','sysadmin','学院概况管理——组织机构管理'),('e66b6864-c445-11e6-b626-00ac7dc2f176','教师信息管理','','2c659331-0d1a-11e6-b867-0025b6dd0800','否',1,'2016-12-17 18:45:18','sysadmin','2016-12-17 18:45:33','sysadmin',''),('e91e9e81-c04d-11e6-9c1a-00ac7dc2f176','学位分委员会管理','collegeIntoevolution.form','85d7b3be-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-12 17:32:33','sysadmin','2017-03-18 17:49:25','sysadmin','教育教学管理——学位分委员会管理'),('effbb7ef-c10c-11e6-a722-00ac7dc2f176','教工信息审核','teacherinfoRevi.form','e66b6864-c445-11e6-b626-00ac7dc2f176','否',1,'2016-12-13 16:19:59','sysadmin','2016-12-17 18:46:42','sysadmin',''),('f18f1f50-c039-11e6-9c1a-00ac7dc2f176','学院新闻管理','CollegeNewsManage.form','cf031dce-8dec-11e6-b52b-085700e51ea8','否',2,'2016-12-12 15:09:38','sysadmin','2016-12-12 15:21:13','sysadmin',''),('f190764f-02ea-11e7-9b3c-d8cb8ab8c894','建筑系讲师、助教','architectorlector.form','800e8cf3-02ea-11e7-9b3c-d8cb8ab8c894','否',3,'2017-03-07 12:02:55','sysadmin',NULL,NULL,''),('f4d9dac1-c446-11e6-b626-00ac7dc2f176','兼职教师管理','teacherinfoManage_2.form','7e5ecace-c031-11e6-9c1a-00ac7dc2f176','否',1,'2016-12-17 18:52:51','sysadmin',NULL,NULL,''),('f51a61c8-c037-11e6-9c1a-00ac7dc2f176','大事记管理','collegeIntoevolution.form','75eefbdf-c031-11e6-9c1a-00ac7dc2f176','否',5,'2016-12-12 14:55:24','sysadmin','2017-03-18 15:44:40','sysadmin','学院概况管理——大事记管理'),('f9f94fe6-c039-11e6-9c1a-00ac7dc2f176','学术活动管理','AcademicActivitiesManage.form','cf031dce-8dec-11e6-b52b-085700e51ea8','否',3,'2016-12-12 15:09:52','sysadmin','2016-12-12 15:21:24','sysadmin',''),('fb3e5125-c04d-11e6-9c1a-00ac7dc2f176','专业概况管理','majorsurveyManage.form','85d7b3be-c031-11e6-9c1a-00ac7dc2f176','否',2,'2016-12-12 17:33:04','sysadmin','2016-12-14 15:30:42','sysadmin','教育教学管理——专业概况管理');

/*Table structure for table `sysmenurequest` */

DROP TABLE IF EXISTS `sysmenurequest`;

CREATE TABLE `sysmenurequest` (
  `sysmenurequestId` int(11) NOT NULL AUTO_INCREMENT,
  `sysmenuId` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '菜单ID',
  `requestName` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '请求名称',
  `remark` varchar(45) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`sysmenurequestId`),
  UNIQUE KEY `requestName_UNIQUE` (`requestName`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='菜单对应的请求路径';

/*Data for the table `sysmenurequest` */

insert  into `sysmenurequest`(`sysmenurequestId`,`sysmenuId`,`requestName`,`remark`) values (1,'4413ab1e-0a0e-11e6-8cac-0025b6dd0800','getSysMenuList.form','系统菜单管理'),(2,'4413ab1e-0a0e-11e6-8cac-0025b6dd0800','getParentMenu.form','系统菜单管理'),(3,'76947a93-0d1a-11e6-b867-0025b6dd0800','AdminloadSysRole.form','系统角色管理'),(4,'0d4d30a9-0a0e-11e6-8cac-0025b6dd0800','AdminloadSysUser.form','系统用户管理'),(5,'0b6dd167-0d3e-11e6-b867-0025b6dd0800','AdmingetRoleName.form','角色权限管理'),(7,'0b6dd167-0d3e-11e6-b867-0025b6dd0800','getParentMenuRole.form','角色权限管理');

/*Table structure for table `sysrole` */

DROP TABLE IF EXISTS `sysrole`;

CREATE TABLE `sysrole` (
  `sysrole_id` varchar(50) NOT NULL,
  `sysrole_name` varchar(50) NOT NULL COMMENT '角色名称',
  `is_sysrole` varchar(45) DEFAULT NULL COMMENT '是否为系统角色',
  `create_date` datetime DEFAULT NULL,
  `create_man` varchar(50) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `update_man` varchar(50) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`sysrole_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统角色表';

/*Data for the table `sysrole` */

insert  into `sysrole`(`sysrole_id`,`sysrole_name`,`is_sysrole`,`create_date`,`create_man`,`update_date`,`update_man`,`remark`) values ('1e225d95-126c-11e6-989d-0025b6dd0800','系统管理员','是','2016-05-05 10:50:25','neunavy',NULL,NULL,''),('c73f95fd-c42f-11e6-b626-00ac7dc2f176','教师教工','否','2016-12-17 16:06:56','sysadmin','2016-12-17 16:07:18','sysadmin','此角色无任何权限只为教师填写个人信息用'),('fe785f38-0baf-11e6-883e-0025b6dd0800','东深科技管理员','是','2016-12-12 15:04:09','neunavy',NULL,NULL,NULL),('jianghe','建筑学院管理员','是','2016-12-12 14:40:36','neunavy',NULL,NULL,NULL);

/*Table structure for table `sysrolemenu` */

DROP TABLE IF EXISTS `sysrolemenu`;

CREATE TABLE `sysrolemenu` (
  `sysrolemenu_id` varchar(50) NOT NULL,
  `sysrole_id` varchar(50) NOT NULL COMMENT '系统角色ID',
  `sysmenu_id` varchar(50) NOT NULL COMMENT '系统菜单ID',
  PRIMARY KEY (`sysrolemenu_id`),
  KEY `菜单删除` (`sysmenu_id`),
  KEY `角色删除` (`sysrole_id`),
  CONSTRAINT `菜单删除` FOREIGN KEY (`sysmenu_id`) REFERENCES `sysmenu` (`sysmenu_id`) ON DELETE CASCADE,
  CONSTRAINT `角色删除` FOREIGN KEY (`sysrole_id`) REFERENCES `sysrole` (`sysrole_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统角色和系统菜单的关系表,用于菜单显示功能';

/*Data for the table `sysrolemenu` */

insert  into `sysrolemenu`(`sysrolemenu_id`,`sysrole_id`,`sysmenu_id`) values ('21f47231-c446-11e6-b626-00ac7dc2f176','c73f95fd-c42f-11e6-b626-00ac7dc2f176','db6bb42e-c42d-11e6-b626-00ac7dc2f176'),('21f4c58e-c446-11e6-b626-00ac7dc2f176','c73f95fd-c42f-11e6-b626-00ac7dc2f176','e66b6864-c445-11e6-b626-00ac7dc2f176'),('21f50ee8-c446-11e6-b626-00ac7dc2f176','c73f95fd-c42f-11e6-b626-00ac7dc2f176','2c659331-0d1a-11e6-b867-0025b6dd0800'),('c018baef-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','800e8cf3-02ea-11e7-9b3c-d8cb8ab8c894'),('c01a2891-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','c07f12b3-02ea-11e7-9b3c-d8cb8ab8c894'),('c01a7ae0-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','d8c88b88-02ea-11e7-9b3c-d8cb8ab8c894'),('c01ac579-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','f190764f-02ea-11e7-9b3c-d8cb8ab8c894'),('c01b0b83-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','8eee86f2-02ea-11e7-9b3c-d8cb8ab8c894'),('c01b47fb-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','120be153-02eb-11e7-9b3c-d8cb8ab8c894'),('c01b7b14-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','27f9b203-02eb-11e7-9b3c-d8cb8ab8c894'),('c01bb07d-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','47ffc8b3-02eb-11e7-9b3c-d8cb8ab8c894'),('c01bebba-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','b1513d06-02eb-11e7-9b3c-d8cb8ab8c894'),('c01c21e0-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','bb81e35a-02eb-11e7-9b3c-d8cb8ab8c894'),('c01c53aa-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','9cc3727d-c031-11e6-9c1a-00ac7dc2f176'),('c01c8a65-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','10ba2215-c10e-11e6-a722-00ac7dc2f176'),('c01cbe01-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','172cfc68-c10e-11e6-a722-00ac7dc2f176'),('c01cf60a-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','a3ebafec-c031-11e6-9c1a-00ac7dc2f176'),('c01d2974-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','1e18a75a-c10e-11e6-a722-00ac7dc2f176'),('c01d5927-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','2e985dcf-c10e-11e6-a722-00ac7dc2f176'),('c01d886c-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','399ca065-c10e-11e6-a722-00ac7dc2f176'),('c01dbaf7-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','410f027e-c10e-11e6-a722-00ac7dc2f176'),('c01deafe-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','ac16dcef-c031-11e6-9c1a-00ac7dc2f176'),('c01e1c29-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','49471ece-c10e-11e6-a722-00ac7dc2f176'),('c01e4fa6-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','4fdbcf03-c10e-11e6-a722-00ac7dc2f176'),('c01f3d87-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','5c725a25-c10e-11e6-a722-00ac7dc2f176'),('c0202fbc-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','b24c6336-c031-11e6-9c1a-00ac7dc2f176'),('c02074b5-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','6920f298-c10e-11e6-a722-00ac7dc2f176'),('c020b54b-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','7136725f-c10e-11e6-a722-00ac7dc2f176'),('c020e8fd-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','78828e95-c10e-11e6-a722-00ac7dc2f176'),('c02119ae-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','cf031dce-8dec-11e6-b52b-085700e51ea8'),('c0214a25-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','e3df07f5-c039-11e6-9c1a-00ac7dc2f176'),('c0217d5e-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','f18f1f50-c039-11e6-9c1a-00ac7dc2f176'),('c021ad7a-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','f9f94fe6-c039-11e6-9c1a-00ac7dc2f176'),('c021dc40-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','029d3282-c03a-11e6-9c1a-00ac7dc2f176'),('c0220e99-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','0841f577-c03a-11e6-9c1a-00ac7dc2f176'),('c0223ebc-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','0f455850-c03a-11e6-9c1a-00ac7dc2f176'),('c0226ef4-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','75eefbdf-c031-11e6-9c1a-00ac7dc2f176'),('c022a261-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','a36caad6-c037-11e6-9c1a-00ac7dc2f176'),('c022d38c-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','bd8ed368-c037-11e6-9c1a-00ac7dc2f176'),('c023039c-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','d6447c13-c037-11e6-9c1a-00ac7dc2f176'),('c02332ad-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','e4c2f87e-c037-11e6-9c1a-00ac7dc2f176'),('c0236ed1-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','f51a61c8-c037-11e6-9c1a-00ac7dc2f176'),('c0239e04-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','bc50fa33-fff6-11e6-9450-38d547ab495f'),('c023d312-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','85d7b3be-c031-11e6-9c1a-00ac7dc2f176'),('c0241702-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','e91e9e81-c04d-11e6-9c1a-00ac7dc2f176'),('c024fd40-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','fb3e5125-c04d-11e6-9c1a-00ac7dc2f176'),('c02534c2-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','4a736c08-c04e-11e6-9c1a-00ac7dc2f176'),('c0256a79-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','20d06f13-c04e-11e6-9c1a-00ac7dc2f176'),('c025a907-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','11c805bb-c1a4-11e6-956b-00ac7dc2f176'),('c025dde4-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','19a94b63-c1a4-11e6-956b-00ac7dc2f176'),('c02611b1-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','209a5989-c1a4-11e6-956b-00ac7dc2f176'),('c0264aa9-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','28fc0e36-c1a4-11e6-956b-00ac7dc2f176'),('c0267c82-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','31aa405b-c1a4-11e6-956b-00ac7dc2f176'),('c026ae36-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176'),('c026e453-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','9ed74c16-c1a4-11e6-956b-00ac7dc2f176'),('c0271578-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','a5ab7b0a-c1a4-11e6-956b-00ac7dc2f176'),('c027479c-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','4a3501b6-c1a5-11e6-956b-00ac7dc2f176'),('c02779f1-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','5103a139-c1a5-11e6-956b-00ac7dc2f176'),('c027ab1f-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','57645378-c1a5-11e6-956b-00ac7dc2f176'),('c027db5b-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','8d69760f-c031-11e6-9c1a-00ac7dc2f176'),('c0281ccd-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','76880a70-c266-11e6-b526-00ac7dc2f176'),('c0285868-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','4282d668-c1cb-11e6-956b-00ac7dc2f176'),('c0289703-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','4b444879-c1cb-11e6-956b-00ac7dc2f176'),('c028c869-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','8eafd5ae-c04e-11e6-9c1a-00ac7dc2f176'),('c028fb44-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','9aca0083-c04e-11e6-9c1a-00ac7dc2f176'),('c0292e6a-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','7386cd02-c04e-11e6-9c1a-00ac7dc2f176'),('c0295fdd-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','e66b6864-c445-11e6-b626-00ac7dc2f176'),('c0299063-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','db6bb42e-c42d-11e6-b626-00ac7dc2f176'),('c029c220-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','effbb7ef-c10c-11e6-a722-00ac7dc2f176'),('c029f345-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','d18f7189-d3f0-11e6-8cda-00ac7dc2f176'),('c02a2486-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','7e5ecace-c031-11e6-9c1a-00ac7dc2f176'),('c02a5803-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','5db0147a-0a0e-11e6-8cac-0025b6dd0800'),('c02a8924-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','2c659331-0d1a-11e6-b867-0025b6dd0800'),('c02aba2a-02ed-11e7-9b3c-d8cb8ab8c894','jianghe','a3950c2b-d3f0-11e6-8cda-00ac7dc2f176'),('d74bb871-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','2c659331-0d1a-11e6-b867-0025b6dd0800'),('d74e16a6-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','5db0147a-0a0e-11e6-8cac-0025b6dd0800'),('d74e5b61-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','7e5ecace-c031-11e6-9c1a-00ac7dc2f176'),('d74e9e52-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','d78fff10-c10c-11e6-a722-00ac7dc2f176'),('d74ee341-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','f4d9dac1-c446-11e6-b626-00ac7dc2f176'),('d74f2a41-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','800e8cf3-02ea-11e7-9b3c-d8cb8ab8c894'),('d74f6aed-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','c07f12b3-02ea-11e7-9b3c-d8cb8ab8c894'),('d74f9eed-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','d8c88b88-02ea-11e7-9b3c-d8cb8ab8c894'),('d74fda1a-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','f190764f-02ea-11e7-9b3c-d8cb8ab8c894'),('d7501484-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','8eee86f2-02ea-11e7-9b3c-d8cb8ab8c894'),('d7504c89-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','120be153-02eb-11e7-9b3c-d8cb8ab8c894'),('d75094e3-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','27f9b203-02eb-11e7-9b3c-d8cb8ab8c894'),('d750d432-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','47ffc8b3-02eb-11e7-9b3c-d8cb8ab8c894'),('d7510f53-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','b1513d06-02eb-11e7-9b3c-d8cb8ab8c894'),('d75144bc-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','bb81e35a-02eb-11e7-9b3c-d8cb8ab8c894'),('d751933e-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','9cc3727d-c031-11e6-9c1a-00ac7dc2f176'),('d751d82d-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','10ba2215-c10e-11e6-a722-00ac7dc2f176'),('d7521e31-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','172cfc68-c10e-11e6-a722-00ac7dc2f176'),('d7525093-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','a3ebafec-c031-11e6-9c1a-00ac7dc2f176'),('d7528b29-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','1e18a75a-c10e-11e6-a722-00ac7dc2f176'),('d7536f8a-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','2e985dcf-c10e-11e6-a722-00ac7dc2f176'),('d75456c0-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','399ca065-c10e-11e6-a722-00ac7dc2f176'),('d75496d4-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','410f027e-c10e-11e6-a722-00ac7dc2f176'),('d754ce40-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','ac16dcef-c031-11e6-9c1a-00ac7dc2f176'),('d75501ab-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','49471ece-c10e-11e6-a722-00ac7dc2f176'),('d75535ec-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','4fdbcf03-c10e-11e6-a722-00ac7dc2f176'),('d75568dd-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','5c725a25-c10e-11e6-a722-00ac7dc2f176'),('d7559a87-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','b24c6336-c031-11e6-9c1a-00ac7dc2f176'),('d755cd4d-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','6920f298-c10e-11e6-a722-00ac7dc2f176'),('d75603ae-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','7136725f-c10e-11e6-a722-00ac7dc2f176'),('d756376c-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','78828e95-c10e-11e6-a722-00ac7dc2f176'),('d75667e6-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','cf031dce-8dec-11e6-b52b-085700e51ea8'),('d7569cc9-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','e3df07f5-c039-11e6-9c1a-00ac7dc2f176'),('d756d752-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','f18f1f50-c039-11e6-9c1a-00ac7dc2f176'),('d7571251-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','f9f94fe6-c039-11e6-9c1a-00ac7dc2f176'),('d757478b-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','029d3282-c03a-11e6-9c1a-00ac7dc2f176'),('d7577795-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','0841f577-c03a-11e6-9c1a-00ac7dc2f176'),('d757a6e4-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','0f455850-c03a-11e6-9c1a-00ac7dc2f176'),('d757d6d1-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','75eefbdf-c031-11e6-9c1a-00ac7dc2f176'),('d7580684-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','a36caad6-c037-11e6-9c1a-00ac7dc2f176'),('d758432d-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','bd8ed368-c037-11e6-9c1a-00ac7dc2f176'),('d758733a-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','d6447c13-c037-11e6-9c1a-00ac7dc2f176'),('d758a2fc-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','e4c2f87e-c037-11e6-9c1a-00ac7dc2f176'),('d758d1aa-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','f51a61c8-c037-11e6-9c1a-00ac7dc2f176'),('d75905a0-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','bc50fa33-fff6-11e6-9450-38d547ab495f'),('d75937be-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','85d7b3be-c031-11e6-9c1a-00ac7dc2f176'),('d7596cfb-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','e91e9e81-c04d-11e6-9c1a-00ac7dc2f176'),('d7599e00-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','fb3e5125-c04d-11e6-9c1a-00ac7dc2f176'),('d759ceb2-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','4a736c08-c04e-11e6-9c1a-00ac7dc2f176'),('d75a0053-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','20d06f13-c04e-11e6-9c1a-00ac7dc2f176'),('d75a3127-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','11c805bb-c1a4-11e6-956b-00ac7dc2f176'),('d75a7760-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','19a94b63-c1a4-11e6-956b-00ac7dc2f176'),('d75aa9a6-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','209a5989-c1a4-11e6-956b-00ac7dc2f176'),('d75adde1-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','28fc0e36-c1a4-11e6-956b-00ac7dc2f176'),('d75b0e6d-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','31aa405b-c1a4-11e6-956b-00ac7dc2f176'),('d75b4104-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176'),('d75b7392-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','9ed74c16-c1a4-11e6-956b-00ac7dc2f176'),('d75ba79e-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','a5ab7b0a-c1a4-11e6-956b-00ac7dc2f176'),('d75bd8e2-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','4a3501b6-c1a5-11e6-956b-00ac7dc2f176'),('d75c0c0e-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','5103a139-c1a5-11e6-956b-00ac7dc2f176'),('d75c4476-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','57645378-c1a5-11e6-956b-00ac7dc2f176'),('d75c7384-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','8d69760f-c031-11e6-9c1a-00ac7dc2f176'),('d75ca37b-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','76880a70-c266-11e6-b526-00ac7dc2f176'),('d75ce3d3-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','4282d668-c1cb-11e6-956b-00ac7dc2f176'),('d75d12b8-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','4b444879-c1cb-11e6-956b-00ac7dc2f176'),('d75d44e5-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','8eafd5ae-c04e-11e6-9c1a-00ac7dc2f176'),('d75d7939-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','9aca0083-c04e-11e6-9c1a-00ac7dc2f176'),('d75da9bf-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','7386cd02-c04e-11e6-9c1a-00ac7dc2f176'),('d75dd857-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','e66b6864-c445-11e6-b626-00ac7dc2f176'),('d75e0dee-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','db6bb42e-c42d-11e6-b626-00ac7dc2f176'),('d75e41bf-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','effbb7ef-c10c-11e6-a722-00ac7dc2f176'),('d75e745c-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','a3950c2b-d3f0-11e6-8cda-00ac7dc2f176'),('d75f745b-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','051e0cde-c343-11e6-99a5-00ac7dc2f176'),('d75fb18a-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','236cd752-c33b-11e6-af95-00ac7dc2f176'),('d75fe96a-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','d18f7189-d3f0-11e6-8cda-00ac7dc2f176'),('d7601beb-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','d763ea25-c1ca-11e6-956b-00ac7dc2f176'),('d7604e12-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','561e0774-0a0d-11e6-8cac-0025b6dd0800'),('d7608464-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','4413ab1e-0a0e-11e6-8cac-0025b6dd0800'),('d760b477-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','8c8b6966-c111-11e6-a722-00ac7dc2f176'),('d760e774-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','76947a93-0d1a-11e6-b867-0025b6dd0800'),('d7611b23-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','0d4d30a9-0a0e-11e6-8cac-0025b6dd0800'),('d76149ab-02eb-11e7-9b3c-d8cb8ab8c894','1e225d95-126c-11e6-989d-0025b6dd0800','0b6dd167-0d3e-11e6-b867-0025b6dd0800'),('e04d39ed-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','2c659331-0d1a-11e6-b867-0025b6dd0800'),('e04da9af-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','5db0147a-0a0e-11e6-8cac-0025b6dd0800'),('e04eb48b-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','7e5ecace-c031-11e6-9c1a-00ac7dc2f176'),('e04f021e-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','d78fff10-c10c-11e6-a722-00ac7dc2f176'),('e04f3f3a-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','f4d9dac1-c446-11e6-b626-00ac7dc2f176'),('e04f770a-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','800e8cf3-02ea-11e7-9b3c-d8cb8ab8c894'),('e04fafff-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','c07f12b3-02ea-11e7-9b3c-d8cb8ab8c894'),('e04fe09b-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','d8c88b88-02ea-11e7-9b3c-d8cb8ab8c894'),('e0501610-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','f190764f-02ea-11e7-9b3c-d8cb8ab8c894'),('e0504e66-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','8eee86f2-02ea-11e7-9b3c-d8cb8ab8c894'),('e05082b6-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','120be153-02eb-11e7-9b3c-d8cb8ab8c894'),('e050b4f6-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','27f9b203-02eb-11e7-9b3c-d8cb8ab8c894'),('e050e9dc-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','47ffc8b3-02eb-11e7-9b3c-d8cb8ab8c894'),('e0511c82-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','b1513d06-02eb-11e7-9b3c-d8cb8ab8c894'),('e0514e5e-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','bb81e35a-02eb-11e7-9b3c-d8cb8ab8c894'),('e0517db4-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','9cc3727d-c031-11e6-9c1a-00ac7dc2f176'),('e051b24c-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','10ba2215-c10e-11e6-a722-00ac7dc2f176'),('e051eb59-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','172cfc68-c10e-11e6-a722-00ac7dc2f176'),('e0522291-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','a3ebafec-c031-11e6-9c1a-00ac7dc2f176'),('e0525755-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','1e18a75a-c10e-11e6-a722-00ac7dc2f176'),('e0528ea9-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','2e985dcf-c10e-11e6-a722-00ac7dc2f176'),('e052bfe0-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','399ca065-c10e-11e6-a722-00ac7dc2f176'),('e052f156-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','410f027e-c10e-11e6-a722-00ac7dc2f176'),('e05329be-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','ac16dcef-c031-11e6-9c1a-00ac7dc2f176'),('e053612e-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','49471ece-c10e-11e6-a722-00ac7dc2f176'),('e0539528-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','4fdbcf03-c10e-11e6-a722-00ac7dc2f176'),('e053c905-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','5c725a25-c10e-11e6-a722-00ac7dc2f176'),('e053f9dc-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','b24c6336-c031-11e6-9c1a-00ac7dc2f176'),('e0542f61-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','6920f298-c10e-11e6-a722-00ac7dc2f176'),('e054652d-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','7136725f-c10e-11e6-a722-00ac7dc2f176'),('e0549619-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','78828e95-c10e-11e6-a722-00ac7dc2f176'),('e05578b5-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','cf031dce-8dec-11e6-b52b-085700e51ea8'),('e055c1c3-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','e3df07f5-c039-11e6-9c1a-00ac7dc2f176'),('e0560808-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','f18f1f50-c039-11e6-9c1a-00ac7dc2f176'),('e0563e4d-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','f9f94fe6-c039-11e6-9c1a-00ac7dc2f176'),('e05674e6-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','029d3282-c03a-11e6-9c1a-00ac7dc2f176'),('e056a9b3-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','0841f577-c03a-11e6-9c1a-00ac7dc2f176'),('e056e6c0-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','0f455850-c03a-11e6-9c1a-00ac7dc2f176'),('e0571c45-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','75eefbdf-c031-11e6-9c1a-00ac7dc2f176'),('e057504a-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','a36caad6-c037-11e6-9c1a-00ac7dc2f176'),('e0578125-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','bd8ed368-c037-11e6-9c1a-00ac7dc2f176'),('e057af56-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','d6447c13-c037-11e6-9c1a-00ac7dc2f176'),('e057e125-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','e4c2f87e-c037-11e6-9c1a-00ac7dc2f176'),('e05814cb-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','f51a61c8-c037-11e6-9c1a-00ac7dc2f176'),('e05845e3-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','bc50fa33-fff6-11e6-9450-38d547ab495f'),('e0588bc8-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','85d7b3be-c031-11e6-9c1a-00ac7dc2f176'),('e058bc04-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','e91e9e81-c04d-11e6-9c1a-00ac7dc2f176'),('e058eb82-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','fb3e5125-c04d-11e6-9c1a-00ac7dc2f176'),('e0591dc8-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','4a736c08-c04e-11e6-9c1a-00ac7dc2f176'),('e05952d6-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','20d06f13-c04e-11e6-9c1a-00ac7dc2f176'),('e059834f-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','11c805bb-c1a4-11e6-956b-00ac7dc2f176'),('e059b50d-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','19a94b63-c1a4-11e6-956b-00ac7dc2f176'),('e059e4f1-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','209a5989-c1a4-11e6-956b-00ac7dc2f176'),('e05a14f8-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','28fc0e36-c1a4-11e6-956b-00ac7dc2f176'),('e05a4623-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','31aa405b-c1a4-11e6-956b-00ac7dc2f176'),('e05a7a64-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','3a38fc2b-c04e-11e6-9c1a-00ac7dc2f176'),('e05aa9f4-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','9ed74c16-c1a4-11e6-956b-00ac7dc2f176'),('e05adaa9-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','a5ab7b0a-c1a4-11e6-956b-00ac7dc2f176'),('e05bc840-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','4a3501b6-c1a5-11e6-956b-00ac7dc2f176'),('e05bfc0e-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','5103a139-c1a5-11e6-956b-00ac7dc2f176'),('e05cec2f-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','57645378-c1a5-11e6-956b-00ac7dc2f176'),('e05d2e37-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','8d69760f-c031-11e6-9c1a-00ac7dc2f176'),('e05d67f0-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','76880a70-c266-11e6-b526-00ac7dc2f176'),('e05d9cd9-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','4282d668-c1cb-11e6-956b-00ac7dc2f176'),('e05dce96-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','4b444879-c1cb-11e6-956b-00ac7dc2f176'),('e05e01c8-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','8eafd5ae-c04e-11e6-9c1a-00ac7dc2f176'),('e05e3711-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','9aca0083-c04e-11e6-9c1a-00ac7dc2f176'),('e05e69a2-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','7386cd02-c04e-11e6-9c1a-00ac7dc2f176'),('e05e9aca-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','e66b6864-c445-11e6-b626-00ac7dc2f176'),('e05ec9b9-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','db6bb42e-c42d-11e6-b626-00ac7dc2f176'),('e05f0167-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','effbb7ef-c10c-11e6-a722-00ac7dc2f176'),('e05f4407-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','a3950c2b-d3f0-11e6-8cda-00ac7dc2f176'),('e05f833a-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','051e0cde-c343-11e6-99a5-00ac7dc2f176'),('e05fb7c6-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','236cd752-c33b-11e6-af95-00ac7dc2f176'),('e05fecc8-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','d18f7189-d3f0-11e6-8cda-00ac7dc2f176'),('e0601ff1-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','d763ea25-c1ca-11e6-956b-00ac7dc2f176'),('e06051ba-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','561e0774-0a0d-11e6-8cac-0025b6dd0800'),('e060882b-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','4413ab1e-0a0e-11e6-8cac-0025b6dd0800'),('e060b902-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','8c8b6966-c111-11e6-a722-00ac7dc2f176'),('e060ea62-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','76947a93-0d1a-11e6-b867-0025b6dd0800'),('e0611afe-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','0d4d30a9-0a0e-11e6-8cac-0025b6dd0800'),('e0615558-02eb-11e7-9b3c-d8cb8ab8c894','fe785f38-0baf-11e6-883e-0025b6dd0800','0b6dd167-0d3e-11e6-b867-0025b6dd0800');

/*Table structure for table `sysuser` */

DROP TABLE IF EXISTS `sysuser`;

CREATE TABLE `sysuser` (
  `sysuser_id` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL COMMENT '用户名,用于登录时输入,和密码一起输入',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `sysrole_id` varchar(50) DEFAULT NULL COMMENT '用户所属角色',
  `is_sysadmin` varchar(45) DEFAULT NULL COMMENT '是否是系统管理员',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `create_man` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_date` datetime DEFAULT NULL COMMENT '更新日期',
  `update_man` varchar(50) DEFAULT NULL COMMENT '更新者',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`sysuser_id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `角色限制` (`sysrole_id`),
  CONSTRAINT `角色限制` FOREIGN KEY (`sysrole_id`) REFERENCES `sysrole` (`sysrole_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户表';

/*Data for the table `sysuser` */

insert  into `sysuser`(`sysuser_id`,`username`,`password`,`sysrole_id`,`is_sysadmin`,`create_date`,`create_man`,`update_date`,`update_man`,`remark`) values ('4b99a5d4-c039-11e6-9c1a-00ac7dc2f176','neunavy','14E1B600B1FD579F47433B88E8D85291','fe785f38-0baf-11e6-883e-0025b6dd0800','是','2016-12-12 15:04:59','伯亮',NULL,NULL,'超级管理员，无法删除'),('526354ba-c037-11e6-9c1a-00ac7dc2f176','sysadmin','D9B1D7DB4CD6E70935368A1EFB10E377','1e225d95-126c-11e6-989d-0025b6dd0800','否','2016-12-12 14:50:51','neunavy',NULL,NULL,''),('8a3c7264-c430-11e6-b626-00ac7dc2f176','teacher','14E1B600B1FD579F47433B88E8D85291','c73f95fd-c42f-11e6-b626-00ac7dc2f176','否','2016-12-17 16:12:24','sysadmin',NULL,NULL,'此角色只可以填写个人信息 无任何权限'),('f4aa8a27-c035-11e6-9c1a-00ac7dc2f176','jianghe','14E1B600B1FD579F47433B88E8D85291','jianghe','否','2016-12-12 14:41:05','sysadmin',NULL,NULL,'');

/*Table structure for table `teacherinfo` */

DROP TABLE IF EXISTS `teacherinfo`;

CREATE TABLE `teacherinfo` (
  `id` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL COMMENT '姓名',
  `brith` datetime DEFAULT NULL COMMENT '生日',
  `level` varchar(45) DEFAULT NULL COMMENT '职称    助教、教授 等 ',
  `photo` varchar(100) DEFAULT NULL COMMENT '照片',
  `tel` varchar(45) DEFAULT NULL COMMENT '电话',
  `fax` varchar(45) DEFAULT NULL COMMENT '传真',
  `email` varchar(100) DEFAULT NULL COMMENT 'e-mail',
  `educations` text COMMENT '教育背景',
  `works` text COMMENT '工作经历',
  `teaching` varchar(1000) DEFAULT NULL COMMENT '研究和教学方向',
  `course` varchar(100) DEFAULT NULL COMMENT '课程教学',
  `benKe` varchar(1000) DEFAULT NULL COMMENT '本科生教学',
  `yanJiu` varchar(1000) DEFAULT NULL COMMENT '研究生教学',
  `thesis` varchar(1000) DEFAULT NULL COMMENT '发表论文',
  `writings` varchar(1000) DEFAULT NULL COMMENT '出版著作',
  `achievements` varchar(1000) DEFAULT NULL COMMENT '科研成果',
  `award` varchar(1000) DEFAULT NULL COMMENT '获奖情况',
  `exchange` varchar(1000) DEFAULT NULL COMMENT '学术交流',
  `parttime` varchar(1000) DEFAULT NULL COMMENT '社会兼职',
  `auditStatus` varchar(45) DEFAULT NULL COMMENT '审核状态',
  `autitDate` datetime DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教师信息';

/*Data for the table `teacherinfo` */

/*Table structure for table `visitorcount` */

DROP TABLE IF EXISTS `visitorcount`;

CREATE TABLE `visitorcount` (
  `pageName` varchar(100) NOT NULL COMMENT '页面名字\n\n前端所有的页面都需要针对每一个页面进行统计\n可以从拦截器中获取到页面名字，然后查询数据库里有没有该页面，若存在，则访问量+1，若不存在，则插入',
  `count` int(22) DEFAULT NULL COMMENT '访问量计数',
  PRIMARY KEY (`pageName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='访问量统计 \n前端所有的页面都需要针对每一个页面进行统计\n可以从拦截器中获取到页面名字，然后查询数据库里有没有该页面，若存在，则访问量+1，若不存在，则插入';

/*Data for the table `visitorcount` */

/*Table structure for table `wheelimg` */

DROP TABLE IF EXISTS `wheelimg`;

CREATE TABLE `wheelimg` (
  `id` varchar(50) NOT NULL,
  `img` varchar(100) DEFAULT NULL COMMENT '图片文件名',
  `sort` int(11) DEFAULT NULL COMMENT '播放顺序',
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='轮播图片';

/*Data for the table `wheelimg` */

insert  into `wheelimg`(`id`,`img`,`sort`,`updatetime`) values ('0','20170717085711_337.jpg',3,'2017-07-17 08:57:11'),('1','20170717085658_654.jpg',2,'2017-07-17 08:56:58'),('2','20170717085738_698.jpg',1,'2017-07-17 08:57:38');

/* Function  structure for function  `getrolename` */

/*!50003 DROP FUNCTION IF EXISTS `getrolename` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `getrolename`(roleid VARCHAR(50)) RETURNS varchar(50) CHARSET utf8
BEGIN
	DECLARE result VARCHAR(50);
	SELECT `sysrole_name` INTO result FROM sysrole WHERE `sysrole_id`= roleid;
	RETURN result;
END */$$
DELIMITER ;

/* Procedure structure for procedure `forinsert` */

/*!50003 DROP PROCEDURE IF EXISTS  `forinsert` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `forinsert`()
BEGIN
	declare i int;
	set i=1;
	while i<=100 do
		insert into news(newsId,moduleType,newsTitle,isDelete) 
			values(uuid(),'647559b5-8dee-11e6-b52b-085700e51ea8',i,'是');
		set i=i+1;
	end while;
END */$$
DELIMITER ;

/*Table structure for table `gq_news_parent` */

DROP TABLE IF EXISTS `gq_news_parent`;

/*!50001 DROP VIEW IF EXISTS `gq_news_parent` */;
/*!50001 DROP TABLE IF EXISTS `gq_news_parent` */;

/*!50001 CREATE TABLE  `gq_news_parent`(
 `newsId` varchar(45) ,
 `moduleType` varchar(45) ,
 `newsTitle` varchar(100) ,
 `newsClass` varchar(100) ,
 `newsDate` datetime ,
 `newsIcon` varchar(45) ,
 `newsAuthor` varchar(45) ,
 `newsDescribe` varchar(200) ,
 `isDelete` varchar(45) ,
 `isTop` varchar(45) ,
 `newsContent` text ,
 `createMan` varchar(45) ,
 `createDate` datetime ,
 `updateMan` varchar(45) ,
 `updateDate` datetime ,
 `newsFile` varchar(2000) ,
 `newsLevel` varchar(45) ,
 `sysmenu_name` varchar(50) ,
 `parentId` varchar(50) ,
 `parentName` varchar(50) 
)*/;

/*Table structure for table `gq_news_typename` */

DROP TABLE IF EXISTS `gq_news_typename`;

/*!50001 DROP VIEW IF EXISTS `gq_news_typename` */;
/*!50001 DROP TABLE IF EXISTS `gq_news_typename` */;

/*!50001 CREATE TABLE  `gq_news_typename`(
 `newsId` varchar(45) ,
 `moduleType` varchar(45) ,
 `newsTitle` varchar(100) ,
 `newsClass` varchar(100) ,
 `newsDate` datetime ,
 `newsIcon` varchar(45) ,
 `newsAuthor` varchar(45) ,
 `newsDescribe` varchar(200) ,
 `isDelete` varchar(45) ,
 `isTop` varchar(45) ,
 `newsContent` text ,
 `createMan` varchar(45) ,
 `createDate` datetime ,
 `updateMan` varchar(45) ,
 `updateDate` datetime ,
 `newsFile` varchar(2000) ,
 `newsLevel` varchar(45) ,
 `sysmenu_name` varchar(50) ,
 `sysmenu_url` varchar(500) ,
 `parent_menuid` varchar(50) 
)*/;

/*Table structure for table `pjj_modetype_news_view` */

DROP TABLE IF EXISTS `pjj_modetype_news_view`;

/*!50001 DROP VIEW IF EXISTS `pjj_modetype_news_view` */;
/*!50001 DROP TABLE IF EXISTS `pjj_modetype_news_view` */;

/*!50001 CREATE TABLE  `pjj_modetype_news_view`(
 `modelId` varchar(50) ,
 `modelName` varchar(100) ,
 `newsId` varchar(45) ,
 `moduleType` varchar(45) ,
 `newsTitle` varchar(100) ,
 `newsClass` varchar(100) ,
 `newsDate` datetime ,
 `newsIcon` varchar(45) ,
 `newsAuthor` varchar(45) ,
 `newsDescribe` varchar(200) ,
 `isDelete` varchar(45) ,
 `isTop` varchar(45) ,
 `newsContent` text ,
 `createMan` varchar(45) ,
 `createDate` datetime ,
 `updateMan` varchar(45) ,
 `updateDate` datetime ,
 `newsFile` varchar(2000) 
)*/;

/*Table structure for table `sys_sysuser_sysmenu_view` */

DROP TABLE IF EXISTS `sys_sysuser_sysmenu_view`;

/*!50001 DROP VIEW IF EXISTS `sys_sysuser_sysmenu_view` */;
/*!50001 DROP TABLE IF EXISTS `sys_sysuser_sysmenu_view` */;

/*!50001 CREATE TABLE  `sys_sysuser_sysmenu_view`(
 `sysuser_id` varchar(50) ,
 `username` varchar(50) ,
 `password` varchar(50) ,
 `sysrole_id` varchar(50) ,
 `is_sysadmin` varchar(45) ,
 `create_date` datetime ,
 `create_man` varchar(50) ,
 `update_date` datetime ,
 `update_man` varchar(50) ,
 `remark` varchar(100) ,
 `sysrolemenu_id` varchar(50) ,
 `sysmenu_id` varchar(50) ,
 `sysmenu_name` varchar(50) ,
 `sysmenu_url` varchar(500) ,
 `parent_menuid` varchar(50) ,
 `is_sysmanage_menu` varchar(45) ,
 `sort` int(11) 
)*/;

/*View structure for view gq_news_parent */

/*!50001 DROP TABLE IF EXISTS `gq_news_parent` */;
/*!50001 DROP VIEW IF EXISTS `gq_news_parent` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gq_news_parent` AS select `news`.`newsId` AS `newsId`,`news`.`moduleType` AS `moduleType`,`news`.`newsTitle` AS `newsTitle`,`news`.`newsClass` AS `newsClass`,`news`.`newsDate` AS `newsDate`,`news`.`newsIcon` AS `newsIcon`,`news`.`newsAuthor` AS `newsAuthor`,`news`.`newsDescribe` AS `newsDescribe`,`news`.`isDelete` AS `isDelete`,`news`.`isTop` AS `isTop`,`news`.`newsContent` AS `newsContent`,`news`.`createMan` AS `createMan`,`news`.`createDate` AS `createDate`,`news`.`updateMan` AS `updateMan`,`news`.`updateDate` AS `updateDate`,`news`.`newsFile` AS `newsFile`,`news`.`newsLevel` AS `newsLevel`,`sysmenu`.`sysmenu_name` AS `sysmenu_name`,`sysmenu`.`parent_menuid` AS `parentId`,`sysmenu_1`.`sysmenu_name` AS `parentName` from ((`sysmenu` left join `sysmenu` `sysmenu_1` on((`sysmenu`.`parent_menuid` = `sysmenu_1`.`sysmenu_id`))) left join `news` on((`news`.`moduleType` = convert(`sysmenu`.`sysmenu_id` using utf8mb4)))) */;

/*View structure for view gq_news_typename */

/*!50001 DROP TABLE IF EXISTS `gq_news_typename` */;
/*!50001 DROP VIEW IF EXISTS `gq_news_typename` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gq_news_typename` AS select `news`.`newsId` AS `newsId`,`news`.`moduleType` AS `moduleType`,`news`.`newsTitle` AS `newsTitle`,`news`.`newsClass` AS `newsClass`,`news`.`newsDate` AS `newsDate`,`news`.`newsIcon` AS `newsIcon`,`news`.`newsAuthor` AS `newsAuthor`,`news`.`newsDescribe` AS `newsDescribe`,`news`.`isDelete` AS `isDelete`,`news`.`isTop` AS `isTop`,`news`.`newsContent` AS `newsContent`,`news`.`createMan` AS `createMan`,`news`.`createDate` AS `createDate`,`news`.`updateMan` AS `updateMan`,`news`.`updateDate` AS `updateDate`,`news`.`newsFile` AS `newsFile`,`news`.`newsLevel` AS `newsLevel`,`sysmenu`.`sysmenu_name` AS `sysmenu_name`,`sysmenu`.`sysmenu_url` AS `sysmenu_url`,`sysmenu`.`parent_menuid` AS `parent_menuid` from (`news` left join `sysmenu` on((`news`.`moduleType` = convert(`sysmenu`.`sysmenu_id` using utf8mb4)))) */;

/*View structure for view pjj_modetype_news_view */

/*!50001 DROP TABLE IF EXISTS `pjj_modetype_news_view` */;
/*!50001 DROP VIEW IF EXISTS `pjj_modetype_news_view` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pjj_modetype_news_view` AS select `modeltype`.`modelId` AS `modelId`,`modeltype`.`modelName` AS `modelName`,`news`.`newsId` AS `newsId`,`news`.`moduleType` AS `moduleType`,`news`.`newsTitle` AS `newsTitle`,`news`.`newsClass` AS `newsClass`,`news`.`newsDate` AS `newsDate`,`news`.`newsIcon` AS `newsIcon`,`news`.`newsAuthor` AS `newsAuthor`,`news`.`newsDescribe` AS `newsDescribe`,`news`.`isDelete` AS `isDelete`,`news`.`isTop` AS `isTop`,`news`.`newsContent` AS `newsContent`,`news`.`createMan` AS `createMan`,`news`.`createDate` AS `createDate`,`news`.`updateMan` AS `updateMan`,`news`.`updateDate` AS `updateDate`,`news`.`newsFile` AS `newsFile` from (`modeltype` left join `news` on((convert(`modeltype`.`modelId` using utf8mb4) = `news`.`moduleType`))) */;

/*View structure for view sys_sysuser_sysmenu_view */

/*!50001 DROP TABLE IF EXISTS `sys_sysuser_sysmenu_view` */;
/*!50001 DROP VIEW IF EXISTS `sys_sysuser_sysmenu_view` */;

/*!50001 CREATE ALGORITHM=TEMPTABLE DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sys_sysuser_sysmenu_view` AS select `sysuser`.`sysuser_id` AS `sysuser_id`,`sysuser`.`username` AS `username`,`sysuser`.`password` AS `password`,`sysuser`.`sysrole_id` AS `sysrole_id`,`sysuser`.`is_sysadmin` AS `is_sysadmin`,`sysuser`.`create_date` AS `create_date`,`sysuser`.`create_man` AS `create_man`,`sysuser`.`update_date` AS `update_date`,`sysuser`.`update_man` AS `update_man`,`sysuser`.`remark` AS `remark`,`sysrolemenu`.`sysrolemenu_id` AS `sysrolemenu_id`,`sysmenu`.`sysmenu_id` AS `sysmenu_id`,`sysmenu`.`sysmenu_name` AS `sysmenu_name`,`sysmenu`.`sysmenu_url` AS `sysmenu_url`,`sysmenu`.`parent_menuid` AS `parent_menuid`,`sysmenu`.`is_sysmanage_menu` AS `is_sysmanage_menu`,`sysmenu`.`sort` AS `sort` from ((`sysuser` left join `sysrolemenu` on((`sysuser`.`sysrole_id` = `sysrolemenu`.`sysrole_id`))) left join `sysmenu` on((`sysrolemenu`.`sysmenu_id` = `sysmenu`.`sysmenu_id`))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;