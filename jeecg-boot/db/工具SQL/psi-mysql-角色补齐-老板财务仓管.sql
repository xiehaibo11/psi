/*
 * 角色权限补齐：新增 老板、财务、仓管 三个预设角色
 * 执行前请备份数据库
 * 执行：mysql -u用户 -p 数据库名 < psi-mysql-角色补齐-老板财务仓管.sql
 */

-- 1. 新增三个角色
INSERT IGNORE INTO `sys_role` (`id`, `role_name`, `role_code`, `description`, `create_by`, `create_time`, `update_by`, `update_time`) VALUES
('2000010000000000001', '老板', 'psi-boss', '全权限、审批', 'admin', NOW(), 'admin', NOW()),
('2000010000000000002', '财务', 'psi-finance', '制单/复核/记账', 'admin', NOW(), 'admin', NOW()),
('2000010000000000003', '仓管', 'psi-warehouse', '出入库/库存管理', 'admin', NOW(), 'admin', NOW());

-- 2. 老板：复制 单据审批者 的全部权限（全 ERP + 审批）
INSERT IGNORE INTO `sys_role_permission` (`id`, `role_id`, `permission_id`, `data_rule_ids`, `operate_date`, `operate_ip`)
SELECT REPLACE(UUID(),'-',''), '2000010000000000001', `permission_id`, `data_rule_ids`, NOW(), NULL
FROM `sys_role_permission` WHERE `role_id` = '1607406089571188738';

-- 3. 老板：补充首页权限（若尚未包含）
INSERT IGNORE INTO `sys_role_permission` (`id`, `role_id`, `permission_id`, `data_rule_ids`, `operate_date`, `operate_ip`)
SELECT REPLACE(UUID(),'-',''), '2000010000000000001', '9502685863ab87f0ad1134142788a385', NULL, NOW(), NULL
FROM (SELECT 1) t WHERE NOT EXISTS (
  SELECT 1 FROM sys_role_permission WHERE role_id = '2000010000000000001' AND permission_id = '9502685863ab87f0ad1134142788a385'
);

-- 4. 财务：从 单据审批者 复制 应收、应付、收款、付款、预付、预收、发票、基础资料 相关权限
INSERT IGNORE INTO `sys_role_permission` (`id`, `role_id`, `permission_id`, `data_rule_ids`, `operate_date`, `operate_ip`)
SELECT REPLACE(UUID(),'-',''), '2000010000000000002', rp.`permission_id`, rp.`data_rule_ids`, NOW(), NULL
FROM `sys_role_permission` rp
JOIN `sys_permission` p ON rp.permission_id = p.id
WHERE rp.`role_id` = '1607406089571188738'
  AND (p.id IN ('1571879677364051970','1249544156015607810','1263456573379211265','1556576207841058817','1561656502558666753','1242263502445903874','1259846003342069761','1259846469224386562','1259846724485533697','1259846940940980225')
    OR p.parent_id IN ('1571879677364051970','1249544156015607810','1263456573379211265','1556576207841058817','1561656502558666753','1242263502445903874','1259846003342069761','1259846469224386562','1259846724485533697','1259846940940980225'));

-- 5. 财务：补充首页
INSERT IGNORE INTO `sys_role_permission` (`id`, `role_id`, `permission_id`, `data_rule_ids`, `operate_date`, `operate_ip`)
SELECT REPLACE(UUID(),'-',''), '2000010000000000002', '9502685863ab87f0ad1134142788a385', NULL, NOW(), NULL
FROM (SELECT 1) t WHERE NOT EXISTS (
  SELECT 1 FROM sys_role_permission WHERE role_id = '2000010000000000002' AND permission_id = '9502685863ab87f0ad1134142788a385'
);

-- 6. 仓管：从 单据审批者 复制 库存管理、基础资料(物料/仓库/分类/单位) 相关权限
INSERT IGNORE INTO `sys_role_permission` (`id`, `role_id`, `permission_id`, `data_rule_ids`, `operate_date`, `operate_ip`)
SELECT REPLACE(UUID(),'-',''), '2000010000000000003', rp.`permission_id`, rp.`data_rule_ids`, NOW(), NULL
FROM `sys_role_permission` rp
JOIN `sys_permission` p ON rp.permission_id = p.id
WHERE rp.`role_id` = '1607406089571188738'
  AND (p.id IN ('1244876622988214274','1242263502445903874','1261213213500452866','1261213485316517889','1565540953273507842','1573311771759919105','1244271300749729794','1245154050731200514','1262262642546475010','1266386162661343233')
    OR p.parent_id IN ('1244876622988214274','1242263502445903874','1261213213500452866','1261213485316517889','1565540953273507842','1573311771759919105'));

-- 7. 仓管：补充首页
INSERT IGNORE INTO `sys_role_permission` (`id`, `role_id`, `permission_id`, `data_rule_ids`, `operate_date`, `operate_ip`)
SELECT REPLACE(UUID(),'-',''), '2000010000000000003', '9502685863ab87f0ad1134142788a385', NULL, NOW(), NULL
FROM (SELECT 1) t WHERE NOT EXISTS (
  SELECT 1 FROM sys_role_permission WHERE role_id = '2000010000000000003' AND permission_id = '9502685863ab87f0ad1134142788a385'
);
