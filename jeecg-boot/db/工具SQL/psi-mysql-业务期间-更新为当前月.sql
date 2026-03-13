-- 业务期间：将当前月度更新为系统当前年月
-- 执行前请备份。适用于 MySQL 5.7+
-- 执行：mysql -u root -p 数据库名 < psi-mysql-业务期间-更新为当前月.sql

-- 更新 year、month 为当前日期的年月（例如 2026年3月10日 -> 2026年3月）
UPDATE `bas_biz_period`
   SET `year` = YEAR(CURDATE()),
       `month` = MONTH(CURDATE())
 WHERE `id` = 'ba43143c9fc711eab66f18dbf2568723';
