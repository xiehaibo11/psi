-- 库存预警：为物料表增加安全库存字段，并新增库存预警菜单
-- 执行前请备份。适用于 MySQL 5.7+

-- 1. bas_material 增加 safety_stock（安全库存/最小库存）
ALTER TABLE bas_material
  ADD COLUMN safety_stock decimal(18,6) DEFAULT NULL COMMENT '安全库存（最小库存）' AFTER unit_id;

-- 2. 新增「库存预警」菜单（放在「即时库存」下）
INSERT IGNORE INTO `sys_permission` (`id`, `parent_id`, `name`, `url`, `component`, `component_name`, `redirect`, `menu_type`, `perms`, `perms_type`, `sort_no`, `always_show`, `icon`, `is_route`, `is_leaf`, `keep_alive`, `hidden`, `hide_tab`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`, `rule_flag`, `status`, `internal_or_external`) VALUES
('1796540450559004675', '1573311771759919105', '库存预警', '/erp/stock/inventory/alert', 'erp/stock/StkInventoryAlertList', null, null, '1', null, '1', '5.00', '0', 'warning', '1', '1', '0', '0', '0', null, 'admin', NOW(), 'admin', NOW(), '0', '0', '1', '0');
