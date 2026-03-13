-- 物料分类：预置水产行业分类（虾苗、饲料、渔药、设备等）
-- 执行前请备份。适用于 MySQL 5.7+
-- 执行：mysql -u root -p 数据库名 < psi-mysql-物料分类-水产行业预置.sql

INSERT IGNORE INTO `bas_material_category` (`id`, `pid`, `has_child`, `code`, `name`, `fullname`, `is_enabled`, `create_by`, `create_time`, `update_by`, `update_time`, `version`) VALUES
('1890010000000000001', '0', '0', '20', '虾苗', NULL, 1, 'admin', NOW(), NULL, NULL, NULL),
('1890010000000000002', '0', '0', '21', '饲料', NULL, 1, 'admin', NOW(), NULL, NULL, NULL),
('1890010000000000003', '0', '0', '22', '渔药', NULL, 1, 'admin', NOW(), NULL, NULL, NULL),
('1890010000000000004', '0', '0', '23', '设备', NULL, 1, 'admin', NOW(), NULL, NULL, NULL);
