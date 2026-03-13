<template>
  <a-card :bordered="false">
    <!-- 查询区域 -->
    <div class="table-page-search-wrapper">
      <a-form layout="inline" @keyup.enter.native="loadData">
        <a-row :gutter="24">
          <a-col :xl="6" :lg="7" :md="8" :sm="24">
            <a-form-item label="物料编码">
              <a-input placeholder="请输入" v-model="queryParam.materialCode" allowClear/>
            </a-form-item>
          </a-col>
          <a-col :xl="6" :lg="7" :md="8" :sm="24">
            <a-form-item label="物料名称">
              <a-input placeholder="请输入" v-model="queryParam.materialName" allowClear/>
            </a-form-item>
          </a-col>
          <a-col :xl="4" :lg="6" :md="7" :sm="24">
            <span style="float: left;overflow: hidden;" class="table-page-search-submitButtons">
              <a-button type="primary" @click="loadData" icon="search">查询</a-button>
              <a-button @click="searchReset" icon="reload" style="margin-left: 8px">重置</a-button>
            </span>
          </a-col>
        </a-row>
      </a-form>
    </div>

    <!-- 提示 -->
    <a-alert v-if="dataSource.length > 0" type="warning" show-icon style="margin-bottom: 12px">
      <template slot="message">
        以下物料当前库存低于安全库存，请及时补货
      </template>
    </a-alert>
    <a-alert v-else-if="!loading" type="info" show-icon style="margin-bottom: 12px">
      <template slot="message">
        暂无库存预警。请先在物料管理中设置安全库存，当当前库存低于安全库存时将在此显示。
      </template>
    </a-alert>

    <!-- 表格 -->
    <a-table
      ref="table"
      size="middle"
      bordered
      rowKey="materialId"
      :scroll="{ x: true }"
      :columns="columns"
      :dataSource="dataSource"
      :loading="loading"
      :pagination="false">
      <span slot="shortage" slot-scope="text, record">
        <a-tag color="red" v-if="getShortage(record) > 0">
          缺 {{ formatQty(getShortage(record)) }}
        </a-tag>
        <span v-else>-</span>
      </span>
      <span slot="materialCode" slot-scope="text, record">
        <a @click="goMaterial(record.materialId)">{{ text }}</a>
      </span>
    </a-table>
  </a-card>
</template>

<script>
  import { getAction } from '@/api/manage'
  import XEUtils from 'xe-utils'

  export default {
    name: 'StkInventoryAlertList',
    data() {
      return {
        queryParam: {
          materialCode: '',
          materialName: '',
        },
        loading: false,
        dataSource: [],
        columns: [
          { title: '#', dataIndex: '', key: 'rowIndex', width: 60, align: 'center',
            customRender: (t, r, index) => index + 1 },
          { title: '物料编码', dataIndex: 'materialCode', width: 140, scopedSlots: { customRender: 'materialCode' } },
          { title: '物料名称', dataIndex: 'materialName', width: 180 },
          { title: '规格型号', dataIndex: 'materialModel', width: 160, ellipsis: true },
          { title: '单位', dataIndex: 'unitId_dictText', width: 80, align: 'center' },
          { title: '安全库存', dataIndex: 'safetyStock', width: 100, align: 'right',
            customRender: t => t != null ? XEUtils.commafy(t, { digits: 2 }) : '-' },
          { title: '当前库存', dataIndex: 'currentQty', width: 100, align: 'right',
            customRender: t => t != null ? XEUtils.commafy(t, { digits: 2 }) : '0' },
          { title: '缺口', key: 'shortage', width: 120, align: 'center', scopedSlots: { customRender: 'shortage' } },
        ],
      }
    },
    created() {
      this.loadData()
    },
    methods: {
      loadData() {
        this.loading = true
        getAction('/stock/stkInventory/alert/list', this.queryParam)
          .then(res => {
            if (res.success && res.result) {
              this.dataSource = res.result
            } else {
              this.dataSource = []
            }
          })
          .finally(() => { this.loading = false })
      },
      searchReset() {
        this.queryParam = { materialCode: '', materialName: '' }
        this.loadData()
      },
      getShortage(record) {
        const safety = record.safetyStock != null ? parseFloat(record.safetyStock) : 0
        const current = record.currentQty != null ? parseFloat(record.currentQty) : 0
        return Math.max(0, safety - current)
      },
      goMaterial(materialId) {
        this.$router.push({ path: '/erp/base/BasMaterialList', query: { id: materialId } })
      },
      formatQty(val) {
        return val != null ? XEUtils.commafy(val, { digits: 2 }) : '-'
      },
    },
  }
</script>

<style lang="less" scoped>
  @import '~@assets/less/common.less';
  @import '../common/less/List.less';
</style>
