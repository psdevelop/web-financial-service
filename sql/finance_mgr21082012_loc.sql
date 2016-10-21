# SQL Manager Lite for MySQL 5.1.0.5
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : finance_mgr


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE `finance_mgr`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `finance_mgr`;

#
# Структура для таблицы `action`: 
#

CREATE TABLE `action` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `action_data_templates`: 
#

CREATE TABLE `action_data_templates` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `action_statuses`: 
#

CREATE TABLE `action_statuses` (
  `action_status_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `act_status_name` VARCHAR(255) COLLATE utf8_general_ci NOT NULL,
  `closed` INTEGER(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`action_status_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=4 AVG_ROW_LENGTH=33 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `articles_categories`: 
#

CREATE TABLE `articles_categories` (
  `aricle_cat_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `acat_name` VARCHAR(255) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`aricle_cat_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `articles_storage`: 
#

CREATE TABLE `articles_storage` (
  `article_storage_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `article_title` VARCHAR(255) COLLATE utf8_general_ci NOT NULL,
  `article_body_standart` TEXT COLLATE utf8_general_ci,
  `astor_category_id` INTEGER(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`article_storage_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `attempts`: 
#

CREATE TABLE `attempts` (
  `ip` VARCHAR(15) COLLATE utf8_general_ci NOT NULL,
  `count` INTEGER(11) NOT NULL,
  `expiredate` DATETIME NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `category_dictionary`: 
#

CREATE TABLE `category_dictionary` (
  `category_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `closed` INTEGER(11) DEFAULT 0,
  `parent_category_id` INTEGER(11) NOT NULL DEFAULT 0,
  `category_level` INTEGER(11) NOT NULL DEFAULT 0,
  `user_id` INTEGER(11) NOT NULL,
  `big_image_id` INTEGER(11) NOT NULL DEFAULT 0,
  `small_image_id` INTEGER(11) NOT NULL DEFAULT 0,
  `default_entity_id` INTEGER(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`category_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=845 AVG_ROW_LENGTH=44 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `content_type`: 
#

CREATE TABLE `content_type` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `currencies_rates`: 
#

CREATE TABLE `currencies_rates` (
  `currency_rate_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `rate_date` DATE NOT NULL,
  `rate_currency_id` INTEGER(11) NOT NULL,
  `currency_rate_value` DOUBLE(15,3) NOT NULL,
  PRIMARY KEY (`currency_rate_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=231 AVG_ROW_LENGTH=20 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `currency_dictionary`: 
#

CREATE TABLE `currency_dictionary` (
  `currency_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `currency_name` VARCHAR(255) COLLATE utf8_general_ci NOT NULL,
  `currency_rate` DOUBLE(15,3) NOT NULL DEFAULT 1.000,
  `closed` INTEGER(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`currency_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=4 AVG_ROW_LENGTH=29 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `dictionary`: 
#

CREATE TABLE `dictionary` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `entity_groups`: 
#

CREATE TABLE `entity_groups` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `group_name` VARCHAR(255) COLLATE utf8_general_ci NOT NULL,
  `table_name` VARCHAR(150) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `entity_types`: 
#

CREATE TABLE `entity_types` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `finance_action_data_storage`: 
#

CREATE TABLE `finance_action_data_storage` (
  `fca_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `fca_operation_id` INTEGER(11) DEFAULT 0,
  `fca_actor_id` INTEGER(11) NOT NULL DEFAULT 0,
  `fca_quantity` DOUBLE(15,3) DEFAULT NULL,
  `fca_summ` DOUBLE(15,3) DEFAULT NULL,
  `fca_purse_id` INTEGER(11) DEFAULT NULL,
  `fca_actor_description` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `fca_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fca_description` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `fca_operation_type_id` INTEGER(11) DEFAULT 0,
  `closed` INTEGER(11) NOT NULL DEFAULT 0,
  `fca_category_id` INTEGER(11) DEFAULT 0,
  `fca_currency_id` INTEGER(11) DEFAULT 0,
  `fca_sync_key` VARCHAR(2000) COLLATE utf8_general_ci DEFAULT NULL,
  `fca_plan_id` INTEGER(11) DEFAULT 0,
  `fca_transfert_purse_id` INTEGER(11) DEFAULT 0,
  `fca_status_id` INTEGER(11) DEFAULT 1,
  `order_index` INTEGER(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`fca_id`)
)ENGINE=InnoDB
AUTO_INCREMENT=2337 AVG_ROW_LENGTH=414 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `finance_operation`: 
#

CREATE TABLE `finance_operation` (
  `finance_operation_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `operation_id` INTEGER(11) NOT NULL,
  `finance_op_descript` INTEGER(11) DEFAULT NULL,
  `finance_quantity` DOUBLE(15,3) NOT NULL,
  `finance_summ` DOUBLE(15,3) NOT NULL,
  `purse_dictionary_id` INTEGER(11) NOT NULL,
  PRIMARY KEY (`finance_operation_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `images`: 
#

CREATE TABLE `images` (
  `image_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `image_path` VARCHAR(1000) COLLATE utf8_general_ci NOT NULL,
  `image_caption` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`image_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=27 AVG_ROW_LENGTH=44 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `interface_type`: 
#

CREATE TABLE `interface_type` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `invite`: 
#

CREATE TABLE `invite` (
  `name` TEXT COLLATE utf8_general_ci NOT NULL,
  `email` TEXT COLLATE utf8_general_ci NOT NULL
)ENGINE=MyISAM
AVG_ROW_LENGTH=32 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `operation`: 
#

CREATE TABLE `operation` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `optype_dictionary`: 
#

CREATE TABLE `optype_dictionary` (
  `optype_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `optype_name` VARCHAR(255) COLLATE utf8_general_ci NOT NULL,
  `account_type` INTEGER(11) NOT NULL DEFAULT 0,
  `closed` INTEGER(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`optype_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=17 AVG_ROW_LENGTH=48 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `payment_systems`: 
#

CREATE TABLE `payment_systems` (
  `payment_system_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `payment_system_name` VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
  `ps_order_counter` INTEGER(11) UNSIGNED NOT NULL DEFAULT 0,
  `ps_custom_name` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `account_merchant_id` VARCHAR(50) COLLATE utf8_general_ci NOT NULL DEFAULT 'XXXXXX',
  PRIMARY KEY (`payment_system_id`),
  UNIQUE KEY `payment_system_name` (`payment_system_name`)
)ENGINE=MyISAM
AUTO_INCREMENT=2 AVG_ROW_LENGTH=32 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `person_types`: 
#

CREATE TABLE `person_types` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `person_type_name` VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
  `closed` INTEGER(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=11 AVG_ROW_LENGTH=29 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `persons`: 
#

CREATE TABLE `persons` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `code` VARCHAR(10) COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `person_type_id` INTEGER(11) NOT NULL DEFAULT 0,
  `first_name` VARCHAR(100) COLLATE utf8_general_ci DEFAULT NULL,
  `last_name` VARCHAR(100) COLLATE utf8_general_ci DEFAULT NULL,
  `sur_name` VARCHAR(100) COLLATE utf8_general_ci DEFAULT NULL,
  `stationare_phones` VARCHAR(255) COLLATE utf8_general_ci DEFAULT 'Не заданы',
  `mobile_phones` VARCHAR(255) COLLATE utf8_general_ci DEFAULT 'Не заданы',
  `employment_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `closed` INTEGER(11) NOT NULL DEFAULT 0,
  `uid` INTEGER(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `person_type_id` (`person_type_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=434 AVG_ROW_LENGTH=72 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `plan_dictionary`: 
#

CREATE TABLE `plan_dictionary` (
  `plan_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `plan_name` VARCHAR(255) COLLATE utf8_general_ci NOT NULL,
  `plan_summ` DOUBLE(15,3) NOT NULL DEFAULT 0.000,
  `complete_days_count` INTEGER(11) NOT NULL DEFAULT 0,
  `first_payment_date` DATE DEFAULT NULL,
  `plan_optype_id` INTEGER(11) NOT NULL,
  `plan_shedule_id` INTEGER(11) NOT NULL DEFAULT 0,
  `default_purse_id` INTEGER(11) DEFAULT 0,
  `complete_month_count` INTEGER(11) NOT NULL DEFAULT 0,
  `user_id` INTEGER(11) NOT NULL,
  `min_payment_summ` DOUBLE(15,3) DEFAULT 0.000,
  `closed` INTEGER(11) NOT NULL DEFAULT 0,
  `apr` DECIMAL(15,3) NOT NULL DEFAULT 0.000,
  `extra_payment` DECIMAL(15,3) NOT NULL DEFAULT 0.000,
  `plan_currency_id` INTEGER(11) DEFAULT 0,
  `target_date` DATE DEFAULT NULL,
  PRIMARY KEY (`plan_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=14 AVG_ROW_LENGTH=65 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `plan_shedules_dictionary`: 
#

CREATE TABLE `plan_shedules_dictionary` (
  `shedule_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `year_frequency` INTEGER(11) NOT NULL DEFAULT 12,
  `is_periodic` INTEGER(11) NOT NULL DEFAULT 0,
  `shedule_name` VARCHAR(20) COLLATE utf8_general_ci NOT NULL,
  `closed` INTEGER(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`shedule_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=3 AVG_ROW_LENGTH=46 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `purse_dictionary`: 
#

CREATE TABLE `purse_dictionary` (
  `purse_dictionary_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `pd_dictionary_id` INTEGER(11) NOT NULL DEFAULT 0,
  `purse_logo_img` VARCHAR(255) COLLATE utf8_general_ci DEFAULT '',
  `purse_name` VARCHAR(255) COLLATE utf8_general_ci NOT NULL,
  `closed` INTEGER(11) NOT NULL DEFAULT 0,
  `user_id` INTEGER(11) NOT NULL,
  `purse_currency_id` INTEGER(11) NOT NULL DEFAULT 0,
  `purse_ptype_id` INTEGER(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`purse_dictionary_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=26 AVG_ROW_LENGTH=58 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `purstype_dictionary`: 
#

CREATE TABLE `purstype_dictionary` (
  `purse_type_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `closed` INTEGER(11) NOT NULL DEFAULT 0,
  `purse_type_name` VARCHAR(255) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`purse_type_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=4 AVG_ROW_LENGTH=37 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `sessions`: 
#

CREATE TABLE `sessions` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `uid` INTEGER(11) NOT NULL,
  `username` VARCHAR(30) COLLATE utf8_general_ci NOT NULL,
  `hash` VARCHAR(32) COLLATE utf8_general_ci NOT NULL,
  `expiredate` DATETIME NOT NULL,
  `ip` VARCHAR(15) COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1332 AVG_ROW_LENGTH=40 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `struct_type`: 
#

CREATE TABLE `struct_type` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `task`: 
#

CREATE TABLE `task` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `template`: 
#

CREATE TABLE `template` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `test_table`: 
#

CREATE TABLE `test_table` (
  `str_field` VARCHAR(255) COLLATE utf8_general_ci NOT NULL
)ENGINE=MyISAM
CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `user_payments`: 
#

CREATE TABLE `user_payments` (
  `user_payment_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `payment_summ` DOUBLE(15,3) NOT NULL DEFAULT 0.000,
  `psystem_id` INTEGER(11) NOT NULL,
  `approved_status` SMALLINT(6) NOT NULL DEFAULT 0,
  `start_datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_optype_id` INTEGER(11) NOT NULL DEFAULT 1,
  `payment_currency_id` INTEGER(11) DEFAULT NULL,
  `payment_currency_code` VARCHAR(50) COLLATE utf8_general_ci DEFAULT NULL,
  `payment_user_id` INTEGER(11) NOT NULL,
  `order_number` VARCHAR(50) COLLATE utf8_general_ci NOT NULL,
  `billing_number` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `target_payment_system_name` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  `payment_datetime` TIMESTAMP NULL NOT NULL,
  `approve_currency_id` INTEGER(11) DEFAULT NULL,
  `ps_order_number` INTEGER(11) NOT NULL,
  `closed` INTEGER(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_payment_id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `users`: 
#

CREATE TABLE `users` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(30) COLLATE utf8_general_ci NOT NULL,
  `password` VARCHAR(128) COLLATE utf8_general_ci NOT NULL,
  `email` VARCHAR(100) COLLATE utf8_general_ci NOT NULL,
  `isactive` TINYINT(1) NOT NULL DEFAULT 0,
  `person_id` INTEGER(11) NOT NULL DEFAULT 0,
  `closed` INTEGER(11) NOT NULL DEFAULT 0,
  `enable_admin` CHAR(1) COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `enable_deleting` CHAR(1) COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `db_server_adress` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT 'localhost',
  `user_db_name` VARCHAR(255) COLLATE utf8_general_ci NOT NULL DEFAULT 'finance_mgr',
  `user_db_login` VARCHAR(50) COLLATE utf8_general_ci NOT NULL DEFAULT 'root',
  `load_visa_default_cats` BIT(1) NOT NULL DEFAULT 0,
  `load_visa_cats` INTEGER(11) NOT NULL DEFAULT 0,
  `default_currency_id` INTEGER(11) NOT NULL DEFAULT 0,
  `external_reg` SMALLINT(6) DEFAULT 0,
  `system_name` VARCHAR(255) COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=36 AVG_ROW_LENGTH=92 CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Структура для таблицы `visual_form`: 
#

CREATE TABLE `visual_form` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
)ENGINE=MyISAM
AUTO_INCREMENT=1 ROW_FORMAT=FIXED CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
COMMENT=''
;

#
# Definition for the `f_get_category_name` function : 
#

CREATE DEFINER = 'root'@'localhost' FUNCTION `f_get_category_name`(
        in_cat_id INTEGER
    )
    RETURNS varchar(255) CHARSET utf8
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  SET @res=NULL;
  SELECT category_name INTO @res FROM `category_dictionary` 
  WHERE `category_id`=in_cat_id;
  RETURN @res;
END;

#
# Определение для процедуры `get_category_parent_with_level`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `get_category_parent_with_level`(
        IN in_cat_id INTEGER(11),
        IN in_parent_max_level INTEGER(11),
        OUT out_parent_id INTEGER(11),
        OUT out_parent_name VARCHAR(255)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
    SET @parent_name=NULL;
    SET @parent_id=0;
    SET @parent_cat_id=NULL;
    SET @cat_level=NULL;
    
	IF (NOT ISNULL(in_cat_id) AND NOT ISNULL(in_parent_max_level)) THEN
  	IF ((in_cat_id>0) AND (in_parent_max_level>=0)) THEN
  		SELECT category_id, category_name, parent_category_id, category_level 
        	INTO @parent_id, @parent_name, @parent_cat_id, @cat_level  
  			FROM `category_dictionary` WHERE category_id=in_cat_id;
  		
  		IF (NOT ISNULL(@parent_cat_id) AND NOT ISNULL(@cat_level)) THEN
        	IF ((@cat_level>in_parent_max_level) AND (@parent_cat_id>0)) THEN

        		SET max_sp_recursion_depth=3000;
            	call `get_category_parent_with_level`
                	(@parent_cat_id, in_parent_max_level, @parent_id, @parent_name);

        	END IF;
        END IF;
        
  	END IF;
  	END IF;
    
    SET out_parent_id=@parent_id;
    SET out_parent_name=@parent_name;
    
END;

#
# Definition for the `f_get_category_root_id` function : 
#

CREATE DEFINER = 'root'@'localhost' FUNCTION `f_get_category_root_id`(
        in_cat_id INTEGER(11)
    )
    RETURNS int(11)
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  SET @out_cat_id=NULL;
  SET @out_cat_name=NULL;
  
  call `get_category_parent_with_level`
  	( in_cat_id, 0,@out_cat_id, @out_cat_name);
  
  RETURN @out_cat_id;
END;

#
# Definition for the `f_get_category_root_name` function : 
#

CREATE DEFINER = 'root'@'localhost' FUNCTION `f_get_category_root_name`(
        in_cat_id INTEGER(11)
    )
    RETURNS varchar(255) CHARSET utf8
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  SET @out_cat_id=NULL;
  SET @out_cat_name=NULL;
  
  call `get_category_parent_with_level`
  	( in_cat_id, 0,@out_cat_id, @out_cat_name);
  
  RETURN @out_cat_name;
END;

#
# Definition for the `f_get_currency_rate` function : 
#

CREATE DEFINER = 'root'@'localhost' FUNCTION `f_get_currency_rate`(
        in_rate_date DATE,
        in_currency_id INTEGER(11)
    )
    RETURNS decimal(15,13)
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  SET @currency_rate=1.0;
  SELECT IFNULL(currency_rate_value, 1.0) INTO @currency_rate
  FROM `currencies_rates` WHERE
  rate_currency_id=in_currency_id AND rate_date=in_rate_date;
  IF ISNULL(@currency_rate)	THEN
  	SET @currency_rate=1.0;
  END IF;
  RETURN @currency_rate;
END;

#
# Определение для представления `plan_view`: 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `plan_view`
AS
select 
    `pdc`.`plan_id` AS `plan_id`,
    `pdc`.`plan_name` AS `plan_name`,
    `pdc`.`plan_summ` AS `plan_summ`,
    `pdc`.`complete_days_count` AS `complete_days_count`,
    `pdc`.`first_payment_date` AS `first_payment_date`,
    `pdc`.`plan_optype_id` AS `plan_optype_id`,
    `pdc`.`plan_shedule_id` AS `plan_shedule_id`,
    `pdc`.`default_purse_id` AS `default_purse_id`,
    `pdc`.`complete_month_count` AS `complete_month_count`,
    `odc`.`account_type` AS `account_type`,
    `odc`.`optype_name` AS `optype_name`,
    `pdc`.`user_id` AS `user_id`,
    `pdc`.`min_payment_summ` AS `min_payment_summ`,
    `pdc`.`closed` AS `closed`,
    `pdc`.`apr` AS `apr`,
    `pdc`.`extra_payment` AS `extra_payment`,
    `pdc`.`plan_currency_id` AS `plan_currency_id`,
    `pdc`.`target_date` AS `target_date` 
  from 
    (`plan_dictionary` `pdc` left join `optype_dictionary` `odc` on((`pdc`.`plan_optype_id` = `odc`.`optype_id`)));

#
# Определение для процедуры `get_purse_calculated_on_moment`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `get_purse_calculated_on_moment`(
        IN in_purse_id INTEGER(11),
        OUT purse_summ DECIMAL(15,3),
        IN in_moment TIMESTAMP,
        IN in_fca_id INTEGER(11)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	SELECT SUM(fcav.`fca_summ`*`f_get_currency_rate`(CAST(`fcav`.`fca_date` AS DATE),`fcav`.`fca_currency_id`)/`f_get_currency_rate`(CAST(`fcav`.`fca_date` AS DATE),`fcav`.`purse_currency_id`)*IF(fcav.`account_type`=1,1,-1)) INTO purse_summ 
    from 
    (select 
    `fca`.`fca_id` AS `fca_id`,
    `fca`.`fca_operation_id` AS `fca_operation_id`,
    `fca`.`fca_actor_id` AS `fca_actor_id`,
    `fca`.`fca_quantity` AS `fca_quantity`,
    `fca`.`fca_summ` AS `fca_summ`,
    `fca`.`fca_purse_id` AS `fca_purse_id`,
    `fca`.`fca_actor_description` AS `fca_actor_description`,
    `fca`.`fca_date` AS `fca_date`,
    `fca`.`fca_description` AS `fca_description`,
    `fca`.`fca_operation_type_id` AS `fca_operation_type_id`,
    `fca`.`closed` AS `closed`,
    `fca`.`fca_category_id` AS `fca_category_id`,
    `fca`.`fca_currency_id` AS `fca_currency_id`,
    `fca`.`fca_sync_key` AS `fca_sync_key`,
    `fca`.`fca_plan_id` AS `fca_plan_id`,
    `fca`.`fca_transfert_purse_id` AS `fca_transfert_purse_id`,
    `pdc`.`purse_name` AS `purse_name`,
    ifnull(`pdc`.`user_id`,`plv`.`user_id`) AS `user_id`,
    `odc`.`account_type` AS `account_type`,
    `plv`.`plan_name` AS `plan_name`,
    `odc`.`optype_name` AS `optype_name`,
    `cdc`.`currency_name` AS `currency_name`,
    `cdc`.`currency_rate` AS `currency_rate`,
    ifnull(`ctdc`.`category_name`,'Без категории') AS `category_name`,
    `fca`.`fca_status_id` AS `fca_status_id`,
    `pdc`.`purse_currency_id` AS `purse_currency_id` 
  from 
    (((((`finance_action_data_storage` `fca` left join `purse_dictionary` `pdc` 
    on((`fca`.`fca_purse_id` = `pdc`.`purse_dictionary_id`))) 
    left join `optype_dictionary` `odc` 
    on((`fca`.`fca_operation_type_id` = `odc`.`optype_id`))) 
    left join `currency_dictionary` `cdc` 
    on((`fca`.`fca_currency_id` = `cdc`.`currency_id`))) 
    left join `category_dictionary` `ctdc` 
    on((`fca`.`fca_category_id` = `ctdc`.`category_id`))) 
    left join `plan_view` `plv` on((`fca`.`fca_plan_id` = `plv`.`plan_id`)))
    WHERE pdc.purse_dictionary_id=in_purse_id
    ) 
    fcav 
    WHERE fcav.`fca_purse_id`=in_purse_id AND closed<>1 AND ((`fcav`.`fca_date`<in_moment) OR ((`fcav`.`fca_date`=in_moment) AND (`fcav`.`fca_id`<=in_fca_id))) AND `fcav`.`account_type`<2 AND `fcav`.`fca_status_id`=3;
END;

#
# Definition for the `f_get_purse_calculated_on_moment` function : 
#

CREATE DEFINER = 'root'@'localhost' FUNCTION `f_get_purse_calculated_on_moment`(
        in_purse_id INTEGER(11),
        in_moment TIMESTAMP,
        in_fca_id INTEGER(11)
    )
    RETURNS decimal(15,3)
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  SET @purse_summ=0.0;
  call `get_purse_calculated_on_moment`(in_purse_id, 
  	@purse_summ, in_moment, in_fca_id);
  RETURN @purse_summ;
END;

#
# Определение для представления `fca_view`: 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `fca_view`
AS
select 
    `fca`.`fca_id` AS `fca_id`,
    `fca`.`fca_operation_id` AS `fca_operation_id`,
    `fca`.`fca_actor_id` AS `fca_actor_id`,
    `fca`.`fca_quantity` AS `fca_quantity`,
    `fca`.`fca_summ` AS `fca_summ`,
    `fca`.`fca_purse_id` AS `fca_purse_id`,
    `fca`.`fca_actor_description` AS `fca_actor_description`,
    `fca`.`fca_date` AS `fca_date`,
    `fca`.`fca_description` AS `fca_description`,
    `fca`.`fca_operation_type_id` AS `fca_operation_type_id`,
    `fca`.`closed` AS `closed`,
    `fca`.`fca_category_id` AS `fca_category_id`,
    `fca`.`fca_currency_id` AS `fca_currency_id`,
    `fca`.`fca_sync_key` AS `fca_sync_key`,
    `fca`.`fca_plan_id` AS `fca_plan_id`,
    `fca`.`fca_transfert_purse_id` AS `fca_transfert_purse_id`,
    `pdc`.`purse_name` AS `purse_name`,
    ifnull(`pdc`.`user_id`,`plv`.`user_id`) AS `user_id`,
    `odc`.`account_type` AS `account_type`,
    `plv`.`plan_name` AS `plan_name`,
    `odc`.`optype_name` AS `optype_name`,
    `cdc`.`currency_name` AS `currency_name`,
    `cdc`.`currency_rate` AS `currency_rate`,
    ifnull(`ctdc`.`category_name`,'Без категории') AS `category_name`,
    `ctdc`.`parent_category_id` AS `parent_category_id`,
    `ctdc`.`default_entity_id` AS `category_entity_id`,
    `fca`.`fca_status_id` AS `fca_status_id`,
    `pdc`.`purse_currency_id` AS `purse_currency_id`,
    `f_get_purse_calculated_on_moment`(`fca`.`fca_purse_id`,`fca`.`fca_date`,`fca`.`fca_id`) AS `fca_moment_psumm`,
    `f_get_category_name`(`ctdc`.`parent_category_id`) AS `parent_category_name` 
  from 
    (((((`finance_action_data_storage` `fca` left join `purse_dictionary` `pdc` on((`fca`.`fca_purse_id` = `pdc`.`purse_dictionary_id`))) left join `optype_dictionary` `odc` on((`fca`.`fca_operation_type_id` = `odc`.`optype_id`))) left join `currency_dictionary` `cdc` on((`fca`.`fca_currency_id` = `cdc`.`currency_id`))) left join `category_dictionary` `ctdc` on((`fca`.`fca_category_id` = `ctdc`.`category_id`))) left join `plan_view` `plv` on((`fca`.`fca_plan_id` = `plv`.`plan_id`)));

#
# Определение для процедуры `get_category_calculated`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `get_category_calculated`(
        IN in_cat_id INTEGER(11),
        INOUT cat_summ DOUBLE(15,3),
        IN in_user_id INTEGER(11)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
    DECLARE b INT;
    DECLARE fetch_ch_cat_id INTEGER(11);
    DECLARE ch_cat_summ DECIMAL(15,3);
    DECLARE ch_cats_cur CURSOR FOR  
    SELECT ch_cats.`category_id`
    FROM `category_dictionary` ch_cats 
    WHERE (ch_cats.`parent_category_id`=in_cat_id) 
    AND (closed<>1);
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET b = 1;
    
    SET @cat_derived_summ=0.0;
    
    OPEN ch_cats_cur; 
    SET b = 0;  
    WHILE b = 0 DO 
        FETCH ch_cats_cur INTO fetch_ch_cat_id; 
        SET ch_cat_summ=0;
        IF b = 0 THEN 
            SET max_sp_recursion_depth=3000;
			call `get_category_calculated`(
            	fetch_ch_cat_id, ch_cat_summ, in_user_id);
            IF NOT ISNULL(ch_cat_summ)	THEN
            	SET @cat_derived_summ = 
                	@cat_derived_summ+ch_cat_summ;
            END IF;    
    	END IF; 

    END WHILE; 

    CLOSE ch_cats_cur;
    
	SELECT SUM(fcav.`fca_summ`*IF(fcav.`account_type`=1,1,-1)) INTO cat_summ 
    from `fca_view` fcav 
    WHERE fcav.`fca_category_id`=in_cat_id AND closed<>1 AND
    fcav.`user_id`=in_user_id AND `fcav`.`account_type`<2 AND `fcav`.`fca_status_id`=3;
    IF ISNULL(@cat_derived_summ) THEN
    	SET @cat_derived_summ=0.0;
    END IF;
    IF ISNULL(cat_summ) THEN
    	SET cat_summ=0.0;
    END IF;
    SET cat_summ=cat_summ+@cat_derived_summ;
END;

#
# Definition for the `f_get_cat_summ` function : 
#

CREATE DEFINER = 'root'@'localhost' FUNCTION `f_get_cat_summ`(
        in_cat_id INTEGER(11),
        in_user_id INTEGER(11)
    )
    RETURNS double(15,3)
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	SET @cat_summ=0.0;
  	call `get_category_calculated`(in_cat_id, 
  	@cat_summ, in_user_id);
  	RETURN @cat_summ;
END;

#
# Определение для процедуры `get_purse_calculated`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `get_purse_calculated`(
        IN in_purse_id INTEGER(11),
        OUT purse_summ DECIMAL(15,3)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	SELECT SUM(fcav.`fca_summ`*`f_get_currency_rate`(CAST(`fcav`.`fca_date` AS DATE),`fcav`.`fca_currency_id`)/`f_get_currency_rate`(CAST(`fcav`.`fca_date` AS DATE),`fcav`.`purse_currency_id`)*IF(fcav.`account_type`=1,1,-1)) INTO purse_summ 
    from `fca_view` fcav 
    WHERE fcav.`fca_purse_id`=in_purse_id AND closed<>1 AND `fcav`.`account_type`<2 AND `fcav`.`fca_status_id`=3;
END;

#
# Definition for the `f_get_purse_calculated` function : 
#

CREATE DEFINER = 'root'@'localhost' FUNCTION `f_get_purse_calculated`(
        in_purse_id INTEGER(11)
    )
    RETURNS decimal(15,3)
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  SET @purse_summ=0.0;
  call `get_purse_calculated`(in_purse_id, 
  	@purse_summ);
  RETURN @purse_summ;
END;

#
# Определение для процедуры `get_category_parenting`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `get_category_parenting`(
        IN in_cat_id INTEGER(11),
        IN in_parent_cat_id INTEGER(11),
        OUT is_parenting SMALLINT
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
    SET @parent_cat_id=0;
    SET @res=0;
    
	IF (NOT ISNULL(in_cat_id) AND NOT ISNULL(in_parent_cat_id)) THEN
  	IF ((in_cat_id>0) AND (in_parent_cat_id>0)) THEN
  		SELECT parent_category_id INTO @parent_cat_id 
  			FROM `category_dictionary` WHERE category_id=in_cat_id;
  		
  		IF (NOT ISNULL(@parent_cat_id)) THEN
        	IF (@parent_cat_id>0) THEN
        		IF (@parent_cat_id=in_parent_cat_id) THEN
        			SET @res=1;
  				ELSE
        			SET max_sp_recursion_depth=3000;
            		call `get_category_parenting`(@parent_cat_id, in_parent_cat_id, @res);
  				END IF;
            END IF;
        END IF;
        
  	END IF;
  	END IF;
    
    SET is_parenting=@res;
    
END;

#
# Definition for the `f_its_child_category` function : 
#

CREATE DEFINER = 'root'@'localhost' FUNCTION `f_its_child_category`(
        in_cat_id INTEGER(11),
        in_parent_cat_id INTEGER(11)
    )
    RETURNS tinyint(1)
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
  SET @res=FALSE;
  SET @sp_res=0;
  call `get_category_parenting`(in_cat_id, in_parent_cat_id, @sp_res);
  IF (@sp_res=1) THEN
  	SET @res=TRUE;
  END IF;
  RETURN @res;
END;

#
# Определение для процедуры `add_default_income_cats`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `add_default_income_cats`(
        IN in_user_id INTEGER(11)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	IF NOT ISNULL(in_user_id) THEN
    	INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) 
            VALUES (NULL,'Зарплата и личные доходы',0,0,0,in_user_id, 96);
		
        SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT(); 
		INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  			(NULL,'Зарплата (вкл. налоги)',0,@last_cat_id,1,in_user_id,97),
  			(NULL,'Зарплата (без налогов)',0,@last_cat_id,1,in_user_id,98),
            (NULL,'Оклад',0,@last_cat_id,1,in_user_id,99),
            (NULL,'Бонус',0,@last_cat_id,1,in_user_id,100),
            (NULL,'Премия',0,@last_cat_id,1,in_user_id,101),
            (NULL,'Предпринимательский доход',0,@last_cat_id,1,in_user_id,102),
            (NULL,'Пенсия',0,@last_cat_id,1,in_user_id,103);
            
        INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) 
            VALUES (NULL,'Инвестиционный доход',0,0,0,in_user_id, 104);
		
        SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT(); 
		INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  			(NULL,'Дивиденды',0,@last_cat_id,1,in_user_id,105),
  			(NULL,'Доход от аренды',0,@last_cat_id,1,in_user_id,106),
            (NULL,'Прирост капитала',0,@last_cat_id,1,in_user_id,107),
            (NULL,'Проценты',0,@last_cat_id,1,in_user_id,108);
        
        INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) 
            VALUES (NULL,'Прочие доходы',0,0,0,in_user_id, 109);
    END IF;
END;

#
# Определение для процедуры `add_update_category`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `add_update_category`(
        IN in_category_id INTEGER(11),
        IN in_category_name VARCHAR(255),
        IN in_parent_category_id INTEGER(11),
        IN in_category_level INTEGER(11),
        IN in_user_id INTEGER(11)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
    SET @new_cat_level=NULL;
	IF ISNULL(in_category_id) THEN
		
        SET @new_cat_level=NULL;
        IF NOT ISNULL(in_parent_category_id) AND 
        	(in_parent_category_id>0) THEN
       		SELECT (category_level+1) INTO @new_cat_level	
        	FROM `category_dictionary` 
        	WHERE (`category_id`=in_parent_category_id);
        ELSE
        	SET @new_cat_level=0;
        END IF;
        
        IF NOT ISNULL(@new_cat_level) THEN
        	insert into `category_dictionary`
			(`category_id`,`category_name`, `parent_category_id`,
    		`category_level`, `user_id`) 
			values(null, in_category_name, in_parent_category_id,
    		@new_cat_level, in_user_id);
        END IF;
        
	END IF;
END;

#
# Определение для процедуры `add_update_fca`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `add_update_fca`(
        INOUT in_fca_id INTEGER(11),
        IN in_fca_purse_id INTEGER(11),
        IN in_fca_operation_type_id INTEGER(11),
        IN in_fca_date TIMESTAMP,
        IN in_fca_actor_description VARCHAR(255),
        IN in_fca_description VARCHAR(255),
        IN in_fca_summ DECIMAL(15,3),
        IN in_fca_category_id INTEGER(11),
        IN in_fca_transfert_purse_id INTEGER(11),
        IN const_income_transf_optype_id INTEGER(11),
        IN const_outcome_transf_optype_id INTEGER(11)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
    IF ISNULL(in_fca_id) THEN
    	insert into `finance_action_data_storage`(`fca_id`,`fca_purse_id`, 
    		`fca_operation_type_id`, `fca_date`, `fca_actor_description`, 
    		`fca_description`, `fca_summ`, `fca_category_id`, `fca_transfert_purse_id`) 
    		values(null,in_fca_purse_id, in_fca_operation_type_id, in_fca_date, 
    		in_fca_actor_description, in_fca_description, 
			in_fca_summ, in_fca_category_id,in_fca_transfert_purse_id);
            
    	IF (in_fca_operation_type_id=const_income_transf_optype_id) THEN
    		insert into `finance_action_data_storage`(`fca_id`,`fca_purse_id`, 
    			`fca_operation_type_id`, `fca_date`, `fca_actor_description`, 
    			`fca_description`, `fca_summ`, `fca_category_id`, `fca_transfert_purse_id`) 
    			values(null,in_fca_transfert_purse_id, const_outcome_transf_optype_id, 
                in_fca_date, in_fca_actor_description, in_fca_description, 
				in_fca_summ, in_fca_category_id, in_fca_purse_id);
        END IF;	
    
    END IF;
END;

#
# Определение для процедуры `add_update_fca_2ver`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `add_update_fca_2ver`(
        INOUT in_fca_id INTEGER(11),
        IN in_fca_purse_id INTEGER(11),
        IN in_fca_operation_type_id INTEGER(11),
        IN in_fca_date TIMESTAMP,
        IN in_fca_actor_description VARCHAR(255),
        IN in_fca_description VARCHAR(255),
        IN in_fca_summ DECIMAL(15,3),
        IN in_fca_category_id INTEGER(11),
        IN in_fca_transfert_purse_id INTEGER(11),
        IN const_income_transf_optype_id INTEGER(11),
        IN const_outcome_transf_optype_id INTEGER(11),
        IN in_fca_status_id INTEGER(11),
        IN in_fca_currency_id INTEGER(11)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
    IF ISNULL(in_fca_id) THEN
    	IF ISNULL(in_fca_currency_id) THEN
        	SELECT purse_currency_id INTO in_fca_currency_id FROM `purse_dictionary` 
            WHERE `purse_dictionary_id`=in_fca_purse_id;
        END IF;
    	insert into `finance_action_data_storage`(`fca_id`,`fca_purse_id`, 
    		`fca_operation_type_id`, `fca_date`, `fca_actor_description`, 
    		`fca_description`, `fca_summ`, `fca_category_id`, `fca_transfert_purse_id`,
            `fca_status_id`, `fca_currency_id`) 
    		values(null,in_fca_purse_id, in_fca_operation_type_id, in_fca_date, 
    		in_fca_actor_description, in_fca_description, 
			in_fca_summ, in_fca_category_id,in_fca_transfert_purse_id,
            in_fca_status_id, in_fca_currency_id);
            
    	IF (in_fca_operation_type_id=const_income_transf_optype_id) THEN
    		insert into `finance_action_data_storage`(`fca_id`,`fca_purse_id`, 
    			`fca_operation_type_id`, `fca_date`, `fca_actor_description`, 
    			`fca_description`, `fca_summ`, `fca_category_id`, `fca_transfert_purse_id`,
            	`fca_status_id`, `fca_currency_id`) 
    			values(null,in_fca_transfert_purse_id, const_outcome_transf_optype_id, 
                in_fca_date, in_fca_actor_description, in_fca_description, 
				in_fca_summ, in_fca_category_id, in_fca_purse_id,
                in_fca_status_id, in_fca_currency_id);
        END IF;	
    
    END IF;
END;

#
# Определение для процедуры `add_visa_categories`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `add_visa_categories`(
        IN in_user_id INTEGER(11)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	IF NOT ISNULL(in_user_id) THEN
    	INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) 
            VALUES (NULL,'Жилье',0,0,0,in_user_id, 1);
		
        SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT(); 
		INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  			(NULL,'Аренда или выплата по ипотечному кредиту ',0,@last_cat_id,1,in_user_id,2),
  			(NULL,'Налоги на недвижимость ',0,@last_cat_id,1,in_user_id,3);
		
        INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  			(NULL,'Коммунальные платежи',0,0,0,in_user_id, 4);

		SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT();
		INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES   
  			(NULL,'Электричество',0,@last_cat_id,1,in_user_id, 5),
  			(NULL,'Газ',0,@last_cat_id,1,in_user_id, 6),
  			(NULL,'Водоснабжение',0,@last_cat_id,1,in_user_id, 7),
  			(NULL,'Телефон',0,@last_cat_id,1,in_user_id, 8),
  			(NULL,'Вывоз мусора',0,@last_cat_id,1,in_user_id, 9),
  			(NULL,'Другое',0,@last_cat_id,1,in_user_id, 10);
            
		INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  			(NULL,'Страхование ',0,0,0,in_user_id, 11);
		
        SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT();
		INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  			(NULL,'Машины',0,@last_cat_id,1,in_user_id, 12),
  			(NULL,'Жизни / от несчастного случая ',0,@last_cat_id,1,in_user_id, 13),
  			(NULL,'Недвижимости ',0,@last_cat_id,1,in_user_id, 14),
  			(NULL,'Медицинское',0,@last_cat_id,1,in_user_id, 15),
  			(NULL,'От нетрудоспособности ',0,@last_cat_id,1,in_user_id, 16),
  			(NULL,'Другое',0,@last_cat_id,1,in_user_id, 17);
            
		INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  			(NULL,'Питание',0,0,0,in_user_id, 18);
            
		SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT();
		INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  			(NULL,'Продукты',0,@last_cat_id,1,in_user_id, 19),
  			(NULL,'Выходы в кафе, рестораны ',0,@last_cat_id,1,in_user_id, 20),
  			(NULL,'Оплата обедов на работе ',0,@last_cat_id,1,in_user_id, 21),
  			(NULL,'Школьное питание детей ',0,@last_cat_id,1,in_user_id, 22);
            
		INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  			(NULL,'Отдых и развлечения ',0,0,0,in_user_id, 23);
            
		SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT();
		INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  			(NULL,'Хобби',0,@last_cat_id,1,in_user_id, 24),
  			(NULL,'Отпуск',0,@last_cat_id,1,in_user_id, 25),
  			(NULL,'Театр / кино',0,@last_cat_id,1,in_user_id, 26),
  			(NULL,'Спортивные состязания',0,@last_cat_id,1,in_user_id, 27),
  			(NULL,'Выход с друзьями в кафе / ресторан',0,@last_cat_id,1,in_user_id, 28),
  			(NULL,'Членские взносы в клубы',0,@last_cat_id,1,in_user_id, 29),
  			(NULL,'Алкоголь',0,@last_cat_id,1,in_user_id, 30),
  			(NULL,'Табак',0,@last_cat_id,1,in_user_id, 31),
  			(NULL,'Покупка лотерейных билетов',0,@last_cat_id,1,in_user_id, 32),
  			(NULL,'Книги, газеты, журналы',0,@last_cat_id,1,in_user_id, 33),
  			(NULL,'Кабельное телевидение',0,@last_cat_id,1,in_user_id, 34),
  			(NULL,'Частные уроки / репетиторы',0,@last_cat_id,1,in_user_id, 35),
  			(NULL,'Другое',0,@last_cat_id,1,in_user_id, 36);
            
		INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  			(NULL,'Семейные расходы',0,0,0,in_user_id, 37);
            
		SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT();
		INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
			`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  			(NULL,'Медицинские расходы, здравоохранение',0,@last_cat_id,1,in_user_id, 38),
  			(NULL,'Расходы на ребенка',0,@last_cat_id,1,in_user_id, 39),
  			(NULL,'Алименты / содержание ребенка ',0,@last_cat_id,1,in_user_id, 40),
  			(NULL,'Детский сад',0,@last_cat_id,1,in_user_id, 41),
  			(NULL,'Няня для ребенка',0,41,1,in_user_id, 42),
  			(NULL,'Карманные расходы для детей',0,@last_cat_id,1,in_user_id, 43),
  			(NULL,'Помощь родителям',0,@last_cat_id,1,in_user_id, 44),
 			(NULL,'Другое',0,@last_cat_id,1,in_user_id, 45);
            
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Подарки / пожертвования',0,0,0,in_user_id, 46);
                
			SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT();
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Религиозные пожертвования',0,@last_cat_id,1,in_user_id, 47),
  				(NULL,'Добровольные пожертвования в фонды',0,@last_cat_id,1,in_user_id, 48),
  				(NULL,'Покупка подарков на дни рождения',0,@last_cat_id,1,in_user_id, 49),
  				(NULL,'Покупка подарков на свадьбы',0,@last_cat_id,1,in_user_id, 50),
  				(NULL,'Другое',0,@last_cat_id,1,in_user_id, 51);
                
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Хозяйственные расходы',0,0,0,in_user_id, 52);
                
			SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT();
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Мебель',0,@last_cat_id,1,in_user_id, 53),
  				(NULL,'Техника',0,@last_cat_id,1,in_user_id, 54),
  				(NULL,'Белье',0,@last_cat_id,1,in_user_id, 55),
  				(NULL,'Кухонная утварь',0,@last_cat_id,1,in_user_id, 56),
  				(NULL,'Инструменты',0,@last_cat_id,1,in_user_id, 57),
  				(NULL,'Чистящие средства',0,@last_cat_id,1,in_user_id, 58),
  				(NULL,'Садоводство',0,@last_cat_id,1,in_user_id, 59),
  				(NULL,'Гонорары экономкам, помощникам по хозяйству',0,@last_cat_id,1,in_user_id, 60),
  				(NULL,'Другое',0,@last_cat_id,1,in_user_id, 61);
                
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Личные расходы',0,0,0,in_user_id, 62);
                
			SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT();
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Лекарства по рецепту',0,@last_cat_id,1,in_user_id, 63),
  				(NULL,'Прачечная',0,@last_cat_id,1,in_user_id, 64),
  				(NULL,'Парикмахерская',0,@last_cat_id,1,in_user_id, 65),
  				(NULL,'Одежда',0,@last_cat_id,1,in_user_id, 66),
  				(NULL,'Парфюмерия',0,@last_cat_id,1,in_user_id, 67),
  				(NULL,'Другое',0,@last_cat_id,1,in_user_id, 68);
                
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Транспорт',0,0,0,in_user_id, 69);
                
			SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT();
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Выплата по кредиту за машину',0,@last_cat_id,1,in_user_id, 70),
  				(NULL,'Бензин',0,@last_cat_id,1,in_user_id, 71),
  				(NULL,'Машинное масло и т.д.',0,@last_cat_id,1,in_user_id, 72),
  				(NULL,'Ремонт',0,@last_cat_id,1,in_user_id, 73),
  				(NULL,'Шины',0,@last_cat_id,1,in_user_id, 74),
  				(NULL,'Техосмотр / налоги',0,@last_cat_id,1,in_user_id, 75),
  				(NULL,'Общественный транспорт',0,@last_cat_id,1,in_user_id, 76),
  				(NULL,'Парковка',0,@last_cat_id,1,in_user_id, 77),
  				(NULL,'Другое',0,@last_cat_id,1,in_user_id, 78);
                
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Сбережения',0,0,0,in_user_id, 79);
                
			SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT();
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Регулярные',0,@last_cat_id,1,in_user_id, 80),
  				(NULL,'Периодические',0,@last_cat_id,1,in_user_id, 81),
  				(NULL,'Отложения на дополнительную пенсию',0,@last_cat_id,1,in_user_id, 82),
 	 			(NULL,'Инвестиции',0,@last_cat_id,1,in_user_id, 83),
  				(NULL,'Покупка облигаций',0,@last_cat_id,1,in_user_id, 84),
  				(NULL,'Другое ',0,@last_cat_id,1,in_user_id, 85);
                
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Разное',0,0,0,in_user_id, 86);
                
			SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT();
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Расходы, относящиеся к образованию детей (оплата обучения, общежития)',0,@last_cat_id,1,in_user_id, 87),
  				(NULL,'Взносы в клубы / общества',0,@last_cat_id,1,in_user_id, 88),
  				(NULL,'Юристы, нотариусы, адвокаты',0,@last_cat_id,1,in_user_id, 89),
  				(NULL,'Выплата по потребительскому кредиту / кредитной карте',0,@last_cat_id,1,in_user_id, 90),
  				(NULL,'Банковские комиссии',0,@last_cat_id,1,in_user_id, 91),
  				(NULL,'Другое',0,@last_cat_id,1,in_user_id, 92);
                
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Налоги',0,0,0,in_user_id, 93);
                
			SET @last_cat_id = LAST_INSERT_ID()*ROW_COUNT();
			INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, 
				`parent_category_id`, `category_level`, `user_id`, `default_entity_id`) VALUES 
  				(NULL,'Подоходный налог',0,@last_cat_id,1,in_user_id, 94),
  				(NULL,'Другие',0,@last_cat_id,1,in_user_id, 95);
                
            UPDATE `category_dictionary` SET big_image_id=1, small_image_id=2
            WHERE default_entity_id=1 AND user_id=in_user_id; 
            UPDATE `category_dictionary` SET big_image_id=3, small_image_id=4
            WHERE default_entity_id=4 AND user_id=in_user_id; 
            UPDATE `category_dictionary` SET big_image_id=5, small_image_id=6
            WHERE default_entity_id=11 AND user_id=in_user_id;
            UPDATE `category_dictionary` SET big_image_id=7, small_image_id=8
            WHERE default_entity_id=18 AND user_id=in_user_id;
            UPDATE `category_dictionary` SET big_image_id=9, small_image_id=10
            WHERE default_entity_id=23 AND user_id=in_user_id;
            UPDATE `category_dictionary` SET big_image_id=11, small_image_id=12
            WHERE default_entity_id=37 AND user_id=in_user_id;
            UPDATE `category_dictionary` SET big_image_id=13, small_image_id=14
            WHERE default_entity_id=46 AND user_id=in_user_id;
            UPDATE `category_dictionary` SET big_image_id=15, small_image_id=16
            WHERE default_entity_id=52 AND user_id=in_user_id;
            UPDATE `category_dictionary` SET big_image_id=17, small_image_id=18
            WHERE default_entity_id=62 AND user_id=in_user_id; 
            UPDATE `category_dictionary` SET big_image_id=19, small_image_id=20
            WHERE default_entity_id=69 AND user_id=in_user_id;
            UPDATE `category_dictionary` SET big_image_id=21, small_image_id=22
            WHERE default_entity_id=79 AND user_id=in_user_id; 
            UPDATE `category_dictionary` SET big_image_id=23, small_image_id=24
            WHERE default_entity_id=86 AND user_id=in_user_id;
            UPDATE `category_dictionary` SET big_image_id=25, small_image_id=26
            WHERE default_entity_id=93 AND user_id=in_user_id;
            
            call `add_default_income_cats`(in_user_id);

    END IF;
END;

#
# Определение для процедуры `delete_object_by_type`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `delete_object_by_type`(
        IN OBJ_TYPE VARCHAR(50),
        IN OBJ_ID INTEGER(11),
        OUT OBJ_COUNT INTEGER(11)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN 
    IF OBJ_TYPE="fca" THEN
    	UPDATE finance_action_data_storage SET closed=1 WHERE fca_id=OBJ_ID;
    ELSE
    	IF OBJ_TYPE="purse" THEN
        	UPDATE purse_dictionary SET closed=1 WHERE purse_dictionary_id=OBJ_ID;
        ELSE
        	IF OBJ_TYPE="plan" THEN
            	UPDATE `plan_dictionary` SET closed=1 WHERE id=OBJ_ID;
            ELSE
            	IF OBJ_TYPE="user" THEN
            		UPDATE users SET isactive=0 WHERE id=OBJ_ID;
                ELSE
                	IF OBJ_TYPE="category" THEN
            		UPDATE `category_dictionary` SET closed=0 WHERE id=OBJ_ID;
                	ELSE
                		IF OBJ_TYPE="currency" THEN
            			UPDATE `currency_dictionary` SET closed=0 WHERE id=OBJ_ID;
                		ELSE
                			IF OBJ_TYPE="action_status" THEN
            				UPDATE `action_statuses` SET closed=0 WHERE id=OBJ_ID;
                			ELSE
                				IF OBJ_TYPE="optype" THEN
            					UPDATE `optype_dictionary` SET closed=0 WHERE id=OBJ_ID;
                				ELSE
                					IF OBJ_TYPE="plan_shedule" THEN
            						UPDATE `plan_shedules_dictionary` SET closed=0 WHERE id=OBJ_ID;
                					END IF;
                				END IF;
                			END IF;
                		END IF;
                	END IF;
                END IF;
            END IF;
    	END IF;
    END IF;
      
END;

#
# Определение для процедуры `insert_external_fca`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `insert_external_fca`(
        IN in_fca_purse_id INTEGER(11),
        IN in_fca_operation_type_id INTEGER(11),
        IN in_fca_date TIMESTAMP,
        IN in_fca_actor_description VARCHAR(255),
        IN in_fca_description VARCHAR(255),
        IN in_fca_summ DOUBLE(15,3),
        IN in_fca_category_id INTEGER(11),
        IN in_fca_currency_id INTEGER(11),
        IN in_fca_sync_key VARCHAR(2000)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	DECLARE c INT;
    SET @c=1;
	IF NOT ISNULL(in_fca_purse_id) AND NOT ISNULL(in_fca_sync_key) THEN
    	IF (in_fca_purse_id>0) AND (in_fca_sync_key<>'') THEN
    		SELECT COUNT(*) INTO @c FROM `finance_action_data_storage`
    		WHERE (fca_purse_id=in_fca_purse_id) AND (fca_sync_key=in_fca_sync_key) 
            AND (closed<>1);
    
    		IF @c=0 THEN
            
            SET NAMES 'utf8';
    
    		insert into `finance_action_data_storage`(`fca_id`,`fca_purse_id`, 
    			`fca_operation_type_id`, `fca_date`, `fca_actor_description`, 
    			`fca_description`, `fca_summ`, `fca_category_id`, `fca_currency_id`,
    			`fca_sync_key`, `fca_status_id`) 
    			values(null, in_fca_purse_id, in_fca_operation_type_id, 
    			in_fca_date, in_fca_actor_description, 
    			in_fca_description, in_fca_summ, in_fca_category_id, 
    			in_fca_currency_id, in_fca_sync_key, 3);
                
            END IF;
    	END IF;
    END IF;
END;

#
# Определение для процедуры `insert_planning_fca`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `insert_planning_fca`(
        IN in_fca_plan_id INTEGER(11),
        IN in_fca_operation_type_id INTEGER(11),
        IN in_fca_date TIMESTAMP,
        IN in_fca_actor_description VARCHAR(255),
        IN in_fca_description VARCHAR(255),
        IN in_fca_summ DOUBLE(15,3),
        IN in_fca_category_id INTEGER(11),
        IN in_fca_currency_id INTEGER(11),
        IN in_fca_sync_key VARCHAR(2000)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	IF NOT ISNULL(in_fca_plan_id)  THEN
    	IF (in_fca_plan_id>0) THEN
            
            SET NAMES 'utf8';
    
    		insert into `finance_action_data_storage`(`fca_id`, `fca_plan_id`, `fca_purse_id`, 
    			`fca_operation_type_id`, `fca_date`, `fca_actor_description`, 
    			`fca_description`, `fca_summ`, `fca_category_id`, `fca_currency_id`,
    			`fca_sync_key`) 
    			values(null, in_fca_plan_id, 0, in_fca_operation_type_id, 
    			in_fca_date, in_fca_actor_description, 
    			in_fca_description, in_fca_summ, in_fca_category_id, 
    			in_fca_currency_id, in_fca_sync_key);
                
    	END IF;
    END IF;
END;

#
# Определение для процедуры `register_external_user`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `register_external_user`(
        IN in_username VARCHAR(30),
        IN in_password VARCHAR(128),
        IN in_email VARCHAR(100),
        IN in_custom_name VARCHAR(100),
        IN in_system_name VARCHAR(255),
        INOUT success INTEGER(11),
        OUT out_user_id INTEGER(11),
        OUT out_person_id INTEGER(11)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	SET out_person_id=NULL;
    SET out_user_id=NULL;
    SET success=NULL;
    INSERT INTO `persons` (`id`, `first_name`) 
    	VALUES (NULL, in_custom_name);
    SET out_person_id = LAST_INSERT_ID()*ROW_COUNT();
    IF NOT ISNULL(out_person_id) THEN
    	IF (out_person_id>0) THEN
    		INSERT INTO users (`id`, `username`, `password`,
            	`email`, `isactive`, `person_id`, `system_name`)
                VALUES (NULL, in_username, in_password,
                in_email, 1, out_person_id, in_system_name);
            SET out_user_id = LAST_INSERT_ID()*ROW_COUNT();
            IF NOT ISNULL(out_user_id) THEN
    			IF (out_user_id>0) THEN
                	SET success=1;
                END IF;
            END IF;    
    	END IF;
    END IF;
END;

#
# Определение для процедуры `register_user`: 
#

CREATE DEFINER = 'root'@'localhost' PROCEDURE `register_user`(
        IN in_username VARCHAR(30),
        IN in_password VARCHAR(128),
        IN in_email VARCHAR(100),
        IN in_custom_name VARCHAR(100),
        INOUT success INTEGER(11),
        OUT out_user_id INTEGER(11),
        OUT out_person_id INTEGER(11)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	SET out_person_id=NULL;
    SET out_user_id=NULL;
    SET success=NULL;
    INSERT INTO `persons` (`id`, `first_name`) 
    	VALUES (NULL, in_custom_name);
    SET out_person_id = LAST_INSERT_ID()*ROW_COUNT();
    IF NOT ISNULL(out_person_id) THEN
    	IF (out_person_id>0) THEN
    		INSERT INTO users (`id`, `username`, `password`,
            	`email`, `isactive`, `person_id`)
                VALUES (NULL, in_username, in_password,
                in_email, 1, out_person_id);
            SET out_user_id = LAST_INSERT_ID()*ROW_COUNT();
            IF NOT ISNULL(out_user_id) THEN
    			IF (out_user_id>0) THEN
                	SET success=1;
                END IF;
            END IF;    
    	END IF;
    END IF;
END;

#
# Определение для представления `category_view`: 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `category_view`
AS
select 
    `ctg`.`category_id` AS `category_id`,
    `ctg`.`category_name` AS `category_name`,
    `ctg`.`closed` AS `closed`,
    `ctg`.`parent_category_id` AS `parent_category_id`,
    `ctg`.`category_level` AS `category_level`,
    `ctg`.`user_id` AS `user_id`,
    `f_get_cat_summ`(`ctg`.`category_id`,`ctg`.`user_id`) AS `cat_summ`,
    `bim`.`image_path` AS `big_image_path`,
    `sim`.`image_path` AS `small_image_path` 
  from 
    ((`category_dictionary` `ctg` left join `images` `bim` on((`ctg`.`big_image_id` = `bim`.`image_id`))) left join `images` `sim` on((`ctg`.`small_image_id` = `sim`.`image_id`)));

#
# Определение для представления `fca_optype_view`: 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `fca_optype_view`
AS
select 
    `fca`.`fca_id` AS `fca_id`,
    `fca`.`fca_operation_id` AS `fca_operation_id`,
    `fca`.`fca_actor_id` AS `fca_actor_id`,
    `fca`.`fca_quantity` AS `fca_quantity`,
    `fca`.`fca_summ` AS `fca_summ`,
    `fca`.`fca_purse_id` AS `fca_purse_id`,
    `fca`.`fca_actor_description` AS `fca_actor_description`,
    `fca`.`fca_date` AS `fca_date`,
    `fca`.`fca_description` AS `fca_description`,
    `fca`.`fca_operation_type_id` AS `fca_operation_type_id`,
    `fca`.`closed` AS `closed`,
    `fca`.`fca_category_id` AS `fca_category_id`,
    `fca`.`fca_currency_id` AS `fca_currency_id`,
    `fca`.`fca_sync_key` AS `fca_sync_key`,
    `fca`.`fca_plan_id` AS `fca_plan_id`,
    `fca`.`fca_transfert_purse_id` AS `fca_transfert_purse_id`,
    `pdc`.`purse_name` AS `purse_name`,
    ifnull(`pdc`.`user_id`,`plv`.`user_id`) AS `user_id`,
    `odc`.`account_type` AS `account_type`,
    `plv`.`plan_name` AS `plan_name`,
    `odc`.`optype_name` AS `optype_name`,
    `cdc`.`currency_name` AS `currency_name`,
    `cdc`.`currency_rate` AS `currency_rate`,
    ifnull(`ctdc`.`category_name`,'Без категории') AS `category_name`,
    `fca`.`fca_status_id` AS `fca_status_id`,
    `pdc`.`purse_currency_id` AS `purse_currency_id` 
  from 
    (((((`finance_action_data_storage` `fca` left join `purse_dictionary` `pdc` on((`fca`.`fca_purse_id` = `pdc`.`purse_dictionary_id`))) left join `optype_dictionary` `odc` on((`fca`.`fca_operation_type_id` = `odc`.`optype_id`))) left join `currency_dictionary` `cdc` on((`fca`.`fca_currency_id` = `cdc`.`currency_id`))) left join `category_dictionary` `ctdc` on((`fca`.`fca_category_id` = `ctdc`.`category_id`))) left join `plan_view` `plv` on((`fca`.`fca_plan_id` = `plv`.`plan_id`)));

#
# Определение для представления `fca_view_detail`: 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `fca_view_detail`
AS
select 
    `fca`.`fca_id` AS `fca_id`,
    `fca`.`fca_operation_id` AS `fca_operation_id`,
    `fca`.`fca_actor_id` AS `fca_actor_id`,
    `fca`.`fca_quantity` AS `fca_quantity`,
    `fca`.`fca_summ` AS `fca_summ`,
    `fca`.`fca_purse_id` AS `fca_purse_id`,
    `fca`.`fca_actor_description` AS `fca_actor_description`,
    `fca`.`fca_date` AS `fca_date`,
    `fca`.`fca_description` AS `fca_description`,
    `fca`.`fca_operation_type_id` AS `fca_operation_type_id`,
    `fca`.`closed` AS `closed`,
    `fca`.`fca_category_id` AS `fca_category_id`,
    `fca`.`fca_currency_id` AS `fca_currency_id`,
    `fca`.`fca_sync_key` AS `fca_sync_key`,
    `fca`.`fca_plan_id` AS `fca_plan_id`,
    `fca`.`fca_transfert_purse_id` AS `fca_transfert_purse_id`,
    `pdc`.`purse_name` AS `purse_name`,
    ifnull(`pdc`.`user_id`,`plv`.`user_id`) AS `user_id`,
    `odc`.`account_type` AS `account_type`,
    `plv`.`plan_name` AS `plan_name`,
    `odc`.`optype_name` AS `optype_name`,
    `cdc`.`currency_name` AS `currency_name`,
    `cdc`.`currency_rate` AS `currency_rate`,
    ifnull(`ctdc`.`category_name`,'Без категории') AS `category_name`,
    `ctdc`.`parent_category_id` AS `parent_category_id`,
    `fca`.`fca_status_id` AS `fca_status_id`,
    `pdc`.`purse_currency_id` AS `purse_currency_id`,
    `f_get_purse_calculated_on_moment`(`fca`.`fca_purse_id`,`fca`.`fca_date`,`fca`.`fca_id`) AS `fca_moment_psumm`,
    `f_get_category_name`(`ctdc`.`parent_category_id`) AS `parent_category_name`,
    `f_get_category_root_id`(`fca`.`fca_category_id`) AS `root_category_id`,
    `f_get_category_root_name`(`fca`.`fca_category_id`) AS `root_category_name` 
  from 
    (((((`finance_action_data_storage` `fca` left join `purse_dictionary` `pdc` on((`fca`.`fca_purse_id` = `pdc`.`purse_dictionary_id`))) left join `optype_dictionary` `odc` on((`fca`.`fca_operation_type_id` = `odc`.`optype_id`))) left join `currency_dictionary` `cdc` on((`fca`.`fca_currency_id` = `cdc`.`currency_id`))) left join `category_dictionary` `ctdc` on((`fca`.`fca_category_id` = `ctdc`.`category_id`))) left join `plan_view` `plv` on((`fca`.`fca_plan_id` = `plv`.`plan_id`)));

#
# Определение для представления `inout_comp_report_view`: 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `inout_comp_report_view`
AS
select 
    concat(month(`fcav`.`fca_date`),'.',year(`fcav`.`fca_date`)) AS `month_date_point`,
    sum((`fcav`.`fca_summ` * if((`fcav`.`account_type` = 1),1,-(1)))) AS `month_summ`,
    sum((`fcav`.`fca_summ` * if((`fcav`.`account_type` = 1),1,0))) AS `month_income`,
    sum((`fcav`.`fca_summ` * if((`fcav`.`account_type` = 1),0,1))) AS `month_outcome` 
  from 
    `fca_view` `fcav` 
  group by 
    (month(`fcav`.`fca_date`) + (year(`fcav`.`fca_date`) * 12));

#
# Определение для представления `person_with_types`: 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `person_with_types`
AS
select 
    ifnull(`pt`.`person_type_name`,' ') AS `person_type_name`,
    `p`.`id` AS `id`,
    `p`.`closed` AS `closed`,
    `p`.`person_type_id` AS `person_type_id`,
    `p`.`code` AS `person_code`,
    `p`.`first_name` AS `first_name`,
    `p`.`last_name` AS `last_name`,
    `p`.`sur_name` AS `sur_name`,
    `p`.`employment_date` AS `employment_date`,
    `p`.`stationare_phones` AS `stationare_phones`,
    `p`.`mobile_phones` AS `mobile_phones`,
    concat(ifnull(`p`.`last_name`,' '),' ',ifnull(`p`.`first_name`,' '),' ',ifnull(`p`.`sur_name`,' ')) AS `person_name` 
  from 
    (`persons` `p` left join `person_types` `pt` on((`p`.`person_type_id` = `pt`.`id`))) 
  order by 
    `p`.`id` desc;

#
# Определение для представления `purse_view`: 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `purse_view`
AS
select 
    `pdc`.`purse_dictionary_id` AS `purse_dictionary_id`,
    `pdc`.`pd_dictionary_id` AS `pd_dictionary_id`,
    `pdc`.`purse_logo_img` AS `purse_logo_img`,
    `pdc`.`purse_name` AS `purse_name`,
    `pdc`.`closed` AS `closed`,
    `pdc`.`user_id` AS `user_id`,
    `f_get_purse_calculated`(`pdc`.`purse_dictionary_id`) AS `purse_summ`,
    `pdc`.`purse_currency_id` AS `purse_currency_id`,
    `cdc`.`currency_name` AS `purse_currency_name`,
    `pdc`.`purse_ptype_id` AS `purse_ptype_id` 
  from 
    (`purse_dictionary` `pdc` left join `currency_dictionary` `cdc` on((`pdc`.`purse_currency_id` = `cdc`.`currency_id`)));

#
# Определение для представления `user_payments_view`: 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `user_payments_view`
AS
select 
    `usp`.`user_payment_id` AS `user_payment_id`,
    `usp`.`payment_summ` AS `payment_summ`,
    `usp`.`psystem_id` AS `psystem_id`,
    `usp`.`approved_status` AS `approved_status`,
    `usp`.`start_datetime` AS `start_datetime`,
    `usp`.`payment_optype_id` AS `payment_optype_id`,
    `usp`.`payment_currency_id` AS `payment_currency_id`,
    `usp`.`payment_currency_code` AS `payment_currency_code`,
    `usp`.`payment_user_id` AS `payment_user_id`,
    `usp`.`order_number` AS `order_number`,
    `usp`.`billing_number` AS `billing_number`,
    `usp`.`target_payment_system_name` AS `target_payment_system_name`,
    `usp`.`payment_datetime` AS `payment_datetime`,
    `usp`.`approve_currency_id` AS `approve_currency_id`,
    `usp`.`ps_order_number` AS `ps_order_number`,
    `usp`.`closed` AS `closed`,
    `odc`.`account_type` AS `account_type`,
    `pst`.`account_merchant_id` AS `account_merchant_id`,
    `pst`.`payment_system_name` AS `payment_system_name`,
    `pst`.`ps_custom_name` AS `ps_custom_name`,
    `pst`.`ps_order_counter` AS `ps_order_counter` 
  from 
    ((`user_payments` `usp` left join `optype_dictionary` `odc` on((`usp`.`payment_optype_id` = `odc`.`optype_id`))) left join `payment_systems` `pst` on((`usp`.`psystem_id` = `pst`.`payment_system_id`)));

#
# Определение для представления `users_with_relative`: 
#

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `users_with_relative`
AS
select 
    `us`.`id` AS `id`,
    `us`.`isactive` AS `isactive`,
    `us`.`person_id` AS `person_id`,
    `us`.`username` AS `username`,
    `us`.`closed` AS `closed`,
    `pwt`.`person_type_id` AS `person_type_id`,
    `us`.`password` AS `password`,
    `us`.`enable_admin` AS `enable_admin`,
    `us`.`enable_deleting` AS `enable_deleting`,
    concat(`pwt`.`person_type_name`,' ',`pwt`.`person_name`) AS `person_name` 
  from 
    (`users` `us` left join `person_with_types` `pwt` on((`us`.`person_id` = `pwt`.`id`)));

#
# Data for the `action_statuses` table  (LIMIT -496,500)
#

INSERT INTO `action_statuses` (`action_status_id`, `act_status_name`, `closed`) VALUES 
  (1,'Черновик',0),
  (2,'Рабочая',1),
  (3,'Проведена',0);
COMMIT;

#
# Data for the `category_dictionary` table  (LIMIT -281,500)
#

INSERT INTO `category_dictionary` (`category_id`, `category_name`, `closed`, `parent_category_id`, `category_level`, `user_id`, `big_image_id`, `small_image_id`, `default_entity_id`) VALUES 
  (627,'Жилье',0,0,0,30,1,2,1),
  (628,'Аренда или выплата по ипотечному кредиту ',0,627,1,30,0,0,2),
  (629,'Налоги на недвижимость ',0,627,1,30,0,0,3),
  (630,'Коммунальные платежи',0,0,0,30,3,4,4),
  (631,'Электричество',0,630,1,30,0,0,5),
  (632,'Газ',0,630,1,30,0,0,6),
  (633,'Водоснабжение',0,630,1,30,0,0,7),
  (634,'Телефон',0,630,1,30,0,0,8),
  (635,'Вывоз мусора',0,630,1,30,0,0,9),
  (636,'Другое',0,630,1,30,0,0,10),
  (637,'Страхование ',0,0,0,30,5,6,11),
  (638,'Машины',0,637,1,30,0,0,12),
  (639,'Жизни / от несчастного случая ',0,637,1,30,0,0,13),
  (640,'Недвижимости ',0,637,1,30,0,0,14),
  (641,'Медицинское',0,637,1,30,0,0,15),
  (642,'От нетрудоспособности ',0,637,1,30,0,0,16),
  (643,'Другое',0,637,1,30,0,0,17),
  (644,'Питание',0,0,0,30,7,8,18),
  (645,'Продукты',0,644,1,30,0,0,19),
  (646,'Выходы в кафе, рестораны ',0,644,1,30,0,0,20),
  (647,'Оплата обедов на работе ',0,644,1,30,0,0,21),
  (648,'Школьное питание детей ',0,644,1,30,0,0,22),
  (649,'Отдых и развлечения ',0,0,0,30,9,10,23),
  (650,'Хобби',0,649,1,30,0,0,24),
  (651,'Отпуск',0,649,1,30,0,0,25),
  (652,'Театр / кино',0,649,1,30,0,0,26),
  (653,'Спортивные состязания',0,649,1,30,0,0,27),
  (654,'Выход с друзьями в кафе / ресторан',0,649,1,30,0,0,28),
  (655,'Членские взносы в клубы',0,649,1,30,0,0,29),
  (656,'Алкоголь',0,649,1,30,0,0,30),
  (657,'Табак',0,649,1,30,0,0,31),
  (658,'Покупка лотерейных билетов',0,649,1,30,0,0,32),
  (659,'Книги, газеты, журналы',0,649,1,30,0,0,33),
  (660,'Кабельное телевидение',0,649,1,30,0,0,34),
  (661,'Частные уроки / репетиторы',0,649,1,30,0,0,35),
  (662,'Другое',0,649,1,30,0,0,36),
  (663,'Семейные расходы',0,0,0,30,11,12,37),
  (664,'Медицинские расходы, здравоохранение',0,663,1,30,0,0,38),
  (665,'Расходы на ребенка',0,663,1,30,0,0,39),
  (666,'Алименты / содержание ребенка ',0,663,1,30,0,0,40),
  (667,'Детский сад',0,663,1,30,0,0,41),
  (668,'Няня для ребенка',0,41,1,30,0,0,42),
  (669,'Карманные расходы для детей',0,663,1,30,0,0,43),
  (670,'Помощь родителям',0,663,1,30,0,0,44),
  (671,'Другое',0,663,1,30,0,0,45),
  (672,'Подарки / пожертвования',0,0,0,30,13,14,46),
  (673,'Религиозные пожертвования',0,672,1,30,0,0,47),
  (674,'Добровольные пожертвования в фонды',0,672,1,30,0,0,48),
  (675,'Покупка подарков на дни рождения',0,672,1,30,0,0,49),
  (676,'Покупка подарков на свадьбы',0,672,1,30,0,0,50),
  (677,'Другое',0,672,1,30,0,0,51),
  (678,'Хозяйственные расходы',0,0,0,30,15,16,52),
  (679,'Мебель',0,678,1,30,0,0,53),
  (680,'Техника',0,678,1,30,0,0,54),
  (681,'Белье',0,678,1,30,0,0,55),
  (682,'Кухонная утварь',0,678,1,30,0,0,56),
  (683,'Инструменты',0,678,1,30,0,0,57),
  (684,'Чистящие средства',0,678,1,30,0,0,58),
  (685,'Садоводство',0,678,1,30,0,0,59),
  (686,'Гонорары экономкам, помощникам по хозяйству',0,678,1,30,0,0,60),
  (687,'Другое',0,678,1,30,0,0,61),
  (688,'Личные расходы',0,0,0,30,17,18,62),
  (689,'Лекарства по рецепту',0,688,1,30,0,0,63),
  (690,'Прачечная',0,688,1,30,0,0,64),
  (691,'Парикмахерская',0,688,1,30,0,0,65),
  (692,'Одежда',0,688,1,30,0,0,66),
  (693,'Парфюмерия',0,688,1,30,0,0,67),
  (694,'Другое',0,688,1,30,0,0,68),
  (695,'Транспорт',0,0,0,30,19,20,69),
  (696,'Выплата по кредиту за машину',0,695,1,30,0,0,70),
  (697,'Бензин',0,695,1,30,0,0,71),
  (698,'Машинное масло и т.д.',0,695,1,30,0,0,72),
  (699,'Ремонт',0,695,1,30,0,0,73),
  (700,'Шины',0,695,1,30,0,0,74),
  (701,'Техосмотр / налоги',0,695,1,30,0,0,75),
  (702,'Общественный транспорт',0,695,1,30,0,0,76),
  (703,'Парковка',0,695,1,30,0,0,77),
  (704,'Другое',0,695,1,30,0,0,78),
  (705,'Сбережения',0,0,0,30,21,22,79),
  (706,'Регулярные',0,705,1,30,0,0,80),
  (707,'Периодические',0,705,1,30,0,0,81),
  (708,'Отложения на дополнительную пенсию',0,705,1,30,0,0,82),
  (709,'Инвестиции',0,705,1,30,0,0,83),
  (710,'Покупка облигаций',0,705,1,30,0,0,84),
  (711,'Другое ',0,705,1,30,0,0,85),
  (712,'Разное',0,0,0,30,23,24,86),
  (713,'Расходы, относящиеся к образованию детей (оплата обучения, общежития)',0,712,1,30,0,0,87),
  (714,'Взносы в клубы / общества',0,712,1,30,0,0,88),
  (715,'Юристы, нотариусы, адвокаты',0,712,1,30,0,0,89),
  (716,'Выплата по потребительскому кредиту / кредитной карте',0,712,1,30,0,0,90),
  (717,'Банковские комиссии',0,712,1,30,0,0,91),
  (718,'Другое',0,712,1,30,0,0,92),
  (719,'Налоги',0,0,0,30,25,26,93),
  (720,'Подоходный налог',0,719,1,30,0,0,94),
  (721,'Другие',0,719,1,30,0,0,95),
  (722,'Зарплата и личные доходы',0,0,0,30,0,0,96),
  (723,'Зарплата (вкл. налоги)',0,722,1,30,0,0,97),
  (724,'Зарплата (без налогов)',0,722,1,30,0,0,98),
  (725,'Оклад',0,722,1,30,0,0,99),
  (726,'Бонус',0,722,1,30,0,0,100),
  (727,'Премия',0,722,1,30,0,0,101),
  (728,'Предпринимательский доход',0,722,1,30,0,0,102),
  (729,'Пенсия',0,722,1,30,0,0,103),
  (730,'Инвестиционный доход',0,0,0,30,0,0,104),
  (731,'Дивиденды',0,730,1,30,0,0,105),
  (732,'Доход от аренды',0,730,1,30,0,0,106),
  (733,'Прирост капитала',0,730,1,30,0,0,107),
  (734,'Проценты',0,730,1,30,0,0,108),
  (735,'Прочие доходы',0,0,0,30,0,0,109),
  (736,'Жилье',0,0,0,33,1,2,1),
  (737,'Аренда или выплата по ипотечному кредиту ',0,736,1,33,0,0,2),
  (738,'Налоги на недвижимость ',0,736,1,33,0,0,3),
  (739,'Коммунальные платежи',0,0,0,33,3,4,4),
  (740,'Электричество',0,739,1,33,0,0,5),
  (741,'Газ',0,739,1,33,0,0,6),
  (742,'Водоснабжение',0,739,1,33,0,0,7),
  (743,'Телефон',0,739,1,33,0,0,8),
  (744,'Вывоз мусора',0,739,1,33,0,0,9),
  (745,'Другое',0,739,1,33,0,0,10),
  (746,'Страхование ',0,0,0,33,5,6,11),
  (747,'Машины',0,746,1,33,0,0,12),
  (748,'Жизни / от несчастного случая ',0,746,1,33,0,0,13),
  (749,'Недвижимости ',0,746,1,33,0,0,14),
  (750,'Медицинское',0,746,1,33,0,0,15),
  (751,'От нетрудоспособности ',0,746,1,33,0,0,16),
  (752,'Другое',0,746,1,33,0,0,17),
  (753,'Питание',0,0,0,33,7,8,18),
  (754,'Продукты',0,753,1,33,0,0,19),
  (755,'Выходы в кафе, рестораны ',0,753,1,33,0,0,20),
  (756,'Оплата обедов на работе ',0,753,1,33,0,0,21),
  (757,'Школьное питание детей ',0,753,1,33,0,0,22),
  (758,'Отдых и развлечения ',0,0,0,33,9,10,23),
  (759,'Хобби',0,758,1,33,0,0,24),
  (760,'Отпуск',0,758,1,33,0,0,25),
  (761,'Театр / кино',0,758,1,33,0,0,26),
  (762,'Спортивные состязания',0,758,1,33,0,0,27),
  (763,'Выход с друзьями в кафе / ресторан',0,758,1,33,0,0,28),
  (764,'Членские взносы в клубы',0,758,1,33,0,0,29),
  (765,'Алкоголь',0,758,1,33,0,0,30),
  (766,'Табак',0,758,1,33,0,0,31),
  (767,'Покупка лотерейных билетов',0,758,1,33,0,0,32),
  (768,'Книги, газеты, журналы',0,758,1,33,0,0,33),
  (769,'Кабельное телевидение',0,758,1,33,0,0,34),
  (770,'Частные уроки / репетиторы',0,758,1,33,0,0,35),
  (771,'Другое',0,758,1,33,0,0,36),
  (772,'Семейные расходы',0,0,0,33,11,12,37),
  (773,'Медицинские расходы, здравоохранение',0,772,1,33,0,0,38),
  (774,'Расходы на ребенка',0,772,1,33,0,0,39),
  (775,'Алименты / содержание ребенка ',0,772,1,33,0,0,40),
  (776,'Детский сад',0,772,1,33,0,0,41),
  (777,'Няня для ребенка',0,41,1,33,0,0,42),
  (778,'Карманные расходы для детей',0,772,1,33,0,0,43),
  (779,'Помощь родителям',0,772,1,33,0,0,44),
  (780,'Другое',0,772,1,33,0,0,45),
  (781,'Подарки / пожертвования',0,0,0,33,13,14,46),
  (782,'Религиозные пожертвования',0,781,1,33,0,0,47),
  (783,'Добровольные пожертвования в фонды',0,781,1,33,0,0,48),
  (784,'Покупка подарков на дни рождения',0,781,1,33,0,0,49),
  (785,'Покупка подарков на свадьбы',0,781,1,33,0,0,50),
  (786,'Другое',0,781,1,33,0,0,51),
  (787,'Хозяйственные расходы',0,0,0,33,15,16,52),
  (788,'Мебель',0,787,1,33,0,0,53),
  (789,'Техника',0,787,1,33,0,0,54),
  (790,'Белье',0,787,1,33,0,0,55),
  (791,'Кухонная утварь',0,787,1,33,0,0,56),
  (792,'Инструменты',0,787,1,33,0,0,57),
  (793,'Чистящие средства',0,787,1,33,0,0,58),
  (794,'Садоводство',0,787,1,33,0,0,59),
  (795,'Гонорары экономкам, помощникам по хозяйству',0,787,1,33,0,0,60),
  (796,'Другое',0,787,1,33,0,0,61),
  (797,'Личные расходы',0,0,0,33,17,18,62),
  (798,'Лекарства по рецепту',0,797,1,33,0,0,63),
  (799,'Прачечная',0,797,1,33,0,0,64),
  (800,'Парикмахерская',0,797,1,33,0,0,65),
  (801,'Одежда',0,797,1,33,0,0,66),
  (802,'Парфюмерия',0,797,1,33,0,0,67),
  (803,'Другое',0,797,1,33,0,0,68),
  (804,'Транспорт',0,0,0,33,19,20,69),
  (805,'Выплата по кредиту за машину',0,804,1,33,0,0,70),
  (806,'Бензин',0,804,1,33,0,0,71),
  (807,'Машинное масло и т.д.',0,804,1,33,0,0,72),
  (808,'Ремонт',0,804,1,33,0,0,73),
  (809,'Шины',0,804,1,33,0,0,74),
  (810,'Техосмотр / налоги',0,804,1,33,0,0,75),
  (811,'Общественный транспорт',0,804,1,33,0,0,76),
  (812,'Парковка',0,804,1,33,0,0,77),
  (813,'Другое',0,804,1,33,0,0,78),
  (814,'Сбережения',0,0,0,33,21,22,79),
  (815,'Регулярные',0,814,1,33,0,0,80),
  (816,'Периодические',0,814,1,33,0,0,81),
  (817,'Отложения на дополнительную пенсию',0,814,1,33,0,0,82),
  (818,'Инвестиции',0,814,1,33,0,0,83),
  (819,'Покупка облигаций',0,814,1,33,0,0,84),
  (820,'Другое ',0,814,1,33,0,0,85),
  (821,'Разное',0,0,0,33,23,24,86),
  (822,'Расходы, относящиеся к образованию детей (оплата обучения, общежития)',0,821,1,33,0,0,87),
  (823,'Взносы в клубы / общества',0,821,1,33,0,0,88),
  (824,'Юристы, нотариусы, адвокаты',0,821,1,33,0,0,89),
  (825,'Выплата по потребительскому кредиту / кредитной карте',0,821,1,33,0,0,90),
  (826,'Банковские комиссии',0,821,1,33,0,0,91),
  (827,'Другое',0,821,1,33,0,0,92),
  (828,'Налоги',0,0,0,33,25,26,93),
  (829,'Подоходный налог',0,828,1,33,0,0,94),
  (830,'Другие',0,828,1,33,0,0,95),
  (831,'Зарплата и личные доходы',0,0,0,33,0,0,96),
  (832,'Зарплата (вкл. налоги)',0,831,1,33,0,0,97),
  (833,'Зарплата (без налогов)',0,831,1,33,0,0,98),
  (834,'Оклад',0,831,1,33,0,0,99),
  (835,'Бонус',0,831,1,33,0,0,100),
  (836,'Премия',0,831,1,33,0,0,101),
  (837,'Предпринимательский доход',0,831,1,33,0,0,102),
  (838,'Пенсия',0,831,1,33,0,0,103),
  (839,'Инвестиционный доход',0,0,0,33,0,0,104),
  (840,'Дивиденды',0,839,1,33,0,0,105),
  (841,'Доход от аренды',0,839,1,33,0,0,106),
  (842,'Прирост капитала',0,839,1,33,0,0,107),
  (843,'Проценты',0,839,1,33,0,0,108),
  (844,'Прочие доходы',0,0,0,33,0,0,109);
COMMIT;

#
# Data for the `currencies_rates` table  (LIMIT -362,500)
#

INSERT INTO `currencies_rates` (`currency_rate_id`, `rate_date`, `rate_currency_id`, `currency_rate_value`) VALUES 
  (94,'2012-04-16',2,38.813),
  (95,'2012-04-16',3,29.471),
  (96,'2012-04-10',2,38.719),
  (97,'2012-04-10',3,29.636),
  (98,'2012-04-05',2,38.837),
  (99,'2012-04-05',3,29.428),
  (100,'2012-04-04',2,39.085),
  (101,'2012-04-04',3,29.294),
  (102,'2012-04-02',2,39.171),
  (103,'2012-04-02',3,29.328),
  (104,'2012-03-19',2,38.412),
  (105,'2012-03-19',3,29.358),
  (106,'2012-03-17',2,38.412),
  (107,'2012-03-17',3,29.358),
  (108,'2012-03-16',2,38.578),
  (109,'2012-03-16',3,29.582),
  (110,'2012-03-14',2,38.852),
  (111,'2012-03-14',3,29.509),
  (112,'2012-03-10',2,38.994),
  (113,'2012-03-10',3,29.662),
  (114,'2012-03-06',2,38.653),
  (115,'2012-03-06',3,29.289),
  (116,'2012-03-05',2,38.949),
  (117,'2012-03-05',3,29.296),
  (118,'2012-03-04',2,38.949),
  (119,'2012-03-04',3,29.296),
  (120,'2012-03-02',2,39.071),
  (121,'2012-03-02',3,29.289),
  (122,'2012-03-01',2,39.103),
  (123,'2012-03-01',3,29.025),
  (124,'2012-02-29',2,38.912),
  (125,'2012-02-29',3,28.950),
  (126,'2012-02-27',2,39.364),
  (127,'2012-02-27',3,29.449),
  (128,'2012-02-25',2,39.364),
  (129,'2012-02-25',3,29.449),
  (130,'2012-02-22',2,39.523),
  (131,'2012-02-22',3,29.780),
  (132,'2012-02-21',2,39.331),
  (133,'2012-02-21',3,29.780),
  (134,'2012-02-17',2,39.318),
  (135,'2012-02-17',3,30.210),
  (136,'2012-02-10',2,39.477),
  (137,'2012-02-10',3,29.680),
  (138,'2012-01-30',2,39.784),
  (139,'2012-01-30',3,30.363),
  (140,'2012-01-23',2,40.587),
  (141,'2012-01-23',3,31.288),
  (142,'2012-01-19',2,40.261),
  (143,'2012-01-19',3,31.543),
  (144,'2012-01-18',2,40.169),
  (145,'2012-01-18',3,31.544),
  (146,'2012-01-17',2,40.384),
  (147,'2012-01-17',3,31.934),
  (148,'2012-01-16',2,40.619),
  (149,'2012-01-16',3,31.583),
  (150,'2012-05-23',2,39.738),
  (151,'2012-05-23',3,31.064),
  (152,'2012-05-26',2,39.843),
  (153,'2012-05-26',3,31.757),
  (154,'2012-05-30',2,40.242),
  (155,'2012-05-30',3,32.086),
  (156,'2012-01-13',2,40.285),
  (157,'2012-01-13',3,31.681),
  (158,'2011-12-21',2,41.706),
  (159,'2011-12-21',3,32.052),
  (160,'2012-01-21',2,40.587),
  (161,'2012-01-21',3,31.288),
  (162,'2012-01-24',2,40.406),
  (163,'2012-01-24',3,31.332),
  (164,'2012-01-25',2,40.187),
  (165,'2012-01-25',3,30.875),
  (166,'2012-01-26',2,39.950),
  (167,'2012-01-26',3,30.667),
  (168,'2012-01-29',2,39.784),
  (169,'2012-01-29',3,30.363),
  (170,'2012-02-03',2,39.766),
  (171,'2012-02-03',3,30.186),
  (172,'2012-02-05',2,39.742),
  (173,'2012-02-05',3,30.238),
  (174,'2012-02-07',2,39.514),
  (175,'2012-02-07',3,30.232),
  (176,'2012-02-11',2,39.628),
  (177,'2012-02-11',3,29.892),
  (178,'2012-02-12',2,39.628),
  (179,'2012-02-12',3,29.892),
  (180,'2012-02-13',2,39.628),
  (181,'2012-02-13',3,29.892),
  (182,'2012-02-15',2,39.543),
  (183,'2012-02-15',3,30.087),
  (184,'2012-02-16',2,39.457),
  (185,'2012-02-16',3,29.944),
  (186,'2012-03-07',2,38.872),
  (187,'2012-03-07',3,29.451),
  (188,'2012-03-11',2,38.994),
  (189,'2012-03-11',3,29.662),
  (190,'2012-03-22',2,38.759),
  (191,'2012-03-22',3,29.208),
  (192,'2012-03-21',2,38.600),
  (193,'2012-03-21',3,29.165),
  (194,'2012-03-23',2,38.726),
  (195,'2012-03-23',3,29.245),
  (196,'2012-03-25',2,38.819),
  (197,'2012-03-25',3,29.404),
  (198,'2012-03-26',2,38.819),
  (199,'2012-03-26',3,29.404),
  (200,'2012-03-28',2,38.627),
  (201,'2012-03-28',3,28.947),
  (202,'2012-03-29',2,38.770),
  (203,'2012-03-29',3,29.084),
  (204,'2012-04-06',2,38.710),
  (205,'2012-04-06',3,29.430),
  (206,'2012-04-09',2,38.514),
  (207,'2012-04-09',3,29.461),
  (208,'2012-04-11',2,38.835),
  (209,'2012-04-11',3,29.636),
  (210,'2012-04-14',2,38.813),
  (211,'2012-04-14',3,29.471),
  (212,'2012-07-06',2,41.196),
  (213,'2012-07-06',3,32.941),
  (214,'2012-06-06',2,41.507),
  (215,'2012-06-06',3,33.200),
  (216,'2012-05-06',2,39.000),
  (217,'2012-05-06',3,29.808),
  (218,'2012-02-06',2,39.742),
  (219,'2012-03-18',2,38.412),
  (220,'2012-03-18',3,29.358),
  (221,'2012-03-27',2,38.743),
  (222,'2012-03-27',3,29.231),
  (223,'2012-04-01',2,39.171),
  (224,'2012-04-01',3,29.328),
  (225,'2012-04-13',2,38.851),
  (226,'2012-04-13',3,29.569),
  (227,'2012-06-29',2,41.196),
  (228,'2012-06-29',3,32.941),
  (229,'2012-07-10',2,40.552),
  (230,'2012-07-10',3,32.991);
COMMIT;

#
# Data for the `currency_dictionary` table  (LIMIT -496,500)
#

INSERT INTO `currency_dictionary` (`currency_id`, `currency_name`, `currency_rate`, `closed`) VALUES 
  (1,'Рубль',1.000,0),
  (2,'Евро',1.000,0),
  (3,'Доллар',1.000,0);
COMMIT;

#
# Data for the `finance_action_data_storage` table  (LIMIT 1,500)
#

INSERT INTO `finance_action_data_storage` (`fca_id`, `fca_operation_id`, `fca_actor_id`, `fca_quantity`, `fca_summ`, `fca_purse_id`, `fca_actor_description`, `fca_date`, `fca_description`, `fca_operation_type_id`, `closed`, `fca_category_id`, `fca_currency_id`, `fca_sync_key`, `fca_plan_id`, `fca_transfert_purse_id`, `fca_status_id`, `order_index`) VALUES 
  (1535,0,0,NULL,45000.000,1,'','2012-04-16 12:00:00','Внесение средств через устройство Cash-in 400777 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR16.04.2012CASHIN400777Внесение средств через устройство Cash-in 400777 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА45000,000,00',0,0,1,0),
  (1536,0,0,NULL,59.000,1,'','2012-04-10 12:00:00','Комиссия за услугу Альфа-Мобайл за период с 10.04.2012 по 09.05.2012 Согл.тариф.банка',2,1,0,1,'Текущий счет40817810104610017169RUR10.04.2012MORE 10204000017Комиссия за услугу Альфа-Мобайл за период с 10.04.2012 по 09.05.2012 Согл.тариф.банка0,0059,00',0,0,1,0),
  (1537,0,0,NULL,58.380,1,'','2012-04-10 12:00:00','Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR10.04.2012MORE 21004000009Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА58,380,00',0,0,1,0),
  (1538,0,0,NULL,129.000,1,'','2012-04-10 12:00:00','Комиссия за пакет услуг            за апрель 2012 г. Согласно тарифам Банка  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR10.04.2012Комиссия за пакет услуг            за апрель 2012 г. Согласно тарифам Банка  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,1,0),
  (1539,0,0,NULL,26000.000,1,'','2012-04-05 12:00:00','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,1,0,1,'Текущий счет40817810104610017169RUR05.04.201296449683.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0026000,00',0,0,1,0),
  (1540,0,0,NULL,1000.000,1,'','2012-04-04 12:00:00','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR04.04.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА1000,000,00',0,0,1,0),
  (1541,0,0,NULL,25000.000,1,'','2012-04-04 12:00:00','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR04.04.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА25000,000,00',0,0,1,0),
  (1542,0,0,NULL,59.000,1,'','2012-04-02 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с28.03.12 до28.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR02.04.2012MORE 02204000294Комиссия за услугу \"Альфа-Чек\"за период с28.03.12 до28.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,1,0),
  (1543,0,0,NULL,59.000,1,'','2012-03-19 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с16.03.12 до16.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR19.03.2012MORE 19203000736Комиссия за услугу \"Альфа-Чек\"за период с16.03.12 до16.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,1,0),
  (1544,0,0,NULL,1000.000,1,'','2012-03-19 12:00:00','N 20120319211059912. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 19.03.2012, 21-10-55.',2,1,0,1,'Текущий счет40817810104610017169RUR19.03.2012YMO005I4231J0MVCN 20120319211059912. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 19.03.2012, 21-10-55.0,001000,00',0,0,1,0),
  (1545,0,0,NULL,1000.000,1,'','2012-03-17 12:00:00','N 20120317093400621. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 17.03.2012, 09-33-59.',2,1,0,1,'Текущий счет40817810104610017169RUR17.03.2012YMO005I4222I7UI5N 20120317093400621. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 17.03.2012, 09-33-59.0,001000,00',0,0,1,0),
  (1546,0,0,NULL,200.000,1,'','2012-03-16 12:00:00','Платеж 94144899.1 в пользу Beeline,903+++3554,16.03.12,16-05-24,Номер ответа 1003345955259',2,1,0,1,'Текущий счет40817810104610017169RUR16.03.201294144899.1Платеж 94144899.1 в пользу Beeline,903+++3554,16.03.12,16-05-24,Номер ответа 10033459552590,00200,00',0,0,1,0),
  (1547,0,0,NULL,500.000,1,'','2012-03-16 12:00:00','Платеж 94144198.1 в пользу Beeline,903+++3554,16.03.12,15-57-09,Номер ответа 1003345940771',2,1,0,1,'Текущий счет40817810104610017169RUR16.03.201294144198.1Платеж 94144198.1 в пользу Beeline,903+++3554,16.03.12,15-57-09,Номер ответа 10033459407710,00500,00',0,0,1,0),
  (1548,0,0,NULL,194.270,1,'','2012-03-14 12:00:00','548673++++++1500    \\GBR\\44870835190\\2\\SKYPE                          13.03.12 07.03.12         5.00  EUR',2,1,0,1,'Текущий счет40817810104610017169RUR14.03.2012CRD_2KU18Y548673++++++1500    \\GBR\\44870835190\\2\\SKYPE                          13.03.12 07.03.12         5.00  EUR0,00194,27',0,0,1,0),
  (1549,0,0,NULL,59.000,1,'','2012-03-10 12:00:00','Комиссия за услугу Альфа-Мобайл за период с 10.03.2012 по 09.04.2012 Согл.тариф.банка',2,1,0,1,'Текущий счет40817810104610017169RUR10.03.2012MORE 10203000009Комиссия за услугу Альфа-Мобайл за период с 10.03.2012 по 09.04.2012 Согл.тариф.банка0,0059,00',0,0,1,0),
  (1550,0,0,NULL,129.000,1,'','2012-03-10 12:00:00','Комиссия за пакет услуг            за март 2012 г.                    Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR10.03.2012Комиссия за пакет услуг            за март 2012 г.                    Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,1,0),
  (1551,0,0,NULL,5000.000,1,'','2012-03-06 12:00:00','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               04.03.12 03.03.12      5000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR06.03.2012CRD_6738FV548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               04.03.12 03.03.12      5000.00  RUR0,005000,00',0,0,1,0),
  (1552,0,0,NULL,10000.000,1,'','2012-03-05 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               03.03.12 02.03.12     10000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR05.03.2012CRD_4ZH2TU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               03.03.12 02.03.12     10000.00  RUR0,0010000,00',0,0,1,0),
  (1553,0,0,NULL,500.000,1,'','2012-03-04 12:00:00','Платеж 92710631.1 в пользу Beeline,903+++3554,04.03.12,14-17-58,Номер ответа 1003310833202',2,1,0,1,'Текущий счет40817810104610017169RUR04.03.201292710631.1Платеж 92710631.1 в пользу Beeline,903+++3554,04.03.12,14-17-58,Номер ответа 10033108332020,00500,00',0,0,1,0),
  (1554,0,0,NULL,6000.000,1,'','2012-03-02 12:00:00','Внесение средств через устройство Cash-in 155087 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR02.03.2012CASHIN155087Внесение средств через устройство Cash-in 155087 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА6000,000,00',0,0,1,0),
  (1555,0,0,NULL,30000.000,1,'','2012-03-02 12:00:00','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,1,0,1,'Текущий счет40817810104610017169RUR02.03.201292464822.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0030000,00',0,0,1,0),
  (1556,0,0,NULL,99.000,1,'','2012-03-01 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 26.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000090Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 26.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0099,00',0,0,1,0),
  (1557,0,0,NULL,59.000,1,'','2012-03-01 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с28.02.12 до28.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000089Комиссия за услугу \"Альфа-Чек\"за период с28.02.12 до28.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,1,0),
  (1558,0,0,NULL,11.880,1,'','2012-03-01 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000088Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0011,88',0,0,1,0),
  (1559,0,0,NULL,21000.000,1,'','2012-03-01 12:00:00','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА21000,000,00',0,0,1,0),
  (1560,0,0,NULL,22000.000,1,'','2012-03-01 12:00:00','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА22000,000,00',0,0,1,0),
  (1561,0,0,NULL,87.120,1,'','2012-02-29 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR29.02.2012MORE 29202000168Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0087,12',0,0,1,0),
  (1562,0,0,NULL,15.050,1,'','2012-02-29 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR29.02.2012MORE 29202000167Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0015,05',0,0,1,0),
  (1563,0,0,NULL,1602.090,1,'','2012-02-29 12:00:00','548673++++++1500     S1B7112\\THA\\PHUKET\\JUNGSE\\BAY                    28.02.12 26.02.12      1650.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR29.02.2012CRD_1860WR548673++++++1500     S1B7112\\THA\\PHUKET\\JUNGSE\\BAY                    28.02.12 26.02.12      1650.00  THB0,001602,09',0,0,1,0),
  (1564,0,0,NULL,181.490,1,'','2012-02-27 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012MORE 27202000181Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00181,49',0,0,1,0),
  (1565,0,0,NULL,19653.910,1,'','2012-02-27 12:00:00','548673++++++1500     S1B2837\\THA\\PHUKET\\HAT PA\\KASIKORNBANK           25.02.12 23.02.12     20150.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_13C90N548673++++++1500     S1B2837\\THA\\PHUKET\\HAT PA\\KASIKORNBANK           25.02.12 23.02.12     20150.00  THB0,0019653,91',0,0,1,0),
  (1566,0,0,NULL,9023.240,1,'','2012-02-27 12:00:00','548673++++++1500    \\THA\\PHUKET\\4116 J\\KRUNGTHAI OPT                  24.02.12 22.02.12      9200.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_97U1SM548673++++++1500    \\THA\\PHUKET\\4116 J\\KRUNGTHAI OPT                  24.02.12 22.02.12      9200.00  THB0,009023,24',0,0,1,0),
  (1567,0,0,NULL,3079.210,1,'','2012-02-27 12:00:00','548673++++++1500     S1B5292\\THA\\PHUKET\\JUNGCE\\KASIKORNBANK           24.02.12 22.02.12      3150.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_5AV3NM548673++++++1500     S1B5292\\THA\\PHUKET\\JUNGCE\\KASIKORNBANK           24.02.12 22.02.12      3150.00  THB0,003079,21',0,0,1,0),
  (1568,0,0,NULL,1000.000,1,'','2012-02-25 12:00:00','Платеж 91611317.1 в пользу Beeline,903+++3554,25.02.12,05-03-56,Номер ответа 1003287066805',2,1,0,1,'Текущий счет40817810104610017169RUR25.02.201291611317.1Платеж 91611317.1 в пользу Beeline,903+++3554,25.02.12,05-03-56,Номер ответа 10032870668050,001000,00',0,0,1,0),
  (1569,0,0,NULL,299.000,1,'','2012-02-22 12:00:00','Комиссия за обслуживание карты за период с19.02.12 по19.02.13 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR22.02.2012MORE 22202000150Комиссия за обслуживание карты за период с19.02.12 по19.02.13 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00299,00',0,0,1,0),
  (1570,0,0,NULL,15000.000,1,'','2012-02-22 12:00:00','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,1,0,1,'Текущий счет40817810104610017169RUR22.02.201291308200.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0015000,00',0,0,1,0),
  (1571,0,0,NULL,58.890,1,'','2012-02-21 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR21.02.2012MORE 21202000140Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0058,89',0,0,1,0),
  (1572,0,0,NULL,50000.000,1,'','2012-02-21 12:00:00','Внесение средств через устройство Cash-in 155123 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR21.02.2012CASHIN155123Внесение средств через устройство Cash-in 155123 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА50000,000,00',0,0,1,0),
  (1573,0,0,NULL,0.110,1,'','2012-02-17 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR17.02.2012MORE 17202000208Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,000,11',0,0,1,0),
  (1574,0,0,NULL,59.000,1,'','2012-02-10 12:00:00','Комиссия за услугу Альфа-Мобайл за период с 10.02.2012 по 09.03.2012 Согл.тариф.банка',2,1,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 10202000010Комиссия за услугу Альфа-Мобайл за период с 10.02.2012 по 09.03.2012 Согл.тариф.банка0,0059,00',0,0,1,0),
  (1575,0,0,NULL,129.000,1,'','2012-02-10 12:00:00','Комиссия за пакет услуг            за февраль 2012 г.                 Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 10202000009Комиссия за пакет услуг            за февраль 2012 г.                 Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,1,0),
  (1576,0,0,NULL,183.120,1,'','2012-02-10 12:00:00','Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 21002000006Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА183,120,00',0,0,1,0),
  (1577,0,0,NULL,59.000,1,'','2012-01-30 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с28.01.12 до28.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR30.01.2012MORE 30201000086Комиссия за услугу \"Альфа-Чек\"за период с28.01.12 до28.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,1,0),
  (1578,0,0,NULL,355.000,1,'','2012-01-23 12:00:00','548673++++++1500      899026\\RUS\\MOSCOW\\82-4 V\\IP AKAD NAROD          21.01.12 18.01.12       355.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR23.01.2012CRD_67C7EX548673++++++1500      899026\\RUS\\MOSCOW\\82-4 V\\IP AKAD NAROD          21.01.12 18.01.12       355.00  RUR0,00355,00',0,0,1,0),
  (1579,0,0,NULL,16000.000,1,'','2012-01-23 12:00:00','548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 20.01.12 19.01.12     16000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR23.01.2012CRD_4X85BY548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 20.01.12 19.01.12     16000.00  RUR0,0016000,00',0,0,1,0),
  (1580,0,0,NULL,416.000,1,'','2012-01-19 12:00:00','548673++++++1500    26001256\\RUS\\ORENBURG\\MCDONALDS 271               18.01.12 15.01.12       416.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR19.01.2012CRD_1118TV548673++++++1500    26001256\\RUS\\ORENBURG\\MCDONALDS 271               18.01.12 15.01.12       416.00  RUR0,00416,00',0,0,1,0),
  (1581,0,0,NULL,7060.000,1,'','2012-01-18 12:00:00','548673++++++1500    15516001\\RUS\\ORENBURGSKY \\\\ORENBURG AIRL          17.01.12 14.01.12      7060.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_9NR85V548673++++++1500    15516001\\RUS\\ORENBURGSKY \\\\ORENBURG AIRL          17.01.12 14.01.12      7060.00  RUR0,007060,00',0,0,1,0),
  (1582,0,0,NULL,8722.000,1,'','2012-01-18 12:00:00','548673++++++1500    20508433\\RUS\\ORENBURG\\1-2,\\\"SAMSONITE\"            17.01.12 15.01.12      8722.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_8S18VV548673++++++1500    20508433\\RUS\\ORENBURG\\1-2,\\\"SAMSONITE\"            17.01.12 15.01.12      8722.00  RUR0,008722,00',0,0,1,0),
  (1583,0,0,NULL,3000.000,1,'','2012-01-18 12:00:00','548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 17.01.12 16.01.12      3000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5E31NW548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 17.01.12 16.01.12      3000.00  RUR0,003000,00',0,0,1,0),
  (1584,0,0,NULL,201.920,1,'','2012-01-18 12:00:00','548673++++++1500    00003297\\LUX\\LUXEMBOURG\\23\\SKYPE COMMUNI          17.01.12 11.01.12         5.00  EUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_3KR8RT548673++++++1500    00003297\\LUX\\LUXEMBOURG\\23\\SKYPE COMMUNI          17.01.12 11.01.12         5.00  EUR0,00201,92',0,0,1,0),
  (1585,0,0,NULL,6900.000,1,'','2012-01-18 12:00:00','548673++++++1500    80002001\\RUS\\MOSKVA\\13 STR\\1GB.RU                 15.01.12 13.01.12      6900.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_7646ZT548673++++++1500    80002001\\RUS\\MOSKVA\\13 STR\\1GB.RU                 15.01.12 13.01.12      6900.00  RUR0,006900,00',0,0,1,0),
  (1586,0,0,NULL,40000.000,1,'','2012-01-18 12:00:00','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5V345V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,1,0),
  (1587,0,0,NULL,40000.000,1,'','2012-01-18 12:00:00','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5U545V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,1,0),
  (1588,0,0,NULL,40000.000,1,'','2012-01-18 12:00:00','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_1W445V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,1,0),
  (1589,0,0,NULL,500.000,1,'','2012-01-17 12:00:00','Платеж 86010703.1 в пользу Beeline,903+++3554,17.01.12,20-07-52,Номер ответа 1003182924042',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.201286010703.1Платеж 86010703.1 в пользу Beeline,903+++3554,17.01.12,20-07-52,Номер ответа 10031829240420,00500,00',0,0,1,0),
  (1590,0,0,NULL,40000.000,1,'','2012-01-17 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_8TS7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,1,0),
  (1591,0,0,NULL,30000.000,1,'','2012-01-17 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     30000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_4418YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     30000.00  RUR0,0030000,00',0,0,1,0),
  (1592,0,0,NULL,40000.000,1,'','2012-01-17 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_4WF7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,1,0),
  (1593,0,0,NULL,40000.000,1,'','2012-01-17 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_22A7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,1,0),
  (1594,0,0,NULL,59.000,1,NULL,'2012-01-16 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с16.01.12 до16.02.12 Согласно тарифам Банка AB2DV9 \ncwwece\ncwecwc ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,NULL,3,'Текущий счет40817810104610017169USD16.01.2012MORE 16201000205Комиссия за услугу \"Альфа-Чек\"за период с16.01.12 до16.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,1,0),
  (1595,0,0,NULL,2000.000,1,NULL,'2012-05-23 16:04:00',NULL,16,1,627,3,NULL,0,NULL,3,0),
  (1596,0,0,NULL,1000.000,1,NULL,'2012-05-23 16:04:00',NULL,1,1,627,3,NULL,0,NULL,3,0),
  (1597,0,0,NULL,1000.000,1,NULL,'2012-05-26 16:42:00',NULL,1,1,627,3,NULL,0,NULL,3,0),
  (1598,0,0,NULL,1400.000,1,NULL,'2012-05-26 16:42:00',NULL,1,1,627,3,NULL,0,NULL,3,0),
  (1599,0,0,NULL,45000.000,1,'','2012-04-16 12:00:00','Внесение средств через устройство Cash-in 400777 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR16.04.2012CASHIN400777Внесение средств через устройство Cash-in 400777 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА45000,000,00',0,0,1,0),
  (1600,0,0,NULL,59.000,1,'','2012-04-10 12:00:00','Комиссия за услугу Альфа-Мобайл за период с 10.04.2012 по 09.05.2012 Согл.тариф.банка',2,1,0,1,'Текущий счет40817810104610017169RUR10.04.2012MORE 10204000017Комиссия за услугу Альфа-Мобайл за период с 10.04.2012 по 09.05.2012 Согл.тариф.банка0,0059,00',0,0,1,0),
  (1601,0,0,NULL,58.380,1,'','2012-04-10 12:00:00','Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR10.04.2012MORE 21004000009Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА58,380,00',0,0,1,0),
  (1602,0,0,NULL,129.000,1,NULL,'2012-04-10 12:00:00','Комиссия за пакет услуг            за апрель 2012 г. Согласно тарифам Банка  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,635,1,'Текущий счет40817810104610017169RUR10.04.2012Комиссия за пакет услуг            за апрель 2012 г. Согласно тарифам Банка  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,3,0),
  (1603,0,0,NULL,26000.000,1,'','2012-04-05 12:00:00','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,1,0,1,'Текущий счет40817810104610017169RUR05.04.201296449683.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0026000,00',0,0,1,0),
  (1604,0,0,NULL,1000.000,1,'','2012-04-04 12:00:00','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR04.04.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА1000,000,00',0,0,1,0),
  (1605,0,0,NULL,25000.000,1,'','2012-04-04 12:00:00','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR04.04.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА25000,000,00',0,0,1,0),
  (1606,0,0,NULL,59.000,1,'','2012-04-02 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с28.03.12 до28.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR02.04.2012MORE 02204000294Комиссия за услугу \"Альфа-Чек\"за период с28.03.12 до28.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,1,0),
  (1607,0,0,NULL,59.000,1,'','2012-03-19 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с16.03.12 до16.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR19.03.2012MORE 19203000736Комиссия за услугу \"Альфа-Чек\"за период с16.03.12 до16.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,1,0),
  (1608,0,0,NULL,1000.000,1,'','2012-03-19 12:00:00','N 20120319211059912. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 19.03.2012, 21-10-55.',2,1,0,1,'Текущий счет40817810104610017169RUR19.03.2012YMO005I4231J0MVCN 20120319211059912. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 19.03.2012, 21-10-55.0,001000,00',0,0,1,0),
  (1609,0,0,NULL,1000.000,1,'','2012-03-17 12:00:00','N 20120317093400621. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 17.03.2012, 09-33-59.',2,1,0,1,'Текущий счет40817810104610017169RUR17.03.2012YMO005I4222I7UI5N 20120317093400621. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 17.03.2012, 09-33-59.0,001000,00',0,0,1,0),
  (1610,0,0,NULL,200.000,1,'','2012-03-16 12:00:00','Платеж 94144899.1 в пользу Beeline,903+++3554,16.03.12,16-05-24,Номер ответа 1003345955259',2,1,0,1,'Текущий счет40817810104610017169RUR16.03.201294144899.1Платеж 94144899.1 в пользу Beeline,903+++3554,16.03.12,16-05-24,Номер ответа 10033459552590,00200,00',0,0,1,0),
  (1611,0,0,NULL,500.000,1,'','2012-03-16 12:00:00','Платеж 94144198.1 в пользу Beeline,903+++3554,16.03.12,15-57-09,Номер ответа 1003345940771',2,1,0,1,'Текущий счет40817810104610017169RUR16.03.201294144198.1Платеж 94144198.1 в пользу Beeline,903+++3554,16.03.12,15-57-09,Номер ответа 10033459407710,00500,00',0,0,1,0),
  (1612,0,0,NULL,194.270,1,'','2012-03-14 12:00:00','548673++++++1500    \\GBR\\44870835190\\2\\SKYPE                          13.03.12 07.03.12         5.00  EUR',2,1,0,1,'Текущий счет40817810104610017169RUR14.03.2012CRD_2KU18Y548673++++++1500    \\GBR\\44870835190\\2\\SKYPE                          13.03.12 07.03.12         5.00  EUR0,00194,27',0,0,1,0),
  (1613,0,0,NULL,59.000,1,'','2012-03-10 12:00:00','Комиссия за услугу Альфа-Мобайл за период с 10.03.2012 по 09.04.2012 Согл.тариф.банка',2,1,0,1,'Текущий счет40817810104610017169RUR10.03.2012MORE 10203000009Комиссия за услугу Альфа-Мобайл за период с 10.03.2012 по 09.04.2012 Согл.тариф.банка0,0059,00',0,0,1,0),
  (1614,0,0,NULL,129.000,1,'','2012-03-10 12:00:00','Комиссия за пакет услуг            за март 2012 г.                    Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR10.03.2012Комиссия за пакет услуг            за март 2012 г.                    Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,1,0),
  (1615,0,0,NULL,5000.000,1,'','2012-03-06 12:00:00','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               04.03.12 03.03.12      5000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR06.03.2012CRD_6738FV548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               04.03.12 03.03.12      5000.00  RUR0,005000,00',0,0,1,0),
  (1616,0,0,NULL,10000.000,1,'','2012-03-05 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               03.03.12 02.03.12     10000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR05.03.2012CRD_4ZH2TU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               03.03.12 02.03.12     10000.00  RUR0,0010000,00',0,0,1,0),
  (1617,0,0,NULL,500.000,1,'','2012-03-04 12:00:00','Платеж 92710631.1 в пользу Beeline,903+++3554,04.03.12,14-17-58,Номер ответа 1003310833202',2,1,0,1,'Текущий счет40817810104610017169RUR04.03.201292710631.1Платеж 92710631.1 в пользу Beeline,903+++3554,04.03.12,14-17-58,Номер ответа 10033108332020,00500,00',0,0,1,0),
  (1618,0,0,NULL,6000.000,1,'','2012-03-02 12:00:00','Внесение средств через устройство Cash-in 155087 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR02.03.2012CASHIN155087Внесение средств через устройство Cash-in 155087 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА6000,000,00',0,0,1,0),
  (1619,0,0,NULL,30000.000,1,'','2012-03-02 12:00:00','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,1,0,1,'Текущий счет40817810104610017169RUR02.03.201292464822.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0030000,00',0,0,1,0),
  (1620,0,0,NULL,99.000,1,'','2012-03-01 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 26.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000090Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 26.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0099,00',0,0,1,0),
  (1621,0,0,NULL,59.000,1,'','2012-03-01 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с28.02.12 до28.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000089Комиссия за услугу \"Альфа-Чек\"за период с28.02.12 до28.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,1,0),
  (1622,0,0,NULL,11.880,1,'','2012-03-01 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000088Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0011,88',0,0,1,0),
  (1623,0,0,NULL,21000.000,1,'','2012-03-01 12:00:00','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА21000,000,00',0,0,1,0),
  (1624,0,0,NULL,22000.000,1,'','2012-03-01 12:00:00','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА22000,000,00',0,0,1,0),
  (1625,0,0,NULL,87.120,1,'','2012-02-29 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR29.02.2012MORE 29202000168Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0087,12',0,0,1,0),
  (1626,0,0,NULL,15.050,1,'','2012-02-29 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR29.02.2012MORE 29202000167Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0015,05',0,0,1,0),
  (1627,0,0,NULL,1602.090,1,'','2012-02-29 12:00:00','548673++++++1500     S1B7112\\THA\\PHUKET\\JUNGSE\\BAY                    28.02.12 26.02.12      1650.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR29.02.2012CRD_1860WR548673++++++1500     S1B7112\\THA\\PHUKET\\JUNGSE\\BAY                    28.02.12 26.02.12      1650.00  THB0,001602,09',0,0,1,0),
  (1628,0,0,NULL,181.490,1,'','2012-02-27 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012MORE 27202000181Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00181,49',0,0,1,0),
  (1629,0,0,NULL,19653.910,1,'','2012-02-27 12:00:00','548673++++++1500     S1B2837\\THA\\PHUKET\\HAT PA\\KASIKORNBANK           25.02.12 23.02.12     20150.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_13C90N548673++++++1500     S1B2837\\THA\\PHUKET\\HAT PA\\KASIKORNBANK           25.02.12 23.02.12     20150.00  THB0,0019653,91',0,0,1,0),
  (1630,0,0,NULL,9023.240,1,'','2012-02-27 12:00:00','548673++++++1500    \\THA\\PHUKET\\4116 J\\KRUNGTHAI OPT                  24.02.12 22.02.12      9200.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_97U1SM548673++++++1500    \\THA\\PHUKET\\4116 J\\KRUNGTHAI OPT                  24.02.12 22.02.12      9200.00  THB0,009023,24',0,0,1,0),
  (1631,0,0,NULL,3079.210,1,'','2012-02-27 12:00:00','548673++++++1500     S1B5292\\THA\\PHUKET\\JUNGCE\\KASIKORNBANK           24.02.12 22.02.12      3150.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_5AV3NM548673++++++1500     S1B5292\\THA\\PHUKET\\JUNGCE\\KASIKORNBANK           24.02.12 22.02.12      3150.00  THB0,003079,21',0,0,1,0),
  (1632,0,0,NULL,1000.000,1,'','2012-02-25 12:00:00','Платеж 91611317.1 в пользу Beeline,903+++3554,25.02.12,05-03-56,Номер ответа 1003287066805',2,1,0,1,'Текущий счет40817810104610017169RUR25.02.201291611317.1Платеж 91611317.1 в пользу Beeline,903+++3554,25.02.12,05-03-56,Номер ответа 10032870668050,001000,00',0,0,1,0),
  (1633,0,0,NULL,299.000,1,'','2012-02-22 12:00:00','Комиссия за обслуживание карты за период с19.02.12 по19.02.13 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR22.02.2012MORE 22202000150Комиссия за обслуживание карты за период с19.02.12 по19.02.13 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00299,00',0,0,1,0),
  (1634,0,0,NULL,15000.000,1,'','2012-02-22 12:00:00','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,1,0,1,'Текущий счет40817810104610017169RUR22.02.201291308200.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0015000,00',0,0,1,0),
  (1635,0,0,NULL,58.890,1,'','2012-02-21 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR21.02.2012MORE 21202000140Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0058,89',0,0,1,0),
  (1636,0,0,NULL,50000.000,1,'','2012-02-21 12:00:00','Внесение средств через устройство Cash-in 155123 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR21.02.2012CASHIN155123Внесение средств через устройство Cash-in 155123 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА50000,000,00',0,0,1,0),
  (1637,0,0,NULL,0.110,1,'','2012-02-17 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR17.02.2012MORE 17202000208Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,000,11',0,0,1,0),
  (1638,0,0,NULL,59.000,1,'','2012-02-10 12:00:00','Комиссия за услугу Альфа-Мобайл за период с 10.02.2012 по 09.03.2012 Согл.тариф.банка',2,1,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 10202000010Комиссия за услугу Альфа-Мобайл за период с 10.02.2012 по 09.03.2012 Согл.тариф.банка0,0059,00',0,0,1,0),
  (1639,0,0,NULL,129.000,1,'','2012-02-10 12:00:00','Комиссия за пакет услуг            за февраль 2012 г.                 Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 10202000009Комиссия за пакет услуг            за февраль 2012 г.                 Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,1,0),
  (1640,0,0,NULL,183.120,1,'','2012-02-10 12:00:00','Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 21002000006Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА183,120,00',0,0,1,0),
  (1641,0,0,NULL,59.000,1,'','2012-01-30 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с28.01.12 до28.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR30.01.2012MORE 30201000086Комиссия за услугу \"Альфа-Чек\"за период с28.01.12 до28.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,1,0),
  (1642,0,0,NULL,355.000,1,'','2012-01-23 12:00:00','548673++++++1500      899026\\RUS\\MOSCOW\\82-4 V\\IP AKAD NAROD          21.01.12 18.01.12       355.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR23.01.2012CRD_67C7EX548673++++++1500      899026\\RUS\\MOSCOW\\82-4 V\\IP AKAD NAROD          21.01.12 18.01.12       355.00  RUR0,00355,00',0,0,1,0),
  (1643,0,0,NULL,16000.000,1,'','2012-01-23 12:00:00','548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 20.01.12 19.01.12     16000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR23.01.2012CRD_4X85BY548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 20.01.12 19.01.12     16000.00  RUR0,0016000,00',0,0,1,0),
  (1644,0,0,NULL,416.000,1,'','2012-01-19 12:00:00','548673++++++1500    26001256\\RUS\\ORENBURG\\MCDONALDS 271               18.01.12 15.01.12       416.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR19.01.2012CRD_1118TV548673++++++1500    26001256\\RUS\\ORENBURG\\MCDONALDS 271               18.01.12 15.01.12       416.00  RUR0,00416,00',0,0,1,0),
  (1645,0,0,NULL,7060.000,1,'','2012-01-18 12:00:00','548673++++++1500    15516001\\RUS\\ORENBURGSKY \\\\ORENBURG AIRL          17.01.12 14.01.12      7060.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_9NR85V548673++++++1500    15516001\\RUS\\ORENBURGSKY \\\\ORENBURG AIRL          17.01.12 14.01.12      7060.00  RUR0,007060,00',0,0,1,0),
  (1646,0,0,NULL,8722.000,1,'','2012-01-18 12:00:00','548673++++++1500    20508433\\RUS\\ORENBURG\\1-2,\\\"SAMSONITE\"            17.01.12 15.01.12      8722.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_8S18VV548673++++++1500    20508433\\RUS\\ORENBURG\\1-2,\\\"SAMSONITE\"            17.01.12 15.01.12      8722.00  RUR0,008722,00',0,0,1,0),
  (1647,0,0,NULL,3000.000,1,'','2012-01-18 12:00:00','548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 17.01.12 16.01.12      3000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5E31NW548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 17.01.12 16.01.12      3000.00  RUR0,003000,00',0,0,1,0),
  (1648,0,0,NULL,201.920,1,'','2012-01-18 12:00:00','548673++++++1500    00003297\\LUX\\LUXEMBOURG\\23\\SKYPE COMMUNI          17.01.12 11.01.12         5.00  EUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_3KR8RT548673++++++1500    00003297\\LUX\\LUXEMBOURG\\23\\SKYPE COMMUNI          17.01.12 11.01.12         5.00  EUR0,00201,92',0,0,1,0),
  (1649,0,0,NULL,6900.000,1,'','2012-01-18 12:00:00','548673++++++1500    80002001\\RUS\\MOSKVA\\13 STR\\1GB.RU                 15.01.12 13.01.12      6900.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_7646ZT548673++++++1500    80002001\\RUS\\MOSKVA\\13 STR\\1GB.RU                 15.01.12 13.01.12      6900.00  RUR0,006900,00',0,0,1,0),
  (1650,0,0,NULL,40000.000,1,'','2012-01-18 12:00:00','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5V345V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,1,0),
  (1651,0,0,NULL,40000.000,1,'','2012-01-18 12:00:00','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5U545V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,1,0),
  (1652,0,0,NULL,40000.000,1,'','2012-01-18 12:00:00','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_1W445V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,1,0),
  (1653,0,0,NULL,500.000,1,'','2012-01-17 12:00:00','Платеж 86010703.1 в пользу Beeline,903+++3554,17.01.12,20-07-52,Номер ответа 1003182924042',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.201286010703.1Платеж 86010703.1 в пользу Beeline,903+++3554,17.01.12,20-07-52,Номер ответа 10031829240420,00500,00',0,0,1,0),
  (1654,0,0,NULL,40000.000,1,'','2012-01-17 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_8TS7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,1,0),
  (1655,0,0,NULL,30000.000,1,'','2012-01-17 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     30000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_4418YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     30000.00  RUR0,0030000,00',0,0,1,0),
  (1656,0,0,NULL,40000.000,1,'','2012-01-17 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_4WF7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,1,0),
  (1657,0,0,NULL,40000.000,1,'','2012-01-17 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_22A7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,1,0),
  (1658,0,0,NULL,59.000,1,'','2012-01-16 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с16.01.12 до16.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,3,'Текущий счет40817810104610017169USD16.01.2012MORE 16201000205Комиссия за услугу \"Альфа-Чек\"за период с16.01.12 до16.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,1,0),
  (1684,0,0,NULL,121.000,21,NULL,'2012-05-30 02:56:00',NULL,1,1,627,1,NULL,0,NULL,3,0),
  (1773,0,0,NULL,1100.824,0,'','2012-05-30 12:00:00','Оплата кредита от 2012-05-30 12:00:00.',5,0,0,1,NULL,8,0,1,0),
  (1774,0,0,NULL,1100.824,0,'','2012-06-30 12:00:00','Оплата кредита от 2012-06-30 12:00:00.',5,0,0,1,NULL,8,0,1,0),
  (1775,0,0,NULL,1100.824,0,'','2012-07-30 12:00:00','Оплата кредита от 2012-07-30 12:00:00.',5,1,0,1,NULL,8,0,1,0),
  (1776,0,0,NULL,1100.824,0,'','2012-08-30 12:00:00','Оплата кредита от 2012-08-30 12:00:00.',5,0,0,1,NULL,8,0,1,0),
  (1777,0,0,NULL,1100.824,0,'','2012-09-30 12:00:00','Оплата кредита от 2012-09-30 12:00:00.',5,0,0,1,NULL,8,0,1,0),
  (1778,0,0,NULL,1100.820,NULL,NULL,'2012-10-30 12:00:00','Оплата кредита от 2012-10-30 12:00:00.',5,0,NULL,1,NULL,8,0,1,0),
  (1779,0,0,NULL,1100.820,NULL,NULL,'2012-11-30 12:00:00','Оплата кредита от 2012-11-30 12:00:00.',5,1,NULL,1,NULL,8,0,1,0),
  (1780,0,0,NULL,1100.820,NULL,NULL,'2012-12-30 12:00:00','Оплата кредита от 2012-12-30 12:00:00.',5,1,629,1,NULL,8,0,1,0),
  (1781,0,0,NULL,1100.824,0,'','2013-01-30 12:00:00','Оплата кредита от 2013-01-30 12:00:00.',5,0,0,1,NULL,8,0,1,0),
  (1782,0,0,NULL,1100.820,NULL,NULL,'2013-03-02 12:00:00','Оплата кредита от 2013-03-02 12:00:00.',5,1,633,1,NULL,8,0,3,0),
  (1783,0,0,NULL,1100.824,0,'','2013-04-02 12:00:00','Оплата кредита от 2013-04-02 12:00:00.',5,0,0,1,NULL,8,0,1,0),
  (1784,0,0,NULL,1100.824,0,'','2013-05-02 12:00:00','Оплата кредита от 2013-05-02 12:00:00.',5,0,0,1,NULL,8,0,1,0),
  (1785,0,0,NULL,100.000,1,NULL,'2012-06-05 03:51:51',NULL,1,1,627,3,NULL,0,NULL,3,0),
  (1786,0,0,NULL,1000.000,2,'','2012-01-13 05:15:52','Note Acceptance RUS ORENBURG 3,M.ZHUKOVA 510369',1,1,0,1,'708113.01.2012 17:15:5213.01.20121000.00RUR0.001000.00Note Acceptance RUS ORENBURG 3,M.ZHUKOVA 510369',0,0,3,0),
  (1787,0,0,NULL,150.000,2,'','2011-12-21 05:11:16','Card Production (Debit) 2 years   Card Production (Debit) 2 years',2,1,0,1,'708121.12.2011 17:11:1614.01.20120.00RUR-150.00-150.00Card Production (Debit) 2 years   Card Production (Debit) 2 years',0,0,3,0),
  (1788,0,0,NULL,34000.000,2,'','2012-01-16 09:04:03','Note Acceptance RUS MOSCOW 1,1,POKRYISHKINA 567463',1,1,0,1,'708116.01.2012 21:04:0317.01.201234000.00RUR0.0034000.00Note Acceptance RUS MOSCOW 1,1,POKRYISHKINA 567463',0,0,3,0),
  (1789,0,0,NULL,40000.000,2,'','2012-01-16 09:05:06','Note Acceptance RUS MOSCOW 1,1,POKRYISHKINA 568439',1,1,0,1,'708116.01.2012 21:05:0617.01.201240000.00RUR0.0040000.00Note Acceptance RUS MOSCOW 1,1,POKRYISHKINA 568439',0,0,3,0),
  (1790,0,0,NULL,40000.000,2,'','2012-01-18 02:58:40','Credit RUS ORENBURG 10, GAGARINA 119635',1,1,0,1,'708118.01.2012 14:58:4018.01.201240000.00RUR0.0040000.00Credit RUS ORENBURG 10, GAGARINA 119635',0,0,3,0),
  (1791,0,0,NULL,10000.000,2,'','2012-01-21 11:15:23','Unique RUS MOSCOW TELEBANK 843368',2,1,0,1,'708121.01.2012 11:15:2321.01.2012-10000.00RUR0.00-10000.00Unique RUS MOSCOW TELEBANK 843368',0,0,3,0),
  (1792,0,0,NULL,60000.000,2,'','2012-01-24 12:00:46','Credit RUS ORENBURG 10, GAGARINA 964890',1,1,0,1,'708124.01.2012 12:00:4624.01.201260000.00RUR0.0060000.00Credit RUS ORENBURG 10, GAGARINA 964890',0,0,3,0),
  (1793,0,0,NULL,7060.000,2,'','2012-01-25 12:00:00','Retail RUS ORENBURGSKY R ORENBURG AI 2912428306245 416599',2,1,0,1,'708125.01.2012 00:00:0027.01.2012-7060.00RUR0.00-7060.00Retail RUS ORENBURGSKY R ORENBURG AI 2912428306245 416599',0,0,3,0),
  (1794,0,0,NULL,6200.000,2,'','2012-01-25 12:00:00','ATM RUS MOSCOW 00000230/ZENIT ATM 230    727361',2,1,0,1,'708125.01.2012 00:00:0027.01.2012-6000.00RUR-200.00-6200.00ATM RUS MOSCOW 00000230/ZENIT ATM 230    727361',0,0,3,0),
  (1795,0,0,NULL,6200.000,2,'','2012-01-25 12:00:00','ATM RUS MOSCOW 00000230/ZENIT ATM 230    728717',2,1,0,1,'708125.01.2012 00:00:0027.01.2012-6000.00RUR-200.00-6200.00ATM RUS MOSCOW 00000230/ZENIT ATM 230    728717',0,0,3,0),
  (1796,0,0,NULL,2671.450,2,'','2012-01-25 12:00:00','Retail MUS 442031399063P VENDOSUPPORT.COM          427309',2,1,0,1,'708125.01.2012 00:00:0028.01.2012-87.16USD0.00-2671.45Retail MUS 442031399063P VENDOSUPPORT.COM          427309',0,0,3,0),
  (1797,0,0,NULL,7700.000,2,'','2012-01-26 12:00:00','ATM RUS MOSCOW BANKOMAT 830489 7970      448539',2,1,0,1,'708126.01.2012 00:00:0028.01.2012-7500.00RUR-200.00-7700.00ATM RUS MOSCOW BANKOMAT 830489 7970      448539',0,0,3,0),
  (1798,0,0,NULL,7700.000,2,'','2012-01-26 12:00:00','ATM RUS MOSCOW BANKOMAT 830489 7970      449769',2,1,0,1,'708126.01.2012 00:00:0028.01.2012-7500.00RUR-200.00-7700.00ATM RUS MOSCOW BANKOMAT 830489 7970      449769',0,0,3,0),
  (1799,0,0,NULL,7700.000,2,'','2012-01-26 12:00:00','ATM RUS MOSCOW BANKOMAT 830489 7970      451034',2,1,0,1,'708126.01.2012 00:00:0028.01.2012-7500.00RUR-200.00-7700.00ATM RUS MOSCOW BANKOMAT 830489 7970      451034',0,0,3,0),
  (1800,0,0,NULL,5200.000,2,'','2012-01-29 12:00:00','ATM RUS ORENBURG 01849537/ATM-01849537 URA 538121',2,1,0,1,'708129.01.2012 00:00:0031.01.2012-5000.00RUR-200.00-5200.00ATM RUS ORENBURG 01849537/ATM-01849537 URA 538121',0,0,3,0),
  (1801,0,0,NULL,114418.000,2,'','2012-02-03 03:35:57','Unique RUS MOSCOW TELEBANK 814242',2,1,0,1,'708103.02.2012 15:35:5703.02.2012-114418.00RUR0.00-114418.00Unique RUS MOSCOW TELEBANK 814242',0,0,3,0),
  (1802,0,0,NULL,20000.000,2,'','2012-02-03 03:52:25','Credit RUS MOSCOW TELEBANK 847446',1,1,0,1,'708103.02.2012 15:52:2503.02.201220000.00RUR0.0020000.00Credit RUS MOSCOW TELEBANK 847446',0,0,3,0),
  (1803,0,0,NULL,20000.000,2,'','2012-02-03 03:52:40','ATM RUS ORENBURG 3,M.ZHUKOVA 847963',2,1,0,1,'708103.02.2012 15:52:4003.02.2012-20000.00RUR0.00-20000.00ATM RUS ORENBURG 3,M.ZHUKOVA 847963',0,0,3,0),
  (1804,0,0,NULL,5000.000,2,'','2012-02-05 09:21:52','Credit RUS MOSCOW TELEBANK 822806',1,1,0,1,'708105.02.2012 09:21:5205.02.20125000.00RUR0.005000.00Credit RUS MOSCOW TELEBANK 822806',0,0,3,0),
  (1805,0,0,NULL,118.900,2,'','2012-02-07 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    400740',2,1,0,1,'708107.02.2012 00:00:0009.02.2012-3.97USD0.00-118.90Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    400740',0,0,3,0),
  (1806,0,0,NULL,415000.000,2,'','2012-02-10 03:06:58','Credit RUS MOSCOW 5-1, MARKSISTSKAYA 729674',1,1,0,1,'708110.02.2012 15:06:5810.02.2012415000.00RUR0.00415000.00Credit RUS MOSCOW 5-1, MARKSISTSKAYA 729674',0,0,3,0),
  (1807,0,0,NULL,218000.000,2,'','2012-02-10 03:13:19','Unique RUS MOSCOW TELEBANK 744178',2,1,0,1,'708110.02.2012 15:13:1910.02.2012-218000.00RUR0.00-218000.00Unique RUS MOSCOW TELEBANK 744178',0,0,3,0),
  (1808,0,0,NULL,40000.000,2,'','2012-02-11 06:39:58','ATM RUS ORENBURG 3,M.ZHUKOVA 677341',2,1,0,1,'708111.02.2012 06:39:5811.02.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 677341',0,0,3,0),
  (1809,0,0,NULL,40000.000,2,'','2012-02-11 06:40:42','ATM RUS ORENBURG 3,M.ZHUKOVA 677725',2,1,0,1,'708111.02.2012 06:40:4211.02.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 677725',0,0,3,0),
  (1810,0,0,NULL,60000.000,2,'','2012-02-11 10:04:21','Unique RUS MOSCOW TELEBANK 882452',2,1,0,1,'708111.02.2012 10:04:2111.02.2012-60000.00RUR0.00-60000.00Unique RUS MOSCOW TELEBANK 882452',0,0,3,0),
  (1811,0,0,NULL,999.890,2,'','2012-02-10 12:00:00','Retail RUS ORENBURG LUKOIL 59                 587220',2,1,0,1,'708110.02.2012 00:00:0012.02.2012-999.89RUR0.00-999.89Retail RUS ORENBURG LUKOIL 59                 587220',0,0,3,0),
  (1812,0,0,NULL,172.000,2,'','2012-02-10 12:00:00','Retail RUS ORENBURG MCDONALDS 27101           823387',2,1,0,1,'708110.02.2012 00:00:0012.02.2012-172.00RUR0.00-172.00Retail RUS ORENBURG MCDONALDS 27101           823387',0,0,3,0),
  (1813,0,0,NULL,56.000,2,'','2012-02-10 12:00:00','Retail RUS ORENBURG MCDONALDS 27101           830816',2,1,0,1,'708110.02.2012 00:00:0012.02.2012-56.00RUR0.00-56.00Retail RUS ORENBURG MCDONALDS 27101           830816',0,0,3,0),
  (1814,0,0,NULL,3680.000,2,'','2012-02-12 12:06:20','Retail RUS OREBURG UP!STOR 309442',2,1,0,1,'708112.02.2012 12:06:2012.02.2012-3680.00RUR0.00-3680.00Retail RUS OREBURG UP!STOR 309442',0,0,3,0),
  (1815,0,0,NULL,40000.000,2,'','2012-02-13 11:33:59','ATM RUS ORENBURG 3,M.ZHUKOVA 461445',2,1,0,1,'708113.02.2012 11:33:5913.02.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 461445',0,0,3,0),
  (1816,0,0,NULL,16000.000,2,'','2012-02-13 11:35:20','ATM RUS ORENBURG 3,M.ZHUKOVA 463864',2,1,0,1,'708113.02.2012 11:35:2013.02.2012-16000.00RUR0.00-16000.00ATM RUS ORENBURG 3,M.ZHUKOVA 463864',0,0,3,0),
  (1817,0,0,NULL,151.450,2,'','2012-02-12 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    940437',2,1,0,1,'708112.02.2012 00:00:0014.02.2012-4.99USD0.00-151.45Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    940437',0,0,3,0),
  (1818,0,0,NULL,102100.000,2,'','2012-02-15 11:51:21','Credit RUS MOSCOW 35, MYASNITSKAYA 926813',1,1,0,1,'708115.02.2012 11:51:2115.02.2012102100.00RUR0.00102100.00Credit RUS MOSCOW 35, MYASNITSKAYA 926813',0,0,3,0),
  (1819,0,0,NULL,100000.000,2,'','2012-02-15 03:53:05','Unique RUS MOSCOW TELEBANK 464223',2,1,0,1,'708115.02.2012 15:53:0515.02.2012-100000.00RUR0.00-100000.00Unique RUS MOSCOW TELEBANK 464223',0,0,3,0),
  (1820,0,0,NULL,30000.000,2,'','2012-02-16 08:04:11','Credit RUS MOSCOW TELEBANK 398625',1,1,0,1,'708116.02.2012 08:04:1116.02.201230000.00RUR0.0030000.00Credit RUS MOSCOW TELEBANK 398625',0,0,3,0),
  (1821,0,0,NULL,26512.500,2,'','2012-02-16 08:08:57','Cash RUS ORENBURG 3,MARSHALA ZHUKOVA 404085',2,1,0,1,'708116.02.2012 08:08:5716.02.2012-26512.50RUR0.00-26512.50Cash RUS ORENBURG 3,MARSHALA ZHUKOVA 404085',0,0,3,0),
  (1822,0,0,NULL,90.600,2,'','2012-02-16 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    424280',2,1,0,1,'708116.02.2012 00:00:0018.02.2012-2.99USD0.00-90.60Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    424280',0,0,3,0),
  (1823,0,0,NULL,5000.000,2,'','2012-03-06 07:27:38','Unique RUS MOSCOW TELEBANK 328242',2,1,0,1,'708106.03.2012 07:27:3806.03.2012-5000.00RUR0.00-5000.00Unique RUS MOSCOW TELEBANK 328242',0,0,3,0),
  (1824,0,0,NULL,450000.000,2,'','2012-03-06 07:42:06','Credit RUS MOSCOW 35, MYASNITSKAYA 817446',1,1,0,1,'708106.03.2012 19:42:0606.03.2012450000.00RUR0.00450000.00Credit RUS MOSCOW 35, MYASNITSKAYA 817446',0,0,3,0),
  (1825,0,0,NULL,300000.000,2,'','2012-03-06 08:16:18','Unique RUS MOSCOW TELEBANK 868557',2,1,0,1,'708106.03.2012 20:16:1806.03.2012-300000.00RUR0.00-300000.00Unique RUS MOSCOW TELEBANK 868557',0,0,3,0),
  (1826,0,0,NULL,40000.000,2,'','2012-03-07 08:41:51','ATM RUS ORENBURG 3,M.ZHUKOVA 331699',2,1,0,1,'708107.03.2012 08:41:5107.03.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 331699',0,0,3,0),
  (1827,0,0,NULL,40000.000,2,'','2012-03-07 08:42:51','ATM RUS ORENBURG 3,M.ZHUKOVA 333362',2,1,0,1,'708107.03.2012 08:42:5107.03.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 333362',0,0,3,0),
  (1828,0,0,NULL,1499.000,2,'','2012-03-06 12:00:00','Retail LUX ORIGIN.COM EA *ORIGIN.COM            899435',2,1,0,1,'708106.03.2012 00:00:0009.03.2012-1499.00RUR0.00-1499.00Retail LUX ORIGIN.COM EA *ORIGIN.COM            899435',0,0,3,0),
  (1829,0,0,NULL,40000.000,2,'','2012-03-11 06:33:03','ATM RUS ORENBURG 3,M.ZHUKOVA 774731',2,1,0,1,'708111.03.2012 06:33:0311.03.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 774731',0,0,3,0),
  (1830,0,0,NULL,25000.000,2,'','2012-03-11 06:34:04','ATM RUS ORENBURG 3,M.ZHUKOVA 775371',2,1,0,1,'708111.03.2012 06:34:0411.03.2012-25000.00RUR0.00-25000.00ATM RUS ORENBURG 3,M.ZHUKOVA 775371',0,0,3,0),
  (1831,0,0,NULL,29.650,2,'','2012-03-14 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    311501',2,1,0,1,'708114.03.2012 00:00:0015.03.2012-0.99USD0.00-29.65Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    311501',0,0,3,0),
  (1832,0,0,NULL,88.210,2,'','2012-03-19 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    491028',2,1,0,1,'708119.03.2012 00:00:0021.03.2012-2.99USD0.00-88.21Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    491028',0,0,3,0),
  (1833,0,0,NULL,16000.000,2,'','2012-03-22 08:30:02','Credit RUS MOSCOW TELEBANK 418139',1,1,0,1,'708122.03.2012 08:30:0222.03.201216000.00RUR0.0016000.00Credit RUS MOSCOW TELEBANK 418139',0,0,3,0),
  (1834,0,0,NULL,15000.000,2,'','2012-03-22 08:33:14','Credit RUS MOSCOW TELEBANK 422161',1,1,0,1,'708122.03.2012 08:33:1422.03.201215000.00RUR0.0015000.00Credit RUS MOSCOW TELEBANK 422161',0,0,3,0),
  (1835,0,0,NULL,35000.000,2,'','2012-03-22 08:43:03','ATM RUS ORENBURG 3,M.ZHUKOVA 434977',2,1,0,1,'708122.03.2012 08:43:0322.03.2012-35000.00RUR0.00-35000.00ATM RUS ORENBURG 3,M.ZHUKOVA 434977',0,0,3,0),
  (1836,0,0,NULL,296.910,2,'','2012-03-21 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    417859',2,1,0,1,'708121.03.2012 00:00:0023.03.2012-9.98USD0.00-296.91Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    417859',0,0,3,0),
  (1837,0,0,NULL,340.000,2,'','2012-03-23 08:19:10','Unique RUS MOSCOW TELEBANK 136491',2,1,0,1,'708123.03.2012 08:19:1023.03.2012-340.00RUR0.00-340.00Unique RUS MOSCOW TELEBANK 136491',0,0,3,0),
  (1838,0,0,NULL,278.000,2,'','2012-03-25 09:11:55','Credit RUS MOSCOW TELEBANK 271867',1,1,0,1,'708125.03.2012 21:11:5525.03.2012278.00RUR0.00278.00Credit RUS MOSCOW TELEBANK 271867',0,0,3,0),
  (1839,0,0,NULL,87.310,2,'','2012-03-26 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    272897',2,1,0,1,'708126.03.2012 00:00:0027.03.2012-2.99USD0.00-87.31Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    272897',0,0,3,0),
  (1840,0,0,NULL,450000.000,2,'','2012-03-28 04:09:33','Credit RUS MOSCOW 5-1, MARKSISTSKAYA 758853',1,1,0,1,'708128.03.2012 16:09:3328.03.2012450000.00RUR0.00450000.00Credit RUS MOSCOW 5-1, MARKSISTSKAYA 758853',0,0,3,0),
  (1841,0,0,NULL,40000.000,2,'','2012-03-28 05:15:50','ATM RUS ORENBURG 3,M.ZHUKOVA 889330',2,1,0,1,'708128.03.2012 17:15:5028.03.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 889330',0,0,3,0),
  (1842,0,0,NULL,20000.000,2,'','2012-03-28 05:17:21','ATM RUS ORENBURG 3,M.ZHUKOVA 892751',2,1,0,1,'708128.03.2012 17:17:2128.03.2012-20000.00RUR0.00-20000.00ATM RUS ORENBURG 3,M.ZHUKOVA 892751',0,0,3,0),
  (1843,0,0,NULL,20000.000,2,'','2012-03-28 05:18:14','ATM RUS ORENBURG 3,M.ZHUKOVA 894735',2,1,0,1,'708128.03.2012 17:18:1428.03.2012-20000.00RUR0.00-20000.00ATM RUS ORENBURG 3,M.ZHUKOVA 894735',0,0,3,0),
  (1844,0,0,NULL,20000.000,2,'','2012-03-28 05:18:53','ATM RUS ORENBURG 3,M.ZHUKOVA 896230',2,1,0,1,'708128.03.2012 17:18:5328.03.2012-20000.00RUR0.00-20000.00ATM RUS ORENBURG 3,M.ZHUKOVA 896230',0,0,3,0),
  (1845,0,0,NULL,250000.000,2,'','2012-03-28 05:37:14','Unique RUS MOSCOW TELEBANK 936859',2,1,0,1,'708128.03.2012 17:37:1428.03.2012-250000.00RUR0.00-250000.00Unique RUS MOSCOW TELEBANK 936859',0,0,3,0),
  (1846,0,0,NULL,15000.000,2,'','2012-03-29 03:13:33','Unique RUS MOSCOW TELEBANK 222786',2,1,0,1,'708129.03.2012 15:13:3329.03.2012-15000.00RUR0.00-15000.00Unique RUS MOSCOW TELEBANK 222786',0,0,3,0),
  (1847,0,0,NULL,40000.000,2,'','2012-03-29 10:33:09','ATM RUS ORENBURG 1, SHARLYKSKOE 716071',2,1,0,1,'708129.03.2012 10:33:0930.03.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 1, SHARLYKSKOE 716071',0,0,3,0),
  (1848,0,0,NULL,40000.000,2,'','2012-03-29 10:34:15','ATM RUS ORENBURG 1, SHARLYKSKOE 717823',2,1,0,1,'708129.03.2012 10:34:1530.03.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 1, SHARLYKSKOE 717823',0,0,3,0),
  (1849,0,0,NULL,2500.000,2,'','2012-04-05 03:58:27','Unique RUS MOSCOW TELEBANK 704413',2,1,0,1,'708105.04.2012 15:58:2705.04.2012-2500.00RUR0.00-2500.00Unique RUS MOSCOW TELEBANK 704413',0,0,3,0),
  (1850,0,0,NULL,550000.000,2,'','2012-04-06 01:09:28','Credit RUS MOSCOW 5-1, MARKSISTSKAYA 109496',1,1,0,1,'708106.04.2012 13:09:2806.04.2012550000.00RUR0.00550000.00Credit RUS MOSCOW 5-1, MARKSISTSKAYA 109496',0,0,3,0),
  (1851,0,0,NULL,40000.000,2,'','2012-04-09 12:00:55','ATM RUS ORENBURG 3,M.ZHUKOVA 217417',2,1,0,1,'708109.04.2012 12:00:5509.04.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 217417',0,0,3,0),
  (1852,0,0,NULL,40000.000,2,'','2012-04-09 12:01:37','ATM RUS ORENBURG 3,M.ZHUKOVA 218890',2,1,0,1,'708109.04.2012 12:01:3709.04.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 218890',0,0,3,0),
  (1853,0,0,NULL,20000.000,2,'','2012-04-09 12:02:19','ATM RUS ORENBURG 3,M.ZHUKOVA 220343',2,1,0,1,'708109.04.2012 12:02:1909.04.2012-20000.00RUR0.00-20000.00ATM RUS ORENBURG 3,M.ZHUKOVA 220343',0,0,3,0),
  (1854,0,0,NULL,90.000,2,'','2012-04-09 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    204060',2,1,0,1,'708109.04.2012 00:00:0011.04.2012-2.99USD0.00-90.00Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    204060',0,0,3,0),
  (1855,0,0,NULL,350000.000,2,NULL,'2012-04-11 06:35:06','Unique RUS MOSCOW TELEBANK 324238',2,1,629,1,'708111.04.2012 06:35:0611.04.2012-350000.00RUR0.00-350000.00Unique RUS MOSCOW TELEBANK 324238',0,0,3,0),
  (1856,0,0,NULL,100000.000,2,'','2012-04-11 07:11:23','Cash RUS ORENBURG 14, POBEDY 354727',2,1,0,1,'708111.04.2012 07:11:2311.04.2012-100000.00RUR0.00-100000.00Cash RUS ORENBURG 14, POBEDY 354727',0,0,3,0),
  (1857,0,0,NULL,684.800,2,'','2012-04-14 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    583407',2,1,0,1,'708114.04.2012 00:00:0015.04.2012-22.98USD0.00-684.80Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    583407',0,0,3,0),
  (1858,0,0,NULL,100.000,21,NULL,'2012-06-27 16:50:22',NULL,1,1,627,1,NULL,0,NULL,3,0),
  (1859,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'10/06/2012KOFEYINYA KOFE HAUZ DO   MOSCOW       RU-610.20''5203XXXXXXXX4003''',0,0,3,0),
  (1860,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'10/06/2012MAGAZIN SUPERMARKET V-   MOSCOW       RU-1152.00''5203XXXXXXXX4003''',0,0,3,0),
  (1861,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'08/06/2012Jel Gaucho  Restoran     MOSCOW       RU-10400.00''5203XXXXXXXX4003''',0,0,3,0),
  (1862,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'07/06/2012PET RETAIL 55            MOSCOW       RU-6831.00''5203XXXXXXXX4003''',0,0,3,0),
  (1863,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'07/06/2012PRODUKTY 24              MOSCOW       RU-678.00''5203XXXXXXXX4003''',0,0,3,0),
  (1864,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'07/06/2012AZBUKA VKUSA DOROG       MOSCOW       RU-1038.50''5203XXXXXXXX4003''',0,0,3,0),
  (1865,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'06/06/2012ПЛАТЕЖ ЧЕРЕЗ CITIBANK ONLINE10000.00''5203XXXXXXXX4003''',0,0,3,0),
  (1866,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'06/06/2012CHENTRALE - RESTORAN (   MOSCOW       RU-940.00''5203XXXXXXXX4003''',0,0,3,0),
  (1867,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'05/06/2012BP DONSKAYA RC091        MOSCOW       RU-1850.22''5203XXXXXXXX4003''',0,0,3,0),
  (1868,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'03/06/2012PRODUKTY 24              MOSCOW       RU-421.50''5203XXXXXXXX4003''',0,0,3,0),
  (1869,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'03/06/2012MOROZKO                  MOSCOW       RU-876.32''5203XXXXXXXX4003''',0,0,3,0),
  (1870,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'02/06/2012SCOTTISH BOOK SOURCE L   GLASGOW      GB 14.95 UK? 14.95 UK?-791.58''5203XXXXXXXX4003''',0,0,3,0),
  (1871,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'02/06/2012MAGNOLIYA-REMIZOVA STR   MOSCOW       RU-535.50''5203XXXXXXXX4003''',0,0,3,0),
  (1872,0,0,NULL,0.000,22,'','2012-06-28 23:18:42',NULL,0,1,0,0,'01/06/2012CHENTRALE - RESTORAN (   MOSCOW       RU-4930.00''5203XXXXXXXX4003''',0,0,3,0),
  (1873,0,0,NULL,0.000,22,'','2012-06-28 23:39:48',NULL,0,1,0,0,'11/06/2012BP TREKHGORKA RC302      ODINTSOVSKIY RU-2341.55''5203XXXXXXXX4003''',0,0,3,0),
  (1874,0,0,NULL,548.000,22,'','2012-11-06 12:00:00','''5203XXXXXXXX4003''',2,1,0,0,'11/06/2012PRODUKTY 24              MOSCOW       RU-548.00''5203XXXXXXXX4003''',0,0,3,0),
  (1875,0,0,NULL,45000.000,24,'','2012-04-16 12:00:00','Внесение средств через устройство Cash-in 400777 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR16.04.2012CASHIN400777Внесение средств через устройство Cash-in 400777 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА45000,000,00',0,0,3,0),
  (1876,0,0,NULL,59.000,24,'','2012-04-10 12:00:00','Комиссия за услугу Альфа-Мобайл за период с 10.04.2012 по 09.05.2012 Согл.тариф.банка',2,1,0,1,'Текущий счет40817810104610017169RUR10.04.2012MORE 10204000017Комиссия за услугу Альфа-Мобайл за период с 10.04.2012 по 09.05.2012 Согл.тариф.банка0,0059,00',0,0,3,0),
  (1877,0,0,NULL,58.380,24,'','2012-04-10 12:00:00','Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR10.04.2012MORE 21004000009Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА58,380,00',0,0,3,0),
  (1878,0,0,NULL,129.000,24,'','2012-04-10 12:00:00','Комиссия за пакет услуг            за апрель 2012 г. Согласно тарифам Банка  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR10.04.2012Комиссия за пакет услуг            за апрель 2012 г. Согласно тарифам Банка  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,3,0),
  (1879,0,0,NULL,26000.000,24,'','2012-04-05 12:00:00','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,1,0,1,'Текущий счет40817810104610017169RUR05.04.201296449683.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0026000,00',0,0,3,0),
  (1880,0,0,NULL,1000.000,24,'','2012-04-04 12:00:00','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR04.04.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА1000,000,00',0,0,3,0),
  (1881,0,0,NULL,25000.000,24,'','2012-04-04 12:00:00','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR04.04.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА25000,000,00',0,0,3,0),
  (1882,0,0,NULL,59.000,24,'','2012-04-02 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с28.03.12 до28.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR02.04.2012MORE 02204000294Комиссия за услугу \"Альфа-Чек\"за период с28.03.12 до28.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (1883,0,0,NULL,59.000,24,'','2012-03-19 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с16.03.12 до16.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR19.03.2012MORE 19203000736Комиссия за услугу \"Альфа-Чек\"за период с16.03.12 до16.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (1884,0,0,NULL,1000.000,24,'','2012-03-19 12:00:00','N 20120319211059912. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 19.03.2012, 21-10-55.',2,1,0,1,'Текущий счет40817810104610017169RUR19.03.2012YMO005I4231J0MVCN 20120319211059912. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 19.03.2012, 21-10-55.0,001000,00',0,0,3,0),
  (1885,0,0,NULL,1000.000,24,'','2012-03-17 12:00:00','N 20120317093400621. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 17.03.2012, 09-33-59.',2,1,0,1,'Текущий счет40817810104610017169RUR17.03.2012YMO005I4222I7UI5N 20120317093400621. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 17.03.2012, 09-33-59.0,001000,00',0,0,3,0),
  (1886,0,0,NULL,200.000,24,'','2012-03-16 12:00:00','Платеж 94144899.1 в пользу Beeline,903+++3554,16.03.12,16-05-24,Номер ответа 1003345955259',2,1,0,1,'Текущий счет40817810104610017169RUR16.03.201294144899.1Платеж 94144899.1 в пользу Beeline,903+++3554,16.03.12,16-05-24,Номер ответа 10033459552590,00200,00',0,0,3,0),
  (1887,0,0,NULL,500.000,24,'','2012-03-16 12:00:00','Платеж 94144198.1 в пользу Beeline,903+++3554,16.03.12,15-57-09,Номер ответа 1003345940771',2,1,0,1,'Текущий счет40817810104610017169RUR16.03.201294144198.1Платеж 94144198.1 в пользу Beeline,903+++3554,16.03.12,15-57-09,Номер ответа 10033459407710,00500,00',0,0,3,0),
  (1888,0,0,NULL,194.270,24,'','2012-03-14 12:00:00','548673++++++1500    \\GBR\\44870835190\\2\\SKYPE                          13.03.12 07.03.12         5.00  EUR',2,1,0,1,'Текущий счет40817810104610017169RUR14.03.2012CRD_2KU18Y548673++++++1500    \\GBR\\44870835190\\2\\SKYPE                          13.03.12 07.03.12         5.00  EUR0,00194,27',0,0,3,0),
  (1889,0,0,NULL,59.000,24,'','2012-03-10 12:00:00','Комиссия за услугу Альфа-Мобайл за период с 10.03.2012 по 09.04.2012 Согл.тариф.банка',2,1,0,1,'Текущий счет40817810104610017169RUR10.03.2012MORE 10203000009Комиссия за услугу Альфа-Мобайл за период с 10.03.2012 по 09.04.2012 Согл.тариф.банка0,0059,00',0,0,3,0),
  (1890,0,0,NULL,129.000,24,'','2012-03-10 12:00:00','Комиссия за пакет услуг            за март 2012 г.                    Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR10.03.2012Комиссия за пакет услуг            за март 2012 г.                    Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,3,0),
  (1891,0,0,NULL,5000.000,24,'','2012-03-06 12:00:00','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               04.03.12 03.03.12      5000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR06.03.2012CRD_6738FV548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               04.03.12 03.03.12      5000.00  RUR0,005000,00',0,0,3,0),
  (1892,0,0,NULL,10000.000,24,'','2012-03-05 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               03.03.12 02.03.12     10000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR05.03.2012CRD_4ZH2TU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               03.03.12 02.03.12     10000.00  RUR0,0010000,00',0,0,3,0),
  (1893,0,0,NULL,500.000,24,'','2012-03-04 12:00:00','Платеж 92710631.1 в пользу Beeline,903+++3554,04.03.12,14-17-58,Номер ответа 1003310833202',2,1,0,1,'Текущий счет40817810104610017169RUR04.03.201292710631.1Платеж 92710631.1 в пользу Beeline,903+++3554,04.03.12,14-17-58,Номер ответа 10033108332020,00500,00',0,0,3,0),
  (1894,0,0,NULL,6000.000,24,'','2012-03-02 12:00:00','Внесение средств через устройство Cash-in 155087 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR02.03.2012CASHIN155087Внесение средств через устройство Cash-in 155087 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА6000,000,00',0,0,3,0),
  (1895,0,0,NULL,30000.000,24,'','2012-03-02 12:00:00','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,1,0,1,'Текущий счет40817810104610017169RUR02.03.201292464822.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0030000,00',0,0,3,0),
  (1896,0,0,NULL,99.000,24,'','2012-03-01 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 26.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000090Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 26.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0099,00',0,0,3,0),
  (1897,0,0,NULL,59.000,24,'','2012-03-01 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с28.02.12 до28.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000089Комиссия за услугу \"Альфа-Чек\"за период с28.02.12 до28.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (1898,0,0,NULL,11.880,24,'','2012-03-01 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000088Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0011,88',0,0,3,0),
  (1899,0,0,NULL,21000.000,24,'','2012-03-01 12:00:00','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА21000,000,00',0,0,3,0),
  (1900,0,0,NULL,22000.000,24,'','2012-03-01 12:00:00','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА22000,000,00',0,0,3,0),
  (1901,0,0,NULL,87.120,24,'','2012-02-29 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR29.02.2012MORE 29202000168Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0087,12',0,0,3,0),
  (1902,0,0,NULL,15.050,24,'','2012-02-29 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR29.02.2012MORE 29202000167Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0015,05',0,0,3,0),
  (1903,0,0,NULL,1602.090,24,'','2012-02-29 12:00:00','548673++++++1500     S1B7112\\THA\\PHUKET\\JUNGSE\\BAY                    28.02.12 26.02.12      1650.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR29.02.2012CRD_1860WR548673++++++1500     S1B7112\\THA\\PHUKET\\JUNGSE\\BAY                    28.02.12 26.02.12      1650.00  THB0,001602,09',0,0,3,0),
  (1904,0,0,NULL,181.490,24,'','2012-02-27 12:00:00','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012MORE 27202000181Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00181,49',0,0,3,0),
  (1905,0,0,NULL,19653.910,24,'','2012-02-27 12:00:00','548673++++++1500     S1B2837\\THA\\PHUKET\\HAT PA\\KASIKORNBANK           25.02.12 23.02.12     20150.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_13C90N548673++++++1500     S1B2837\\THA\\PHUKET\\HAT PA\\KASIKORNBANK           25.02.12 23.02.12     20150.00  THB0,0019653,91',0,0,3,0),
  (1906,0,0,NULL,9023.240,24,'','2012-02-27 12:00:00','548673++++++1500    \\THA\\PHUKET\\4116 J\\KRUNGTHAI OPT                  24.02.12 22.02.12      9200.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_97U1SM548673++++++1500    \\THA\\PHUKET\\4116 J\\KRUNGTHAI OPT                  24.02.12 22.02.12      9200.00  THB0,009023,24',0,0,3,0),
  (1907,0,0,NULL,3079.210,24,'','2012-02-27 12:00:00','548673++++++1500     S1B5292\\THA\\PHUKET\\JUNGCE\\KASIKORNBANK           24.02.12 22.02.12      3150.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_5AV3NM548673++++++1500     S1B5292\\THA\\PHUKET\\JUNGCE\\KASIKORNBANK           24.02.12 22.02.12      3150.00  THB0,003079,21',0,0,3,0),
  (1908,0,0,NULL,1000.000,24,'','2012-02-25 12:00:00','Платеж 91611317.1 в пользу Beeline,903+++3554,25.02.12,05-03-56,Номер ответа 1003287066805',2,1,0,1,'Текущий счет40817810104610017169RUR25.02.201291611317.1Платеж 91611317.1 в пользу Beeline,903+++3554,25.02.12,05-03-56,Номер ответа 10032870668050,001000,00',0,0,3,0),
  (1909,0,0,NULL,299.000,24,'','2012-02-22 12:00:00','Комиссия за обслуживание карты за период с19.02.12 по19.02.13 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR22.02.2012MORE 22202000150Комиссия за обслуживание карты за период с19.02.12 по19.02.13 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00299,00',0,0,3,0),
  (1910,0,0,NULL,15000.000,24,'','2012-02-22 12:00:00','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,1,0,1,'Текущий счет40817810104610017169RUR22.02.201291308200.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0015000,00',0,0,3,0),
  (1911,0,0,NULL,58.890,24,'','2012-02-21 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR21.02.2012MORE 21202000140Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0058,89',0,0,3,0),
  (1912,0,0,NULL,50000.000,24,'','2012-02-21 12:00:00','Внесение средств через устройство Cash-in 155123 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR21.02.2012CASHIN155123Внесение средств через устройство Cash-in 155123 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА50000,000,00',0,0,3,0),
  (1913,0,0,NULL,0.110,24,'','2012-02-17 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR17.02.2012MORE 17202000208Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,000,11',0,0,3,0),
  (1914,0,0,NULL,59.000,24,'','2012-02-10 12:00:00','Комиссия за услугу Альфа-Мобайл за период с 10.02.2012 по 09.03.2012 Согл.тариф.банка',2,1,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 10202000010Комиссия за услугу Альфа-Мобайл за период с 10.02.2012 по 09.03.2012 Согл.тариф.банка0,0059,00',0,0,3,0),
  (1915,0,0,NULL,129.000,24,'','2012-02-10 12:00:00','Комиссия за пакет услуг            за февраль 2012 г.                 Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 10202000009Комиссия за пакет услуг            за февраль 2012 г.                 Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,3,0),
  (1916,0,0,NULL,183.120,24,'','2012-02-10 12:00:00','Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 21002000006Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА183,120,00',0,0,3,0),
  (1917,0,0,NULL,59.000,24,'','2012-01-30 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с28.01.12 до28.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR30.01.2012MORE 30201000086Комиссия за услугу \"Альфа-Чек\"за период с28.01.12 до28.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (1918,0,0,NULL,355.000,24,'','2012-01-23 12:00:00','548673++++++1500      899026\\RUS\\MOSCOW\\82-4 V\\IP AKAD NAROD          21.01.12 18.01.12       355.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR23.01.2012CRD_67C7EX548673++++++1500      899026\\RUS\\MOSCOW\\82-4 V\\IP AKAD NAROD          21.01.12 18.01.12       355.00  RUR0,00355,00',0,0,3,0),
  (1919,0,0,NULL,16000.000,24,'','2012-01-23 12:00:00','548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 20.01.12 19.01.12     16000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR23.01.2012CRD_4X85BY548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 20.01.12 19.01.12     16000.00  RUR0,0016000,00',0,0,3,0),
  (1920,0,0,NULL,416.000,24,'','2012-01-19 12:00:00','548673++++++1500    26001256\\RUS\\ORENBURG\\MCDONALDS 271               18.01.12 15.01.12       416.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR19.01.2012CRD_1118TV548673++++++1500    26001256\\RUS\\ORENBURG\\MCDONALDS 271               18.01.12 15.01.12       416.00  RUR0,00416,00',0,0,3,0),
  (1921,0,0,NULL,7060.000,24,'','2012-01-18 12:00:00','548673++++++1500    15516001\\RUS\\ORENBURGSKY \\\\ORENBURG AIRL          17.01.12 14.01.12      7060.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_9NR85V548673++++++1500    15516001\\RUS\\ORENBURGSKY \\\\ORENBURG AIRL          17.01.12 14.01.12      7060.00  RUR0,007060,00',0,0,3,0),
  (1922,0,0,NULL,8722.000,24,'','2012-01-18 12:00:00','548673++++++1500    20508433\\RUS\\ORENBURG\\1-2,\\\"SAMSONITE\"            17.01.12 15.01.12      8722.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_8S18VV548673++++++1500    20508433\\RUS\\ORENBURG\\1-2,\\\"SAMSONITE\"            17.01.12 15.01.12      8722.00  RUR0,008722,00',0,0,3,0),
  (1923,0,0,NULL,3000.000,24,'','2012-01-18 12:00:00','548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 17.01.12 16.01.12      3000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5E31NW548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 17.01.12 16.01.12      3000.00  RUR0,003000,00',0,0,3,0),
  (1924,0,0,NULL,201.920,24,'','2012-01-18 12:00:00','548673++++++1500    00003297\\LUX\\LUXEMBOURG\\23\\SKYPE COMMUNI          17.01.12 11.01.12         5.00  EUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_3KR8RT548673++++++1500    00003297\\LUX\\LUXEMBOURG\\23\\SKYPE COMMUNI          17.01.12 11.01.12         5.00  EUR0,00201,92',0,0,3,0),
  (1925,0,0,NULL,6900.000,24,'','2012-01-18 12:00:00','548673++++++1500    80002001\\RUS\\MOSKVA\\13 STR\\1GB.RU                 15.01.12 13.01.12      6900.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_7646ZT548673++++++1500    80002001\\RUS\\MOSKVA\\13 STR\\1GB.RU                 15.01.12 13.01.12      6900.00  RUR0,006900,00',0,0,3,0),
  (1926,0,0,NULL,40000.000,24,'','2012-01-18 12:00:00','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5V345V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (1927,0,0,NULL,40000.000,24,'','2012-01-18 12:00:00','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5U545V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (1928,0,0,NULL,40000.000,24,'','2012-01-18 12:00:00','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_1W445V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (1929,0,0,NULL,500.000,24,'','2012-01-17 12:00:00','Платеж 86010703.1 в пользу Beeline,903+++3554,17.01.12,20-07-52,Номер ответа 1003182924042',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.201286010703.1Платеж 86010703.1 в пользу Beeline,903+++3554,17.01.12,20-07-52,Номер ответа 10031829240420,00500,00',0,0,3,0),
  (1930,0,0,NULL,40000.000,24,'','2012-01-17 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_8TS7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (1931,0,0,NULL,30000.000,24,'','2012-01-17 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     30000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_4418YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     30000.00  RUR0,0030000,00',0,0,3,0),
  (1932,0,0,NULL,40000.000,24,'','2012-01-17 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_4WF7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (1933,0,0,NULL,40000.000,24,'','2012-01-17 12:00:00','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_22A7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (1934,0,0,NULL,59.000,24,'','2012-01-16 12:00:00','Комиссия за услугу \"Альфа-Чек\"за период с16.01.12 до16.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,3,'Текущий счет40817810104610017169USD16.01.2012MORE 16201000205Комиссия за услугу \"Альфа-Чек\"за период с16.01.12 до16.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (1935,0,0,NULL,548.000,24,'','2012-11-06 12:00:00','''5203XXXXXXXX4003''',2,1,0,0,'11/06/2012PRODUKTY 24              MOSCOW       RU-548.00''5203XXXXXXXX4003''',0,0,3,0),
  (1936,0,0,NULL,2341.550,24,'','2012-11-06 12:00:00','''5203XXXXXXXX4003''',2,1,0,0,'11/06/2012BP TREKHGORKA RC302      ODINTSOVSKIY RU-2341.55''5203XXXXXXXX4003''',0,0,3,0),
  (1937,0,0,NULL,610.200,24,'','2012-10-06 12:00:00','''5203XXXXXXXX4003''',2,1,0,0,'10/06/2012KOFEYINYA KOFE HAUZ DO   MOSCOW       RU-610.20''5203XXXXXXXX4003''',0,0,3,0),
  (1938,0,0,NULL,1152.000,24,'','2012-10-06 12:00:00','''5203XXXXXXXX4003''',2,1,0,0,'10/06/2012MAGAZIN SUPERMARKET V-   MOSCOW       RU-1152.00''5203XXXXXXXX4003''',0,0,3,0),
  (1939,0,0,NULL,10400.000,24,'','2012-08-06 12:00:00','''5203XXXXXXXX4003''',2,1,0,0,'08/06/2012Jel Gaucho  Restoran     MOSCOW       RU-10400.00''5203XXXXXXXX4003''',0,0,3,0),
  (1940,0,0,NULL,6831.000,24,'','2012-07-06 12:00:00','''5203XXXXXXXX4003''',2,1,0,0,'07/06/2012PET RETAIL 55            MOSCOW       RU-6831.00''5203XXXXXXXX4003''',0,0,3,0),
  (1941,0,0,NULL,678.000,24,'','2012-07-06 12:00:00','''5203XXXXXXXX4003''',2,1,0,0,'07/06/2012PRODUKTY 24              MOSCOW       RU-678.00''5203XXXXXXXX4003''',0,0,3,0),
  (1942,0,0,NULL,1038.500,24,'','2012-07-06 12:00:00','''5203XXXXXXXX4003''',2,1,0,0,'07/06/2012AZBUKA VKUSA DOROG       MOSCOW       RU-1038.50''5203XXXXXXXX4003''',0,0,3,0),
  (1943,0,0,NULL,10000.000,24,'','2012-06-06 12:00:00','''5203XXXXXXXX4003''',1,1,0,0,'06/06/2012ПЛАТЕЖ ЧЕРЕЗ CITIBANK ONLINE10000.00''5203XXXXXXXX4003''',0,0,3,0),
  (1944,0,0,NULL,940.000,24,'','2012-06-06 12:00:00','''5203XXXXXXXX4003''',2,1,0,0,'06/06/2012CHENTRALE - RESTORAN (   MOSCOW       RU-940.00''5203XXXXXXXX4003''',0,0,3,0),
  (1945,0,0,NULL,1850.220,24,'','2012-05-06 12:00:00','''5203XXXXXXXX4003''',2,1,0,0,'05/06/2012BP DONSKAYA RC091        MOSCOW       RU-1850.22''5203XXXXXXXX4003''',0,0,3,0),
  (1946,0,0,NULL,421.500,24,'','2012-03-06 12:00:00','''5203XXXXXXXX4003''',2,1,0,0,'03/06/2012PRODUKTY 24              MOSCOW       RU-421.50''5203XXXXXXXX4003''',0,0,3,0),
  (1947,0,0,NULL,876.320,24,'','2012-03-06 12:00:00','''5203XXXXXXXX4003''',2,1,0,0,'03/06/2012MOROZKO                  MOSCOW       RU-876.32''5203XXXXXXXX4003''',0,0,3,0),
  (1948,0,0,NULL,548.000,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'11/06/2012PRODUKTY 24              MOSCOW       RU-548.00''5203XXXXXXXX4003''',0,0,3,0),
  (1949,0,0,NULL,2341.550,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'11/06/2012BP TREKHGORKA RC302      ODINTSOVSKIY RU-2341.55''5203XXXXXXXX4003''',0,0,3,0),
  (1950,0,0,NULL,610.200,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'10/06/2012KOFEYINYA KOFE HAUZ DO   MOSCOW       RU-610.20''5203XXXXXXXX4003''',0,0,3,0),
  (1951,0,0,NULL,1152.000,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'10/06/2012MAGAZIN SUPERMARKET V-   MOSCOW       RU-1152.00''5203XXXXXXXX4003''',0,0,3,0),
  (1952,0,0,NULL,10400.000,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'08/06/2012Jel Gaucho  Restoran     MOSCOW       RU-10400.00''5203XXXXXXXX4003''',0,0,3,0),
  (1953,0,0,NULL,6831.000,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'07/06/2012PET RETAIL 55            MOSCOW       RU-6831.00''5203XXXXXXXX4003''',0,0,3,0),
  (1954,0,0,NULL,678.000,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'07/06/2012PRODUKTY 24              MOSCOW       RU-678.00''5203XXXXXXXX4003''',0,0,3,0),
  (1955,0,0,NULL,1038.500,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'07/06/2012AZBUKA VKUSA DOROG       MOSCOW       RU-1038.50''5203XXXXXXXX4003''',0,0,3,0),
  (1956,0,0,NULL,10000.000,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',1,1,0,0,'06/06/2012ПЛАТЕЖ ЧЕРЕЗ CITIBANK ONLINE10000.00''5203XXXXXXXX4003''',0,0,3,0),
  (1957,0,0,NULL,940.000,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'06/06/2012CHENTRALE - RESTORAN (   MOSCOW       RU-940.00''5203XXXXXXXX4003''',0,0,3,0),
  (1958,0,0,NULL,1850.220,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'05/06/2012BP DONSKAYA RC091        MOSCOW       RU-1850.22''5203XXXXXXXX4003''',0,0,3,0),
  (1959,0,0,NULL,421.500,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'03/06/2012PRODUKTY 24              MOSCOW       RU-421.50''5203XXXXXXXX4003''',0,0,3,0),
  (1960,0,0,NULL,876.320,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'03/06/2012MOROZKO                  MOSCOW       RU-876.32''5203XXXXXXXX4003''',0,0,3,0),
  (1961,0,0,NULL,791.580,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'02/06/2012SCOTTISH BOOK SOURCE L   GLASGOW      GB 14.95 UK? 14.95 UK?-791.58''5203XXXXXXXX4003''',0,0,3,0),
  (1962,0,0,NULL,535.500,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'02/06/2012MAGNOLIYA-REMIZOVA STR   MOSCOW       RU-535.50''5203XXXXXXXX4003''',0,0,3,0),
  (1963,0,0,NULL,4930.000,23,'','2012-06-29 02:10:50','''5203XXXXXXXX4003''',2,1,0,0,'01/06/2012CHENTRALE - RESTORAN (   MOSCOW       RU-4930.00''5203XXXXXXXX4003''',0,0,3,0),
  (1964,0,0,NULL,791.580,24,'','2012-06-02 11:26:00','''5203XXXXXXXX4003''',2,1,0,0,'02/06/2012SCOTTISH BOOK SOURCE L   GLASGOW      GB 14.95 UK? 14.95 UK?-791.58''5203XXXXXXXX4003''',0,0,3,0),
  (1965,0,0,NULL,535.500,24,'','2012-06-02 11:26:00','''5203XXXXXXXX4003''',2,1,0,0,'02/06/2012MAGNOLIYA-REMIZOVA STR   MOSCOW       RU-535.50''5203XXXXXXXX4003''',0,0,3,0),
  (1966,0,0,NULL,4930.000,24,'','2012-06-01 11:26:00','''5203XXXXXXXX4003''',2,1,0,0,'01/06/2012CHENTRALE - RESTORAN (   MOSCOW       RU-4930.00''5203XXXXXXXX4003''',0,0,3,0),
  (1967,0,0,NULL,45000.000,16,'','2012-04-16 11:28:07','Внесение средств через устройство Cash-in 400777 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR16.04.2012CASHIN400777Внесение средств через устройство Cash-in 400777 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА45000,000,00',0,0,3,0),
  (1968,0,0,NULL,59.000,16,'','2012-04-10 11:28:07','Комиссия за услугу Альфа-Мобайл за период с 10.04.2012 по 09.05.2012 Согл.тариф.банка',2,1,0,1,'Текущий счет40817810104610017169RUR10.04.2012MORE 10204000017Комиссия за услугу Альфа-Мобайл за период с 10.04.2012 по 09.05.2012 Согл.тариф.банка0,0059,00',0,0,3,0),
  (1969,0,0,NULL,58.380,16,'','2012-04-10 11:28:07','Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR10.04.2012MORE 21004000009Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА58,380,00',0,0,3,0),
  (1970,0,0,NULL,129.000,16,'','2012-04-10 11:28:07','Комиссия за пакет услуг            за апрель 2012 г. Согласно тарифам Банка  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR10.04.2012Комиссия за пакет услуг            за апрель 2012 г. Согласно тарифам Банка  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,3,0),
  (1971,0,0,NULL,26000.000,16,'','2012-04-05 11:28:07','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,1,0,1,'Текущий счет40817810104610017169RUR05.04.201296449683.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0026000,00',0,0,3,0),
  (1972,0,0,NULL,1000.000,16,'','2012-04-04 11:28:07','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR04.04.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА1000,000,00',0,0,3,0),
  (1973,0,0,NULL,25000.000,16,'','2012-04-04 11:28:07','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR04.04.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА25000,000,00',0,0,3,0),
  (1974,0,0,NULL,59.000,16,'','2012-04-02 11:28:07','Комиссия за услугу \"Альфа-Чек\"за период с28.03.12 до28.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR02.04.2012MORE 02204000294Комиссия за услугу \"Альфа-Чек\"за период с28.03.12 до28.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (1975,0,0,NULL,59.000,16,'','2012-03-19 11:28:07','Комиссия за услугу \"Альфа-Чек\"за период с16.03.12 до16.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR19.03.2012MORE 19203000736Комиссия за услугу \"Альфа-Чек\"за период с16.03.12 до16.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (1976,0,0,NULL,1000.000,16,'','2012-03-19 11:28:08','N 20120319211059912. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 19.03.2012, 21-10-55.',2,1,0,1,'Текущий счет40817810104610017169RUR19.03.2012YMO005I4231J0MVCN 20120319211059912. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 19.03.2012, 21-10-55.0,001000,00',0,0,3,0),
  (1977,0,0,NULL,1000.000,16,'','2012-03-17 11:28:08','N 20120317093400621. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 17.03.2012, 09-33-59.',2,1,0,1,'Текущий счет40817810104610017169RUR17.03.2012YMO005I4222I7UI5N 20120317093400621. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 17.03.2012, 09-33-59.0,001000,00',0,0,3,0),
  (1978,0,0,NULL,200.000,16,'','2012-03-16 11:28:08','Платеж 94144899.1 в пользу Beeline,903+++3554,16.03.12,16-05-24,Номер ответа 1003345955259',2,1,0,1,'Текущий счет40817810104610017169RUR16.03.201294144899.1Платеж 94144899.1 в пользу Beeline,903+++3554,16.03.12,16-05-24,Номер ответа 10033459552590,00200,00',0,0,3,0),
  (1979,0,0,NULL,500.000,16,'','2012-03-16 11:28:08','Платеж 94144198.1 в пользу Beeline,903+++3554,16.03.12,15-57-09,Номер ответа 1003345940771',2,1,0,1,'Текущий счет40817810104610017169RUR16.03.201294144198.1Платеж 94144198.1 в пользу Beeline,903+++3554,16.03.12,15-57-09,Номер ответа 10033459407710,00500,00',0,0,3,0),
  (1980,0,0,NULL,194.270,16,'','2012-03-14 11:28:08','548673++++++1500    \\GBR\\44870835190\\2\\SKYPE                          13.03.12 07.03.12         5.00  EUR',2,1,0,1,'Текущий счет40817810104610017169RUR14.03.2012CRD_2KU18Y548673++++++1500    \\GBR\\44870835190\\2\\SKYPE                          13.03.12 07.03.12         5.00  EUR0,00194,27',0,0,3,0),
  (1981,0,0,NULL,59.000,16,'','2012-03-10 11:28:08','Комиссия за услугу Альфа-Мобайл за период с 10.03.2012 по 09.04.2012 Согл.тариф.банка',2,1,0,1,'Текущий счет40817810104610017169RUR10.03.2012MORE 10203000009Комиссия за услугу Альфа-Мобайл за период с 10.03.2012 по 09.04.2012 Согл.тариф.банка0,0059,00',0,0,3,0),
  (1982,0,0,NULL,129.000,16,'','2012-03-10 11:28:08','Комиссия за пакет услуг            за март 2012 г.                    Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR10.03.2012Комиссия за пакет услуг            за март 2012 г.                    Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,3,0),
  (1983,0,0,NULL,5000.000,16,'','2012-03-06 11:28:08','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               04.03.12 03.03.12      5000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR06.03.2012CRD_6738FV548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               04.03.12 03.03.12      5000.00  RUR0,005000,00',0,0,3,0),
  (1984,0,0,NULL,10000.000,16,'','2012-03-05 11:28:08','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               03.03.12 02.03.12     10000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR05.03.2012CRD_4ZH2TU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               03.03.12 02.03.12     10000.00  RUR0,0010000,00',0,0,3,0),
  (1985,0,0,NULL,500.000,16,'','2012-03-04 11:28:08','Платеж 92710631.1 в пользу Beeline,903+++3554,04.03.12,14-17-58,Номер ответа 1003310833202',2,1,0,1,'Текущий счет40817810104610017169RUR04.03.201292710631.1Платеж 92710631.1 в пользу Beeline,903+++3554,04.03.12,14-17-58,Номер ответа 10033108332020,00500,00',0,0,3,0),
  (1986,0,0,NULL,6000.000,16,'','2012-03-02 11:28:08','Внесение средств через устройство Cash-in 155087 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR02.03.2012CASHIN155087Внесение средств через устройство Cash-in 155087 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА6000,000,00',0,0,3,0),
  (1987,0,0,NULL,30000.000,16,'','2012-03-02 11:28:08','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,1,0,1,'Текущий счет40817810104610017169RUR02.03.201292464822.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0030000,00',0,0,3,0),
  (1988,0,0,NULL,99.000,16,'','2012-03-01 11:28:08','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 26.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000090Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 26.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0099,00',0,0,3,0),
  (1989,0,0,NULL,59.000,16,'','2012-03-01 11:28:08','Комиссия за услугу \"Альфа-Чек\"за период с28.02.12 до28.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000089Комиссия за услугу \"Альфа-Чек\"за период с28.02.12 до28.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (1990,0,0,NULL,11.880,16,'','2012-03-01 11:28:08','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000088Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0011,88',0,0,3,0),
  (1991,0,0,NULL,21000.000,16,'','2012-03-01 11:28:08','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА21000,000,00',0,0,3,0),
  (1992,0,0,NULL,22000.000,16,'','2012-03-01 11:28:08','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR01.03.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА22000,000,00',0,0,3,0),
  (1993,0,0,NULL,87.120,16,'','2012-02-29 11:28:08','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR29.02.2012MORE 29202000168Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0087,12',0,0,3,0),
  (1994,0,0,NULL,15.050,16,'','2012-02-29 11:28:08','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR29.02.2012MORE 29202000167Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0015,05',0,0,3,0),
  (1995,0,0,NULL,1602.090,16,'','2012-02-29 11:28:08','548673++++++1500     S1B7112\\THA\\PHUKET\\JUNGSE\\BAY                    28.02.12 26.02.12      1650.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR29.02.2012CRD_1860WR548673++++++1500     S1B7112\\THA\\PHUKET\\JUNGSE\\BAY                    28.02.12 26.02.12      1650.00  THB0,001602,09',0,0,3,0),
  (1996,0,0,NULL,181.490,16,'','2012-02-27 11:28:08','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012MORE 27202000181Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00181,49',0,0,3,0),
  (1997,0,0,NULL,19653.910,16,'','2012-02-27 11:28:08','548673++++++1500     S1B2837\\THA\\PHUKET\\HAT PA\\KASIKORNBANK           25.02.12 23.02.12     20150.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_13C90N548673++++++1500     S1B2837\\THA\\PHUKET\\HAT PA\\KASIKORNBANK           25.02.12 23.02.12     20150.00  THB0,0019653,91',0,0,3,0),
  (1998,0,0,NULL,9023.240,16,'','2012-02-27 11:28:08','548673++++++1500    \\THA\\PHUKET\\4116 J\\KRUNGTHAI OPT                  24.02.12 22.02.12      9200.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_97U1SM548673++++++1500    \\THA\\PHUKET\\4116 J\\KRUNGTHAI OPT                  24.02.12 22.02.12      9200.00  THB0,009023,24',0,0,3,0),
  (1999,0,0,NULL,3079.210,16,'','2012-02-27 11:28:08','548673++++++1500     S1B5292\\THA\\PHUKET\\JUNGCE\\KASIKORNBANK           24.02.12 22.02.12      3150.00  THB',2,1,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_5AV3NM548673++++++1500     S1B5292\\THA\\PHUKET\\JUNGCE\\KASIKORNBANK           24.02.12 22.02.12      3150.00  THB0,003079,21',0,0,3,0),
  (2000,0,0,NULL,1000.000,16,'','2012-02-25 11:28:08','Платеж 91611317.1 в пользу Beeline,903+++3554,25.02.12,05-03-56,Номер ответа 1003287066805',2,1,0,1,'Текущий счет40817810104610017169RUR25.02.201291611317.1Платеж 91611317.1 в пользу Beeline,903+++3554,25.02.12,05-03-56,Номер ответа 10032870668050,001000,00',0,0,3,0),
  (2001,0,0,NULL,299.000,16,'','2012-02-22 11:28:08','Комиссия за обслуживание карты за период с19.02.12 по19.02.13 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR22.02.2012MORE 22202000150Комиссия за обслуживание карты за период с19.02.12 по19.02.13 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00299,00',0,0,3,0),
  (2002,0,0,NULL,15000.000,16,'','2012-02-22 11:28:08','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,1,0,1,'Текущий счет40817810104610017169RUR22.02.201291308200.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0015000,00',0,0,3,0),
  (2003,0,0,NULL,58.890,16,'','2012-02-21 11:28:08','Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR21.02.2012MORE 21202000140Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0058,89',0,0,3,0),
  (2004,0,0,NULL,50000.000,16,'','2012-02-21 11:28:08','Внесение средств через устройство Cash-in 155123 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR21.02.2012CASHIN155123Внесение средств через устройство Cash-in 155123 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА50000,000,00',0,0,3,0),
  (2005,0,0,NULL,0.110,16,'','2012-02-17 11:28:08','Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR17.02.2012MORE 17202000208Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,000,11',0,0,3,0),
  (2006,0,0,NULL,59.000,16,'','2012-02-10 11:28:08','Комиссия за услугу Альфа-Мобайл за период с 10.02.2012 по 09.03.2012 Согл.тариф.банка',2,1,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 10202000010Комиссия за услугу Альфа-Мобайл за период с 10.02.2012 по 09.03.2012 Согл.тариф.банка0,0059,00',0,0,3,0),
  (2007,0,0,NULL,129.000,16,'','2012-02-10 11:28:09','Комиссия за пакет услуг            за февраль 2012 г.                 Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 10202000009Комиссия за пакет услуг            за февраль 2012 г.                 Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,3,0),
  (2008,0,0,NULL,183.120,16,'','2012-02-10 11:28:09','Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,1,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 21002000006Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА183,120,00',0,0,3,0),
  (2009,0,0,NULL,59.000,16,'','2012-01-30 11:28:09','Комиссия за услугу \"Альфа-Чек\"за период с28.01.12 до28.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,1,'Текущий счет40817810104610017169RUR30.01.2012MORE 30201000086Комиссия за услугу \"Альфа-Чек\"за период с28.01.12 до28.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (2010,0,0,NULL,355.000,16,'','2012-01-23 11:28:09','548673++++++1500      899026\\RUS\\MOSCOW\\82-4 V\\IP AKAD NAROD          21.01.12 18.01.12       355.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR23.01.2012CRD_67C7EX548673++++++1500      899026\\RUS\\MOSCOW\\82-4 V\\IP AKAD NAROD          21.01.12 18.01.12       355.00  RUR0,00355,00',0,0,3,0),
  (2011,0,0,NULL,16000.000,16,'','2012-01-23 11:28:09','548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 20.01.12 19.01.12     16000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR23.01.2012CRD_4X85BY548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 20.01.12 19.01.12     16000.00  RUR0,0016000,00',0,0,3,0),
  (2012,0,0,NULL,416.000,16,'','2012-01-19 11:28:09','548673++++++1500    26001256\\RUS\\ORENBURG\\MCDONALDS 271               18.01.12 15.01.12       416.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR19.01.2012CRD_1118TV548673++++++1500    26001256\\RUS\\ORENBURG\\MCDONALDS 271               18.01.12 15.01.12       416.00  RUR0,00416,00',0,0,3,0),
  (2013,0,0,NULL,7060.000,16,'','2012-01-18 11:28:09','548673++++++1500    15516001\\RUS\\ORENBURGSKY \\\\ORENBURG AIRL          17.01.12 14.01.12      7060.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_9NR85V548673++++++1500    15516001\\RUS\\ORENBURGSKY \\\\ORENBURG AIRL          17.01.12 14.01.12      7060.00  RUR0,007060,00',0,0,3,0),
  (2014,0,0,NULL,8722.000,16,'','2012-01-18 11:28:09','548673++++++1500    20508433\\RUS\\ORENBURG\\1-2,\\\"SAMSONITE\"            17.01.12 15.01.12      8722.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_8S18VV548673++++++1500    20508433\\RUS\\ORENBURG\\1-2,\\\"SAMSONITE\"            17.01.12 15.01.12      8722.00  RUR0,008722,00',0,0,3,0),
  (2015,0,0,NULL,3000.000,16,'','2012-01-18 11:28:09','548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 17.01.12 16.01.12      3000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5E31NW548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 17.01.12 16.01.12      3000.00  RUR0,003000,00',0,0,3,0),
  (2016,0,0,NULL,201.920,16,'','2012-01-18 11:28:09','548673++++++1500    00003297\\LUX\\LUXEMBOURG\\23\\SKYPE COMMUNI          17.01.12 11.01.12         5.00  EUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_3KR8RT548673++++++1500    00003297\\LUX\\LUXEMBOURG\\23\\SKYPE COMMUNI          17.01.12 11.01.12         5.00  EUR0,00201,92',0,0,3,0),
  (2017,0,0,NULL,6900.000,16,'','2012-01-18 11:28:09','548673++++++1500    80002001\\RUS\\MOSKVA\\13 STR\\1GB.RU                 15.01.12 13.01.12      6900.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_7646ZT548673++++++1500    80002001\\RUS\\MOSKVA\\13 STR\\1GB.RU                 15.01.12 13.01.12      6900.00  RUR0,006900,00',0,0,3,0),
  (2018,0,0,NULL,40000.000,16,'','2012-01-18 11:28:09','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5V345V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (2019,0,0,NULL,40000.000,16,'','2012-01-18 11:28:09','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5U545V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (2020,0,0,NULL,40000.000,16,'','2012-01-18 11:28:09','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_1W445V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (2021,0,0,NULL,500.000,16,'','2012-01-17 11:28:09','Платеж 86010703.1 в пользу Beeline,903+++3554,17.01.12,20-07-52,Номер ответа 1003182924042',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.201286010703.1Платеж 86010703.1 в пользу Beeline,903+++3554,17.01.12,20-07-52,Номер ответа 10031829240420,00500,00',0,0,3,0),
  (2022,0,0,NULL,40000.000,16,'','2012-01-17 11:28:09','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_8TS7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (2023,0,0,NULL,30000.000,16,'','2012-01-17 11:28:09','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     30000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_4418YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     30000.00  RUR0,0030000,00',0,0,3,0),
  (2024,0,0,NULL,40000.000,16,'','2012-01-17 11:28:09','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_4WF7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (2025,0,0,NULL,40000.000,16,'','2012-01-17 11:28:09','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,1,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_22A7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (2026,0,0,NULL,59.000,16,'','2012-01-16 11:28:09','Комиссия за услугу \"Альфа-Чек\"за период с16.01.12 до16.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,1,0,3,'Текущий счет40817810104610017169USD16.01.2012MORE 16201000205Комиссия за услугу \"Альфа-Чек\"за период с16.01.12 до16.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (2027,0,0,NULL,548.000,5,'','2012-06-11 11:35:41',NULL,2,1,0,0,'11/06/2012PRODUKTY 24              MOSCOW       RU-548.00''5203XXXXXXXX4003''',0,0,3,0),
  (2028,0,0,NULL,2341.550,5,'','2012-06-11 11:35:41',NULL,2,1,0,0,'11/06/2012BP TREKHGORKA RC302      ODINTSOVSKIY RU-2341.55''5203XXXXXXXX4003''',0,0,3,0),
  (2029,0,0,NULL,610.200,5,'','2012-06-10 11:35:41',NULL,2,1,0,0,'10/06/2012KOFEYINYA KOFE HAUZ DO   MOSCOW       RU-610.20''5203XXXXXXXX4003''',0,0,3,0),
  (2030,0,0,NULL,1152.000,5,'','2012-06-10 11:35:41',NULL,2,1,0,0,'10/06/2012MAGAZIN SUPERMARKET V-   MOSCOW       RU-1152.00''5203XXXXXXXX4003''',0,0,3,0),
  (2031,0,0,NULL,10400.000,5,'','2012-06-08 11:35:41',NULL,2,1,0,0,'08/06/2012Jel Gaucho  Restoran     MOSCOW       RU-10400.00''5203XXXXXXXX4003''',0,0,3,0),
  (2032,0,0,NULL,6831.000,5,'','2012-06-07 11:35:41',NULL,2,1,0,0,'07/06/2012PET RETAIL 55            MOSCOW       RU-6831.00''5203XXXXXXXX4003''',0,0,3,0),
  (2033,0,0,NULL,678.000,5,'','2012-06-07 11:35:41',NULL,2,1,0,0,'07/06/2012PRODUKTY 24              MOSCOW       RU-678.00''5203XXXXXXXX4003''',0,0,3,0),
  (2034,0,0,NULL,1038.500,5,'','2012-06-07 11:35:41',NULL,2,1,0,0,'07/06/2012AZBUKA VKUSA DOROG       MOSCOW       RU-1038.50''5203XXXXXXXX4003''',0,0,3,0),
  (2035,0,0,NULL,10000.000,5,'','2012-06-06 11:35:41',NULL,1,1,0,0,'06/06/2012ПЛАТЕЖ ЧЕРЕЗ CITIBANK ONLINE10000.00''5203XXXXXXXX4003''',0,0,3,0),
  (2036,0,0,NULL,940.000,5,'','2012-06-06 11:35:42',NULL,2,1,0,0,'06/06/2012CHENTRALE - RESTORAN (   MOSCOW       RU-940.00''5203XXXXXXXX4003''',0,0,3,0),
  (2037,0,0,NULL,1850.220,5,'','2012-06-05 11:35:42',NULL,2,1,0,0,'05/06/2012BP DONSKAYA RC091        MOSCOW       RU-1850.22''5203XXXXXXXX4003''',0,0,3,0),
  (2038,0,0,NULL,421.500,5,'','2012-06-03 11:35:42',NULL,2,1,0,0,'03/06/2012PRODUKTY 24              MOSCOW       RU-421.50''5203XXXXXXXX4003''',0,0,3,0),
  (2039,0,0,NULL,876.320,5,'','2012-06-03 11:35:42',NULL,2,1,0,0,'03/06/2012MOROZKO                  MOSCOW       RU-876.32''5203XXXXXXXX4003''',0,0,3,0),
  (2040,0,0,NULL,791.580,5,'','2012-06-02 11:35:42',NULL,2,1,0,0,'02/06/2012SCOTTISH BOOK SOURCE L   GLASGOW      GB 14.95 UK? 14.95 UK?-791.58''5203XXXXXXXX4003''',0,0,3,0),
  (2041,0,0,NULL,535.500,5,'','2012-06-02 11:35:42',NULL,2,1,0,0,'02/06/2012MAGNOLIYA-REMIZOVA STR   MOSCOW       RU-535.50''5203XXXXXXXX4003''',0,0,3,0),
  (2042,0,0,NULL,4930.000,5,'','2012-06-01 11:35:42',NULL,2,1,0,0,'01/06/2012CHENTRALE - RESTORAN (   MOSCOW       RU-4930.00''5203XXXXXXXX4003''',0,0,3,0),
  (2043,0,0,NULL,548.000,3,'','2012-06-11 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'11/06/2012PRODUKTY 24              MOSCOW       RU-548.00''5203XXXXXXXX4003''',0,0,3,0),
  (2044,0,0,NULL,2341.550,3,'','2012-06-11 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'11/06/2012BP TREKHGORKA RC302      ODINTSOVSKIY RU-2341.55''5203XXXXXXXX4003''',0,0,3,0),
  (2045,0,0,NULL,610.200,3,'','2012-06-10 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'10/06/2012KOFEYINYA KOFE HAUZ DO   MOSCOW       RU-610.20''5203XXXXXXXX4003''',0,0,3,0),
  (2046,0,0,NULL,1152.000,3,'','2012-06-10 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'10/06/2012MAGAZIN SUPERMARKET V-   MOSCOW       RU-1152.00''5203XXXXXXXX4003''',0,0,3,0),
  (2047,0,0,NULL,10400.000,3,'','2012-06-08 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'08/06/2012Jel Gaucho  Restoran     MOSCOW       RU-10400.00''5203XXXXXXXX4003''',0,0,3,0),
  (2048,0,0,NULL,6831.000,3,'','2012-06-07 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'07/06/2012PET RETAIL 55            MOSCOW       RU-6831.00''5203XXXXXXXX4003''',0,0,3,0),
  (2049,0,0,NULL,678.000,3,'','2012-06-07 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'07/06/2012PRODUKTY 24              MOSCOW       RU-678.00''5203XXXXXXXX4003''',0,0,3,0),
  (2050,0,0,NULL,1038.500,3,'','2012-06-07 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'07/06/2012AZBUKA VKUSA DOROG       MOSCOW       RU-1038.50''5203XXXXXXXX4003''',0,0,3,0),
  (2051,0,0,NULL,10000.000,3,'','2012-06-06 11:42:22','''5203XXXXXXXX4003''',1,1,0,0,'06/06/2012ПЛАТЕЖ ЧЕРЕЗ CITIBANK ONLINE10000.00''5203XXXXXXXX4003''',0,0,3,0),
  (2052,0,0,NULL,940.000,3,'','2012-06-06 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'06/06/2012CHENTRALE - RESTORAN (   MOSCOW       RU-940.00''5203XXXXXXXX4003''',0,0,3,0),
  (2053,0,0,NULL,1850.220,3,'','2012-06-05 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'05/06/2012BP DONSKAYA RC091        MOSCOW       RU-1850.22''5203XXXXXXXX4003''',0,0,3,0),
  (2054,0,0,NULL,421.500,3,'','2012-06-03 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'03/06/2012PRODUKTY 24              MOSCOW       RU-421.50''5203XXXXXXXX4003''',0,0,3,0),
  (2055,0,0,NULL,876.320,3,'','2012-06-03 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'03/06/2012MOROZKO                  MOSCOW       RU-876.32''5203XXXXXXXX4003''',0,0,3,0),
  (2056,0,0,NULL,791.580,3,'','2012-06-02 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'02/06/2012SCOTTISH BOOK SOURCE L   GLASGOW      GB 14.95 UK? 14.95 UK?-791.58''5203XXXXXXXX4003''',0,0,3,0),
  (2057,0,0,NULL,535.500,3,'','2012-06-02 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'02/06/2012MAGNOLIYA-REMIZOVA STR   MOSCOW       RU-535.50''5203XXXXXXXX4003''',0,0,3,0),
  (2058,0,0,NULL,4930.000,3,'','2012-06-01 11:42:22','''5203XXXXXXXX4003''',2,1,0,0,'01/06/2012CHENTRALE - RESTORAN (   MOSCOW       RU-4930.00''5203XXXXXXXX4003''',0,0,3,0),
  (2059,0,0,NULL,876.320,22,'','2012-06-03 11:54:47','MOROZKO                  MOSCOW       RU',2,1,0,0,'03/06/2012MOROZKO                  MOSCOW       RU-876.32''5203XXXXXXXX4003''',0,0,3,0),
  (2060,0,0,NULL,791.580,22,'','2012-06-02 11:54:47','SCOTTISH BOOK SOURCE L   GLASGOW      GB 14.95 UK? 14.95 UK?',2,1,0,0,'02/06/2012SCOTTISH BOOK SOURCE L   GLASGOW      GB 14.95 UK? 14.95 UK?-791.58''5203XXXXXXXX4003''',0,0,3,0),
  (2061,0,0,NULL,535.500,22,'','2012-06-02 11:54:47','MAGNOLIYA-REMIZOVA STR   MOSCOW       RU',2,1,0,0,'02/06/2012MAGNOLIYA-REMIZOVA STR   MOSCOW       RU-535.50''5203XXXXXXXX4003''',0,0,3,0),
  (2062,0,0,NULL,548.000,22,'','2012-06-11 12:03:49','PRODUKTY 24              MOSCOW       RU',2,0,0,0,'11/06/2012PRODUKTY 24              MOSCOW       RU-548.00''5203XXXXXXXX4003''',0,0,3,0),
  (2063,0,0,NULL,2341.550,22,'','2012-06-11 12:03:49','BP TREKHGORKA RC302      ODINTSOVSKIY RU',2,0,0,0,'11/06/2012BP TREKHGORKA RC302      ODINTSOVSKIY RU-2341.55''5203XXXXXXXX4003''',0,0,3,0),
  (2064,0,0,NULL,610.200,22,'','2012-06-10 12:03:49','KOFEYINYA KOFE HAUZ DO   MOSCOW       RU',2,0,0,0,'10/06/2012KOFEYINYA KOFE HAUZ DO   MOSCOW       RU-610.20''5203XXXXXXXX4003''',0,0,3,0),
  (2065,0,0,NULL,1152.000,22,'','2012-06-10 12:03:50','MAGAZIN SUPERMARKET V-   MOSCOW       RU',2,0,0,0,'10/06/2012MAGAZIN SUPERMARKET V-   MOSCOW       RU-1152.00''5203XXXXXXXX4003''',0,0,3,0),
  (2066,0,0,NULL,10400.000,22,'','2012-06-08 12:03:50','Jel Gaucho  Restoran     MOSCOW       RU',2,0,0,0,'08/06/2012Jel Gaucho  Restoran     MOSCOW       RU-10400.00''5203XXXXXXXX4003''',0,0,3,0),
  (2067,0,0,NULL,6831.000,22,'','2012-06-07 12:03:50','PET RETAIL 55            MOSCOW       RU',2,0,0,0,'07/06/2012PET RETAIL 55            MOSCOW       RU-6831.00''5203XXXXXXXX4003''',0,0,3,0),
  (2068,0,0,NULL,678.000,22,'','2012-06-07 12:03:50','PRODUKTY 24              MOSCOW       RU',2,0,0,0,'07/06/2012PRODUKTY 24              MOSCOW       RU-678.00''5203XXXXXXXX4003''',0,0,3,0),
  (2069,0,0,NULL,1038.500,22,'','2012-06-07 12:03:50','AZBUKA VKUSA DOROG       MOSCOW       RU',2,0,0,0,'07/06/2012AZBUKA VKUSA DOROG       MOSCOW       RU-1038.50''5203XXXXXXXX4003''',0,0,3,0),
  (2070,0,0,NULL,10000.000,22,'','2012-06-06 12:03:50','ПЛАТЕЖ ЧЕРЕЗ CITIBANK ONLINE',1,0,0,0,'06/06/2012ПЛАТЕЖ ЧЕРЕЗ CITIBANK ONLINE10000.00''5203XXXXXXXX4003''',0,0,3,0),
  (2071,0,0,NULL,940.000,22,'','2012-06-06 12:03:50','CHENTRALE - RESTORAN (   MOSCOW       RU',2,0,0,0,'06/06/2012CHENTRALE - RESTORAN (   MOSCOW       RU-940.00''5203XXXXXXXX4003''',0,0,3,0),
  (2072,0,0,NULL,1850.220,22,'','2012-06-05 12:03:50','BP DONSKAYA RC091        MOSCOW       RU',2,0,0,0,'05/06/2012BP DONSKAYA RC091        MOSCOW       RU-1850.22''5203XXXXXXXX4003''',0,0,3,0),
  (2073,0,0,NULL,421.500,22,'','2012-06-03 12:03:50','PRODUKTY 24              MOSCOW       RU',2,0,0,0,'03/06/2012PRODUKTY 24              MOSCOW       RU-421.50''5203XXXXXXXX4003''',0,0,3,0),
  (2074,0,0,NULL,876.320,22,'','2012-06-03 12:03:50','MOROZKO                  MOSCOW       RU',2,0,0,0,'03/06/2012MOROZKO                  MOSCOW       RU-876.32''5203XXXXXXXX4003''',0,0,3,0),
  (2075,0,0,NULL,791.580,22,'','2012-06-02 12:03:50','SCOTTISH BOOK SOURCE L   GLASGOW      GB 14.95 UK? 14.95 UK?',2,0,0,0,'02/06/2012SCOTTISH BOOK SOURCE L   GLASGOW      GB 14.95 UK? 14.95 UK?-791.58''5203XXXXXXXX4003''',0,0,3,0),
  (2076,0,0,NULL,535.500,22,'','2012-06-02 12:03:50','MAGNOLIYA-REMIZOVA STR   MOSCOW       RU',2,0,0,0,'02/06/2012MAGNOLIYA-REMIZOVA STR   MOSCOW       RU-535.50''5203XXXXXXXX4003''',0,0,3,0),
  (2077,0,0,NULL,4930.000,22,'','2012-06-01 12:03:50','CHENTRALE - RESTORAN (   MOSCOW       RU',2,0,0,0,'01/06/2012CHENTRALE - RESTORAN (   MOSCOW       RU-4930.00''5203XXXXXXXX4003''',0,0,3,0),
  (2078,0,0,NULL,45000.000,1,NULL,'2012-04-16 12:08:41','Внесение средств через устройство Cash-in 400777 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,0,723,1,'Текущий счет40817810104610017169RUR16.04.2012CASHIN400777Внесение средств через устройство Cash-in 400777 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА45000,000,00',0,0,3,0),
  (2079,0,0,NULL,59.000,1,'','2012-04-10 12:08:41','Комиссия за услугу Альфа-Мобайл за период с 10.04.2012 по 09.05.2012 Согл.тариф.банка',2,0,0,1,'Текущий счет40817810104610017169RUR10.04.2012MORE 10204000017Комиссия за услугу Альфа-Мобайл за период с 10.04.2012 по 09.05.2012 Согл.тариф.банка0,0059,00',0,0,3,0),
  (2080,0,0,NULL,58.380,1,'','2012-04-10 12:08:41','Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,0,0,1,'Текущий счет40817810104610017169RUR10.04.2012MORE 21004000009Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА58,380,00',0,0,3,0),
  (2081,0,0,NULL,129000.000,1,NULL,'2012-04-10 12:08:41','Комиссия за пакет услуг            за апрель 2012 г. Согласно тарифам Банка  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,628,1,'Текущий счет40817810104610017169RUR10.04.2012Комиссия за пакет услуг            за апрель 2012 г. Согласно тарифам Банка  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,3,0),
  (2082,0,0,NULL,260000.000,1,NULL,'2012-04-05 12:08:41','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,0,629,1,'Текущий счет40817810104610017169RUR05.04.201296449683.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0026000,00',0,0,3,0),
  (2083,0,0,NULL,1000.000,1,'','2012-04-04 12:08:41','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,0,0,1,'Текущий счет40817810104610017169RUR04.04.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА1000,000,00',0,0,3,0),
  (2084,0,0,NULL,25000.000,1,NULL,'2012-04-04 12:08:41','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,0,725,1,'Текущий счет40817810104610017169RUR04.04.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА25000,000,00',0,0,3,0),
  (2085,0,0,NULL,59.000,1,'','2012-04-02 12:08:41','Комиссия за услугу \"Альфа-Чек\"за период с28.03.12 до28.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR02.04.2012MORE 02204000294Комиссия за услугу \"Альфа-Чек\"за период с28.03.12 до28.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (2086,0,0,NULL,59.000,1,'','2012-03-19 12:08:41','Комиссия за услугу \"Альфа-Чек\"за период с16.03.12 до16.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR19.03.2012MORE 19203000736Комиссия за услугу \"Альфа-Чек\"за период с16.03.12 до16.04.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (2087,0,0,NULL,1000.000,1,'','2012-03-19 12:08:41','N 20120319211059912. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 19.03.2012, 21-10-55.',2,0,0,1,'Текущий счет40817810104610017169RUR19.03.2012YMO005I4231J0MVCN 20120319211059912. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 19.03.2012, 21-10-55.0,001000,00',0,0,3,0),
  (2088,0,0,NULL,1000.000,1,'','2012-03-17 12:08:41','N 20120317093400621. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 17.03.2012, 09-33-59.',2,0,0,1,'Текущий счет40817810104610017169RUR17.03.2012YMO005I4222I7UI5N 20120317093400621. Платёж в систему Яндекс.Деньги. Без НДС. Л/сч 41001475948824, 17.03.2012, 09-33-59.0,001000,00',0,0,3,0),
  (2089,0,0,NULL,200.000,1,'','2012-03-16 12:08:41','Платеж 94144899.1 в пользу Beeline,903+++3554,16.03.12,16-05-24,Номер ответа 1003345955259',2,0,0,1,'Текущий счет40817810104610017169RUR16.03.201294144899.1Платеж 94144899.1 в пользу Beeline,903+++3554,16.03.12,16-05-24,Номер ответа 10033459552590,00200,00',0,0,3,0),
  (2090,0,0,NULL,500.000,1,'','2012-03-16 12:08:41','Платеж 94144198.1 в пользу Beeline,903+++3554,16.03.12,15-57-09,Номер ответа 1003345940771',2,0,0,1,'Текущий счет40817810104610017169RUR16.03.201294144198.1Платеж 94144198.1 в пользу Beeline,903+++3554,16.03.12,15-57-09,Номер ответа 10033459407710,00500,00',0,0,3,0),
  (2091,0,0,NULL,194.270,1,'','2012-03-14 12:08:41','548673++++++1500    \\GBR\\44870835190\\2\\SKYPE                          13.03.12 07.03.12         5.00  EUR',2,0,0,1,'Текущий счет40817810104610017169RUR14.03.2012CRD_2KU18Y548673++++++1500    \\GBR\\44870835190\\2\\SKYPE                          13.03.12 07.03.12         5.00  EUR0,00194,27',0,0,3,0),
  (2092,0,0,NULL,59.000,1,'','2012-03-10 12:08:41','Комиссия за услугу Альфа-Мобайл за период с 10.03.2012 по 09.04.2012 Согл.тариф.банка',2,0,0,1,'Текущий счет40817810104610017169RUR10.03.2012MORE 10203000009Комиссия за услугу Альфа-Мобайл за период с 10.03.2012 по 09.04.2012 Согл.тариф.банка0,0059,00',0,0,3,0),
  (2093,0,0,NULL,129.000,1,'','2012-03-10 12:08:41','Комиссия за пакет услуг            за март 2012 г.                    Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR10.03.2012Комиссия за пакет услуг            за март 2012 г.                    Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,3,0),
  (2094,0,0,NULL,5000.000,1,'','2012-03-06 12:08:41','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               04.03.12 03.03.12      5000.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR06.03.2012CRD_6738FV548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               04.03.12 03.03.12      5000.00  RUR0,005000,00',0,0,3,0),
  (2095,0,0,NULL,10000.000,1,'','2012-03-05 12:08:41','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               03.03.12 02.03.12     10000.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR05.03.2012CRD_4ZH2TU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               03.03.12 02.03.12     10000.00  RUR0,0010000,00',0,0,3,0),
  (2096,0,0,NULL,500.000,1,'','2012-03-04 12:08:41','Платеж 92710631.1 в пользу Beeline,903+++3554,04.03.12,14-17-58,Номер ответа 1003310833202',2,0,0,1,'Текущий счет40817810104610017169RUR04.03.201292710631.1Платеж 92710631.1 в пользу Beeline,903+++3554,04.03.12,14-17-58,Номер ответа 10033108332020,00500,00',0,0,3,0),
  (2097,0,0,NULL,6000.000,1,'','2012-03-02 12:08:41','Внесение средств через устройство Cash-in 155087 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,0,0,1,'Текущий счет40817810104610017169RUR02.03.2012CASHIN155087Внесение средств через устройство Cash-in 155087 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА6000,000,00',0,0,3,0),
  (2098,0,0,NULL,30000.000,1,'','2012-03-02 12:08:41','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,0,0,1,'Текущий счет40817810104610017169RUR02.03.201292464822.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0030000,00',0,0,3,0),
  (2099,0,0,NULL,99.000,1,'','2012-03-01 12:08:41','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 26.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000090Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 26.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0099,00',0,0,3,0),
  (2100,0,0,NULL,59.000,1,'','2012-03-01 12:08:41','Комиссия за услугу \"Альфа-Чек\"за период с28.02.12 до28.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000089Комиссия за услугу \"Альфа-Чек\"за период с28.02.12 до28.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (2101,0,0,NULL,11.880,1,'','2012-03-01 12:08:41','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR01.03.2012MORE 01203000088Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0011,88',0,0,3,0),
  (2102,0,0,NULL,21000.000,1,'','2012-03-01 12:08:41','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,0,0,1,'Текущий счет40817810104610017169RUR01.03.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА21000,000,00',0,0,3,0),
  (2103,0,0,NULL,22000.000,1,'','2012-03-01 12:08:41','Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,0,0,1,'Текущий счет40817810104610017169RUR01.03.2012CASHIN500278Внесение средств через устройство Cash-in 500278 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА22000,000,00',0,0,3,0),
  (2104,0,0,NULL,87.120,1,'','2012-02-29 12:08:41','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR29.02.2012MORE 29202000168Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 22.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0087,12',0,0,3,0),
  (2105,0,0,NULL,15.050,1,'','2012-02-29 12:08:41','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR29.02.2012MORE 29202000167Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0015,05',0,0,3,0),
  (2106,0,0,NULL,1602.090,1,'','2012-02-29 12:08:42','548673++++++1500     S1B7112\\THA\\PHUKET\\JUNGSE\\BAY                    28.02.12 26.02.12      1650.00  THB',2,0,0,1,'Текущий счет40817810104610017169RUR29.02.2012CRD_1860WR548673++++++1500     S1B7112\\THA\\PHUKET\\JUNGSE\\BAY                    28.02.12 26.02.12      1650.00  THB0,001602,09',0,0,3,0),
  (2107,0,0,NULL,181.490,1,'','2012-02-27 12:08:42','Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR27.02.2012MORE 27202000181Ком-я за обесп.выд.нал.ден.ср-в через банк-т или ПВН сторон.банка за 23.02.12 Согл.тариф.Банка AB2DV9 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00181,49',0,0,3,0),
  (2108,0,0,NULL,19653.910,1,'','2012-02-27 12:08:42','548673++++++1500     S1B2837\\THA\\PHUKET\\HAT PA\\KASIKORNBANK           25.02.12 23.02.12     20150.00  THB',2,0,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_13C90N548673++++++1500     S1B2837\\THA\\PHUKET\\HAT PA\\KASIKORNBANK           25.02.12 23.02.12     20150.00  THB0,0019653,91',0,0,3,0),
  (2109,0,0,NULL,9023.240,1,'','2012-02-27 12:08:42','548673++++++1500    \\THA\\PHUKET\\4116 J\\KRUNGTHAI OPT                  24.02.12 22.02.12      9200.00  THB',2,0,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_97U1SM548673++++++1500    \\THA\\PHUKET\\4116 J\\KRUNGTHAI OPT                  24.02.12 22.02.12      9200.00  THB0,009023,24',0,0,3,0),
  (2110,0,0,NULL,3079.210,1,'','2012-02-27 12:08:42','548673++++++1500     S1B5292\\THA\\PHUKET\\JUNGCE\\KASIKORNBANK           24.02.12 22.02.12      3150.00  THB',2,0,0,1,'Текущий счет40817810104610017169RUR27.02.2012CRD_5AV3NM548673++++++1500     S1B5292\\THA\\PHUKET\\JUNGCE\\KASIKORNBANK           24.02.12 22.02.12      3150.00  THB0,003079,21',0,0,3,0),
  (2111,0,0,NULL,1000.000,1,'','2012-02-25 12:08:42','Платеж 91611317.1 в пользу Beeline,903+++3554,25.02.12,05-03-56,Номер ответа 1003287066805',2,0,0,1,'Текущий счет40817810104610017169RUR25.02.201291611317.1Платеж 91611317.1 в пользу Beeline,903+++3554,25.02.12,05-03-56,Номер ответа 10032870668050,001000,00',0,0,3,0),
  (2112,0,0,NULL,299.000,1,'','2012-02-22 12:08:42','Комиссия за обслуживание карты за период с19.02.12 по19.02.13 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR22.02.2012MORE 22202000150Комиссия за обслуживание карты за период с19.02.12 по19.02.13 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00299,00',0,0,3,0),
  (2113,0,0,NULL,15000.000,1,'','2012-02-22 12:08:42','Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.',2,0,0,1,'Текущий счет40817810104610017169RUR22.02.201291308200.1Внутрибанковский перевод между счетами, ЧАЧИНА Н. Н.0,0015000,00',0,0,3,0),
  (2114,0,0,NULL,58.890,1,'','2012-02-21 12:08:42','Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR21.02.2012MORE 21202000140Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0058,89',0,0,3,0),
  (2115,0,0,NULL,50000.000,1,'','2012-02-21 12:08:42','Внесение средств через устройство Cash-in 155123 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,0,0,1,'Текущий счет40817810104610017169RUR21.02.2012CASHIN155123Внесение средств через устройство Cash-in 155123 на счет 40817810104610017169 ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА50000,000,00',0,0,3,0),
  (2116,0,0,NULL,0.110,1,'','2012-02-17 12:08:42','Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR17.02.2012MORE 17202000208Комиссия за услугу \"Альфа-Чек\"за период с16.02.12 до16.03.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,000,11',0,0,3,0),
  (2117,0,0,NULL,59.000,1,'','2012-02-10 12:08:42','Комиссия за услугу Альфа-Мобайл за период с 10.02.2012 по 09.03.2012 Согл.тариф.банка',2,0,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 10202000010Комиссия за услугу Альфа-Мобайл за период с 10.02.2012 по 09.03.2012 Согл.тариф.банка0,0059,00',0,0,3,0),
  (2118,0,0,NULL,129.000,1,'','2012-02-10 12:08:42','Комиссия за пакет услуг            за февраль 2012 г.                 Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 10202000009Комиссия за пакет услуг            за февраль 2012 г.                 Согласно тарифам Банка             ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,00129,00',0,0,3,0),
  (2119,0,0,NULL,183.120,1,'','2012-02-10 12:08:42','Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',1,0,0,1,'Текущий счет40817810104610017169RUR10.02.2012MORE 21002000006Перевод средств на Основной счет   для списания комиссий Банка        ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА183,120,00',0,0,3,0),
  (2120,0,0,NULL,59.000,1,'','2012-01-30 12:08:42','Комиссия за услугу \"Альфа-Чек\"за период с28.01.12 до28.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,1,'Текущий счет40817810104610017169RUR30.01.2012MORE 30201000086Комиссия за услугу \"Альфа-Чек\"за период с28.01.12 до28.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (2121,0,0,NULL,355.000,1,'','2012-01-23 12:08:42','548673++++++1500      899026\\RUS\\MOSCOW\\82-4 V\\IP AKAD NAROD          21.01.12 18.01.12       355.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR23.01.2012CRD_67C7EX548673++++++1500      899026\\RUS\\MOSCOW\\82-4 V\\IP AKAD NAROD          21.01.12 18.01.12       355.00  RUR0,00355,00',0,0,3,0),
  (2122,0,0,NULL,16000.000,1,'','2012-01-23 12:08:42','548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 20.01.12 19.01.12     16000.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR23.01.2012CRD_4X85BY548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 20.01.12 19.01.12     16000.00  RUR0,0016000,00',0,0,3,0),
  (2123,0,0,NULL,416.000,1,'','2012-01-19 12:08:42','548673++++++1500    26001256\\RUS\\ORENBURG\\MCDONALDS 271               18.01.12 15.01.12       416.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR19.01.2012CRD_1118TV548673++++++1500    26001256\\RUS\\ORENBURG\\MCDONALDS 271               18.01.12 15.01.12       416.00  RUR0,00416,00',0,0,3,0),
  (2124,0,0,NULL,7060.000,1,'','2012-01-18 12:08:42','548673++++++1500    15516001\\RUS\\ORENBURGSKY \\\\ORENBURG AIRL          17.01.12 14.01.12      7060.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_9NR85V548673++++++1500    15516001\\RUS\\ORENBURGSKY \\\\ORENBURG AIRL          17.01.12 14.01.12      7060.00  RUR0,007060,00',0,0,3,0),
  (2125,0,0,NULL,8722.000,1,'','2012-01-18 12:08:42','548673++++++1500    20508433\\RUS\\ORENBURG\\1-2,\\\"SAMSONITE\"            17.01.12 15.01.12      8722.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_8S18VV548673++++++1500    20508433\\RUS\\ORENBURG\\1-2,\\\"SAMSONITE\"            17.01.12 15.01.12      8722.00  RUR0,008722,00',0,0,3,0),
  (2126,0,0,NULL,3000.000,1,'','2012-01-18 12:08:42','548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 17.01.12 16.01.12      3000.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5E31NW548673++++++1500      500803\\643\\MOSKVA\\Alfa-Bank ATM                 17.01.12 16.01.12      3000.00  RUR0,003000,00',0,0,3,0),
  (2127,0,0,NULL,201.920,1,'','2012-01-18 12:08:42','548673++++++1500    00003297\\LUX\\LUXEMBOURG\\23\\SKYPE COMMUNI          17.01.12 11.01.12         5.00  EUR',2,0,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_3KR8RT548673++++++1500    00003297\\LUX\\LUXEMBOURG\\23\\SKYPE COMMUNI          17.01.12 11.01.12         5.00  EUR0,00201,92',0,0,3,0),
  (2128,0,0,NULL,6900.000,1,'','2012-01-18 12:08:42','548673++++++1500    80002001\\RUS\\MOSKVA\\13 STR\\1GB.RU                 15.01.12 13.01.12      6900.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_7646ZT548673++++++1500    80002001\\RUS\\MOSKVA\\13 STR\\1GB.RU                 15.01.12 13.01.12      6900.00  RUR0,006900,00',0,0,3,0),
  (2129,0,0,NULL,40000.000,1,'','2012-01-18 12:08:42','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5V345V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (2130,0,0,NULL,40000.000,1,'','2012-01-18 12:08:42','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_5U545V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (2131,0,0,NULL,40000.000,1,'','2012-01-18 12:08:42','548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR18.01.2012CRD_1W445V548673++++++1500      400779\\643\\ORENBURG\\Alfa-Bank ATM               15.01.12 14.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (2132,0,0,NULL,500.000,1,'','2012-01-17 12:08:42','Платеж 86010703.1 в пользу Beeline,903+++3554,17.01.12,20-07-52,Номер ответа 1003182924042',2,0,0,1,'Текущий счет40817810104610017169RUR17.01.201286010703.1Платеж 86010703.1 в пользу Beeline,903+++3554,17.01.12,20-07-52,Номер ответа 10031829240420,00500,00',0,0,3,0),
  (2133,0,0,NULL,40000.000,1,'','2012-01-17 12:08:42','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_8TS7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (2134,0,0,NULL,30000.000,1,'','2012-01-17 12:08:42','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     30000.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_4418YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     30000.00  RUR0,0030000,00',0,0,3,0),
  (2135,0,0,NULL,40000.000,1,'','2012-01-17 12:08:42','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_4WF7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (2136,0,0,NULL,40000.000,1,'','2012-01-17 12:08:42','548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR',2,0,0,1,'Текущий счет40817810104610017169RUR17.01.2012CRD_22A7YU548673++++++1500      500278\\643\\ORENBURG\\Alfa-Bank ATM               14.01.12 13.01.12     40000.00  RUR0,0040000,00',0,0,3,0),
  (2137,0,0,NULL,59.000,1,'','2012-01-16 12:08:42','Комиссия за услугу \"Альфа-Чек\"за период с16.01.12 до16.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА',2,0,0,3,'Текущий счет40817810104610017169USD16.01.2012MORE 16201000205Комиссия за услугу \"Альфа-Чек\"за период с16.01.12 до16.02.12 Согласно тарифам Банка AB2DV9  ЧАЧИНА НАТАЛЬЯ НИКОЛАЕВНА0,0059,00',0,0,3,0),
  (2138,0,0,NULL,483.990,24,'','2012-03-18 11:00:00','533469******4354: Комиссия за перевод денежных средств договор 95311004  -483.99 RUB',0,0,0,0,'078892012-03-19T00:00:00+0400483.99533469******4354: Комиссия за перевод денежных средств договор 95311004  -483.99 RUB1RUB',0,0,3,0),
  (2139,0,0,NULL,12410.000,24,'','2012-03-18 11:00:00','533469******4354: Перевод денежных средств  -12410 RUB',0,0,0,0,'078892012-03-19T00:00:00+040012410.00533469******4354: Перевод денежных средств  -12410 RUB1RUB',0,0,3,0),
  (2140,0,0,NULL,7500.000,24,'','2012-03-19 11:00:00','BANKOMAT 890051 7982 MOSCOW RUS 533469******4354: Снято наличными (ATM/POS) 18.03.2012 -7500 RUB',0,0,0,0,'078892012-03-20T00:00:00+04007500.00BANKOMAT 890051 7982 MOSCOW RUS 533469******4354: Снято наличными (ATM/POS) 18.03.2012 -7500 RUB1RUB',0,0,3,0),
  (2141,0,0,NULL,292.500,24,'','2012-03-19 11:00:00','533469******4354: Комиссия за снятие наличных договор 95311004 18.03.2012 -292.5 RUB',0,0,0,0,'078892012-03-20T00:00:00+0400292.50533469******4354: Комиссия за снятие наличных договор 95311004 18.03.2012 -292.5 RUB1RUB',0,0,3,0),
  (2142,0,0,NULL,44.000,24,'','2012-03-27 12:00:00','LUKOIL 02130 UFA RUS 533469******4354: Покупка 25.03.2012 -44 RUB',0,0,0,0,'078892012-03-27T00:00:00+040044.00LUKOIL 02130 UFA RUS 533469******4354: Покупка 25.03.2012 -44 RUB1RUB',0,0,3,0),
  (2143,0,0,NULL,572.000,24,'','2012-03-27 12:00:00','LUKOIL 02130 UFA RUS 533469******4354: Покупка 25.03.2012 -572 RUB',0,0,0,0,'078892012-03-27T00:00:00+0400572.00LUKOIL 02130 UFA RUS 533469******4354: Покупка 25.03.2012 -572 RUB1RUB',0,0,3,0),
  (2144,0,0,NULL,486.200,24,'','2012-03-27 12:00:00','LUKOIL 02130 UFA RUS 533469******4354: Покупка 24.03.2012 -486.2 RUB',0,0,0,0,'078892012-03-27T00:00:00+0400486.20LUKOIL 02130 UFA RUS 533469******4354: Покупка 24.03.2012 -486.2 RUB1RUB',0,0,3,0),
  (2145,0,0,NULL,3000.000,24,'','2012-04-01 12:00:00','533469******4354: Плата за выпуск и обслуживание основной карты договор 95311004 31.03.2012 -3000 RUB',0,0,0,0,'078892012-04-01T00:00:00+04003000.00533469******4354: Плата за выпуск и обслуживание основной карты договор 95311004 31.03.2012 -3000 RUB1RUB',0,0,3,0),
  (2146,0,0,NULL,550.820,24,'','2012-04-13 12:00:00','533469******4354: Уплата процентов  -550.82 RUB',0,0,0,3,'078892012-04-13T00:00:00+0400550.82533469******4354: Уплата процентов  -550.82 RUB1USD',0,0,3,0),
  (2147,0,0,NULL,1000.000,2,'','2012-01-13 05:15:52','Note Acceptance RUS ORENBURG 3,M.ZHUKOVA 510369',1,0,0,1,'708113.01.2012 17:15:5213.01.20121000.00RUR0.001000.00Note Acceptance RUS ORENBURG 3,M.ZHUKOVA 510369',0,0,3,0);
COMMIT;

#
# Data for the `finance_action_data_storage` table  (LIMIT 190,500)
#

INSERT INTO `finance_action_data_storage` (`fca_id`, `fca_operation_id`, `fca_actor_id`, `fca_quantity`, `fca_summ`, `fca_purse_id`, `fca_actor_description`, `fca_date`, `fca_description`, `fca_operation_type_id`, `closed`, `fca_category_id`, `fca_currency_id`, `fca_sync_key`, `fca_plan_id`, `fca_transfert_purse_id`, `fca_status_id`, `order_index`) VALUES 
  (2148,0,0,NULL,150.000,2,'','2011-12-21 05:11:16','Card Production (Debit) 2 years   Card Production (Debit) 2 years',2,0,0,1,'708121.12.2011 17:11:1614.01.20120.00RUR-150.00-150.00Card Production (Debit) 2 years   Card Production (Debit) 2 years',0,0,3,0),
  (2149,0,0,NULL,34000.000,2,'','2012-01-16 09:04:03','Note Acceptance RUS MOSCOW 1,1,POKRYISHKINA 567463',1,0,0,1,'708116.01.2012 21:04:0317.01.201234000.00RUR0.0034000.00Note Acceptance RUS MOSCOW 1,1,POKRYISHKINA 567463',0,0,3,0),
  (2150,0,0,NULL,40000.000,2,'','2012-01-16 09:05:06','Note Acceptance RUS MOSCOW 1,1,POKRYISHKINA 568439',1,0,0,1,'708116.01.2012 21:05:0617.01.201240000.00RUR0.0040000.00Note Acceptance RUS MOSCOW 1,1,POKRYISHKINA 568439',0,0,3,0),
  (2151,0,0,NULL,40000.000,2,'','2012-01-18 02:58:40','Credit RUS ORENBURG 10, GAGARINA 119635',1,0,0,1,'708118.01.2012 14:58:4018.01.201240000.00RUR0.0040000.00Credit RUS ORENBURG 10, GAGARINA 119635',0,0,3,0),
  (2152,0,0,NULL,10000.000,2,'','2012-01-21 11:15:23','Unique RUS MOSCOW TELEBANK 843368',2,0,0,1,'708121.01.2012 11:15:2321.01.2012-10000.00RUR0.00-10000.00Unique RUS MOSCOW TELEBANK 843368',0,0,3,0),
  (2153,0,0,NULL,60000.000,2,'','2012-01-24 12:00:46','Credit RUS ORENBURG 10, GAGARINA 964890',1,0,0,1,'708124.01.2012 12:00:4624.01.201260000.00RUR0.0060000.00Credit RUS ORENBURG 10, GAGARINA 964890',0,0,3,0),
  (2154,0,0,NULL,7060.000,2,'','2012-01-25 12:00:00','Retail RUS ORENBURGSKY R ORENBURG AI 2912428306245 416599',2,0,0,1,'708125.01.2012 00:00:0027.01.2012-7060.00RUR0.00-7060.00Retail RUS ORENBURGSKY R ORENBURG AI 2912428306245 416599',0,0,3,0),
  (2155,0,0,NULL,6200.000,2,'','2012-01-25 12:00:00','ATM RUS MOSCOW 00000230/ZENIT ATM 230    727361',2,0,0,1,'708125.01.2012 00:00:0027.01.2012-6000.00RUR-200.00-6200.00ATM RUS MOSCOW 00000230/ZENIT ATM 230    727361',0,0,3,0),
  (2156,0,0,NULL,6200.000,2,'','2012-01-25 12:00:00','ATM RUS MOSCOW 00000230/ZENIT ATM 230    728717',2,0,0,1,'708125.01.2012 00:00:0027.01.2012-6000.00RUR-200.00-6200.00ATM RUS MOSCOW 00000230/ZENIT ATM 230    728717',0,0,3,0),
  (2157,0,0,NULL,2671.450,2,'','2012-01-25 12:00:00','Retail MUS 442031399063P VENDOSUPPORT.COM          427309',2,0,0,1,'708125.01.2012 00:00:0028.01.2012-87.16USD0.00-2671.45Retail MUS 442031399063P VENDOSUPPORT.COM          427309',0,0,3,0),
  (2158,0,0,NULL,7700.000,2,'','2012-01-26 12:00:00','ATM RUS MOSCOW BANKOMAT 830489 7970      448539',2,0,0,1,'708126.01.2012 00:00:0028.01.2012-7500.00RUR-200.00-7700.00ATM RUS MOSCOW BANKOMAT 830489 7970      448539',0,0,3,0),
  (2159,0,0,NULL,7700.000,2,'','2012-01-26 12:00:00','ATM RUS MOSCOW BANKOMAT 830489 7970      449769',2,0,0,1,'708126.01.2012 00:00:0028.01.2012-7500.00RUR-200.00-7700.00ATM RUS MOSCOW BANKOMAT 830489 7970      449769',0,0,3,0),
  (2160,0,0,NULL,7700.000,2,'','2012-01-26 12:00:00','ATM RUS MOSCOW BANKOMAT 830489 7970      451034',2,0,0,1,'708126.01.2012 00:00:0028.01.2012-7500.00RUR-200.00-7700.00ATM RUS MOSCOW BANKOMAT 830489 7970      451034',0,0,3,0),
  (2161,0,0,NULL,5200.000,2,'','2012-01-29 12:00:00','ATM RUS ORENBURG 01849537/ATM-01849537 URA 538121',2,0,0,1,'708129.01.2012 00:00:0031.01.2012-5000.00RUR-200.00-5200.00ATM RUS ORENBURG 01849537/ATM-01849537 URA 538121',0,0,3,0),
  (2162,0,0,NULL,114418.000,2,'','2012-02-03 03:35:57','Unique RUS MOSCOW TELEBANK 814242',2,0,0,1,'708103.02.2012 15:35:5703.02.2012-114418.00RUR0.00-114418.00Unique RUS MOSCOW TELEBANK 814242',0,0,3,0),
  (2163,0,0,NULL,20000.000,2,'','2012-02-03 03:52:25','Credit RUS MOSCOW TELEBANK 847446',1,0,0,1,'708103.02.2012 15:52:2503.02.201220000.00RUR0.0020000.00Credit RUS MOSCOW TELEBANK 847446',0,0,3,0),
  (2164,0,0,NULL,20000.000,2,'','2012-02-03 03:52:40','ATM RUS ORENBURG 3,M.ZHUKOVA 847963',2,0,0,1,'708103.02.2012 15:52:4003.02.2012-20000.00RUR0.00-20000.00ATM RUS ORENBURG 3,M.ZHUKOVA 847963',0,0,3,0),
  (2165,0,0,NULL,5000.000,2,'','2012-02-05 09:21:52','Credit RUS MOSCOW TELEBANK 822806',1,0,0,1,'708105.02.2012 09:21:5205.02.20125000.00RUR0.005000.00Credit RUS MOSCOW TELEBANK 822806',0,0,3,0),
  (2166,0,0,NULL,118.900,2,'','2012-02-07 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    400740',2,0,0,1,'708107.02.2012 00:00:0009.02.2012-3.97USD0.00-118.90Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    400740',0,0,3,0),
  (2167,0,0,NULL,415000.000,2,'','2012-02-10 03:06:58','Credit RUS MOSCOW 5-1, MARKSISTSKAYA 729674',1,0,0,1,'708110.02.2012 15:06:5810.02.2012415000.00RUR0.00415000.00Credit RUS MOSCOW 5-1, MARKSISTSKAYA 729674',0,0,3,0),
  (2168,0,0,NULL,218000.000,2,'','2012-02-10 03:13:19','Unique RUS MOSCOW TELEBANK 744178',2,0,0,1,'708110.02.2012 15:13:1910.02.2012-218000.00RUR0.00-218000.00Unique RUS MOSCOW TELEBANK 744178',0,0,3,0),
  (2169,0,0,NULL,40000.000,2,'','2012-02-11 06:39:58','ATM RUS ORENBURG 3,M.ZHUKOVA 677341',2,0,0,1,'708111.02.2012 06:39:5811.02.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 677341',0,0,3,0),
  (2170,0,0,NULL,40000.000,2,'','2012-02-11 06:40:42','ATM RUS ORENBURG 3,M.ZHUKOVA 677725',2,0,0,1,'708111.02.2012 06:40:4211.02.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 677725',0,0,3,0),
  (2171,0,0,NULL,60000.000,2,'','2012-02-11 10:04:21','Unique RUS MOSCOW TELEBANK 882452',2,0,0,1,'708111.02.2012 10:04:2111.02.2012-60000.00RUR0.00-60000.00Unique RUS MOSCOW TELEBANK 882452',0,0,3,0),
  (2172,0,0,NULL,999.890,2,'','2012-02-10 12:00:00','Retail RUS ORENBURG LUKOIL 59                 587220',2,0,0,1,'708110.02.2012 00:00:0012.02.2012-999.89RUR0.00-999.89Retail RUS ORENBURG LUKOIL 59                 587220',0,0,3,0),
  (2173,0,0,NULL,172.000,2,'','2012-02-10 12:00:00','Retail RUS ORENBURG MCDONALDS 27101           823387',2,0,0,1,'708110.02.2012 00:00:0012.02.2012-172.00RUR0.00-172.00Retail RUS ORENBURG MCDONALDS 27101           823387',0,0,3,0),
  (2174,0,0,NULL,56.000,2,'','2012-02-10 12:00:00','Retail RUS ORENBURG MCDONALDS 27101           830816',2,0,0,1,'708110.02.2012 00:00:0012.02.2012-56.00RUR0.00-56.00Retail RUS ORENBURG MCDONALDS 27101           830816',0,0,3,0),
  (2175,0,0,NULL,3680.000,2,'','2012-02-12 12:06:20','Retail RUS OREBURG UP!STOR 309442',2,0,0,1,'708112.02.2012 12:06:2012.02.2012-3680.00RUR0.00-3680.00Retail RUS OREBURG UP!STOR 309442',0,0,3,0),
  (2176,0,0,NULL,40000.000,2,'','2012-02-13 11:33:59','ATM RUS ORENBURG 3,M.ZHUKOVA 461445',2,0,0,1,'708113.02.2012 11:33:5913.02.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 461445',0,0,3,0),
  (2177,0,0,NULL,16000.000,2,'','2012-02-13 11:35:20','ATM RUS ORENBURG 3,M.ZHUKOVA 463864',2,0,0,1,'708113.02.2012 11:35:2013.02.2012-16000.00RUR0.00-16000.00ATM RUS ORENBURG 3,M.ZHUKOVA 463864',0,0,3,0),
  (2178,0,0,NULL,151.450,2,'','2012-02-12 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    940437',2,0,0,1,'708112.02.2012 00:00:0014.02.2012-4.99USD0.00-151.45Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    940437',0,0,3,0),
  (2179,0,0,NULL,102100.000,2,'','2012-02-15 11:51:21','Credit RUS MOSCOW 35, MYASNITSKAYA 926813',1,0,0,1,'708115.02.2012 11:51:2115.02.2012102100.00RUR0.00102100.00Credit RUS MOSCOW 35, MYASNITSKAYA 926813',0,0,3,0),
  (2180,0,0,NULL,100000.000,2,'','2012-02-15 03:53:05','Unique RUS MOSCOW TELEBANK 464223',2,0,0,1,'708115.02.2012 15:53:0515.02.2012-100000.00RUR0.00-100000.00Unique RUS MOSCOW TELEBANK 464223',0,0,3,0),
  (2181,0,0,NULL,30000.000,2,'','2012-02-16 08:04:11','Credit RUS MOSCOW TELEBANK 398625',1,0,0,1,'708116.02.2012 08:04:1116.02.201230000.00RUR0.0030000.00Credit RUS MOSCOW TELEBANK 398625',0,0,3,0),
  (2182,0,0,NULL,26512.500,2,'','2012-02-16 08:08:57','Cash RUS ORENBURG 3,MARSHALA ZHUKOVA 404085',2,0,0,1,'708116.02.2012 08:08:5716.02.2012-26512.50RUR0.00-26512.50Cash RUS ORENBURG 3,MARSHALA ZHUKOVA 404085',0,0,3,0),
  (2183,0,0,NULL,90.600,2,'','2012-02-16 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    424280',2,0,0,1,'708116.02.2012 00:00:0018.02.2012-2.99USD0.00-90.60Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    424280',0,0,3,0),
  (2184,0,0,NULL,5000.000,2,'','2012-03-06 07:27:38','Unique RUS MOSCOW TELEBANK 328242',2,0,0,1,'708106.03.2012 07:27:3806.03.2012-5000.00RUR0.00-5000.00Unique RUS MOSCOW TELEBANK 328242',0,0,3,0),
  (2185,0,0,NULL,450000.000,2,'','2012-03-06 07:42:06','Credit RUS MOSCOW 35, MYASNITSKAYA 817446',1,0,0,1,'708106.03.2012 19:42:0606.03.2012450000.00RUR0.00450000.00Credit RUS MOSCOW 35, MYASNITSKAYA 817446',0,0,3,0),
  (2186,0,0,NULL,300000.000,2,'','2012-03-06 08:16:18','Unique RUS MOSCOW TELEBANK 868557',2,0,0,1,'708106.03.2012 20:16:1806.03.2012-300000.00RUR0.00-300000.00Unique RUS MOSCOW TELEBANK 868557',0,0,3,0),
  (2187,0,0,NULL,40000.000,2,'','2012-03-07 08:41:51','ATM RUS ORENBURG 3,M.ZHUKOVA 331699',2,0,0,1,'708107.03.2012 08:41:5107.03.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 331699',0,0,3,0),
  (2188,0,0,NULL,40000.000,2,'','2012-03-07 08:42:51','ATM RUS ORENBURG 3,M.ZHUKOVA 333362',2,0,0,1,'708107.03.2012 08:42:5107.03.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 333362',0,0,3,0),
  (2189,0,0,NULL,1499.000,2,'','2012-03-06 12:00:00','Retail LUX ORIGIN.COM EA *ORIGIN.COM            899435',2,0,0,1,'708106.03.2012 00:00:0009.03.2012-1499.00RUR0.00-1499.00Retail LUX ORIGIN.COM EA *ORIGIN.COM            899435',0,0,3,0),
  (2190,0,0,NULL,40000.000,2,'','2012-03-11 06:33:03','ATM RUS ORENBURG 3,M.ZHUKOVA 774731',2,0,0,1,'708111.03.2012 06:33:0311.03.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 774731',0,0,3,0),
  (2191,0,0,NULL,25000.000,2,'','2012-03-11 06:34:04','ATM RUS ORENBURG 3,M.ZHUKOVA 775371',2,0,0,1,'708111.03.2012 06:34:0411.03.2012-25000.00RUR0.00-25000.00ATM RUS ORENBURG 3,M.ZHUKOVA 775371',0,0,3,0),
  (2192,0,0,NULL,29.650,2,'','2012-03-14 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    311501',2,0,0,1,'708114.03.2012 00:00:0015.03.2012-0.99USD0.00-29.65Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    311501',0,0,3,0),
  (2193,0,0,NULL,88.210,2,'','2012-03-19 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    491028',2,0,0,1,'708119.03.2012 00:00:0021.03.2012-2.99USD0.00-88.21Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    491028',0,0,3,0),
  (2194,0,0,NULL,16000.000,2,'','2012-03-22 08:30:02','Credit RUS MOSCOW TELEBANK 418139',1,0,0,1,'708122.03.2012 08:30:0222.03.201216000.00RUR0.0016000.00Credit RUS MOSCOW TELEBANK 418139',0,0,3,0),
  (2195,0,0,NULL,15000.000,2,'','2012-03-22 08:33:14','Credit RUS MOSCOW TELEBANK 422161',1,0,0,1,'708122.03.2012 08:33:1422.03.201215000.00RUR0.0015000.00Credit RUS MOSCOW TELEBANK 422161',0,0,3,0),
  (2196,0,0,NULL,35000.000,2,'','2012-03-22 08:43:03','ATM RUS ORENBURG 3,M.ZHUKOVA 434977',2,0,0,1,'708122.03.2012 08:43:0322.03.2012-35000.00RUR0.00-35000.00ATM RUS ORENBURG 3,M.ZHUKOVA 434977',0,0,3,0),
  (2197,0,0,NULL,296.910,2,'','2012-03-21 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    417859',2,0,0,1,'708121.03.2012 00:00:0023.03.2012-9.98USD0.00-296.91Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    417859',0,0,3,0),
  (2198,0,0,NULL,340.000,2,'','2012-03-23 08:19:10','Unique RUS MOSCOW TELEBANK 136491',2,0,0,1,'708123.03.2012 08:19:1023.03.2012-340.00RUR0.00-340.00Unique RUS MOSCOW TELEBANK 136491',0,0,3,0),
  (2199,0,0,NULL,278.000,2,'','2012-03-25 09:11:55','Credit RUS MOSCOW TELEBANK 271867',1,0,0,1,'708125.03.2012 21:11:5525.03.2012278.00RUR0.00278.00Credit RUS MOSCOW TELEBANK 271867',0,0,3,0),
  (2200,0,0,NULL,87.310,2,'','2012-03-26 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    272897',2,0,0,1,'708126.03.2012 00:00:0027.03.2012-2.99USD0.00-87.31Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    272897',0,0,3,0),
  (2201,0,0,NULL,450000.000,2,'','2012-03-28 04:09:33','Credit RUS MOSCOW 5-1, MARKSISTSKAYA 758853',1,0,0,1,'708128.03.2012 16:09:3328.03.2012450000.00RUR0.00450000.00Credit RUS MOSCOW 5-1, MARKSISTSKAYA 758853',0,0,3,0),
  (2202,0,0,NULL,40000.000,2,'','2012-03-28 05:15:50','ATM RUS ORENBURG 3,M.ZHUKOVA 889330',2,0,0,1,'708128.03.2012 17:15:5028.03.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 889330',0,0,3,0),
  (2203,0,0,NULL,20000.000,2,'','2012-03-28 05:17:21','ATM RUS ORENBURG 3,M.ZHUKOVA 892751',2,0,0,1,'708128.03.2012 17:17:2128.03.2012-20000.00RUR0.00-20000.00ATM RUS ORENBURG 3,M.ZHUKOVA 892751',0,0,3,0),
  (2204,0,0,NULL,20000.000,2,'','2012-03-28 05:18:14','ATM RUS ORENBURG 3,M.ZHUKOVA 894735',2,0,0,1,'708128.03.2012 17:18:1428.03.2012-20000.00RUR0.00-20000.00ATM RUS ORENBURG 3,M.ZHUKOVA 894735',0,0,3,0),
  (2205,0,0,NULL,20000.000,2,'','2012-03-28 05:18:53','ATM RUS ORENBURG 3,M.ZHUKOVA 896230',2,0,0,1,'708128.03.2012 17:18:5328.03.2012-20000.00RUR0.00-20000.00ATM RUS ORENBURG 3,M.ZHUKOVA 896230',0,0,3,0),
  (2206,0,0,NULL,250000.000,2,'','2012-03-28 05:37:14','Unique RUS MOSCOW TELEBANK 936859',2,0,0,1,'708128.03.2012 17:37:1428.03.2012-250000.00RUR0.00-250000.00Unique RUS MOSCOW TELEBANK 936859',0,0,3,0),
  (2207,0,0,NULL,15000.000,2,'','2012-03-29 03:13:33','Unique RUS MOSCOW TELEBANK 222786',2,0,0,1,'708129.03.2012 15:13:3329.03.2012-15000.00RUR0.00-15000.00Unique RUS MOSCOW TELEBANK 222786',0,0,3,0),
  (2208,0,0,NULL,40000.000,2,'','2012-03-29 10:33:09','ATM RUS ORENBURG 1, SHARLYKSKOE 716071',2,0,0,1,'708129.03.2012 10:33:0930.03.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 1, SHARLYKSKOE 716071',0,0,3,0),
  (2209,0,0,NULL,40000.000,2,'','2012-03-29 10:34:15','ATM RUS ORENBURG 1, SHARLYKSKOE 717823',2,0,0,1,'708129.03.2012 10:34:1530.03.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 1, SHARLYKSKOE 717823',0,0,3,0),
  (2210,0,0,NULL,2500.000,2,'','2012-04-05 03:58:27','Unique RUS MOSCOW TELEBANK 704413',2,0,0,1,'708105.04.2012 15:58:2705.04.2012-2500.00RUR0.00-2500.00Unique RUS MOSCOW TELEBANK 704413',0,0,3,0),
  (2211,0,0,NULL,550000.000,2,'','2012-04-06 01:09:28','Credit RUS MOSCOW 5-1, MARKSISTSKAYA 109496',1,0,0,1,'708106.04.2012 13:09:2806.04.2012550000.00RUR0.00550000.00Credit RUS MOSCOW 5-1, MARKSISTSKAYA 109496',0,0,3,0),
  (2212,0,0,NULL,40000.000,2,'','2012-04-09 12:00:55','ATM RUS ORENBURG 3,M.ZHUKOVA 217417',2,0,0,1,'708109.04.2012 12:00:5509.04.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 217417',0,0,3,0),
  (2213,0,0,NULL,40000.000,2,'','2012-04-09 12:01:37','ATM RUS ORENBURG 3,M.ZHUKOVA 218890',2,0,0,1,'708109.04.2012 12:01:3709.04.2012-40000.00RUR0.00-40000.00ATM RUS ORENBURG 3,M.ZHUKOVA 218890',0,0,3,0),
  (2214,0,0,NULL,20000.000,2,'','2012-04-09 12:02:19','ATM RUS ORENBURG 3,M.ZHUKOVA 220343',2,0,0,1,'708109.04.2012 12:02:1909.04.2012-20000.00RUR0.00-20000.00ATM RUS ORENBURG 3,M.ZHUKOVA 220343',0,0,3,0),
  (2215,0,0,NULL,90.000,2,'','2012-04-09 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    204060',2,0,0,1,'708109.04.2012 00:00:0011.04.2012-2.99USD0.00-90.00Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    204060',0,0,3,0),
  (2216,0,0,NULL,350000.000,2,'','2012-04-11 06:35:06','Unique RUS MOSCOW TELEBANK 324238',2,0,0,1,'708111.04.2012 06:35:0611.04.2012-350000.00RUR0.00-350000.00Unique RUS MOSCOW TELEBANK 324238',0,0,3,0),
  (2217,0,0,NULL,100000.000,2,'','2012-04-11 07:11:23','Cash RUS ORENBURG 14, POBEDY 354727',2,0,0,1,'708111.04.2012 07:11:2311.04.2012-100000.00RUR0.00-100000.00Cash RUS ORENBURG 14, POBEDY 354727',0,0,3,0),
  (2218,0,0,NULL,684.800,2,'','2012-04-14 12:00:00','Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    583407',2,0,0,1,'708114.04.2012 00:00:0015.04.2012-22.98USD0.00-684.80Retail LUX LUXEMBOURG APPLE ITUNES STORE USD    583407',0,0,3,0),
  (2219,0,0,NULL,10000.000,3,'','2012-01-21 11:15:25','Зачисление на счет c п/к (по расп. №34595930)',1,0,0,1,'21.01.2012 11:15:253459593010000.00Зачисление на счет c п/к (по расп. №34595930)10000.00',0,0,3,0),
  (2220,0,0,NULL,100.000,3,'','2012-01-21 11:16:45','Платеж. Квитанция БИ-ЛАЙН №34595984-01',2,0,0,1,'21.01.2012 11:16:4534595984-100.00Платеж. Квитанция БИ-ЛАЙН №34595984-019900.00',0,0,3,0),
  (2221,0,0,NULL,100.000,3,'','2012-01-21 11:21:32','Платеж. Квитанция БИ-ЛАЙН №34596172-01',2,0,0,1,'21.01.2012 11:21:3234596172-100.00Платеж. Квитанция БИ-ЛАЙН №34596172-019800.00',0,0,3,0),
  (2222,0,0,NULL,500.000,3,'','2012-01-27 12:58:03','Платеж. Квитанция БИ-ЛАЙН №34864645-01',2,0,0,1,'27.01.2012 12:58:0334864645-500.00Платеж. Квитанция БИ-ЛАЙН №34864645-019300.00',0,0,3,0),
  (2223,0,0,NULL,114418.000,3,'','2012-02-03 03:35:59','Зачисление на счет c п/к (по расп. №35206421)',1,0,0,1,'03.02.2012 15:35:5935206421114418.00Зачисление на счет c п/к (по расп. №35206421)123718.00',0,0,3,0),
  (2224,0,0,NULL,20000.000,3,'','2012-02-03 03:36:56','Пополнение п/к (по расп. №35206484)',2,0,0,1,'03.02.2012 15:36:5635206484-20000.00Пополнение п/к (по расп. №35206484)103718.00',0,0,3,0),
  (2225,0,0,NULL,20000.000,3,'','2012-02-03 03:52:26','Пополнение п/к (по расп. №35207361)',2,0,0,1,'03.02.2012 15:52:2635207361-20000.00Пополнение п/к (по расп. №35207361)83718.00',0,0,3,0),
  (2226,0,0,NULL,2000.000,3,'','2012-02-04 11:14:40','Платеж в Систему Яндекс.Деньги (расп. №35254289)',2,0,0,1,'04.02.2012 23:14:4035254289-2000.00Платеж в Систему Яндекс.Деньги (расп. №35254289)81718.00',0,0,3,0),
  (2227,0,0,NULL,30.000,3,'','2012-02-04 11:14:40','Комиссия за операцию. Квитанция №35254289-01',2,0,0,1,'04.02.2012 23:14:4035254289-30.00Комиссия за операцию. Квитанция №35254289-0181688.00',0,0,3,0),
  (2228,0,0,NULL,2000.000,3,'','2012-02-04 11:16:02','Платеж в Систему Яндекс.Деньги (расп. №35254310)',2,0,0,1,'04.02.2012 23:16:0235254310-2000.00Платеж в Систему Яндекс.Деньги (расп. №35254310)79688.00',0,0,3,0),
  (2229,0,0,NULL,30.000,3,'','2012-02-04 11:16:02','Комиссия за операцию. Квитанция №35254310-01',2,0,0,1,'04.02.2012 23:16:0235254310-30.00Комиссия за операцию. Квитанция №35254310-0179658.00',0,0,3,0),
  (2230,0,0,NULL,2000.000,3,'','2012-02-04 11:16:36','Платеж в Систему Яндекс.Деньги (расп. №35254318)',2,0,0,1,'04.02.2012 23:16:3635254318-2000.00Платеж в Систему Яндекс.Деньги (расп. №35254318)77658.00',0,0,3,0),
  (2231,0,0,NULL,30.000,3,'','2012-02-04 11:16:36','Комиссия за операцию. Квитанция №35254318-01',2,0,0,1,'04.02.2012 23:16:3635254318-30.00Комиссия за операцию. Квитанция №35254318-0177628.00',0,0,3,0),
  (2232,0,0,NULL,2000.000,3,'','2012-02-04 11:17:57','Платеж в Систему Яндекс.Деньги (расп. №35254341)',2,0,0,1,'04.02.2012 23:17:5735254341-2000.00Платеж в Систему Яндекс.Деньги (расп. №35254341)75628.00',0,0,3,0),
  (2233,0,0,NULL,30.000,3,'','2012-02-04 11:17:57','Комиссия за операцию. Квитанция №35254341-01',2,0,0,1,'04.02.2012 23:17:5735254341-30.00Комиссия за операцию. Квитанция №35254341-0175598.00',0,0,3,0),
  (2234,0,0,NULL,5000.000,3,'','2012-02-05 09:21:56','Пополнение п/к (по расп. №35258559)',2,0,0,1,'05.02.2012 09:21:5635258559-5000.00Пополнение п/к (по расп. №35258559)70598.00',0,0,3,0),
  (2235,0,0,NULL,300.000,3,'','2012-02-09 08:08:04','Платеж. Квитанция БИ-ЛАЙН №35431133-01',2,0,0,1,'09.02.2012 08:08:0435431133-300.00Платеж. Квитанция БИ-ЛАЙН №35431133-0170298.00',0,0,3,0),
  (2236,0,0,NULL,218000.000,3,'','2012-02-10 03:13:21','Зачисление на счет c п/к (по расп. №35504249)',1,0,0,1,'10.02.2012 15:13:2135504249218000.00Зачисление на счет c п/к (по расп. №35504249)288298.00',0,0,3,0),
  (2237,0,0,NULL,191000.000,3,'','2012-02-10 03:14:38','Пополнение п/к (по расп. №35504335)',2,0,0,1,'10.02.2012 15:14:3835504335-191000.00Пополнение п/к (по расп. №35504335)97298.00',0,0,3,0),
  (2238,0,0,NULL,60000.000,3,'','2012-02-11 10:04:22','Зачисление на счет c п/к (по расп. №35531791)',1,0,0,1,'11.02.2012 10:04:223553179160000.00Зачисление на счет c п/к (по расп. №35531791)157298.00',0,0,3,0),
  (2239,0,0,NULL,300.000,3,'','2012-02-12 11:39:14','Платеж. Квитанция БИ-ЛАЙН №35565365-01',2,0,0,1,'12.02.2012 11:39:1435565365-300.00Платеж. Квитанция БИ-ЛАЙН №35565365-01156998.00',0,0,3,0),
  (2240,0,0,NULL,20000.000,3,'','2012-02-13 11:37:26','Пополнение п/к (по расп. №35600771)',2,0,0,1,'13.02.2012 11:37:2635600771-20000.00Пополнение п/к (по расп. №35600771)136998.00',0,0,3,0),
  (2241,0,0,NULL,100000.000,3,'','2012-02-13 02:22:50','Пополнение п/к (по расп. №35611072)',2,0,0,1,'13.02.2012 14:22:5035611072-100000.00Пополнение п/к (по расп. №35611072)36998.00',0,0,3,0),
  (2242,0,0,NULL,30000.000,3,'','2012-02-14 12:44:47','Зачисление на счет c п/к (по расп. №35656537)',1,0,0,1,'14.02.2012 12:44:473565653730000.00Зачисление на счет c п/к (по расп. №35656537)66998.00',0,0,3,0),
  (2243,0,0,NULL,60700.000,3,'','2012-02-14 12:46:43','Конверсия из RUR в USD по курсу 30.35',2,0,0,1,'14.02.2012 12:46:4335656661-60700.00Конверсия из RUR в USD по курсу 30.356298.00',0,0,3,0),
  (2244,0,0,NULL,100000.000,3,'','2012-02-15 03:53:08','Зачисление на счет c п/к (по расп. №35720204)',1,0,0,1,'15.02.2012 15:53:0835720204100000.00Зачисление на счет c п/к (по расп. №35720204)106298.00',0,0,3,0),
  (2245,0,0,NULL,30000.000,3,'','2012-02-16 08:04:13','Пополнение п/к (по расп. №35752537)',2,0,0,1,'16.02.2012 08:04:1335752537-30000.00Пополнение п/к (по расп. №35752537)76298.00',0,0,3,0),
  (2246,0,0,NULL,100.000,3,'','2012-02-17 01:57:04','Платеж. Квитанция БИ-ЛАЙН №35829962-01',2,0,0,1,'17.02.2012 13:57:0435829962-100.00Платеж. Квитанция БИ-ЛАЙН №35829962-0176198.00',0,0,3,0),
  (2247,0,0,NULL,2000.000,3,'','2012-02-17 02:02:54','Платеж. Квитанция БИ-ЛАЙН №35830307-01',2,0,0,1,'17.02.2012 14:02:5435830307-2000.00Платеж. Квитанция БИ-ЛАЙН №35830307-0174198.00',0,0,3,0),
  (2248,0,0,NULL,100.000,3,'','2012-02-17 04:18:55','Платеж (п/п №679). Счет получателя 40817810205770596458. Частный перевод , НДС не облагается',2,0,0,1,'17.02.2012 16:18:5535838679-100.00Платеж (п/п №679). Счет получателя 40817810205770596458. Частный перевод , НДС не облагается74098.00',0,0,3,0),
  (2249,0,0,NULL,15.000,3,'','2012-02-17 04:18:55','Комиссия за операцию (п/п №679)',2,0,0,1,'17.02.2012 16:18:5535838679-15.00Комиссия за операцию (п/п №679)74083.00',0,0,3,0),
  (2250,0,0,NULL,1000.000,3,'','2012-02-29 12:35:25','Платеж в Систему Яндекс.Деньги (расп. №36370316)',2,0,0,1,'29.02.2012 12:35:2536370316-1000.00Платеж в Систему Яндекс.Деньги (расп. №36370316)73083.00',0,0,3,0),
  (2251,0,0,NULL,15.000,3,'','2012-02-29 12:35:25','Комиссия за операцию. Квитанция №36370316-01',2,0,0,1,'29.02.2012 12:35:2536370316-15.00Комиссия за операцию. Квитанция №36370316-0173068.00',0,0,3,0),
  (2252,0,0,NULL,15000.000,3,'','2012-03-05 09:07:27','Пополнение п/к (по расп. №36607232)',2,0,0,1,'05.03.2012 09:07:2736607232-15000.00Пополнение п/к (по расп. №36607232)58068.00',0,0,3,0),
  (2253,0,0,NULL,44400.000,3,'','2012-03-06 07:25:48','Конверсия из RUR в USD по курсу 29.6',2,0,0,1,'06.03.2012 07:25:4836658861-44400.00Конверсия из RUR в USD по курсу 29.613668.00',0,0,3,0),
  (2254,0,0,NULL,5000.000,3,'','2012-03-06 07:27:42','Зачисление на счет c п/к (по расп. №36658899)',1,0,0,1,'06.03.2012 07:27:42366588995000.00Зачисление на счет c п/к (по расп. №36658899)18668.00',0,0,3,0),
  (2255,0,0,NULL,10000.000,3,'','2012-03-06 07:32:31','Пополнение п/к (по расп. №36659006)',2,0,0,1,'06.03.2012 07:32:3136659006-10000.00Пополнение п/к (по расп. №36659006)8668.00',0,0,3,0),
  (2256,0,0,NULL,300000.000,3,'','2012-03-06 08:16:21','Зачисление на счет c п/к (по расп. №36700547)',1,0,0,1,'06.03.2012 20:16:2136700547300000.00Зачисление на счет c п/к (по расп. №36700547)308668.00',0,0,3,0),
  (2257,0,0,NULL,150000.000,3,'','2012-03-07 08:30:30','Пополнение п/к (по расп. №36715937)',2,0,0,1,'07.03.2012 08:30:3036715937-150000.00Пополнение п/к (по расп. №36715937)158668.00',0,0,3,0),
  (2258,0,0,NULL,2000.000,3,'','2012-03-07 02:49:30','Платеж в Систему Яндекс.Деньги (расп. №36739624)',2,0,0,1,'07.03.2012 14:49:3036739624-2000.00Платеж в Систему Яндекс.Деньги (расп. №36739624)156668.00',0,0,3,0),
  (2259,0,0,NULL,30.000,3,'','2012-03-07 02:49:30','Комиссия за операцию. Квитанция №36739624-01',2,0,0,1,'07.03.2012 14:49:3036739624-30.00Комиссия за операцию. Квитанция №36739624-01156638.00',0,0,3,0),
  (2260,0,0,NULL,60000.000,3,'','2012-03-11 06:41:13','Пополнение п/к (по расп. №36853101)',2,0,0,1,'11.03.2012 06:41:1336853101-60000.00Пополнение п/к (по расп. №36853101)96638.00',0,0,3,0),
  (2261,0,0,NULL,80000.000,3,'','2012-03-12 06:59:49','Пополнение п/к (по расп. №36906690)',2,0,0,1,'12.03.2012 06:59:4936906690-80000.00Пополнение п/к (по расп. №36906690)16638.00',0,0,3,0),
  (2262,0,0,NULL,200.000,3,'','2012-03-12 07:05:53','Оплата СМС сообщений',2,0,0,1,'12.03.2012 07:05:5336906982-200.00Оплата СМС сообщений16438.00',0,0,3,0),
  (2263,0,0,NULL,16000.000,3,'','2012-03-22 08:30:04','Пополнение п/к (по расп. №37417845)',2,0,0,1,'22.03.2012 08:30:0437417845-16000.00Пополнение п/к (по расп. №37417845)438.00',0,0,3,0),
  (2264,0,0,NULL,15000.000,3,'','2012-03-22 08:32:35','Конверсия из USD в RUR по курсу 28.9',1,0,0,1,'22.03.2012 08:32:353741793915000.00Конверсия из USD в RUR по курсу 28.915438.00',0,0,3,0),
  (2265,0,0,NULL,15000.000,3,'','2012-03-22 08:33:15','Пополнение п/к (по расп. №37417967)',2,0,0,1,'22.03.2012 08:33:1537417967-15000.00Пополнение п/к (по расп. №37417967)438.00',0,0,3,0),
  (2266,0,0,NULL,340.000,3,'','2012-03-23 08:19:11','Зачисление на счет c п/к (по расп. №37469827)',1,0,0,1,'23.03.2012 08:19:1137469827340.00Зачисление на счет c п/к (по расп. №37469827)778.00',0,0,3,0),
  (2267,0,0,NULL,500.000,3,'','2012-03-23 08:20:18','Платеж. Квитанция БИ-ЛАЙН №37469864-01',2,0,0,1,'23.03.2012 08:20:1837469864-500.00Платеж. Квитанция БИ-ЛАЙН №37469864-01278.00',0,0,3,0),
  (2268,0,0,NULL,278.000,3,'','2012-03-25 09:11:56','Пополнение п/к (по расп. №37568884)',2,0,0,1,'25.03.2012 21:11:5637568884-278.00Пополнение п/к (по расп. №37568884)0.00',0,0,3,0),
  (2269,0,0,NULL,250000.000,3,'','2012-03-28 05:37:15','Зачисление на счет c п/к (по расп. №37711630)',1,0,0,1,'28.03.2012 17:37:1537711630250000.00Зачисление на счет c п/к (по расп. №37711630)250000.00',0,0,3,0),
  (2270,0,0,NULL,300.000,3,'','2012-03-28 05:37:50','Плата за обслуживание на 360 дней',2,0,0,1,'28.03.2012 17:37:5037711652-300.00Плата за обслуживание на 360 дней249700.00',0,0,3,0),
  (2271,0,0,NULL,230000.000,3,'','2012-03-28 05:38:21','Пополнение п/к (по расп. №37711679)',2,0,0,1,'28.03.2012 17:38:2137711679-230000.00Пополнение п/к (по расп. №37711679)19700.00',0,0,3,0),
  (2272,0,0,NULL,19000.000,3,'','2012-03-29 09:16:41','Пополнение п/к (по расп. №37732989)',2,0,0,1,'29.03.2012 09:16:4137732989-19000.00Пополнение п/к (по расп. №37732989)700.00',0,0,3,0),
  (2273,0,0,NULL,15000.000,3,'','2012-03-29 03:13:38','Зачисление на счет c п/к (по расп. №37753062)',1,0,0,1,'29.03.2012 15:13:383775306215000.00Зачисление на счет c п/к (по расп. №37753062)15700.00',0,0,3,0),
  (2274,0,0,NULL,15000.000,3,'','2012-03-29 03:14:02','Пополнение п/к (по расп. №37753079)',2,0,0,1,'29.03.2012 15:14:0237753079-15000.00Пополнение п/к (по расп. №37753079)700.00',0,0,3,0),
  (2275,0,0,NULL,300.000,3,'','2012-04-01 03:19:58','Платеж. Квитанция БИ-ЛАЙН №37899264-01',2,0,0,1,'01.04.2012 15:19:5837899264-300.00Платеж. Квитанция БИ-ЛАЙН №37899264-01400.00',0,0,3,0),
  (2276,0,0,NULL,400.000,3,'','2012-04-01 03:21:16','Платеж. Квитанция БИ-ЛАЙН №37899315-01',2,0,0,1,'01.04.2012 15:21:1637899315-400.00Платеж. Квитанция БИ-ЛАЙН №37899315-010.00',0,0,3,0),
  (2277,0,0,NULL,2500.000,3,'','2012-04-05 03:58:28','Зачисление на счет c п/к (по расп. №38114664)',1,0,0,1,'05.04.2012 15:58:28381146642500.00Зачисление на счет c п/к (по расп. №38114664)2500.00',0,0,3,0),
  (2278,0,0,NULL,2000.000,3,'','2012-04-05 04:00:02','Платеж в Систему Яндекс.Деньги (расп. №38114756)',2,0,0,1,'05.04.2012 16:00:0238114756-2000.00Платеж в Систему Яндекс.Деньги (расп. №38114756)500.00',0,0,3,0),
  (2279,0,0,NULL,30.000,3,'','2012-04-05 04:00:02','Комиссия за операцию. Квитанция №38114756-01',2,0,0,1,'05.04.2012 16:00:0238114756-30.00Комиссия за операцию. Квитанция №38114756-01470.00',0,0,3,0),
  (2280,0,0,NULL,450.000,3,'','2012-04-10 11:18:23','Платеж. Квитанция БИ-ЛАЙН №38319573-01',2,0,0,1,'10.04.2012 11:18:2338319573-450.00Платеж. Квитанция БИ-ЛАЙН №38319573-0120.00',0,0,3,0),
  (2281,0,0,NULL,350000.000,3,'','2012-04-11 06:35:07','Зачисление на счет c п/к (по расп. №38363296)',1,0,0,1,'11.04.2012 06:35:0738363296350000.00Зачисление на счет c п/к (по расп. №38363296)350020.00',0,0,3,0),
  (2282,0,0,NULL,200000.000,3,'','2012-04-11 06:36:00','Пополнение п/к (по расп. №38363321)',2,0,0,1,'11.04.2012 06:36:0038363321-200000.00Пополнение п/к (по расп. №38363321)150020.00',0,0,3,0),
  (2283,0,0,NULL,300.000,3,'','2012-04-11 06:37:00','Платеж. Квитанция БИ-ЛАЙН №38363333-01',2,0,0,1,'11.04.2012 06:37:0038363333-300.00Платеж. Квитанция БИ-ЛАЙН №38363333-01149720.00',0,0,3,0),
  (2284,0,0,NULL,80000.000,3,'','2012-04-12 11:14:22','Пополнение п/к (по расп. №38428858)',2,0,0,1,'12.04.2012 11:14:2238428858-80000.00Пополнение п/к (по расп. №38428858)69720.00',0,0,3,0),
  (2285,0,0,NULL,10000.000,3,'','2012-04-13 06:35:05','Пополнение п/к (по расп. №38469460)',2,0,0,1,'13.04.2012 06:35:0538469460-10000.00Пополнение п/к (по расп. №38469460)59720.00',0,0,3,0),
  (2286,0,0,NULL,2000.000,3,'','2012-04-16 10:23:00','Платеж в Систему Яндекс.Деньги (расп. №38603975)',2,0,0,1,'16.04.2012 10:23:0038603975-2000.00Платеж в Систему Яндекс.Деньги (расп. №38603975)57720.00',0,0,3,0),
  (2287,0,0,NULL,30.000,3,'','2012-04-16 10:23:00','Комиссия за операцию. Квитанция №38603975-01',2,0,0,1,'16.04.2012 10:23:0038603975-30.00Комиссия за операцию. Квитанция №38603975-0157690.00',0,0,3,0),
  (2288,0,0,NULL,103000.000,3,'','2012-04-20 09:03:56','Зачисление на счет c п/к (по расп. №38823592)',1,0,0,1,'20.04.2012 09:03:5638823592103000.00Зачисление на счет c п/к (по расп. №38823592)160690.00',0,0,3,0),
  (2289,0,0,NULL,500.000,3,'','2012-04-25 08:03:09','Платеж. Квитанция БИ-ЛАЙН №39047447-01',2,0,0,1,'25.04.2012 08:03:0939047447-500.00Платеж. Квитанция БИ-ЛАЙН №39047447-01160190.00',0,0,3,0),
  (2290,0,0,NULL,50000.000,3,'','2012-05-02 06:43:53','Для зачисления на карту 4272290301636205 ГАЛЬЧАНСКАЯ ЕКАТЕРИНА АЛЕКСАНДРОВНА',2,0,0,1,'02.05.2012 06:43:5339367930-50000.00Для зачисления на карту 4272290301636205 ГАЛЬЧАНСКАЯ ЕКАТЕРИНА АЛЕКСАНДРОВНА110190.00',0,0,3,0),
  (2291,0,0,NULL,50.000,3,'','2012-05-02 06:43:53','Комиссия за операцию (распоряжение №39367930)',2,0,0,1,'02.05.2012 06:43:5339367930-50.00Комиссия за операцию (распоряжение №39367930)110140.00',0,0,3,0),
  (2292,0,0,NULL,600.000,3,'','2012-05-02 03:16:32','Платеж. Квитанция БИ-ЛАЙН №39402102-01',2,0,0,1,'02.05.2012 15:16:3239402102-600.00Платеж. Квитанция БИ-ЛАЙН №39402102-01109540.00',0,0,3,0),
  (2293,0,0,NULL,25000.000,3,'','2012-05-03 12:26:59','Пополнение п/к (по расп. №39448263)',2,0,0,1,'03.05.2012 12:26:5939448263-25000.00Пополнение п/к (по расп. №39448263)84540.00',0,0,3,0),
  (2294,0,0,NULL,15000.000,3,'','2012-05-05 02:02:17','Пополнение п/к (по расп. №39567411)',2,0,0,1,'05.05.2012 14:02:1739567411-15000.00Пополнение п/к (по расп. №39567411)69540.00',0,0,3,0),
  (2295,0,0,NULL,15000.000,3,'','2012-05-09 01:02:38','Пополнение п/к (по расп. №39677690)',2,0,0,1,'09.05.2012 13:02:3839677690-15000.00Пополнение п/к (по расп. №39677690)54540.00',0,0,3,0),
  (2296,0,0,NULL,100.000,3,'','2012-05-09 01:04:35','Платеж в RUR за тел.9120671103. Квитанция МТС №39677736-01',2,0,0,1,'09.05.2012 13:04:3539677736-100.00Платеж в RUR за тел.9120671103. Квитанция МТС №39677736-0154440.00',0,0,3,0),
  (2297,0,0,NULL,10000.000,3,'','2012-05-12 02:13:53','Пополнение п/к (по расп. №39837334)',2,0,0,1,'12.05.2012 14:13:5339837334-10000.00Пополнение п/к (по расп. №39837334)44440.00',0,0,3,0),
  (2298,0,0,NULL,250000.000,3,'','2012-05-13 05:33:00','Зачисление на счет c п/к (по расп. №39877266)',1,0,0,1,'13.05.2012 17:33:0039877266250000.00Зачисление на счет c п/к (по расп. №39877266)294440.00',0,0,3,0),
  (2299,0,0,NULL,300.000,3,'','2012-05-13 05:33:47','Платеж. Квитанция БИ-ЛАЙН №39877287-01',2,0,0,1,'13.05.2012 17:33:4739877287-300.00Платеж. Квитанция БИ-ЛАЙН №39877287-01294140.00',0,0,3,0),
  (2300,0,0,NULL,150000.000,3,'','2012-05-13 05:34:22','Пополнение п/к (по расп. №39877296)',2,0,0,1,'13.05.2012 17:34:2239877296-150000.00Пополнение п/к (по расп. №39877296)144140.00',0,0,3,0),
  (2301,0,0,NULL,50000.000,3,'','2012-05-14 04:24:44','Платеж (п/п №904). Счет получателя 40701810700000000538. Масленников Дмитрий Владимирович.Перечисление средств по Договору присоединения 43744/Б/08 от 16.04.2008 НДС не облагается.',2,0,0,1,'14.05.2012 16:24:4439924904-50000.00Платеж (п/п №904). Счет получателя 40701810700000000538. Масленников Дмитрий Владимирович.Перечисление средств по Договору присоединения 43744/Б/08 от 16.04.2008 НДС не облагается.94140.00',0,0,3,0),
  (2302,0,0,NULL,150.000,3,'','2012-05-14 04:24:44','Комиссия за операцию (п/п №904)',2,0,0,1,'14.05.2012 16:24:4439924904-150.00Комиссия за операцию (п/п №904)93990.00',0,0,3,0),
  (2303,0,0,NULL,50000.000,3,'','2012-05-14 04:25:19','Платеж (п/п №955). Счет получателя 40701810700000000538. Масленников Дмитрий Владимирович.Перечисление средств по Договору присоединения 43744/Б/08 от 16.04.2008 НДС не облагается.',2,0,0,1,'14.05.2012 16:25:1939924955-50000.00Платеж (п/п №955). Счет получателя 40701810700000000538. Масленников Дмитрий Владимирович.Перечисление средств по Договору присоединения 43744/Б/08 от 16.04.2008 НДС не облагается.43990.00',0,0,3,0),
  (2304,0,0,NULL,150.000,3,'','2012-05-14 04:25:19','Комиссия за операцию (п/п №955)',2,0,0,1,'14.05.2012 16:25:1939924955-150.00Комиссия за операцию (п/п №955)43840.00',0,0,3,0),
  (2305,0,0,NULL,2000.000,3,'','2012-05-15 01:21:08','Платеж в Систему Яндекс.Деньги (расп. №39973209)',2,0,0,1,'15.05.2012 13:21:0839973209-2000.00Платеж в Систему Яндекс.Деньги (расп. №39973209)41840.00',0,0,3,0),
  (2306,0,0,NULL,30.000,3,'','2012-05-15 01:21:08','Комиссия за операцию. Квитанция №39973209-01',2,0,0,1,'15.05.2012 13:21:0839973209-30.00Комиссия за операцию. Квитанция №39973209-0141810.00',0,0,3,0),
  (2307,0,0,NULL,5000.000,3,'','2012-05-16 08:29:32','Пополнение п/к (по расп. №40019352)',2,0,0,1,'16.05.2012 08:29:3240019352-5000.00Пополнение п/к (по расп. №40019352)36810.00',0,0,3,0),
  (2308,0,0,NULL,20000.000,3,'','2012-05-16 10:45:20','Для зачисления на карту 4272290301636205 ГАЛЬЧАНСКАЯ ЕКАТЕРИНА АЛЕКСАНДРОВНА',2,0,0,1,'16.05.2012 10:45:2040027807-20000.00Для зачисления на карту 4272290301636205 ГАЛЬЧАНСКАЯ ЕКАТЕРИНА АЛЕКСАНДРОВНА16810.00',0,0,3,0),
  (2309,0,0,NULL,20.000,3,'','2012-05-16 10:45:20','Комиссия за операцию (распоряжение №40027807)',2,0,0,1,'16.05.2012 10:45:2040027807-20.00Комиссия за операцию (распоряжение №40027807)16790.00',0,0,3,0),
  (2310,0,0,NULL,5000.000,3,'','2012-05-20 05:21:18','Пополнение п/к (по расп. №40241892)',2,0,0,1,'20.05.2012 17:21:1840241892-5000.00Пополнение п/к (по расп. №40241892)11790.00',0,0,3,0),
  (2311,0,0,NULL,483.990,23,'','2012-03-18 11:00:00','533469******4354: Комиссия за перевод денежных средств договор 95311004  -483.99 RUB',0,0,0,0,'078892012-03-19T00:00:00+0400483.99533469******4354: Комиссия за перевод денежных средств договор 95311004  -483.99 RUB1RUB',0,0,3,0),
  (2312,0,0,NULL,12410.000,23,'','2012-03-18 11:00:00','533469******4354: Перевод денежных средств  -12410 RUB',0,0,0,0,'078892012-03-19T00:00:00+040012410.00533469******4354: Перевод денежных средств  -12410 RUB1RUB',0,0,3,0),
  (2313,0,0,NULL,7500.000,23,'','2012-03-19 11:00:00','BANKOMAT 890051 7982 MOSCOW RUS 533469******4354: Снято наличными (ATM/POS) 18.03.2012 -7500 RUB',0,0,0,0,'078892012-03-20T00:00:00+04007500.00BANKOMAT 890051 7982 MOSCOW RUS 533469******4354: Снято наличными (ATM/POS) 18.03.2012 -7500 RUB1RUB',0,0,3,0),
  (2314,0,0,NULL,292.500,23,'','2012-03-19 11:00:00','533469******4354: Комиссия за снятие наличных договор 95311004 18.03.2012 -292.5 RUB',0,0,0,0,'078892012-03-20T00:00:00+0400292.50533469******4354: Комиссия за снятие наличных договор 95311004 18.03.2012 -292.5 RUB1RUB',0,0,3,0),
  (2315,0,0,NULL,44.000,23,'','2012-03-27 12:00:00','LUKOIL 02130 UFA RUS 533469******4354: Покупка 25.03.2012 -44 RUB',0,0,0,0,'078892012-03-27T00:00:00+040044.00LUKOIL 02130 UFA RUS 533469******4354: Покупка 25.03.2012 -44 RUB1RUB',0,0,3,0),
  (2316,0,0,NULL,572.000,23,'','2012-03-27 12:00:00','LUKOIL 02130 UFA RUS 533469******4354: Покупка 25.03.2012 -572 RUB',0,0,0,0,'078892012-03-27T00:00:00+0400572.00LUKOIL 02130 UFA RUS 533469******4354: Покупка 25.03.2012 -572 RUB1RUB',0,0,3,0),
  (2317,0,0,NULL,486.200,23,'','2012-03-27 12:00:00','LUKOIL 02130 UFA RUS 533469******4354: Покупка 24.03.2012 -486.2 RUB',0,0,0,0,'078892012-03-27T00:00:00+0400486.20LUKOIL 02130 UFA RUS 533469******4354: Покупка 24.03.2012 -486.2 RUB1RUB',0,0,3,0),
  (2318,0,0,NULL,3000.000,23,'','2012-04-01 12:00:00','533469******4354: Плата за выпуск и обслуживание основной карты договор 95311004 31.03.2012 -3000 RUB',0,0,0,0,'078892012-04-01T00:00:00+04003000.00533469******4354: Плата за выпуск и обслуживание основной карты договор 95311004 31.03.2012 -3000 RUB1RUB',0,0,3,0),
  (2319,0,0,NULL,550.820,23,'','2012-04-13 12:00:00','533469******4354: Уплата процентов  -550.82 RUB',0,0,0,3,'078892012-04-13T00:00:00+0400550.82533469******4354: Уплата процентов  -550.82 RUB1USD',0,0,3,0),
  (2320,0,0,NULL,1000.000,21,NULL,'2012-06-29 16:40:10',NULL,12,1,NULL,1,NULL,0,1,NULL,0),
  (2321,0,0,NULL,1000.000,1,NULL,'2012-06-29 16:40:10',NULL,11,0,NULL,1,NULL,0,21,NULL,0),
  (2322,0,0,NULL,-2000.000,21,NULL,'2012-07-10 02:56:24',NULL,16,1,0,1,NULL,0,NULL,NULL,0),
  (2323,0,0,NULL,2000.000,21,NULL,'2012-07-10 03:03:24',NULL,16,0,0,1,NULL,0,NULL,NULL,0),
  (2324,0,0,NULL,2000.000,21,NULL,'2012-07-10 03:04:37',NULL,16,0,0,1,NULL,0,NULL,NULL,0),
  (2325,0,0,NULL,1000.000,21,NULL,'2012-07-10 03:05:52',NULL,16,0,0,1,NULL,0,NULL,3,0),
  (2326,0,0,NULL,10.000,21,NULL,'2012-07-10 03:07:11',NULL,16,0,0,1,NULL,0,NULL,3,0),
  (2327,0,0,NULL,10.000,21,NULL,'2012-07-10 03:07:11',NULL,16,0,627,1,NULL,0,NULL,3,0),
  (2328,0,0,NULL,10.000,21,NULL,'2012-07-10 03:07:11',NULL,16,0,627,1,NULL,0,NULL,3,0),
  (2329,0,0,NULL,10.000,21,NULL,'2012-07-10 03:07:11',NULL,16,0,627,1,NULL,0,NULL,3,0),
  (2330,0,0,NULL,10.000,21,NULL,'2012-07-10 03:07:11',NULL,16,0,627,1,NULL,0,NULL,3,0),
  (2331,0,0,NULL,10.000,21,NULL,'2012-07-10 03:07:11',NULL,16,0,627,1,NULL,0,NULL,3,0),
  (2332,0,0,NULL,10.000,21,NULL,'2012-07-10 03:07:11',NULL,16,0,627,1,NULL,0,NULL,3,0),
  (2333,0,0,NULL,10.000,21,NULL,'2012-07-10 03:07:11',NULL,16,0,627,1,NULL,0,NULL,3,0),
  (2334,0,0,NULL,10.000,21,NULL,'2012-07-10 03:07:11',NULL,16,0,627,1,NULL,0,NULL,3,0),
  (2335,0,0,NULL,10.000,21,NULL,'2012-07-10 03:07:11',NULL,16,0,627,1,NULL,0,NULL,3,0),
  (2336,0,0,NULL,10.000,21,NULL,'2012-07-10 03:07:11',NULL,16,0,627,1,NULL,0,NULL,3,0);
COMMIT;

#
# Data for the `images` table  (LIMIT -473,500)
#

INSERT INTO `images` (`image_id`, `image_path`, `image_caption`) VALUES 
  (1,'images/cats/big/1_Housing.png',NULL),
  (2,'images/cats/small/1_Housing.png',NULL),
  (3,'images/cats/big/2_Utilities.png',NULL),
  (4,'images/cats/small/2_Utilities.png',NULL),
  (5,'images/cats/big/3_Insurance.png',NULL),
  (6,'images/cats/small/3_Insurance.png',NULL),
  (7,'images/cats/big/4_Food.png',NULL),
  (8,'images/cats/small/4_Food.png',NULL),
  (9,'images/cats/big/5_Entertainments.png',NULL),
  (10,'images/cats/small/5_Entertainments.png',NULL),
  (11,'images/cats/big/6_Family.png',NULL),
  (12,'images/cats/small/6_Family.png',NULL),
  (13,'images/cats/big/7_Gifts.png',NULL),
  (14,'images/cats/small/7_Gifts.png',NULL),
  (15,'images/cats/big/8_Economy.png',NULL),
  (16,'images/cats/small/8_Economy.png',NULL),
  (17,'images/cats/big/9_PrivateCharges.png',NULL),
  (18,'images/cats/small/9_PrivateCharges.png',NULL),
  (19,'images/cats/big/10_Transport.png',NULL),
  (20,'images/cats/small/10_Transport.png',NULL),
  (21,'images/cats/big/11_Savings.png',NULL),
  (22,'images/cats/small/11_Savings.png',NULL),
  (23,'images/cats/big/12_Different.png',NULL),
  (24,'images/cats/small/12_Different.png',NULL),
  (25,'images/cats/big/13_Taxes.png',NULL),
  (26,'images/cats/small/13_Taxes.png',NULL);
COMMIT;

#
# Data for the `invite` table  (LIMIT -498,500)
#

INSERT INTO `invite` (`name`, `email`) VALUES 
  ('stas','psdevelop@yandex.ru');
COMMIT;

#
# Data for the `optype_dictionary` table  (LIMIT -483,500)
#

INSERT INTO `optype_dictionary` (`optype_id`, `optype_name`, `account_type`, `closed`) VALUES 
  (1,'Приход',1,0),
  (2,'Расход',0,0),
  (3,'Запланированный расход',2,0),
  (4,'Расход по плану',0,0),
  (5,'Запланированное погашение',3,0),
  (6,'Погашение по плану',0,0),
  (7,'Запланированный доход',4,0),
  (8,'Доход по плану',1,0),
  (9,'Запланированный возврат',5,0),
  (10,'Возврат по плану',1,0),
  (11,'Внутренний перевод',0,0),
  (12,'Внутреннее поступление',1,0),
  (13,'Планируемая цель',6,0),
  (14,'Целевой расход',0,0),
  (15,'Корректировка-расход',0,0),
  (16,'Корректировка-пополнение',1,0);
COMMIT;

#
# Data for the `payment_systems` table  (LIMIT -498,500)
#

INSERT INTO `payment_systems` (`payment_system_id`, `payment_system_name`, `ps_order_counter`, `ps_custom_name`, `account_merchant_id`) VALUES 
  (1,'ASSIST_PS',8,NULL,'589490');
COMMIT;

#
# Data for the `person_types` table  (LIMIT -490,500)
#

INSERT INTO `person_types` (`id`, `person_type_name`, `closed`) VALUES 
  (1,'Оператор',0),
  (2,'Менеджер',0),
  (4,'Фотограф',0),
  (5,'Ассистент',0),
  (6,'Водитель',0),
  (7,'Курьер',0),
  (8,'Обработчик',0),
  (9,'Логист',0),
  (10,'Менеджер по акциям',0);
COMMIT;

#
# Data for the `persons` table  (LIMIT -491,500)
#

INSERT INTO `persons` (`id`, `code`, `person_type_id`, `first_name`, `last_name`, `sur_name`, `stationare_phones`, `mobile_phones`, `employment_date`, `closed`, `uid`) VALUES 
  (2,'---',1,'Сергей','Зырянов',NULL,'Не заданы','Не заданы','2012-04-17 05:07:02',0,7),
  (7,'---',2,'Дмитрий',NULL,NULL,'Не заданы','Не заданы','2012-04-17 04:59:05',0,7),
  (428,'',0,'psdevelop',NULL,NULL,'Не заданы','Не заданы','2012-04-29 02:45:22',0,0),
  (429,'',0,'psdevelop',NULL,NULL,'Не заданы','Не заданы','2012-04-29 02:51:44',0,0),
  (430,'',0,'psdevelop',NULL,NULL,'Не заданы','Не заданы','2012-04-29 02:56:58',0,0),
  (431,'',0,'psdevelop2',NULL,NULL,'Не заданы','Не заданы','2012-05-24 05:47:39',0,0),
  (432,'',0,'psdevelop23',NULL,NULL,'Не заданы','Не заданы','2012-06-25 00:49:32',0,0),
  (433,'',0,'psdevelop24',NULL,NULL,'Не заданы','Не заданы','2012-06-25 00:50:59',0,0);
COMMIT;

#
# Data for the `plan_dictionary` table  (LIMIT -486,500)
#

INSERT INTO `plan_dictionary` (`plan_id`, `plan_name`, `plan_summ`, `complete_days_count`, `first_payment_date`, `plan_optype_id`, `plan_shedule_id`, `default_purse_id`, `complete_month_count`, `user_id`, `min_payment_summ`, `closed`, `apr`, `extra_payment`, `plan_currency_id`, `target_date`) VALUES 
  (1,'fsdf',100.000,0,NULL,5,0,0,0,30,0.000,0,0.000,0.000,0,NULL),
  (2,'ewrerwrw',222.000,0,'2012-05-09',5,0,0,0,30,0.000,0,0.000,0.000,0,NULL),
  (3,'ewrerwrw',222.000,0,'2012-05-07',5,0,0,10,30,0.000,0,0.000,0.000,0,NULL),
  (4,'пукпукпук',100.000,0,'2012-05-09',5,2,0,5,30,0.000,0,20.000,0.000,0,NULL),
  (5,'аываыва',10000.000,0,NULL,1,1,0,0,30,0.000,0,10.000,0.000,0,NULL),
  (6,'пукпукпук',100.000,0,NULL,5,2,0,0,30,0.000,0,20.000,0.000,0,NULL),
  (7,'пукпукпук',100.000,0,NULL,5,2,0,0,30,0.000,0,20.000,0.000,0,NULL),
  (8,'цацуауца',10000.000,0,'2012-05-30',5,1,0,12,30,0.000,0,40.000,0.000,0,NULL),
  (9,'керкерке',10000.000,0,NULL,13,0,NULL,0,30,0.000,0,0.000,0.000,NULL,'2012-05-30'),
  (10,'пвапвап',10000.000,0,NULL,5,2,21,0,30,0.000,0,0.000,0.000,1,NULL),
  (11,'sdgsdg',400.000,0,NULL,13,0,21,0,30,0.000,0,0.000,0.000,1,'2012-05-31'),
  (12,'kjhkljklj',4000.000,0,NULL,3,0,21,0,30,0.000,0,0.000,0.000,1,'2012-05-31'),
  (13,'likujouguih',7000.000,0,NULL,7,0,21,0,30,0.000,0,0.000,0.000,1,'2012-05-31');
COMMIT;

#
# Data for the `plan_shedules_dictionary` table  (LIMIT -497,500)
#

INSERT INTO `plan_shedules_dictionary` (`shedule_id`, `year_frequency`, `is_periodic`, `shedule_name`, `closed`) VALUES 
  (1,12,0,'Аннуитентный',0),
  (2,12,0,'Дифференцированный',0);
COMMIT;

#
# Data for the `purse_dictionary` table  (LIMIT -484,500)
#

INSERT INTO `purse_dictionary` (`purse_dictionary_id`, `pd_dictionary_id`, `purse_logo_img`, `purse_name`, `closed`, `user_id`, `purse_currency_id`, `purse_ptype_id`) VALUES 
  (1,0,'','Альфа-Банк дебетовая карта',0,30,1,0),
  (2,0,'','ВТБ кредитная карта',0,30,0,0),
  (3,0,'','СБ дебетовая карта',0,30,0,0),
  (4,0,'','СБ сберегательный вклад',1,30,0,0),
  (5,0,'','Банк \"Связной\" кредитная карта',0,30,0,0),
  (16,0,'','Альфа кредитка__',0,30,0,0),
  (17,0,'','бла бла',1,32,0,0),
  (18,0,'','ош9ош9',0,32,0,0),
  (19,0,'','ош9ош947',0,32,0,0),
  (20,0,'','fsfasfasf',1,30,1,0),
  (21,0,'','dwqdd',0,30,1,0),
  (22,0,'','vsdsdv',0,30,1,0),
  (23,0,'','dwqdd',0,30,1,0),
  (24,0,'','ll[p[p[',0,30,1,0),
  (25,0,'','111иваыивыаи',0,30,1,3);
COMMIT;

#
# Data for the `purstype_dictionary` table  (LIMIT -496,500)
#

INSERT INTO `purstype_dictionary` (`purse_type_id`, `closed`, `purse_type_name`) VALUES 
  (1,0,'Банковская карта'),
  (2,0,'Наличные'),
  (3,0,'Электронные деньги');
COMMIT;

#
# Data for the `sessions` table  (LIMIT 1,500)
#

INSERT INTO `sessions` (`id`, `uid`, `username`, `hash`, `expiredate`, `ip`) VALUES 
  (211,0,'operator1','---','2012-04-08 19:41:08','127.0.0.1'),
  (212,0,'operator1','---','2012-04-08 20:07:27','127.0.0.1'),
  (213,0,'operator1','---','2012-04-08 21:28:31','127.0.0.1'),
  (214,0,'operator1','---','2012-04-08 21:29:02','127.0.0.1'),
  (215,0,'operator1','---','2012-04-08 21:32:32','127.0.0.1'),
  (216,0,'operator1','---','2012-04-11 00:21:47','127.0.0.1'),
  (217,0,'operator1','---','2012-04-11 00:22:34','127.0.0.1'),
  (218,0,'operator1','---','2012-04-11 00:23:43','127.0.0.1'),
  (219,0,'operator1','---','2012-04-11 00:23:54','127.0.0.1'),
  (220,0,'operator1','---','2012-04-11 00:27:22','127.0.0.1'),
  (221,0,'operator1','---','2012-04-11 00:27:26','127.0.0.1'),
  (222,0,'operator1','---','2012-04-11 00:27:31','127.0.0.1'),
  (223,0,'operator1','---','2012-04-11 00:27:36','127.0.0.1'),
  (224,0,'operator1','---','2012-04-11 01:01:59','127.0.0.1'),
  (225,0,'operator1','---','2012-04-11 01:02:07','127.0.0.1'),
  (226,0,'operator1','---','2012-04-11 01:02:13','127.0.0.1'),
  (227,0,'operator1','---','2012-04-11 01:02:19','127.0.0.1'),
  (228,0,'operator1','---','2012-04-11 01:02:25','127.0.0.1'),
  (229,0,'operator1','---','2012-04-11 01:10:31','127.0.0.1'),
  (230,0,'operator1','---','2012-04-11 01:11:51','127.0.0.1'),
  (231,0,'operator1','---','2012-04-11 01:12:02','127.0.0.1'),
  (232,0,'operator1','---','2012-04-11 01:12:14','127.0.0.1'),
  (233,0,'operator1','---','2012-04-11 01:12:19','127.0.0.1'),
  (234,0,'operator1','---','2012-04-11 01:12:24','127.0.0.1'),
  (235,0,'operator1','---','2012-04-11 01:14:47','127.0.0.1'),
  (236,0,'operator1','---','2012-04-11 01:15:02','127.0.0.1'),
  (237,0,'operator1','---','2012-04-11 01:17:29','127.0.0.1'),
  (238,0,'operator1','---','2012-04-11 01:18:05','127.0.0.1'),
  (239,0,'operator1','---','2012-04-11 01:18:10','127.0.0.1'),
  (240,0,'operator1','---','2012-04-11 01:18:16','127.0.0.1'),
  (241,0,'operator1','---','2012-04-11 01:18:46','127.0.0.1'),
  (242,0,'operator1','---','2012-04-11 01:18:52','127.0.0.1'),
  (243,0,'operator1','---','2012-04-14 19:24:49','127.0.0.1'),
  (244,0,'operator1','---','2012-04-14 19:24:53','127.0.0.1'),
  (245,0,'operator1','---','2012-04-14 19:25:11','127.0.0.1'),
  (246,0,'operator1','---','2012-04-14 19:25:15','127.0.0.1'),
  (247,0,'operator1','---','2012-04-14 19:25:19','127.0.0.1'),
  (248,0,'operator1','---','2012-04-14 19:28:04','127.0.0.1'),
  (249,0,'operator1','---','2012-04-14 19:38:03','127.0.0.1'),
  (250,0,'operator1','---','2012-04-14 19:38:09','127.0.0.1'),
  (251,0,'operator1','---','2012-04-14 19:38:13','127.0.0.1'),
  (252,0,'operator1','---','2012-04-14 19:40:46','127.0.0.1'),
  (253,0,'operator1','---','2012-04-14 19:40:55','127.0.0.1'),
  (254,0,'operator1','---','2012-04-14 19:41:13','127.0.0.1'),
  (255,0,'operator1','---','2012-04-14 19:42:39','127.0.0.1'),
  (256,0,'operator1','---','2012-04-14 19:44:33','127.0.0.1'),
  (257,0,'operator1','---','2012-04-14 19:45:29','127.0.0.1'),
  (258,0,'operator1','---','2012-04-14 20:54:41','127.0.0.1'),
  (259,0,'operator1','---','2012-04-14 20:54:44','127.0.0.1'),
  (260,0,'operator1','---','2012-04-14 20:54:52','127.0.0.1'),
  (261,0,'operator1','---','2012-04-14 20:59:29','127.0.0.1'),
  (262,0,'operator1','---','2012-04-14 20:59:33','127.0.0.1'),
  (263,0,'operator1','---','2012-04-14 21:00:28','127.0.0.1'),
  (264,0,'operator1','---','2012-04-14 21:03:32','127.0.0.1'),
  (265,0,'operator1','---','2012-04-14 21:04:23','127.0.0.1'),
  (266,0,'operator1','---','2012-04-14 21:10:48','127.0.0.1'),
  (267,0,'operator1','---','2012-04-14 21:10:57','127.0.0.1'),
  (268,0,'operator1','---','2012-04-14 21:11:53','127.0.0.1'),
  (269,0,'operator1','---','2012-04-14 21:12:25','127.0.0.1'),
  (270,0,'operator1','---','2012-04-14 21:13:47','127.0.0.1'),
  (271,0,'operator1','---','2012-04-14 21:13:55','127.0.0.1'),
  (272,0,'operator1','---','2012-04-14 21:19:17','127.0.0.1'),
  (273,0,'operator1','---','2012-04-14 21:28:50','127.0.0.1'),
  (274,0,'operator1','---','2012-04-14 21:29:00','127.0.0.1'),
  (275,0,'operator1','---','2012-04-14 21:37:45','127.0.0.1'),
  (276,0,'operator1','---','2012-04-14 21:37:50','127.0.0.1'),
  (277,0,'operator1','---','2012-04-14 21:48:06','127.0.0.1'),
  (278,0,'operator1','---','2012-04-14 21:50:33','127.0.0.1'),
  (279,0,'operator1','---','2012-04-14 21:57:47','127.0.0.1'),
  (280,0,'operator1','---','2012-04-14 21:57:59','127.0.0.1'),
  (281,0,'operator1','---','2012-04-14 21:58:41','127.0.0.1'),
  (282,0,'operator1','---','2012-04-14 21:59:38','127.0.0.1'),
  (283,0,'operator1','---','2012-04-14 22:00:43','127.0.0.1'),
  (284,0,'operator1','---','2012-04-14 22:00:58','127.0.0.1'),
  (285,0,'operator1','---','2012-04-14 22:11:12','127.0.0.1'),
  (286,0,'operator1','---','2012-04-14 22:11:19','127.0.0.1'),
  (287,0,'operator1','---','2012-04-14 22:11:32','127.0.0.1'),
  (288,0,'operator1','---','2012-04-14 22:11:42','127.0.0.1'),
  (289,0,'operator1','---','2012-04-14 22:11:46','127.0.0.1'),
  (290,0,'operator1','---','2012-04-14 22:16:28','127.0.0.1'),
  (291,0,'operator1','---','2012-04-14 22:24:46','127.0.0.1'),
  (292,0,'operator1','---','2012-04-14 22:24:50','127.0.0.1'),
  (293,0,'operator1','---','2012-04-14 22:26:11','127.0.0.1'),
  (294,0,'operator1','---','2012-04-14 22:26:25','127.0.0.1'),
  (295,0,'operator1','---','2012-04-14 22:28:32','127.0.0.1'),
  (296,0,'operator1','---','2012-04-14 22:37:40','127.0.0.1'),
  (297,0,'operator1','---','2012-04-14 22:37:44','127.0.0.1'),
  (298,0,'operator1','---','2012-04-14 22:55:44','127.0.0.1'),
  (299,0,'operator1','---','2012-04-14 22:56:51','127.0.0.1'),
  (300,0,'operator1','---','2012-04-14 22:56:58','127.0.0.1'),
  (301,0,'operator1','---','2012-04-14 22:58:32','127.0.0.1'),
  (302,0,'operator1','---','2012-04-14 23:02:44','127.0.0.1'),
  (303,0,'operator1','---','2012-04-14 23:02:49','127.0.0.1'),
  (304,0,'operator1','---','2012-04-14 23:03:55','127.0.0.1'),
  (305,0,'operator1','---','2012-04-14 23:04:38','127.0.0.1'),
  (306,0,'operator1','---','2012-04-14 23:05:20','127.0.0.1'),
  (307,0,'operator1','---','2012-04-14 23:07:59','127.0.0.1'),
  (308,0,'operator1','---','2012-04-14 23:12:15','127.0.0.1'),
  (309,0,'operator1','---','2012-04-14 23:12:20','127.0.0.1'),
  (310,0,'operator1','---','2012-04-14 23:21:40','127.0.0.1'),
  (311,0,'operator1','---','2012-04-14 23:21:44','127.0.0.1'),
  (312,0,'operator1','---','2012-04-14 23:29:47','127.0.0.1'),
  (313,0,'operator1','---','2012-04-14 23:29:51','127.0.0.1'),
  (314,0,'operator1','---','2012-04-14 23:30:35','127.0.0.1'),
  (315,0,'operator1','---','2012-04-14 23:32:01','127.0.0.1'),
  (316,0,'operator1','---','2012-04-14 23:33:07','127.0.0.1'),
  (317,0,'operator1','---','2012-04-14 23:33:09','127.0.0.1'),
  (318,0,'operator1','---','2012-04-14 23:33:12','127.0.0.1'),
  (319,0,'operator1','---','2012-04-14 23:35:01','127.0.0.1'),
  (320,0,'operator1','---','2012-04-14 23:35:07','127.0.0.1'),
  (321,0,'operator1','---','2012-04-14 23:37:13','127.0.0.1'),
  (322,0,'operator1','---','2012-04-15 00:29:39','127.0.0.1'),
  (323,0,'operator1','---','2012-04-15 00:29:47','127.0.0.1'),
  (324,0,'operator1','---','2012-04-15 00:34:25','127.0.0.1'),
  (325,0,'operator1','---','2012-04-15 00:34:58','127.0.0.1'),
  (326,0,'operator1','---','2012-04-15 00:35:01','127.0.0.1'),
  (327,0,'operator1','---','2012-04-15 00:36:19','127.0.0.1'),
  (328,0,'operator1','---','2012-04-15 00:42:36','127.0.0.1'),
  (329,0,'operator1','---','2012-04-15 00:42:39','127.0.0.1'),
  (330,0,'operator1','---','2012-04-15 00:44:16','127.0.0.1'),
  (331,0,'operator1','---','2012-04-15 00:44:20','127.0.0.1'),
  (332,0,'operator1','---','2012-04-15 00:44:35','127.0.0.1'),
  (333,0,'operator1','---','2012-04-15 00:44:54','127.0.0.1'),
  (334,0,'operator1','---','2012-04-15 00:50:50','127.0.0.1'),
  (335,0,'operator1','---','2012-04-15 00:51:12','127.0.0.1'),
  (336,0,'operator1','---','2012-04-15 00:52:14','127.0.0.1'),
  (337,0,'operator1','---','2012-04-15 00:52:45','127.0.0.1'),
  (338,0,'operator1','---','2012-04-15 00:53:53','127.0.0.1'),
  (339,0,'operator1','---','2012-04-15 00:53:58','127.0.0.1'),
  (340,0,'operator1','---','2012-04-15 00:54:01','127.0.0.1'),
  (341,0,'operator1','---','2012-04-15 00:54:10','127.0.0.1'),
  (342,0,'operator1','---','2012-04-15 00:55:46','127.0.0.1'),
  (343,0,'operator1','---','2012-04-15 01:03:20','127.0.0.1'),
  (344,0,'operator1','---','2012-04-15 01:05:25','127.0.0.1'),
  (345,0,'operator1','---','2012-04-15 01:05:29','127.0.0.1'),
  (346,0,'operator1','---','2012-04-15 01:07:05','127.0.0.1'),
  (347,0,'operator1','---','2012-04-15 01:09:43','127.0.0.1'),
  (348,0,'operator1','---','2012-04-15 01:09:48','127.0.0.1'),
  (349,0,'operator1','---','2012-04-15 01:10:05','127.0.0.1'),
  (350,0,'operator1','---','2012-04-15 01:10:41','127.0.0.1'),
  (351,0,'operator1','---','2012-04-15 01:10:44','127.0.0.1'),
  (352,0,'operator1','---','2012-04-15 01:11:49','127.0.0.1'),
  (353,0,'operator1','---','2012-04-15 01:14:26','127.0.0.1'),
  (354,0,'operator1','---','2012-04-15 01:15:03','127.0.0.1'),
  (355,0,'operator1','---','2012-04-15 01:15:24','127.0.0.1'),
  (356,0,'operator1','---','2012-04-15 01:16:04','127.0.0.1'),
  (357,0,'operator1','---','2012-04-15 01:16:18','127.0.0.1'),
  (358,0,'operator1','---','2012-04-15 01:16:39','127.0.0.1'),
  (359,0,'operator1','---','2012-04-15 01:18:08','127.0.0.1'),
  (360,0,'operator1','---','2012-04-15 01:18:23','127.0.0.1'),
  (361,0,'operator1','---','2012-04-15 01:18:42','127.0.0.1'),
  (362,0,'operator1','---','2012-04-15 01:26:24','127.0.0.1'),
  (363,0,'operator1','---','2012-04-15 01:27:13','127.0.0.1'),
  (364,0,'operator1','---','2012-04-15 01:27:29','127.0.0.1'),
  (365,0,'operator1','---','2012-04-15 01:27:51','127.0.0.1'),
  (366,0,'operator1','---','2012-04-15 01:39:10','127.0.0.1'),
  (367,0,'operator1','---','2012-04-15 01:39:51','127.0.0.1'),
  (368,0,'operator1','---','2012-04-15 01:41:43','127.0.0.1'),
  (369,0,'operator1','---','2012-04-15 01:53:43','127.0.0.1'),
  (370,0,'operator1','---','2012-04-15 01:54:14','127.0.0.1'),
  (371,0,'operator1','---','2012-04-15 01:56:45','127.0.0.1'),
  (372,0,'operator1','---','2012-04-15 01:57:05','127.0.0.1'),
  (373,0,'operator1','---','2012-04-15 02:00:43','127.0.0.1'),
  (374,0,'operator1','---','2012-04-15 02:03:09','127.0.0.1'),
  (375,0,'operator1','---','2012-04-15 02:03:13','127.0.0.1'),
  (376,0,'operator1','---','2012-04-15 02:08:05','127.0.0.1'),
  (377,0,'operator1','---','2012-04-15 02:08:09','127.0.0.1'),
  (378,0,'operator1','---','2012-04-15 02:08:36','127.0.0.1'),
  (379,0,'operator1','---','2012-04-15 02:10:27','127.0.0.1'),
  (380,0,'operator1','---','2012-04-15 02:10:31','127.0.0.1'),
  (381,0,'operator1','---','2012-04-15 02:11:03','127.0.0.1'),
  (382,0,'operator1','---','2012-04-15 02:11:41','127.0.0.1'),
  (383,0,'operator1','---','2012-04-15 02:11:46','127.0.0.1'),
  (384,0,'operator1','---','2012-04-15 02:14:20','127.0.0.1'),
  (385,0,'operator1','---','2012-04-15 02:14:24','127.0.0.1'),
  (386,0,'operator1','---','2012-04-15 02:14:35','127.0.0.1'),
  (387,0,'operator1','---','2012-04-15 02:15:24','127.0.0.1'),
  (388,0,'operator1','---','2012-04-15 02:29:13','127.0.0.1'),
  (389,0,'operator1','---','2012-04-15 02:29:17','127.0.0.1'),
  (390,0,'operator1','---','2012-04-15 02:29:26','127.0.0.1'),
  (391,0,'operator1','---','2012-04-15 02:29:29','127.0.0.1'),
  (392,0,'operator1','---','2012-04-15 02:30:12','127.0.0.1'),
  (393,0,'operator1','---','2012-04-15 02:32:19','127.0.0.1'),
  (394,0,'operator1','---','2012-04-15 03:26:46','127.0.0.1'),
  (395,0,'operator1','---','2012-04-15 03:27:41','127.0.0.1'),
  (396,0,'operator1','---','2012-04-15 03:31:49','127.0.0.1'),
  (397,0,'operator1','---','2012-04-15 03:54:02','127.0.0.1'),
  (398,0,'operator1','---','2012-04-15 03:54:09','127.0.0.1'),
  (399,0,'operator1','---','2012-04-15 03:54:22','127.0.0.1'),
  (400,0,'operator1','---','2012-04-15 03:54:45','127.0.0.1'),
  (401,0,'operator1','---','2012-04-15 03:55:18','127.0.0.1'),
  (402,0,'operator1','---','2012-04-15 04:04:11','127.0.0.1'),
  (403,0,'operator1','---','2012-04-15 04:04:23','127.0.0.1'),
  (404,0,'operator1','---','2012-04-15 04:06:58','127.0.0.1'),
  (405,0,'operator1','---','2012-04-15 04:07:37','127.0.0.1'),
  (406,0,'operator1','---','2012-04-15 04:08:26','127.0.0.1'),
  (407,0,'operator1','---','2012-04-15 04:10:41','127.0.0.1'),
  (408,0,'operator1','---','2012-04-18 02:57:56','127.0.0.1'),
  (409,0,'operator1','---','2012-04-19 06:56:15','127.0.0.1'),
  (410,0,'operator1','---','2012-04-19 06:59:59','127.0.0.1'),
  (411,0,'operator1','---','2012-04-19 07:12:05','127.0.0.1'),
  (412,0,'operator1','---','2012-04-19 07:12:14','127.0.0.1'),
  (413,0,'operator1','---','2012-04-19 07:15:29','127.0.0.1'),
  (414,0,'operator1','---','2012-04-19 07:25:58','127.0.0.1'),
  (415,0,'operator1','---','2012-04-19 07:28:06','127.0.0.1'),
  (416,0,'operator1','---','2012-04-19 07:29:22','127.0.0.1'),
  (417,0,'operator1','---','2012-04-20 19:31:12','127.0.0.1'),
  (418,0,'operator1','---','2012-04-21 23:33:37','127.0.0.1'),
  (419,0,'operator1','---','2012-04-21 23:34:33','127.0.0.1'),
  (420,0,'operator1','---','2012-04-21 23:40:28','127.0.0.1'),
  (421,0,'operator1','---','2012-04-21 23:41:29','127.0.0.1'),
  (422,0,'operator1','---','2012-04-21 23:43:44','127.0.0.1'),
  (423,0,'operator1','---','2012-04-21 23:47:37','127.0.0.1'),
  (424,0,'operator1','---','2012-04-21 23:49:50','127.0.0.1'),
  (425,0,'operator1','---','2012-04-21 23:50:07','127.0.0.1'),
  (426,0,'operator1','---','2012-04-21 23:54:28','127.0.0.1'),
  (427,0,'operator1','---','2012-04-21 23:58:31','127.0.0.1'),
  (428,0,'operator1','---','2012-04-22 00:00:23','127.0.0.1'),
  (429,0,'operator1','---','2012-04-22 00:01:24','127.0.0.1'),
  (430,0,'operator1','---','2012-04-22 00:03:51','127.0.0.1'),
  (431,0,'operator1','---','2012-04-22 00:10:25','127.0.0.1'),
  (432,0,'operator1','---','2012-04-22 00:10:52','127.0.0.1'),
  (433,0,'operator1','---','2012-04-22 00:25:40','127.0.0.1'),
  (434,0,'operator1','---','2012-04-22 02:05:01','127.0.0.1'),
  (435,0,'operator1','---','2012-04-22 13:18:53','127.0.0.1'),
  (436,0,'operator1','---','2012-04-25 21:15:39','127.0.0.1'),
  (437,0,'operator1','---','2012-04-25 21:15:46','127.0.0.1'),
  (438,0,'operator1','---','2012-04-25 21:19:28','127.0.0.1'),
  (439,0,'operator1','---','2012-04-25 21:21:42','127.0.0.1'),
  (440,0,'operator1','---','2012-04-25 21:32:30','127.0.0.1'),
  (441,0,'operator1','---','2012-04-25 21:42:01','127.0.0.1'),
  (442,0,'operator1','---','2012-04-25 21:43:04','127.0.0.1'),
  (443,0,'operator1','---','2012-04-25 21:43:35','127.0.0.1'),
  (444,0,'operator1','---','2012-04-25 21:48:49','127.0.0.1'),
  (445,0,'operator1','---','2012-04-25 21:50:02','127.0.0.1'),
  (446,0,'operator1','---','2012-04-25 21:52:25','127.0.0.1'),
  (447,0,'operator1','---','2012-04-25 23:36:41','127.0.0.1'),
  (448,0,'operator1','---','2012-04-25 23:49:11','127.0.0.1'),
  (449,0,'operator1','---','2012-04-26 00:07:45','127.0.0.1'),
  (450,0,'operator1','---','2012-04-26 03:04:18','127.0.0.1'),
  (451,0,'operator1','---','2012-04-26 21:10:11','127.0.0.1'),
  (452,0,'operator1','---','2012-04-27 23:54:43','127.0.0.1'),
  (453,0,'operator1','---','2012-04-27 23:55:55','127.0.0.1'),
  (454,0,'operator1','---','2012-04-27 23:57:08','127.0.0.1'),
  (455,0,'operator1','---','2012-04-27 23:58:30','127.0.0.1'),
  (456,0,'operator1','---','2012-04-28 00:00:13','127.0.0.1'),
  (457,0,'operator1','---','2012-04-28 00:01:10','127.0.0.1'),
  (458,0,'operator1','---','2012-04-28 04:29:53','127.0.0.1'),
  (459,0,'operator1','---','2012-04-28 04:34:50','127.0.0.1'),
  (460,0,'operator1','---','2012-04-28 21:09:24','127.0.0.1'),
  (461,0,'psdevelop','---','2012-04-29 02:45:47','127.0.0.1'),
  (462,0,'psdevelop2','---','2012-04-29 02:52:05','127.0.0.1'),
  (463,0,'psdevelop3','---','2012-04-29 02:57:15','127.0.0.1'),
  (464,0,'psdevelop','---','2012-04-29 15:39:45','127.0.0.1'),
  (465,0,'psdevelop','---','2012-04-29 15:41:07','127.0.0.1'),
  (466,0,'psdevelop','---','2012-04-29 15:42:10','127.0.0.1'),
  (467,0,'psdevelop','---','2012-04-29 15:46:20','127.0.0.1'),
  (468,0,'psdevelop','---','2012-04-29 15:47:47','127.0.0.1'),
  (469,0,'psdevelop','---','2012-04-29 15:49:12','127.0.0.1'),
  (470,0,'psdevelop','---','2012-04-29 15:52:07','127.0.0.1'),
  (471,0,'psdevelop','---','2012-04-29 15:52:49','127.0.0.1'),
  (472,0,'psdevelop','---','2012-04-29 15:53:57','127.0.0.1'),
  (473,0,'psdevelop','---','2012-04-29 15:54:15','127.0.0.1'),
  (474,0,'psdevelop','---','2012-04-29 15:55:42','127.0.0.1'),
  (475,0,'psdevelop','---','2012-04-29 15:56:41','127.0.0.1'),
  (476,0,'psdevelop','---','2012-04-29 15:57:27','127.0.0.1'),
  (477,0,'psdevelop','---','2012-04-29 15:57:51','127.0.0.1'),
  (478,0,'psdevelop','---','2012-04-29 16:00:26','127.0.0.1'),
  (479,0,'psdevelop','---','2012-04-29 16:01:16','127.0.0.1'),
  (480,0,'psdevelop','---','2012-04-29 16:01:58','127.0.0.1'),
  (481,0,'psdevelop','---','2012-04-29 16:03:09','127.0.0.1'),
  (482,0,'psdevelop','---','2012-04-29 16:04:21','127.0.0.1'),
  (483,0,'psdevelop','---','2012-04-29 16:04:42','127.0.0.1'),
  (484,0,'psdevelop','---','2012-04-29 16:05:22','127.0.0.1'),
  (485,0,'psdevelop','---','2012-04-29 16:05:37','127.0.0.1'),
  (486,0,'psdevelop','---','2012-04-29 16:05:49','127.0.0.1'),
  (487,0,'psdevelop','---','2012-04-29 16:06:43','127.0.0.1'),
  (488,0,'psdevelop','---','2012-04-29 16:06:46','127.0.0.1'),
  (489,0,'psdevelop','---','2012-04-29 16:09:04','127.0.0.1'),
  (490,0,'psdevelop','---','2012-04-29 16:10:58','127.0.0.1'),
  (491,0,'psdevelop','---','2012-04-29 16:15:37','127.0.0.1'),
  (492,0,'psdevelop','---','2012-04-29 16:16:19','127.0.0.1'),
  (493,0,'psdevelop','---','2012-04-29 16:18:36','127.0.0.1'),
  (494,0,'psdevelop','---','2012-04-29 16:21:05','127.0.0.1'),
  (495,0,'psdevelop','---','2012-04-29 16:22:40','127.0.0.1'),
  (496,0,'psdevelop','---','2012-04-29 16:25:18','127.0.0.1'),
  (497,0,'psdevelop','---','2012-04-29 16:26:48','127.0.0.1'),
  (498,0,'psdevelop','---','2012-04-29 17:11:58','127.0.0.1'),
  (499,0,'psdevelop','---','2012-04-29 17:12:53','127.0.0.1'),
  (500,0,'psdevelop','---','2012-04-29 17:15:21','127.0.0.1'),
  (501,0,'psdevelop','---','2012-04-29 17:17:54','127.0.0.1'),
  (502,0,'psdevelop','---','2012-04-29 17:20:23','127.0.0.1'),
  (503,0,'psdevelop','---','2012-04-29 17:20:49','127.0.0.1'),
  (504,0,'psdevelop','---','2012-04-29 17:21:33','127.0.0.1'),
  (505,0,'psdevelop','---','2012-04-29 17:22:23','127.0.0.1'),
  (506,0,'psdevelop','---','2012-04-29 17:24:56','127.0.0.1'),
  (507,0,'psdevelop','---','2012-04-29 17:25:44','127.0.0.1'),
  (508,0,'psdevelop','---','2012-04-29 17:26:19','127.0.0.1'),
  (509,0,'psdevelop','---','2012-04-29 17:27:20','127.0.0.1'),
  (510,0,'psdevelop','---','2012-04-29 17:27:53','127.0.0.1'),
  (511,0,'psdevelop','---','2012-04-29 17:29:11','127.0.0.1'),
  (512,0,'psdevelop','---','2012-04-29 17:31:18','127.0.0.1'),
  (513,0,'psdevelop','---','2012-04-29 17:33:29','127.0.0.1'),
  (514,0,'psdevelop','---','2012-04-29 17:34:20','127.0.0.1'),
  (515,0,'psdevelop','---','2012-04-29 17:39:30','127.0.0.1'),
  (516,0,'psdevelop','---','2012-04-29 17:46:22','127.0.0.1'),
  (517,0,'psdevelop','---','2012-04-29 18:15:09','127.0.0.1'),
  (518,0,'psdevelop','---','2012-04-30 05:13:49','127.0.0.1'),
  (519,0,'psdevelop','---','2012-04-30 07:18:33','127.0.0.1'),
  (520,0,'psdevelop','---','2012-04-30 21:49:59','127.0.0.1'),
  (521,0,'psdevelop','---','2012-05-01 05:20:17','127.0.0.1'),
  (522,0,'psdevelop','---','2012-05-01 06:22:40','127.0.0.1'),
  (523,0,'psdevelop','---','2012-05-01 06:23:26','127.0.0.1'),
  (524,0,'psdevelop','---','2012-05-01 18:43:52','127.0.0.1'),
  (525,0,'psdevelop','---','2012-05-01 18:44:13','127.0.0.1'),
  (526,0,'psdevelop','---','2012-05-03 08:31:19','127.0.0.1'),
  (527,0,'psdevelop','---','2012-05-03 08:33:24','127.0.0.1'),
  (528,0,'psdevelop3','---','2012-05-03 21:15:00','127.0.0.1'),
  (529,0,'psdevelop','---','2012-05-03 22:12:35','127.0.0.1'),
  (530,0,'psdevelop','---','2012-05-04 04:24:02','127.0.0.1'),
  (531,0,'psdevelop','---','2012-05-04 15:14:52','127.0.0.1'),
  (532,0,'psdevelop','---','2012-05-05 00:18:24','127.0.0.1'),
  (533,0,'psdevelop','---','2012-05-05 19:21:31','127.0.0.1'),
  (534,0,'psdevelop','---','2012-05-06 18:48:20','127.0.0.1'),
  (535,0,'psdevelop','---','2012-05-07 06:32:09','127.0.0.1'),
  (536,0,'psdevelop','---','2012-05-09 02:30:08','127.0.0.1'),
  (537,0,'psdevelop','---','2012-05-09 13:17:43','127.0.0.1'),
  (538,0,'psdevelop','---','2012-05-11 09:58:54','127.0.0.1'),
  (539,0,'psdevelop','---','2012-05-11 09:59:45','127.0.0.1'),
  (540,0,'psdevelop','---','2012-05-11 12:00:22','127.0.0.1'),
  (541,0,'psdevelop','---','2012-05-11 12:05:53','127.0.0.1'),
  (542,0,'psdevelop','---','2012-05-11 12:08:16','127.0.0.1'),
  (543,0,'psdevelop','---','2012-05-11 12:10:59','127.0.0.1'),
  (544,0,'psdevelop','---','2012-05-11 12:11:09','127.0.0.1'),
  (545,0,'psdevelop','---','2012-05-11 12:11:34','127.0.0.1'),
  (546,0,'psdevelop','---','2012-05-11 19:00:57','127.0.0.1'),
  (547,0,'psdevelop','---','2012-05-11 19:05:42','127.0.0.1'),
  (548,0,'psdevelop','---','2012-05-11 21:10:00','192.168.137.11'),
  (549,0,'psdevelop','---','2012-05-11 21:16:04','192.168.137.11'),
  (550,0,'psdevelop','---','2012-05-11 21:19:22','192.168.137.11'),
  (551,0,'psdevelop','---','2012-05-11 21:40:43','192.168.137.11'),
  (552,0,'psdevelop','---','2012-05-13 09:26:45','127.0.0.1'),
  (553,0,'psdevelop','---','2012-05-13 09:26:51','127.0.0.1'),
  (554,0,'psdevelop','---','2012-05-13 11:39:44','127.0.0.1'),
  (555,0,'psdevelop','---','2012-05-14 08:14:38','127.0.0.1'),
  (556,0,'psdevelop','---','2012-05-14 15:53:59','127.0.0.1'),
  (557,0,'psdevelop','---','2012-05-15 15:02:31','127.0.0.1'),
  (558,0,'psdevelop','---','2012-05-16 10:00:06','127.0.0.1'),
  (559,0,'psdevelop','---','2012-05-16 13:10:11','127.0.0.1'),
  (560,0,'psdevelop','---','2012-05-16 13:28:50','127.0.0.1'),
  (561,0,'psdevelop','---','2012-05-16 13:31:07','127.0.0.1'),
  (562,0,'psdevelop','---','2012-05-16 13:33:26','127.0.0.1'),
  (563,0,'psdevelop','---','2012-05-16 13:33:49','127.0.0.1'),
  (564,0,'psdevelop','---','2012-05-16 13:37:21','127.0.0.1'),
  (565,0,'psdevelop','---','2012-05-16 13:52:43','127.0.0.1'),
  (566,0,'psdevelop','---','2012-05-16 13:53:52','127.0.0.1'),
  (567,0,'psdevelop','---','2012-05-17 01:22:09','127.0.0.1'),
  (568,0,'psdevelop','---','2012-05-17 01:26:43','127.0.0.1'),
  (569,0,'psdevelop','---','2012-05-17 01:27:10','127.0.0.1'),
  (570,0,'psdevelop','---','2012-05-17 01:30:20','127.0.0.1'),
  (571,0,'psdevelop','---','2012-05-17 01:30:25','127.0.0.1'),
  (572,0,'psdevelop','---','2012-05-17 01:30:39','127.0.0.1'),
  (573,0,'psdevelop','---','2012-05-17 01:32:06','127.0.0.1'),
  (574,0,'psdevelop','---','2012-05-17 01:33:12','127.0.0.1'),
  (575,0,'psdevelop','---','2012-05-17 01:51:46','127.0.0.1'),
  (576,0,'psdevelop','---','2012-05-17 01:52:41','127.0.0.1'),
  (577,0,'psdevelop','---','2012-05-17 01:53:15','127.0.0.1'),
  (578,0,'psdevelop','---','2012-05-17 01:57:46','127.0.0.1'),
  (579,0,'psdevelop','---','2012-05-17 02:06:50','127.0.0.1'),
  (580,0,'psdevelop','---','2012-05-17 02:08:37','127.0.0.1'),
  (581,0,'psdevelop','---','2012-05-17 02:22:31','127.0.0.1'),
  (582,0,'psdevelop','---','2012-05-17 02:22:38','127.0.0.1'),
  (583,0,'psdevelop','---','2012-05-17 02:26:32','127.0.0.1'),
  (584,0,'psdevelop','---','2012-05-17 02:27:42','127.0.0.1'),
  (585,0,'psdevelop','---','2012-05-17 02:33:11','127.0.0.1'),
  (586,0,'psdevelop','---','2012-05-17 02:34:23','127.0.0.1'),
  (587,0,'psdevelop','---','2012-05-17 02:37:06','127.0.0.1'),
  (588,0,'psdevelop','---','2012-05-17 02:43:50','127.0.0.1'),
  (589,0,'psdevelop','---','2012-05-17 02:48:15','127.0.0.1'),
  (590,0,'psdevelop','---','2012-05-17 02:51:04','127.0.0.1'),
  (591,0,'psdevelop','---','2012-05-17 02:59:16','127.0.0.1'),
  (592,0,'psdevelop','---','2012-05-17 03:01:04','127.0.0.1'),
  (593,0,'psdevelop','---','2012-05-17 10:22:25','127.0.0.1'),
  (594,0,'psdevelop','---','2012-05-17 10:23:25','127.0.0.1'),
  (595,0,'psdevelop','---','2012-05-17 10:29:25','127.0.0.1'),
  (596,0,'psdevelop','---','2012-05-17 10:32:02','127.0.0.1'),
  (597,0,'psdevelop','---','2012-05-17 10:36:34','127.0.0.1'),
  (598,0,'psdevelop','---','2012-05-17 11:06:04','127.0.0.1'),
  (599,0,'psdevelop','---','2012-05-17 11:07:15','127.0.0.1'),
  (600,0,'psdevelop','---','2012-05-17 11:10:57','127.0.0.1'),
  (601,0,'psdevelop','---','2012-05-17 11:16:36','127.0.0.1'),
  (602,0,'psdevelop','---','2012-05-17 11:18:59','127.0.0.1'),
  (603,0,'psdevelop','---','2012-05-17 11:20:17','127.0.0.1'),
  (604,0,'psdevelop','---','2012-05-17 11:22:16','127.0.0.1'),
  (605,0,'psdevelop','---','2012-05-17 11:24:02','127.0.0.1'),
  (606,0,'psdevelop','---','2012-05-17 11:28:08','127.0.0.1'),
  (607,0,'psdevelop','---','2012-05-17 11:33:23','127.0.0.1'),
  (608,0,'psdevelop','---','2012-05-17 11:34:18','127.0.0.1'),
  (609,0,'psdevelop','---','2012-05-17 11:35:48','127.0.0.1'),
  (610,0,'psdevelop','---','2012-05-17 11:37:53','127.0.0.1'),
  (611,0,'psdevelop','---','2012-05-17 11:39:56','127.0.0.1'),
  (612,0,'psdevelop','---','2012-05-17 11:40:32','127.0.0.1'),
  (613,0,'psdevelop','---','2012-05-17 11:43:19','127.0.0.1'),
  (614,0,'psdevelop','---','2012-05-17 11:43:35','127.0.0.1'),
  (615,0,'psdevelop','---','2012-05-17 11:44:21','127.0.0.1'),
  (616,0,'psdevelop','---','2012-05-17 11:49:35','127.0.0.1'),
  (617,0,'psdevelop','---','2012-05-17 11:50:08','127.0.0.1'),
  (618,0,'psdevelop','---','2012-05-17 11:50:46','127.0.0.1'),
  (619,0,'psdevelop','---','2012-05-17 11:51:12','127.0.0.1'),
  (620,0,'psdevelop','---','2012-05-17 11:52:15','127.0.0.1'),
  (621,0,'psdevelop','---','2012-05-17 11:53:41','127.0.0.1'),
  (622,0,'psdevelop','---','2012-05-17 11:54:00','127.0.0.1'),
  (623,0,'psdevelop','---','2012-05-17 11:54:36','127.0.0.1'),
  (624,0,'psdevelop','---','2012-05-17 11:55:29','127.0.0.1'),
  (625,0,'psdevelop','---','2012-05-17 17:42:27','127.0.0.1'),
  (626,0,'psdevelop','---','2012-05-17 17:45:00','127.0.0.1'),
  (627,0,'psdevelop','---','2012-05-17 18:15:06','127.0.0.1'),
  (628,0,'psdevelop','---','2012-05-17 18:15:41','127.0.0.1'),
  (629,0,'psdevelop','---','2012-05-17 18:16:02','127.0.0.1'),
  (630,0,'psdevelop','---','2012-05-17 19:43:40','127.0.0.1'),
  (631,0,'psdevelop','---','2012-05-17 19:57:02','127.0.0.1'),
  (632,0,'psdevelop','---','2012-05-17 20:05:16','127.0.0.1'),
  (633,0,'psdevelop','---','2012-05-17 20:27:06','127.0.0.1'),
  (634,0,'psdevelop','---','2012-05-17 20:28:03','127.0.0.1'),
  (635,0,'psdevelop','---','2012-05-17 20:30:12','127.0.0.1'),
  (636,0,'psdevelop','---','2012-05-17 20:31:44','127.0.0.1'),
  (637,0,'psdevelop','---','2012-05-17 20:32:38','127.0.0.1'),
  (638,0,'psdevelop','---','2012-05-17 20:36:16','127.0.0.1'),
  (639,0,'psdevelop','---','2012-05-17 20:39:15','127.0.0.1'),
  (640,0,'psdevelop','---','2012-05-17 20:42:06','127.0.0.1'),
  (641,0,'psdevelop','---','2012-05-18 01:09:33','127.0.0.1'),
  (642,0,'psdevelop','---','2012-05-18 01:12:02','127.0.0.1'),
  (643,0,'psdevelop','---','2012-05-18 12:53:34','127.0.0.1'),
  (644,0,'psdevelop','---','2012-05-18 12:53:52','127.0.0.1'),
  (645,0,'psdevelop','---','2012-05-18 12:58:34','127.0.0.1'),
  (646,0,'psdevelop','---','2012-05-18 12:59:31','127.0.0.1'),
  (647,0,'psdevelop','---','2012-05-18 13:00:02','127.0.0.1'),
  (648,0,'psdevelop','---','2012-05-18 13:01:11','127.0.0.1'),
  (649,0,'psdevelop','---','2012-05-18 13:01:43','127.0.0.1'),
  (650,0,'psdevelop','---','2012-05-18 13:02:06','127.0.0.1'),
  (651,0,'psdevelop','---','2012-05-18 13:02:40','127.0.0.1'),
  (652,0,'psdevelop','---','2012-05-18 13:07:39','127.0.0.1'),
  (653,0,'psdevelop','---','2012-05-18 13:08:22','127.0.0.1'),
  (654,0,'psdevelop','---','2012-05-18 13:09:14','127.0.0.1'),
  (655,0,'psdevelop','---','2012-05-18 13:11:47','127.0.0.1'),
  (656,0,'psdevelop','---','2012-05-18 13:13:16','127.0.0.1'),
  (657,0,'psdevelop','---','2012-05-18 13:14:05','127.0.0.1'),
  (658,0,'psdevelop','---','2012-05-18 13:45:55','127.0.0.1'),
  (659,0,'psdevelop','---','2012-05-18 14:04:00','127.0.0.1'),
  (660,0,'psdevelop','---','2012-05-18 14:05:05','127.0.0.1'),
  (661,0,'psdevelop','---','2012-05-18 14:14:30','127.0.0.1'),
  (662,0,'psdevelop','---','2012-05-18 14:23:12','127.0.0.1'),
  (663,0,'psdevelop','---','2012-05-18 14:24:12','127.0.0.1'),
  (664,0,'psdevelop','---','2012-05-18 14:24:47','127.0.0.1'),
  (665,0,'psdevelop','---','2012-05-18 14:26:16','127.0.0.1'),
  (666,0,'psdevelop','---','2012-05-18 14:33:03','127.0.0.1'),
  (667,0,'psdevelop','---','2012-05-18 14:33:46','127.0.0.1'),
  (668,0,'psdevelop','---','2012-05-18 14:45:40','127.0.0.1'),
  (669,0,'psdevelop','---','2012-05-18 14:46:36','127.0.0.1'),
  (670,0,'psdevelop','---','2012-05-18 14:48:07','127.0.0.1'),
  (671,0,'psdevelop','---','2012-05-18 14:50:27','127.0.0.1'),
  (672,0,'psdevelop','---','2012-05-18 15:05:14','127.0.0.1'),
  (673,0,'psdevelop','---','2012-05-18 15:06:21','127.0.0.1'),
  (674,0,'psdevelop','---','2012-05-18 17:43:29','127.0.0.1'),
  (675,0,'psdevelop','---','2012-05-18 17:44:48','127.0.0.1'),
  (676,0,'psdevelop','---','2012-05-18 17:49:35','127.0.0.1'),
  (677,0,'psdevelop','---','2012-05-18 17:50:24','127.0.0.1'),
  (678,0,'psdevelop','---','2012-05-18 17:50:59','127.0.0.1'),
  (679,0,'psdevelop','---','2012-05-18 17:51:23','127.0.0.1'),
  (680,0,'psdevelop','---','2012-05-18 17:51:59','127.0.0.1'),
  (681,0,'psdevelop','---','2012-05-18 17:54:11','127.0.0.1'),
  (682,0,'psdevelop','---','2012-05-18 17:54:53','127.0.0.1'),
  (683,0,'psdevelop','---','2012-05-18 18:58:24','127.0.0.1'),
  (684,0,'psdevelop','---','2012-05-18 19:00:24','127.0.0.1'),
  (685,0,'psdevelop','---','2012-05-18 19:02:41','127.0.0.1'),
  (686,0,'psdevelop','---','2012-05-19 11:28:34','127.0.0.1'),
  (687,0,'psdevelop','---','2012-05-19 12:31:46','127.0.0.1'),
  (688,0,'psdevelop','---','2012-05-19 12:33:36','127.0.0.1'),
  (689,0,'psdevelop','---','2012-05-19 12:35:31','127.0.0.1'),
  (690,0,'psdevelop','---','2012-05-19 12:37:10','127.0.0.1'),
  (691,0,'psdevelop','---','2012-05-19 12:45:13','127.0.0.1'),
  (692,0,'psdevelop','---','2012-05-19 12:49:31','127.0.0.1'),
  (693,0,'psdevelop','---','2012-05-19 13:11:49','127.0.0.1'),
  (694,0,'psdevelop','---','2012-05-19 13:13:10','127.0.0.1'),
  (695,0,'psdevelop','---','2012-05-19 13:13:48','127.0.0.1'),
  (696,0,'psdevelop','---','2012-05-19 13:14:14','127.0.0.1'),
  (697,0,'psdevelop','---','2012-05-19 13:14:26','127.0.0.1'),
  (698,0,'psdevelop','---','2012-05-19 13:14:47','127.0.0.1'),
  (699,0,'psdevelop','---','2012-05-19 13:15:26','127.0.0.1'),
  (700,0,'psdevelop','---','2012-05-19 13:21:18','127.0.0.1'),
  (701,0,'psdevelop','---','2012-05-20 02:16:11','127.0.0.1'),
  (702,0,'psdevelop','---','2012-05-20 02:22:59','127.0.0.1'),
  (703,0,'psdevelop','---','2012-05-20 02:24:28','127.0.0.1'),
  (704,0,'psdevelop','---','2012-05-20 02:25:07','127.0.0.1'),
  (705,0,'psdevelop','---','2012-05-20 02:26:24','127.0.0.1'),
  (706,0,'psdevelop','---','2012-05-20 02:26:47','127.0.0.1'),
  (707,0,'psdevelop','---','2012-05-20 02:32:35','127.0.0.1'),
  (708,0,'psdevelop','---','2012-05-20 02:36:51','127.0.0.1'),
  (709,0,'psdevelop','---','2012-05-20 02:38:33','127.0.0.1'),
  (710,0,'psdevelop','---','2012-05-20 02:38:57','127.0.0.1');
COMMIT;

#
# Data for the `sessions` table  (LIMIT 501,500)
#

INSERT INTO `sessions` (`id`, `uid`, `username`, `hash`, `expiredate`, `ip`) VALUES 
  (711,0,'psdevelop','---','2012-05-20 02:39:13','127.0.0.1'),
  (712,0,'psdevelop','---','2012-05-20 02:39:43','127.0.0.1'),
  (713,0,'psdevelop','---','2012-05-20 02:40:22','127.0.0.1'),
  (714,0,'psdevelop','---','2012-05-20 02:40:40','127.0.0.1'),
  (715,0,'psdevelop','---','2012-05-20 02:41:11','127.0.0.1'),
  (716,0,'psdevelop','---','2012-05-20 02:42:10','127.0.0.1'),
  (717,0,'psdevelop','---','2012-05-20 02:43:12','127.0.0.1'),
  (718,0,'psdevelop','---','2012-05-20 02:43:42','127.0.0.1'),
  (719,0,'psdevelop','---','2012-05-20 02:46:05','127.0.0.1'),
  (720,0,'psdevelop','---','2012-05-20 02:47:29','127.0.0.1'),
  (721,0,'psdevelop','---','2012-05-20 02:49:27','127.0.0.1'),
  (722,0,'psdevelop','---','2012-05-20 02:50:32','127.0.0.1'),
  (723,0,'psdevelop','---','2012-05-20 02:51:25','127.0.0.1'),
  (724,0,'psdevelop','---','2012-05-20 02:52:53','127.0.0.1'),
  (725,0,'psdevelop','---','2012-05-20 02:55:59','127.0.0.1'),
  (726,0,'psdevelop','---','2012-05-20 02:59:55','127.0.0.1'),
  (727,0,'psdevelop','---','2012-05-20 03:00:20','127.0.0.1'),
  (728,0,'psdevelop','---','2012-05-20 03:01:00','127.0.0.1'),
  (729,0,'psdevelop','---','2012-05-20 03:02:12','127.0.0.1'),
  (730,0,'psdevelop','---','2012-05-20 03:02:52','127.0.0.1'),
  (731,0,'psdevelop','---','2012-05-20 11:03:39','127.0.0.1'),
  (732,0,'psdevelop','---','2012-05-20 11:11:42','127.0.0.1'),
  (733,0,'psdevelop','---','2012-05-20 11:11:57','127.0.0.1'),
  (734,0,'psdevelop','---','2012-05-20 11:13:17','127.0.0.1'),
  (735,0,'psdevelop','---','2012-05-20 11:13:49','127.0.0.1'),
  (736,0,'psdevelop','---','2012-05-20 11:17:31','127.0.0.1'),
  (737,0,'psdevelop','---','2012-05-20 11:18:27','127.0.0.1'),
  (738,0,'psdevelop','---','2012-05-20 11:20:36','127.0.0.1'),
  (739,0,'psdevelop','---','2012-05-20 11:20:51','127.0.0.1'),
  (740,0,'psdevelop','---','2012-05-20 11:22:04','127.0.0.1'),
  (741,0,'psdevelop','---','2012-05-20 11:24:53','127.0.0.1'),
  (742,0,'psdevelop','---','2012-05-20 11:25:10','127.0.0.1'),
  (743,0,'psdevelop','---','2012-05-20 11:26:22','127.0.0.1'),
  (744,0,'psdevelop','---','2012-05-20 11:26:27','127.0.0.1'),
  (745,0,'psdevelop','---','2012-05-20 11:26:41','127.0.0.1'),
  (746,0,'psdevelop','---','2012-05-20 11:30:38','127.0.0.1'),
  (747,0,'psdevelop','---','2012-05-20 11:31:22','127.0.0.1'),
  (748,0,'psdevelop','---','2012-05-20 11:31:28','127.0.0.1'),
  (749,0,'psdevelop','---','2012-05-20 11:31:57','127.0.0.1'),
  (750,0,'psdevelop','---','2012-05-20 11:33:54','127.0.0.1'),
  (751,0,'psdevelop','---','2012-05-20 11:33:58','127.0.0.1'),
  (752,0,'psdevelop','---','2012-05-20 11:38:38','127.0.0.1'),
  (753,0,'psdevelop','---','2012-05-20 21:49:42','127.0.0.1'),
  (754,0,'psdevelop','---','2012-05-20 22:41:38','127.0.0.1'),
  (755,0,'psdevelop','---','2012-05-20 22:43:01','127.0.0.1'),
  (756,0,'psdevelop','---','2012-05-20 22:43:41','127.0.0.1'),
  (757,0,'psdevelop','---','2012-05-20 22:44:14','127.0.0.1'),
  (758,0,'psdevelop','---','2012-05-20 22:44:29','127.0.0.1'),
  (759,0,'psdevelop','---','2012-05-20 22:44:43','127.0.0.1'),
  (760,0,'psdevelop','---','2012-05-20 22:45:00','127.0.0.1'),
  (761,0,'psdevelop','---','2012-05-20 22:45:14','127.0.0.1'),
  (762,0,'psdevelop','---','2012-05-20 22:46:08','127.0.0.1'),
  (763,0,'psdevelop','---','2012-05-20 22:48:48','127.0.0.1'),
  (764,0,'psdevelop','---','2012-05-20 22:49:11','127.0.0.1'),
  (765,0,'psdevelop','---','2012-05-20 22:49:38','127.0.0.1'),
  (766,0,'psdevelop','---','2012-05-20 22:49:56','127.0.0.1'),
  (767,0,'psdevelop','---','2012-05-20 22:50:36','127.0.0.1'),
  (768,0,'psdevelop','---','2012-05-20 22:52:59','127.0.0.1'),
  (769,0,'psdevelop','---','2012-05-20 22:53:15','127.0.0.1'),
  (770,0,'psdevelop','---','2012-05-20 22:53:51','127.0.0.1'),
  (771,0,'psdevelop','---','2012-05-20 22:54:26','127.0.0.1'),
  (772,0,'psdevelop','---','2012-05-20 23:01:29','127.0.0.1'),
  (773,0,'psdevelop','---','2012-05-20 23:02:28','127.0.0.1'),
  (774,0,'psdevelop','---','2012-05-20 23:04:08','127.0.0.1'),
  (775,0,'psdevelop','---','2012-05-20 23:04:38','127.0.0.1'),
  (776,0,'psdevelop','---','2012-05-20 23:05:17','127.0.0.1'),
  (777,0,'psdevelop','---','2012-05-20 23:07:16','127.0.0.1'),
  (778,0,'psdevelop','---','2012-05-20 23:07:39','127.0.0.1'),
  (779,0,'psdevelop','---','2012-05-20 23:08:17','127.0.0.1'),
  (780,0,'psdevelop','---','2012-05-20 23:08:53','127.0.0.1'),
  (781,0,'psdevelop','---','2012-05-20 23:09:16','127.0.0.1'),
  (782,0,'psdevelop','---','2012-05-20 23:11:30','127.0.0.1'),
  (783,0,'psdevelop','---','2012-05-20 23:12:34','127.0.0.1'),
  (784,0,'psdevelop','---','2012-05-20 23:15:19','127.0.0.1'),
  (785,0,'psdevelop','---','2012-05-20 23:15:30','127.0.0.1'),
  (786,0,'psdevelop','---','2012-05-20 23:17:39','127.0.0.1'),
  (787,0,'psdevelop','---','2012-05-20 23:19:59','127.0.0.1'),
  (788,0,'psdevelop','---','2012-05-20 23:23:01','127.0.0.1'),
  (789,0,'psdevelop','---','2012-05-20 23:24:23','127.0.0.1'),
  (790,0,'psdevelop','---','2012-05-20 23:26:09','127.0.0.1'),
  (791,0,'psdevelop','---','2012-05-20 23:26:47','127.0.0.1'),
  (792,0,'psdevelop','---','2012-05-20 23:27:16','127.0.0.1'),
  (793,0,'psdevelop','---','2012-05-20 23:28:22','127.0.0.1'),
  (794,0,'psdevelop','---','2012-05-20 23:28:42','127.0.0.1'),
  (795,0,'psdevelop','---','2012-05-20 23:28:57','127.0.0.1'),
  (796,0,'psdevelop','---','2012-05-20 23:32:46','127.0.0.1'),
  (797,0,'psdevelop','---','2012-05-20 23:33:45','127.0.0.1'),
  (798,0,'psdevelop','---','2012-05-20 23:34:07','127.0.0.1'),
  (799,0,'psdevelop','---','2012-05-20 23:35:48','127.0.0.1'),
  (800,0,'psdevelop','---','2012-05-20 23:36:47','127.0.0.1'),
  (801,0,'psdevelop','---','2012-05-21 21:45:47','127.0.0.1'),
  (802,0,'psdevelop','---','2012-05-21 22:00:20','127.0.0.1'),
  (803,0,'psdevelop','---','2012-05-21 22:01:11','127.0.0.1'),
  (804,0,'psdevelop','---','2012-05-21 22:14:11','127.0.0.1'),
  (805,0,'psdevelop','---','2012-05-21 22:27:16','127.0.0.1'),
  (806,0,'psdevelop','---','2012-05-21 22:27:49','127.0.0.1'),
  (807,0,'psdevelop','---','2012-05-21 22:30:40','127.0.0.1'),
  (808,0,'psdevelop','---','2012-05-21 22:31:01','127.0.0.1'),
  (809,0,'psdevelop','---','2012-05-22 00:02:32','127.0.0.1'),
  (810,0,'psdevelop','---','2012-05-22 00:04:00','127.0.0.1'),
  (811,0,'psdevelop','---','2012-05-22 00:04:44','127.0.0.1'),
  (812,0,'psdevelop','---','2012-05-22 00:05:36','127.0.0.1'),
  (813,0,'psdevelop','---','2012-05-22 00:07:02','127.0.0.1'),
  (814,0,'psdevelop','---','2012-05-22 00:08:03','127.0.0.1'),
  (815,0,'psdevelop','---','2012-05-22 00:09:16','127.0.0.1'),
  (816,0,'psdevelop','---','2012-05-22 00:10:11','127.0.0.1'),
  (817,0,'psdevelop','---','2012-05-22 00:10:51','127.0.0.1'),
  (818,0,'psdevelop','---','2012-05-22 00:12:21','127.0.0.1'),
  (819,0,'psdevelop','---','2012-05-22 00:13:16','127.0.0.1'),
  (820,0,'psdevelop','---','2012-05-22 00:16:57','127.0.0.1'),
  (821,0,'psdevelop','---','2012-05-22 00:19:49','127.0.0.1'),
  (822,0,'psdevelop','---','2012-05-22 00:20:27','127.0.0.1'),
  (823,0,'psdevelop','---','2012-05-22 00:24:39','127.0.0.1'),
  (824,0,'psdevelop','---','2012-05-22 00:51:09','127.0.0.1'),
  (825,0,'psdevelop','---','2012-05-22 00:51:28','127.0.0.1'),
  (826,0,'psdevelop','---','2012-05-22 00:54:19','127.0.0.1'),
  (827,0,'psdevelop','---','2012-05-22 00:54:42','127.0.0.1'),
  (828,0,'psdevelop','---','2012-05-22 00:55:25','127.0.0.1'),
  (829,0,'psdevelop','---','2012-05-22 00:56:48','127.0.0.1'),
  (830,0,'psdevelop','---','2012-05-22 00:57:32','127.0.0.1'),
  (831,0,'psdevelop','---','2012-05-22 00:58:56','127.0.0.1'),
  (832,0,'psdevelop','---','2012-05-22 00:59:35','127.0.0.1'),
  (833,0,'psdevelop','---','2012-05-22 00:59:52','127.0.0.1'),
  (834,0,'psdevelop','---','2012-05-22 01:00:24','127.0.0.1'),
  (835,0,'psdevelop','---','2012-05-22 01:03:00','127.0.0.1'),
  (836,0,'psdevelop','---','2012-05-22 01:03:42','127.0.0.1'),
  (837,0,'psdevelop','---','2012-05-22 01:12:57','127.0.0.1'),
  (838,0,'psdevelop','---','2012-05-22 01:13:54','127.0.0.1'),
  (839,0,'psdevelop','---','2012-05-22 01:14:22','127.0.0.1'),
  (840,0,'psdevelop','---','2012-05-22 01:15:01','127.0.0.1'),
  (841,0,'psdevelop','---','2012-05-22 01:16:04','127.0.0.1'),
  (842,0,'psdevelop','---','2012-05-22 01:16:16','127.0.0.1'),
  (843,0,'psdevelop','---','2012-05-22 01:18:05','127.0.0.1'),
  (844,0,'psdevelop','---','2012-05-22 01:23:47','127.0.0.1'),
  (845,0,'psdevelop','---','2012-05-22 01:25:44','127.0.0.1'),
  (846,0,'psdevelop','---','2012-05-22 01:26:46','127.0.0.1'),
  (847,0,'psdevelop','---','2012-05-22 01:27:45','127.0.0.1'),
  (848,0,'psdevelop','---','2012-05-22 01:28:36','127.0.0.1'),
  (849,0,'psdevelop','---','2012-05-22 01:31:54','127.0.0.1'),
  (850,0,'psdevelop','---','2012-05-22 01:33:10','127.0.0.1'),
  (851,0,'psdevelop','---','2012-05-22 01:33:22','127.0.0.1'),
  (852,0,'psdevelop','---','2012-05-22 01:33:32','127.0.0.1'),
  (853,0,'psdevelop','---','2012-05-22 01:36:41','127.0.0.1'),
  (854,0,'psdevelop','---','2012-05-22 04:02:24','127.0.0.1'),
  (855,0,'psdevelop','---','2012-05-22 04:17:31','127.0.0.1'),
  (856,0,'psdevelop','---','2012-05-22 14:58:46','127.0.0.1'),
  (857,0,'psdevelop','---','2012-05-22 15:28:52','127.0.0.1'),
  (858,0,'psdevelop','---','2012-05-22 16:20:41','127.0.0.1'),
  (859,0,'psdevelop','---','2012-05-22 16:27:39','127.0.0.1'),
  (860,0,'psdevelop','---','2012-05-22 16:31:36','127.0.0.1'),
  (861,0,'psdevelop','---','2012-05-22 16:34:39','127.0.0.1'),
  (862,0,'psdevelop','---','2012-05-22 16:36:33','127.0.0.1'),
  (863,0,'psdevelop','---','2012-05-22 16:37:59','127.0.0.1'),
  (864,0,'psdevelop','---','2012-05-22 16:38:32','127.0.0.1'),
  (865,0,'psdevelop','---','2012-05-22 16:39:03','127.0.0.1'),
  (866,0,'psdevelop','---','2012-05-22 16:39:52','127.0.0.1'),
  (867,0,'psdevelop','---','2012-05-22 16:40:10','127.0.0.1'),
  (868,0,'psdevelop','---','2012-05-22 16:40:48','127.0.0.1'),
  (869,0,'psdevelop','---','2012-05-22 16:41:11','127.0.0.1'),
  (870,0,'psdevelop','---','2012-05-22 16:41:20','127.0.0.1'),
  (871,0,'psdevelop','---','2012-05-22 16:41:49','127.0.0.1'),
  (872,0,'psdevelop','---','2012-05-22 16:46:35','127.0.0.1'),
  (873,0,'psdevelop','---','2012-05-22 17:42:21','127.0.0.1'),
  (874,0,'psdevelop','---','2012-05-22 17:43:41','127.0.0.1'),
  (875,0,'psdevelop','---','2012-05-22 17:44:03','127.0.0.1'),
  (876,0,'psdevelop','---','2012-05-22 17:44:38','127.0.0.1'),
  (877,0,'psdevelop','---','2012-05-22 17:44:59','127.0.0.1'),
  (878,0,'psdevelop','---','2012-05-22 17:46:17','127.0.0.1'),
  (879,0,'psdevelop','---','2012-05-22 17:47:53','127.0.0.1'),
  (880,0,'psdevelop','---','2012-05-22 17:51:29','127.0.0.1'),
  (881,0,'psdevelop','---','2012-05-22 17:54:29','127.0.0.1'),
  (882,0,'psdevelop','---','2012-05-22 17:55:31','127.0.0.1'),
  (883,0,'psdevelop','---','2012-05-22 17:58:55','127.0.0.1'),
  (884,0,'psdevelop','---','2012-05-22 17:59:13','127.0.0.1'),
  (885,0,'psdevelop','---','2012-05-22 18:00:20','127.0.0.1'),
  (886,0,'psdevelop','---','2012-05-22 18:01:17','127.0.0.1'),
  (887,0,'psdevelop','---','2012-05-22 18:01:46','127.0.0.1'),
  (888,0,'psdevelop','---','2012-05-22 18:05:15','127.0.0.1'),
  (889,0,'psdevelop','---','2012-05-22 18:06:18','127.0.0.1'),
  (890,0,'psdevelop','---','2012-05-22 18:07:12','127.0.0.1'),
  (891,0,'psdevelop','---','2012-05-22 18:07:51','127.0.0.1'),
  (892,0,'psdevelop','---','2012-05-22 18:08:12','127.0.0.1'),
  (893,0,'psdevelop','---','2012-05-22 18:08:37','127.0.0.1'),
  (894,0,'psdevelop','---','2012-05-22 18:08:51','127.0.0.1'),
  (895,0,'psdevelop','---','2012-05-22 18:09:01','127.0.0.1'),
  (896,0,'psdevelop','---','2012-05-22 18:20:44','127.0.0.1'),
  (897,0,'psdevelop','---','2012-05-22 18:50:03','127.0.0.1'),
  (898,0,'psdevelop','---','2012-05-22 18:50:33','127.0.0.1'),
  (899,0,'psdevelop','---','2012-05-22 19:30:02','127.0.0.1'),
  (900,0,'psdevelop','---','2012-05-22 19:30:26','127.0.0.1'),
  (901,0,'psdevelop','---','2012-05-23 03:39:36','127.0.0.1'),
  (902,0,'psdevelop','---','2012-05-23 03:39:42','127.0.0.1'),
  (903,0,'psdevelop','---','2012-05-23 03:41:43','127.0.0.1'),
  (904,0,'psdevelop','---','2012-05-23 03:42:08','127.0.0.1'),
  (905,0,'psdevelop','---','2012-05-23 12:56:45','127.0.0.1'),
  (906,0,'psdevelop','---','2012-05-24 02:01:56','127.0.0.1'),
  (907,0,'psdevelop','---','2012-05-24 02:02:22','127.0.0.1'),
  (908,0,'psdevelop','---','2012-05-24 02:03:25','127.0.0.1'),
  (909,0,'psdevelop','---','2012-05-24 02:23:08','127.0.0.1'),
  (910,0,'psdevelop','---','2012-05-24 02:24:02','127.0.0.1'),
  (911,0,'psdevelop','---','2012-05-24 02:24:46','127.0.0.1'),
  (912,0,'psdevelop','---','2012-05-24 02:31:10','127.0.0.1'),
  (913,0,'psdevelop','---','2012-05-24 02:35:10','127.0.0.1'),
  (914,0,'psdevelop','---','2012-05-24 02:36:04','127.0.0.1'),
  (915,0,'psdevelop','---','2012-05-24 02:38:07','127.0.0.1'),
  (916,0,'psdevelop','---','2012-05-24 02:39:29','127.0.0.1'),
  (917,0,'psdevelop','---','2012-05-24 02:40:22','127.0.0.1'),
  (918,0,'psdevelop','---','2012-05-24 02:42:43','127.0.0.1'),
  (919,0,'psdevelop','---','2012-05-24 03:01:43','127.0.0.1'),
  (920,0,'psdevelop','---','2012-05-24 03:14:36','127.0.0.1'),
  (921,0,'psdevelop','---','2012-05-24 03:18:50','127.0.0.1'),
  (922,0,'psdevelop','---','2012-05-24 05:00:05','127.0.0.1'),
  (923,0,'psdevelop','---','2012-05-24 05:44:53','127.0.0.1'),
  (924,0,'psdevelop2','---','2012-05-24 05:47:52','127.0.0.1'),
  (925,0,'psdevelop','---','2012-05-24 07:22:35','127.0.0.1'),
  (926,0,'psdevelop','---','2012-05-24 07:52:14','127.0.0.1'),
  (927,0,'psdevelop','---','2012-05-24 07:59:36','127.0.0.1'),
  (928,0,'psdevelop','---','2012-05-24 08:01:41','127.0.0.1'),
  (929,0,'psdevelop','---','2012-05-24 08:02:47','127.0.0.1'),
  (930,0,'psdevelop','---','2012-05-24 08:06:34','127.0.0.1'),
  (931,0,'psdevelop','---','2012-05-24 08:06:41','127.0.0.1'),
  (932,0,'psdevelop','---','2012-05-24 08:06:59','127.0.0.1'),
  (933,0,'psdevelop','---','2012-05-24 08:07:26','127.0.0.1'),
  (934,0,'psdevelop','---','2012-05-24 08:22:56','127.0.0.1'),
  (935,0,'psdevelop','---','2012-05-24 08:27:24','127.0.0.1'),
  (936,0,'psdevelop','---','2012-05-24 08:29:33','127.0.0.1'),
  (937,0,'psdevelop','---','2012-05-24 08:30:08','127.0.0.1'),
  (938,0,'psdevelop','---','2012-05-24 08:33:22','127.0.0.1'),
  (939,0,'psdevelop','---','2012-05-24 08:34:00','127.0.0.1'),
  (940,0,'psdevelop','---','2012-05-24 08:35:24','127.0.0.1'),
  (941,0,'psdevelop','---','2012-05-24 08:35:54','127.0.0.1'),
  (942,0,'psdevelop','---','2012-05-24 08:37:12','127.0.0.1'),
  (943,0,'psdevelop','---','2012-05-24 08:37:31','127.0.0.1'),
  (944,0,'psdevelop','---','2012-05-24 08:44:40','127.0.0.1'),
  (945,0,'psdevelop','---','2012-05-24 08:49:09','127.0.0.1'),
  (946,0,'psdevelop','---','2012-05-24 08:54:25','127.0.0.1'),
  (947,0,'psdevelop','---','2012-05-24 08:55:18','127.0.0.1'),
  (948,0,'psdevelop','---','2012-05-24 13:52:28','127.0.0.1'),
  (949,0,'psdevelop','---','2012-05-24 14:32:00','127.0.0.1'),
  (950,0,'psdevelop','---','2012-05-24 14:32:58','127.0.0.1'),
  (951,0,'psdevelop','---','2012-05-24 14:33:52','127.0.0.1'),
  (952,0,'psdevelop','---','2012-05-24 14:34:04','127.0.0.1'),
  (953,0,'psdevelop','---','2012-05-25 16:27:01','127.0.0.1'),
  (954,0,'psdevelop','---','2012-05-25 16:57:36','127.0.0.1'),
  (955,0,'psdevelop','---','2012-05-25 16:59:14','127.0.0.1'),
  (956,0,'psdevelop','---','2012-05-25 17:00:03','127.0.0.1'),
  (957,0,'psdevelop','---','2012-05-25 17:00:33','127.0.0.1'),
  (958,0,'psdevelop','---','2012-05-25 17:01:18','127.0.0.1'),
  (959,0,'psdevelop','---','2012-05-25 17:13:03','127.0.0.1'),
  (960,0,'psdevelop','---','2012-05-25 17:23:50','127.0.0.1'),
  (961,0,'psdevelop','---','2012-05-25 19:59:27','127.0.0.1'),
  (962,0,'psdevelop','---','2012-05-25 22:46:10','127.0.0.1'),
  (963,0,'psdevelop','---','2012-05-25 22:47:27','127.0.0.1'),
  (964,0,'psdevelop','---','2012-05-25 22:48:05','127.0.0.1'),
  (965,0,'psdevelop','---','2012-05-26 08:38:59','127.0.0.1'),
  (966,0,'psdevelop','---','2012-05-26 13:35:43','127.0.0.1'),
  (967,0,'psdevelop','---','2012-05-26 13:39:25','127.0.0.1'),
  (968,0,'psdevelop','---','2012-05-26 13:40:02','127.0.0.1'),
  (969,0,'psdevelop','---','2012-05-26 14:11:10','127.0.0.1'),
  (970,0,'psdevelop','---','2012-05-26 14:14:25','127.0.0.1'),
  (971,0,'psdevelop','---','2012-05-26 14:16:22','127.0.0.1'),
  (972,0,'psdevelop','---','2012-05-26 14:17:21','127.0.0.1'),
  (973,0,'psdevelop','---','2012-05-26 14:17:40','127.0.0.1'),
  (974,0,'psdevelop','---','2012-05-26 14:21:47','127.0.0.1'),
  (975,0,'psdevelop','---','2012-05-26 14:36:45','127.0.0.1'),
  (976,0,'psdevelop','---','2012-05-26 14:48:17','127.0.0.1'),
  (977,0,'psdevelop','---','2012-05-26 14:48:40','127.0.0.1'),
  (978,0,'psdevelop','---','2012-05-26 14:49:15','127.0.0.1'),
  (979,0,'psdevelop','---','2012-05-26 14:49:33','127.0.0.1'),
  (980,0,'psdevelop','---','2012-05-26 14:50:21','127.0.0.1'),
  (981,0,'psdevelop','---','2012-05-26 14:51:10','127.0.0.1'),
  (982,0,'psdevelop','---','2012-05-26 14:51:52','127.0.0.1'),
  (983,0,'psdevelop','---','2012-05-26 14:52:28','127.0.0.1'),
  (984,0,'psdevelop','---','2012-05-26 14:53:39','127.0.0.1'),
  (985,0,'psdevelop','---','2012-05-26 15:00:47','127.0.0.1'),
  (986,0,'psdevelop','---','2012-05-26 15:01:48','127.0.0.1'),
  (987,0,'psdevelop','---','2012-05-26 15:03:21','127.0.0.1'),
  (988,0,'psdevelop','---','2012-05-26 15:04:05','127.0.0.1'),
  (989,0,'psdevelop','---','2012-05-26 15:06:35','127.0.0.1'),
  (990,0,'psdevelop','---','2012-05-26 15:06:56','127.0.0.1'),
  (991,0,'psdevelop','---','2012-05-26 16:53:27','127.0.0.1'),
  (992,0,'psdevelop','---','2012-05-27 19:39:09','127.0.0.1'),
  (993,0,'psdevelop','---','2012-05-27 19:48:36','127.0.0.1'),
  (994,0,'psdevelop','---','2012-05-27 19:51:52','127.0.0.1'),
  (995,0,'psdevelop','---','2012-05-28 20:27:27','127.0.0.1'),
  (996,0,'psdevelop','---','2012-05-28 22:12:45','127.0.0.1'),
  (997,0,'psdevelop','---','2012-05-28 22:20:29','127.0.0.1'),
  (998,0,'psdevelop','---','2012-05-28 22:23:02','127.0.0.1'),
  (999,0,'psdevelop','---','2012-05-28 22:30:38','127.0.0.1'),
  (1000,0,'psdevelop','---','2012-05-28 22:31:21','127.0.0.1'),
  (1001,0,'psdevelop','---','2012-05-28 22:31:58','127.0.0.1'),
  (1002,0,'psdevelop','---','2012-05-28 22:34:03','127.0.0.1'),
  (1003,0,'psdevelop','---','2012-05-28 22:34:35','127.0.0.1'),
  (1004,0,'psdevelop','---','2012-05-28 22:35:42','127.0.0.1'),
  (1005,0,'psdevelop','---','2012-05-28 22:37:50','127.0.0.1'),
  (1006,0,'psdevelop','---','2012-05-28 22:41:13','127.0.0.1'),
  (1007,0,'psdevelop','---','2012-05-28 23:51:15','127.0.0.1'),
  (1008,0,'psdevelop','---','2012-05-28 23:53:17','127.0.0.1'),
  (1009,0,'psdevelop','---','2012-05-28 23:54:00','127.0.0.1'),
  (1010,0,'psdevelop','---','2012-05-29 00:27:36','127.0.0.1'),
  (1011,0,'psdevelop','---','2012-05-29 00:39:03','127.0.0.1'),
  (1012,0,'psdevelop','---','2012-05-29 15:48:20','127.0.0.1'),
  (1013,0,'psdevelop','---','2012-05-29 15:48:46','127.0.0.1'),
  (1014,0,'psdevelop','---','2012-05-29 20:02:15','127.0.0.1'),
  (1015,0,'psdevelop','---','2012-05-29 20:08:52','127.0.0.1'),
  (1016,0,'psdevelop','---','2012-05-29 20:10:36','127.0.0.1'),
  (1017,0,'psdevelop','---','2012-05-29 20:19:06','127.0.0.1'),
  (1018,0,'psdevelop','---','2012-05-29 20:19:57','127.0.0.1'),
  (1019,0,'psdevelop','---','2012-05-29 20:27:06','127.0.0.1'),
  (1020,0,'psdevelop','---','2012-05-31 04:46:23','127.0.0.1'),
  (1021,0,'psdevelop','---','2012-05-31 04:49:13','127.0.0.1'),
  (1022,0,'psdevelop','---','2012-05-31 04:53:53','127.0.0.1'),
  (1023,0,'psdevelop','---','2012-05-31 18:35:22','127.0.0.1'),
  (1024,0,'psdevelop','---','2012-05-31 18:36:25','127.0.0.1'),
  (1025,0,'psdevelop','---','2012-05-31 18:38:06','127.0.0.1'),
  (1026,0,'psdevelop','---','2012-06-02 01:02:55','127.0.0.1'),
  (1027,0,'psdevelop','---','2012-06-02 01:04:05','127.0.0.1'),
  (1028,0,'psdevelop','---','2012-06-02 01:05:11','127.0.0.1'),
  (1029,0,'psdevelop','---','2012-06-04 00:48:59','127.0.0.1'),
  (1030,0,'psdevelop','---','2012-06-04 00:55:38','127.0.0.1'),
  (1031,0,'psdevelop','---','2012-06-04 00:58:06','127.0.0.1'),
  (1032,0,'psdevelop','---','2012-06-04 00:59:17','127.0.0.1'),
  (1033,0,'psdevelop','---','2012-06-04 01:03:33','127.0.0.1'),
  (1034,0,'psdevelop','---','2012-06-04 01:04:18','127.0.0.1'),
  (1035,0,'psdevelop','---','2012-06-04 01:06:38','127.0.0.1'),
  (1036,0,'psdevelop','---','2012-06-04 01:44:57','127.0.0.1'),
  (1037,0,'psdevelop','---','2012-06-04 01:45:21','127.0.0.1'),
  (1038,0,'psdevelop','---','2012-06-04 01:45:46','127.0.0.1'),
  (1039,0,'psdevelop','---','2012-06-04 18:00:29','127.0.0.1'),
  (1040,0,'psdevelop','---','2012-06-04 18:27:12','127.0.0.1'),
  (1041,0,'psdevelop','---','2012-06-04 18:54:00','127.0.0.1'),
  (1042,0,'psdevelop','---','2012-06-04 18:54:17','127.0.0.1'),
  (1043,0,'psdevelop','---','2012-06-04 19:08:22','127.0.0.1'),
  (1044,0,'psdevelop','---','2012-06-04 19:10:18','127.0.0.1'),
  (1045,0,'psdevelop','---','2012-06-04 19:15:39','127.0.0.1'),
  (1046,0,'psdevelop','---','2012-06-04 19:25:26','127.0.0.1'),
  (1047,0,'psdevelop','---','2012-06-04 19:27:40','127.0.0.1'),
  (1048,0,'psdevelop','---','2012-06-04 19:28:18','127.0.0.1'),
  (1049,0,'psdevelop','---','2012-06-04 19:28:47','127.0.0.1'),
  (1050,0,'psdevelop','---','2012-06-04 20:10:51','127.0.0.1'),
  (1051,0,'psdevelop','---','2012-06-05 16:21:40','127.0.0.1'),
  (1052,0,'psdevelop','---','2012-06-05 22:44:13','127.0.0.1'),
  (1053,0,'psdevelop','---','2012-06-06 02:47:06','127.0.0.1'),
  (1054,0,'psdevelop','---','2012-06-06 14:47:49','127.0.0.1'),
  (1055,0,'psdevelop','---','2012-06-07 17:21:46','127.0.0.1'),
  (1056,0,'psdevelop','---','2012-06-07 17:24:25','127.0.0.1'),
  (1057,0,'psdevelop','---','2012-06-12 02:16:22','127.0.0.1'),
  (1058,0,'psdevelop','---','2012-06-12 02:32:09','127.0.0.1'),
  (1059,0,'psdevelop','---','2012-06-12 05:15:09','127.0.0.1'),
  (1060,0,'psdevelop','---','2012-06-12 05:42:59','192.168.137.11'),
  (1061,0,'psdevelop','---','2012-06-12 05:47:11','127.0.0.1'),
  (1062,0,'psdevelop','---','2012-06-12 05:49:21','192.168.137.11'),
  (1063,0,'psdevelop','---','2012-06-12 07:16:57','192.168.137.11'),
  (1064,0,'psdevelop','---','2012-06-12 07:18:03','127.0.0.1'),
  (1065,0,'psdevelop','---','2012-06-12 07:35:51','192.168.137.11'),
  (1066,0,'psdevelop','---','2012-06-12 07:41:18','192.168.137.11'),
  (1067,0,'psdevelop','---','2012-06-12 07:41:37','192.168.137.11'),
  (1068,0,'psdevelop','---','2012-06-12 07:42:15','127.0.0.1'),
  (1069,0,'psdevelop','---','2012-06-12 07:43:34','192.168.137.11'),
  (1070,0,'psdevelop','---','2012-06-14 02:21:05','192.168.137.11'),
  (1071,0,'psdevelop','---','2012-06-14 02:33:03','192.168.137.11'),
  (1072,0,'psdevelop','---','2012-06-14 02:35:27','127.0.0.1'),
  (1073,0,'psdevelop','---','2012-06-14 02:52:39','192.168.137.11'),
  (1074,0,'psdevelop','---','2012-06-14 10:41:06','127.0.0.1'),
  (1075,0,'psdevelop','---','2012-06-14 10:42:19','127.0.0.1'),
  (1076,0,'psdevelop','---','2012-06-14 10:43:10','127.0.0.1'),
  (1077,0,'psdevelop','---','2012-06-14 10:44:00','127.0.0.1'),
  (1078,0,'psdevelop','---','2012-06-20 00:23:34','127.0.0.1'),
  (1079,0,'psdevelop','---','2012-06-20 01:24:30','127.0.0.1'),
  (1080,0,'psdevelop','---','2012-06-20 01:25:21','127.0.0.1'),
  (1081,0,'psdevelop','---','2012-06-20 03:27:27','127.0.0.1'),
  (1082,0,'psdevelop','---','2012-06-21 08:17:40','127.0.0.1'),
  (1083,0,'psdevelop','---','2012-06-21 08:35:36','127.0.0.1'),
  (1084,0,'psdevelop','---','2012-06-21 08:42:42','127.0.0.1'),
  (1085,0,'psdevelop','---','2012-06-21 08:58:56','127.0.0.1'),
  (1086,0,'psdevelop','---','2012-06-22 20:09:12','127.0.0.1'),
  (1087,0,'psdevelop','---','2012-06-22 20:13:34','127.0.0.1'),
  (1088,0,'psdevelop','---','2012-06-22 20:29:47','127.0.0.1'),
  (1089,0,'psdevelop','---','2012-06-22 20:30:06','127.0.0.1'),
  (1090,0,'psdevelop','---','2012-06-22 20:31:55','127.0.0.1'),
  (1091,0,'psdevelop','---','2012-06-22 20:33:00','127.0.0.1'),
  (1092,0,'psdevelop','---','2012-06-22 20:34:28','127.0.0.1'),
  (1093,0,'psdevelop','---','2012-06-23 10:05:38','127.0.0.1'),
  (1094,0,'psdevelop','---','2012-06-23 10:10:12','127.0.0.1'),
  (1095,0,'psdevelop','---','2012-06-23 10:31:12','127.0.0.1'),
  (1096,0,'psdevelop','---','2012-06-23 10:31:58','127.0.0.1'),
  (1097,0,'psdevelop','---','2012-06-23 10:36:35','127.0.0.1'),
  (1098,0,'psdevelop','---','2012-06-23 10:36:49','127.0.0.1'),
  (1099,0,'psdevelop','---','2012-06-23 10:40:59','127.0.0.1'),
  (1100,0,'psdevelop','---','2012-06-23 10:44:59','127.0.0.1'),
  (1101,0,'psdevelop','---','2012-06-23 10:47:24','127.0.0.1'),
  (1102,0,'psdevelop','---','2012-06-23 11:18:51','127.0.0.1'),
  (1103,0,'psdevelop','---','2012-06-23 11:38:17','127.0.0.1'),
  (1104,0,'psdevelop','---','2012-06-23 11:45:47','127.0.0.1'),
  (1105,0,'psdevelop','---','2012-06-23 11:48:15','127.0.0.1'),
  (1106,0,'psdevelop','---','2012-06-23 11:48:34','127.0.0.1'),
  (1107,0,'psdevelop','---','2012-06-23 12:07:48','127.0.0.1'),
  (1108,0,'psdevelop','---','2012-06-23 12:09:01','127.0.0.1'),
  (1109,0,'psdevelop','---','2012-06-23 12:15:25','127.0.0.1'),
  (1110,0,'psdevelop','---','2012-06-23 12:16:41','127.0.0.1'),
  (1111,0,'psdevelop','---','2012-06-23 12:32:52','127.0.0.1'),
  (1112,0,'psdevelop','---','2012-06-24 02:28:29','127.0.0.1'),
  (1113,0,'psdevelop','---','2012-06-24 16:37:24','127.0.0.1'),
  (1114,0,'psdevelop','---','2012-06-24 17:30:47','127.0.0.1'),
  (1115,0,'psdevelop','---','2012-06-24 17:43:11','127.0.0.1'),
  (1116,0,'psdevelop','---','2012-06-24 19:22:36','127.0.0.1'),
  (1117,0,'psdevelop23','---','2012-06-25 00:50:41','127.0.0.1'),
  (1118,0,'psdevelop','---','2012-06-25 01:08:19','127.0.0.1'),
  (1119,0,'psdevelop','---','2012-06-25 01:08:30','127.0.0.1'),
  (1120,0,'psdevelop','---','2012-06-25 18:10:29','127.0.0.1'),
  (1121,0,'psdevelop','---','2012-06-25 18:26:10','127.0.0.1'),
  (1122,0,'psdevelop','---','2012-06-26 00:37:06','127.0.0.1'),
  (1123,0,'psdevelop','---','2012-06-26 00:43:14','127.0.0.1'),
  (1124,0,'psdevelop','---','2012-06-26 00:44:02','127.0.0.1'),
  (1125,0,'psdevelop','---','2012-06-26 00:46:57','127.0.0.1'),
  (1126,0,'psdevelop','---','2012-06-26 00:53:59','127.0.0.1'),
  (1127,0,'psdevelop','---','2012-06-26 00:55:00','127.0.0.1'),
  (1128,0,'psdevelop','---','2012-06-26 00:58:12','127.0.0.1'),
  (1129,0,'psdevelop','---','2012-06-26 00:59:00','127.0.0.1'),
  (1130,0,'psdevelop','---','2012-06-26 01:01:53','127.0.0.1'),
  (1131,0,'psdevelop','---','2012-06-27 16:49:06','127.0.0.1'),
  (1132,0,'psdevelop','---','2012-06-27 17:51:00','127.0.0.1'),
  (1133,0,'psdevelop','---','2012-06-27 17:51:49','127.0.0.1'),
  (1134,0,'psdevelop','---','2012-06-27 17:58:54','127.0.0.1'),
  (1135,0,'psdevelop','---','2012-06-27 18:06:44','127.0.0.1'),
  (1136,0,'psdevelop','---','2012-06-27 18:22:42','127.0.0.1'),
  (1137,0,'psdevelop','---','2012-06-27 18:27:01','127.0.0.1'),
  (1138,0,'psdevelop','---','2012-06-27 18:27:28','127.0.0.1'),
  (1139,0,'psdevelop','---','2012-06-27 18:28:43','127.0.0.1'),
  (1140,0,'psdevelop','---','2012-06-27 18:29:40','127.0.0.1'),
  (1141,0,'psdevelop','---','2012-06-27 18:31:57','127.0.0.1'),
  (1142,0,'psdevelop','---','2012-06-27 18:33:20','127.0.0.1'),
  (1143,0,'psdevelop','---','2012-06-27 19:00:32','127.0.0.1'),
  (1144,0,'psdevelop','---','2012-06-27 19:42:03','127.0.0.1'),
  (1145,0,'psdevelop','---','2012-06-28 22:16:44','127.0.0.1'),
  (1146,0,'psdevelop','---','2012-06-28 23:48:36','127.0.0.1'),
  (1147,0,'psdevelop','---','2012-06-30 03:42:26','127.0.0.1'),
  (1148,0,'psdevelop','---','2012-06-30 03:42:46','127.0.0.1'),
  (1149,0,'psdevelop','---','2012-07-01 03:38:51','127.0.0.1'),
  (1150,0,'psdevelop','---','2012-07-04 00:59:50','127.0.0.1'),
  (1151,0,'psdevelop','---','2012-07-04 01:23:42','127.0.0.1'),
  (1152,0,'psdevelop','---','2012-07-04 01:33:17','127.0.0.1'),
  (1153,0,'psdevelop','---','2012-07-04 01:56:08','127.0.0.1'),
  (1154,0,'psdevelop','---','2012-07-04 01:58:46','127.0.0.1'),
  (1155,0,'psdevelop','---','2012-07-04 02:01:57','127.0.0.1'),
  (1156,0,'psdevelop','---','2012-07-04 02:03:11','127.0.0.1'),
  (1157,0,'psdevelop','---','2012-07-04 02:03:56','127.0.0.1'),
  (1158,0,'psdevelop','---','2012-07-04 02:04:47','127.0.0.1'),
  (1159,0,'psdevelop','---','2012-07-04 02:05:44','127.0.0.1'),
  (1160,0,'psdevelop','---','2012-07-04 02:15:32','127.0.0.1'),
  (1161,0,'psdevelop','---','2012-07-04 02:16:57','127.0.0.1'),
  (1162,0,'psdevelop','---','2012-07-04 02:17:58','127.0.0.1'),
  (1163,0,'psdevelop','---','2012-07-04 02:20:31','127.0.0.1'),
  (1164,0,'psdevelop','---','2012-07-04 02:23:46','127.0.0.1'),
  (1165,0,'psdevelop','---','2012-07-04 02:24:49','127.0.0.1'),
  (1166,0,'psdevelop','---','2012-07-04 02:27:33','127.0.0.1'),
  (1167,0,'psdevelop','---','2012-07-04 02:28:19','127.0.0.1'),
  (1168,0,'psdevelop','---','2012-07-04 02:31:14','127.0.0.1'),
  (1169,0,'psdevelop','---','2012-07-04 02:32:13','127.0.0.1'),
  (1170,0,'psdevelop','---','2012-07-04 02:33:11','127.0.0.1'),
  (1171,0,'psdevelop','---','2012-07-04 02:35:08','127.0.0.1'),
  (1172,0,'psdevelop','---','2012-07-04 04:14:17','127.0.0.1'),
  (1173,0,'psdevelop','---','2012-07-04 04:27:14','127.0.0.1'),
  (1174,0,'psdevelop','---','2012-07-04 04:49:01','127.0.0.1'),
  (1175,0,'psdevelop','---','2012-07-04 04:49:45','127.0.0.1'),
  (1176,0,'psdevelop','---','2012-07-05 02:57:37','127.0.0.1'),
  (1177,0,'psdevelop','---','2012-07-05 03:10:49','127.0.0.1'),
  (1178,0,'psdevelop','---','2012-07-05 03:12:28','127.0.0.1'),
  (1179,0,'psdevelop','---','2012-07-05 03:21:02','127.0.0.1'),
  (1180,0,'psdevelop','---','2012-07-05 03:23:19','127.0.0.1'),
  (1181,0,'psdevelop','---','2012-07-05 03:23:48','127.0.0.1'),
  (1182,0,'psdevelop','---','2012-07-05 03:24:50','127.0.0.1'),
  (1183,0,'psdevelop','---','2012-07-05 03:25:19','127.0.0.1'),
  (1184,0,'psdevelop','---','2012-07-05 03:26:27','127.0.0.1'),
  (1185,0,'psdevelop','---','2012-07-05 03:27:24','127.0.0.1'),
  (1186,0,'psdevelop','---','2012-07-05 03:30:05','127.0.0.1'),
  (1187,0,'psdevelop','---','2012-07-05 03:31:23','127.0.0.1'),
  (1188,0,'psdevelop','---','2012-07-05 03:37:43','127.0.0.1'),
  (1189,0,'psdevelop','---','2012-07-05 03:39:56','127.0.0.1'),
  (1190,0,'psdevelop','---','2012-07-05 03:41:11','127.0.0.1'),
  (1191,0,'psdevelop','---','2012-07-05 03:41:53','127.0.0.1'),
  (1192,0,'psdevelop','---','2012-07-05 03:42:39','127.0.0.1'),
  (1193,0,'psdevelop','---','2012-07-05 03:43:28','127.0.0.1'),
  (1194,0,'psdevelop','---','2012-07-05 03:43:58','127.0.0.1'),
  (1195,0,'psdevelop','---','2012-07-05 03:47:34','127.0.0.1'),
  (1196,0,'psdevelop','---','2012-07-05 03:48:56','127.0.0.1'),
  (1197,0,'psdevelop','---','2012-07-05 03:51:41','127.0.0.1'),
  (1198,0,'psdevelop','---','2012-07-05 03:53:06','127.0.0.1'),
  (1199,0,'psdevelop','---','2012-07-05 03:54:57','127.0.0.1'),
  (1200,0,'psdevelop','---','2012-07-05 04:01:31','127.0.0.1'),
  (1201,0,'psdevelop','---','2012-07-05 04:03:02','127.0.0.1'),
  (1202,0,'psdevelop','---','2012-07-05 04:03:58','127.0.0.1'),
  (1203,0,'psdevelop','---','2012-07-05 04:05:15','127.0.0.1'),
  (1204,0,'psdevelop','---','2012-07-05 04:07:10','127.0.0.1'),
  (1205,0,'psdevelop','---','2012-07-05 04:10:06','127.0.0.1'),
  (1206,0,'psdevelop','---','2012-07-05 04:14:04','127.0.0.1'),
  (1207,0,'psdevelop','---','2012-07-05 04:14:54','127.0.0.1'),
  (1208,0,'psdevelop','---','2012-07-05 04:17:03','127.0.0.1'),
  (1209,0,'psdevelop','---','2012-07-05 04:18:36','127.0.0.1'),
  (1210,0,'psdevelop','---','2012-07-05 04:19:57','127.0.0.1');
COMMIT;

#
# Data for the `sessions` table  (LIMIT 622,500)
#

INSERT INTO `sessions` (`id`, `uid`, `username`, `hash`, `expiredate`, `ip`) VALUES 
  (1211,0,'psdevelop','---','2012-07-05 04:20:18','127.0.0.1'),
  (1212,0,'psdevelop','---','2012-07-06 21:34:16','127.0.0.1'),
  (1213,0,'psdevelop','---','2012-07-06 21:39:37','127.0.0.1'),
  (1214,0,'psdevelop','---','2012-07-06 21:40:57','127.0.0.1'),
  (1215,0,'psdevelop','---','2012-07-06 21:47:54','127.0.0.1'),
  (1216,0,'psdevelop','---','2012-07-06 21:48:22','127.0.0.1'),
  (1217,0,'psdevelop','---','2012-07-06 21:48:41','127.0.0.1'),
  (1218,0,'psdevelop','---','2012-07-06 21:48:59','127.0.0.1'),
  (1219,0,'psdevelop','---','2012-07-06 21:49:10','127.0.0.1'),
  (1220,0,'psdevelop','---','2012-07-06 21:49:43','127.0.0.1'),
  (1221,0,'psdevelop','---','2012-07-06 21:50:33','127.0.0.1'),
  (1222,0,'psdevelop','---','2012-07-06 22:34:36','127.0.0.1'),
  (1223,0,'psdevelop','---','2012-07-06 22:35:38','127.0.0.1'),
  (1224,0,'psdevelop','---','2012-07-07 02:05:42','127.0.0.1'),
  (1225,0,'psdevelop','---','2012-07-07 02:22:27','127.0.0.1'),
  (1226,0,'psdevelop','---','2012-07-07 02:26:39','127.0.0.1'),
  (1227,0,'psdevelop','---','2012-07-07 02:57:03','127.0.0.1'),
  (1228,0,'psdevelop','---','2012-07-07 02:58:10','127.0.0.1'),
  (1229,0,'psdevelop','---','2012-07-07 03:08:21','127.0.0.1'),
  (1230,0,'psdevelop','---','2012-07-07 03:09:52','127.0.0.1'),
  (1231,0,'psdevelop','---','2012-07-07 03:26:16','127.0.0.1'),
  (1232,0,'psdevelop','---','2012-07-07 03:26:48','127.0.0.1'),
  (1233,0,'psdevelop','---','2012-07-07 03:27:07','127.0.0.1'),
  (1234,0,'psdevelop','---','2012-07-07 03:29:56','127.0.0.1'),
  (1235,0,'psdevelop','---','2012-07-07 03:34:59','127.0.0.1'),
  (1236,0,'psdevelop','---','2012-07-07 03:36:54','127.0.0.1'),
  (1237,0,'psdevelop','---','2012-07-07 03:59:20','127.0.0.1'),
  (1238,0,'psdevelop','---','2012-07-07 04:00:35','127.0.0.1'),
  (1239,0,'psdevelop','---','2012-07-07 04:04:33','127.0.0.1'),
  (1240,0,'psdevelop','---','2012-07-07 04:05:35','127.0.0.1'),
  (1241,0,'psdevelop','---','2012-07-07 05:36:39','127.0.0.1'),
  (1242,0,'psdevelop','---','2012-07-07 05:40:14','127.0.0.1'),
  (1243,0,'psdevelop','---','2012-07-07 06:02:29','127.0.0.1'),
  (1244,0,'psdevelop','---','2012-07-07 06:02:51','127.0.0.1'),
  (1245,0,'psdevelop','---','2012-07-07 06:04:47','127.0.0.1'),
  (1246,0,'psdevelop','---','2012-07-07 06:05:43','127.0.0.1'),
  (1247,0,'psdevelop','---','2012-07-07 06:06:14','127.0.0.1'),
  (1248,0,'psdevelop','---','2012-07-07 06:07:39','127.0.0.1'),
  (1249,0,'psdevelop','---','2012-07-07 06:11:44','127.0.0.1'),
  (1250,0,'psdevelop','---','2012-07-07 15:42:18','127.0.0.1'),
  (1251,0,'psdevelop','---','2012-07-07 15:48:57','127.0.0.1'),
  (1252,0,'psdevelop','---','2012-07-07 15:50:29','127.0.0.1'),
  (1253,0,'psdevelop','---','2012-07-07 15:54:42','127.0.0.1'),
  (1254,0,'psdevelop','---','2012-07-07 16:07:04','127.0.0.1'),
  (1255,0,'psdevelop','---','2012-07-07 16:09:02','127.0.0.1'),
  (1256,0,'psdevelop','---','2012-07-07 16:13:35','127.0.0.1'),
  (1257,0,'psdevelop','---','2012-07-10 02:46:15','127.0.0.1'),
  (1258,0,'psdevelop','---','2012-07-10 02:52:39','127.0.0.1'),
  (1259,0,'psdevelop','---','2012-07-10 02:54:42','127.0.0.1'),
  (1260,0,'psdevelop','---','2012-07-10 02:56:05','127.0.0.1'),
  (1261,0,'psdevelop','---','2012-07-10 03:05:14','127.0.0.1'),
  (1262,0,'psdevelop','---','2012-07-10 03:05:38','127.0.0.1'),
  (1263,0,'psdevelop','---','2012-07-10 03:06:40','127.0.0.1'),
  (1264,0,'psdevelop','---','2012-07-10 03:06:55','127.0.0.1'),
  (1265,0,'psdevelop','---','2012-07-13 00:59:50','127.0.0.1'),
  (1266,0,'psdevelop','---','2012-07-13 01:00:14','127.0.0.1'),
  (1267,0,'psdevelop','---','2012-07-17 07:05:00','127.0.0.1'),
  (1268,0,'psdevelop','---','2012-07-17 19:53:01','127.0.0.1'),
  (1269,0,'psdevelop','---','2012-07-19 00:09:11','127.0.0.1'),
  (1270,0,'psdevelop','---','2012-07-20 18:40:13','127.0.0.1'),
  (1271,0,'psdevelop','---','2012-07-20 22:32:37','127.0.0.1'),
  (1272,0,'psdevelop','---','2012-07-20 22:36:49','127.0.0.1'),
  (1273,0,'psdevelop','---','2012-07-23 10:05:02','127.0.0.1'),
  (1274,0,'psdevelop','---','2012-07-23 10:05:44','127.0.0.1'),
  (1275,0,'psdevelop','---','2012-07-23 10:06:17','127.0.0.1'),
  (1276,0,'psdevelop','---','2012-07-23 10:09:47','127.0.0.1'),
  (1277,0,'psdevelop','---','2012-07-23 10:10:27','127.0.0.1'),
  (1278,0,'psdevelop','---','2012-07-23 10:14:45','127.0.0.1'),
  (1279,0,'psdevelop','---','2012-07-23 10:15:22','127.0.0.1'),
  (1280,0,'psdevelop','---','2012-07-23 10:28:27','127.0.0.1'),
  (1281,0,'psdevelop','---','2012-07-23 10:29:49','127.0.0.1'),
  (1282,0,'psdevelop','---','2012-07-23 10:41:22','127.0.0.1'),
  (1283,0,'psdevelop','---','2012-07-23 10:41:29','127.0.0.1'),
  (1284,0,'psdevelop','---','2012-07-23 10:41:32','127.0.0.1'),
  (1285,0,'psdevelop','---','2012-07-23 10:48:17','127.0.0.1'),
  (1286,0,'psdevelop','---','2012-07-23 10:51:21','127.0.0.1'),
  (1287,0,'psdevelop','---','2012-07-23 10:51:41','127.0.0.1'),
  (1288,0,'psdevelop','---','2012-07-23 10:52:51','127.0.0.1'),
  (1289,0,'psdevelop','---','2012-07-23 10:59:16','127.0.0.1'),
  (1290,0,'psdevelop','---','2012-07-23 10:59:20','127.0.0.1'),
  (1291,0,'psdevelop','---','2012-07-23 11:05:31','127.0.0.1'),
  (1292,0,'psdevelop','---','2012-07-23 11:06:36','127.0.0.1'),
  (1293,0,'psdevelop','---','2012-07-23 11:11:03','127.0.0.1'),
  (1294,0,'psdevelop','---','2012-07-23 11:12:56','127.0.0.1'),
  (1295,0,'psdevelop','---','2012-07-24 00:36:45','127.0.0.1'),
  (1296,0,'psdevelop','---','2012-07-24 05:48:38','127.0.0.1'),
  (1297,0,'psdevelop','---','2012-07-24 05:49:18','127.0.0.1'),
  (1298,0,'psdevelop','---','2012-07-25 11:09:34','127.0.0.1'),
  (1299,0,'psdevelop','---','2012-07-25 11:12:14','127.0.0.1'),
  (1300,0,'psdevelop','---','2012-07-25 11:13:05','127.0.0.1'),
  (1301,0,'psdevelop','---','2012-07-25 11:16:11','127.0.0.1'),
  (1302,0,'psdevelop','---','2012-07-25 11:17:40','127.0.0.1'),
  (1303,0,'psdevelop','---','2012-07-25 11:22:15','127.0.0.1'),
  (1304,0,'psdevelop','---','2012-07-25 11:31:45','127.0.0.1'),
  (1305,0,'psdevelop','---','2012-07-25 11:35:40','127.0.0.1'),
  (1306,0,'psdevelop','---','2012-07-25 11:37:24','127.0.0.1'),
  (1307,0,'psdevelop','---','2012-07-25 11:40:05','127.0.0.1'),
  (1308,0,'psdevelop','---','2012-07-25 11:41:37','127.0.0.1'),
  (1309,0,'psdevelop','---','2012-07-25 11:42:51','127.0.0.1'),
  (1310,0,'psdevelop','---','2012-07-25 11:43:52','127.0.0.1'),
  (1311,0,'psdevelop','---','2012-07-25 11:45:49','127.0.0.1'),
  (1312,0,'psdevelop','---','2012-07-25 12:23:48','127.0.0.1'),
  (1313,0,'psdevelop','---','2012-07-25 12:43:50','127.0.0.1'),
  (1314,0,'psdevelop','---','2012-07-25 12:44:33','127.0.0.1'),
  (1315,0,'psdevelop','---','2012-07-25 13:57:46','127.0.0.1'),
  (1316,0,'psdevelop','---','2012-07-25 14:00:39','127.0.0.1'),
  (1317,0,'psdevelop','---','2012-07-25 14:05:58','127.0.0.1'),
  (1318,0,'psdevelop','---','2012-07-25 14:08:06','127.0.0.1'),
  (1319,0,'psdevelop','---','2012-07-25 14:14:14','127.0.0.1'),
  (1320,0,'psdevelop','---','2012-07-25 14:18:24','127.0.0.1'),
  (1321,0,'psdevelop','---','2012-07-25 14:19:21','127.0.0.1'),
  (1322,0,'psdevelop','---','2012-07-25 14:21:26','127.0.0.1'),
  (1323,0,'psdevelop','---','2012-07-25 14:31:27','127.0.0.1'),
  (1324,0,'psdevelop','---','2012-08-13 23:09:06','127.0.0.1'),
  (1325,0,'psdevelop','---','2012-08-14 21:34:41','127.0.0.1'),
  (1326,0,'psdevelop','---','2012-08-14 21:35:34','127.0.0.1'),
  (1327,0,'psdevelop','---','2012-08-18 00:22:09','127.0.0.1'),
  (1328,0,'psdevelop','---','2012-08-18 21:52:06','127.0.0.1'),
  (1329,0,'psdevelop','---','2012-08-20 20:02:43','127.0.0.1'),
  (1330,0,'psdevelop','---','2012-08-20 23:53:52','127.0.0.1'),
  (1331,0,'psdevelop','---','2012-08-20 23:57:33','127.0.0.1');
COMMIT;

#
# Data for the `users` table  (LIMIT -495,500)
#

INSERT INTO `users` (`id`, `username`, `password`, `email`, `isactive`, `person_id`, `closed`, `enable_admin`, `enable_deleting`, `db_server_adress`, `user_db_name`, `user_db_login`, `load_visa_default_cats`, `load_visa_cats`, `default_currency_id`, `external_reg`, `system_name`) VALUES 
  (30,'psdevelop','MTIzNDU2Nw==','psdevelop@yandex.ru',1,428,0,'0','0','localhost','finance_mgr','root',1,1,0,0,NULL),
  (33,'psdevelop2','MTIzNDU2Nw==','psdevelop2@yandex.ru',1,431,0,'0','0','localhost','finance_mgr','root',0,1,0,0,NULL),
  (34,'psdevelop23','MTIzNDU2Nw==','psdevelop23',1,432,0,'0','0','localhost','finance_mgr','root',0,0,0,0,NULL),
  (35,'psdevelop24','MTIzNDU2Nw==','psdevelop24',1,433,0,'0','0','localhost','finance_mgr','root',0,0,0,0,NULL);
COMMIT;



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;