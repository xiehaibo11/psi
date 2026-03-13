-- 首页今日/本月收支：收款、付款流水统计
-- 执行前请备份。适用于 MySQL 5.7+

-- 1. 创建 home_receipt_payment 视图
DROP VIEW IF EXISTS `home_receipt_payment`;
CREATE VIEW `home_receipt_payment` AS
SELECT '收款' AS label,
  (SELECT IFNULL(SUM(amt),0) FROM fin_receipt WHERE is_effective=1 AND is_voided=0 AND effective_time >= CURDATE()) AS t_amt,
  (SELECT COUNT(1) FROM fin_receipt WHERE is_effective=1 AND is_voided=0 AND effective_time >= CURDATE()) AS t_count,
  (SELECT IFNULL(SUM(amt),0) FROM fin_receipt WHERE is_effective=1 AND is_voided=0 AND YEAR(effective_time)=YEAR(CURDATE()) AND MONTH(effective_time)=MONTH(CURDATE())) AS m_amt,
  (SELECT COUNT(1) FROM fin_receipt WHERE is_effective=1 AND is_voided=0 AND YEAR(effective_time)=YEAR(CURDATE()) AND MONTH(effective_time)=MONTH(CURDATE())) AS m_count
UNION ALL
SELECT '付款',
  (SELECT IFNULL(SUM(amt),0) FROM fin_payment WHERE is_effective=1 AND is_voided=0 AND effective_time >= CURDATE()),
  (SELECT COUNT(1) FROM fin_payment WHERE is_effective=1 AND is_voided=0 AND effective_time >= CURDATE()),
  (SELECT IFNULL(SUM(amt),0) FROM fin_payment WHERE is_effective=1 AND is_voided=0 AND YEAR(effective_time)=YEAR(CURDATE()) AND MONTH(effective_time)=MONTH(CURDATE())),
  (SELECT COUNT(1) FROM fin_payment WHERE is_effective=1 AND is_voided=0 AND YEAR(effective_time)=YEAR(CURDATE()) AND MONTH(effective_time)=MONTH(CURDATE()));

-- 2. 新增 onl_cgreport_head 报表配置
INSERT IGNORE INTO `onl_cgreport_head` VALUES ('1796540450559004676', 'home_receipt_payment', '首页-收支', 'SELECT * FROM home_receipt_payment', null, null, '1', null, null, null, NOW(), 'admin', NOW(), 'admin');
