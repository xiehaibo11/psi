package io.finer.erp.stock.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 库存预警 VO：当前库存低于安全库存的物料
 */
@Data
@ApiModel(value = "库存预警", description = "当前库存低于安全库存的物料")
public class StkInventoryAlertVo implements Serializable {
    private static final long serialVersionUID = 1L;

    @ApiModelProperty("物料ID")
    private String materialId;
    @ApiModelProperty("物料编码")
    private String materialCode;
    @ApiModelProperty("物料名称")
    private String materialName;
    @ApiModelProperty("规格型号")
    private String materialModel;
    @ApiModelProperty("单位ID")
    private String unitId;
    @ApiModelProperty("单位名称")
    private String unitId_dictText;
    @ApiModelProperty("安全库存")
    private BigDecimal safetyStock;
    @ApiModelProperty("当前库存")
    private BigDecimal currentQty;
}
