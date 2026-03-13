package io.finer.erp.stock.mapper;

import io.finer.erp.stock.entity.StkInventory;
import io.finer.erp.stock.vo.StkInventoryAlertVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Description: 库存
 * @Author: jeecg-boot
 * @Date:   2020-04-11
 * @Version: V1.0
 */
public interface StkInventoryMapper extends BaseMapper<StkInventory> {

    /**
     * 库存预警：查询当前库存低于安全库存的物料列表
     */
    List<StkInventoryAlertVo> selectInventoryAlertList(@Param("materialCode") String materialCode,
                                                        @Param("materialName") String materialName);
}
