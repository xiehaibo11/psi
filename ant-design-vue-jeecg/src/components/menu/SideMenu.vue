<template>
  <a-layout-sider
    :class="['sider', isDesktop() ? null : 'shadow', theme, fixSiderbar ? 'ant-fixed-sidemenu' : null ]"
    width="208px"
    :collapsible="collapsible"
    v-model="collapsed"
    :trigger="null">
    <div class="sider-content">
      <logo />
      <s-menu
        :collapsed="collapsed"
        :menu="menus"
        :theme="theme"
        @select="onSelect"
        @updateMenuTitle="onUpdateMenuTitle"
        :mode="mode"
        :style="smenuStyle">
      </s-menu>
      <div
        class="sider-setting-entry"
        :class="theme"
        @click="openSetting">
        <a-icon type="tool"/>
        <span class="sider-setting-text" v-show="!collapsed">系统设置</span>
      </div>
    </div>
  </a-layout-sider>

</template>

<script>
  import ALayoutSider from 'ant-design-vue/es/layout/Sider'
  import Logo from '../tools/Logo'
  import SMenu from './index'
  import { mixin, mixinDevice } from '@/utils/mixin.js'

  export default {
    name: "SideMenu",
    components: { ALayoutSider, Logo, SMenu },
    mixins: [mixin, mixinDevice],
    props: {
      mode: {
        type: String,
        required: false,
        default: 'inline'
      },
      theme: {
        type: String,
        required: false,
        default: 'dark'
      },
      collapsible: {
        type: Boolean,
        required: false,
        default: false
      },
      collapsed: {
        type: Boolean,
        required: false,
        default: false
      },
      menus: {
        type: Array,
        required: true
      }
    },
    computed:{
      smenuStyle() {
        return {
          padding: '0',
          flex: '1',
          minHeight: 0,
          overflow: 'auto',
          overflowX: 'hidden'
        }
      }
    },
    methods: {
      onSelect (obj) {
        this.$emit('menuSelect', obj)
      },
      onUpdateMenuTitle (obj) {
        this.$emit('updateMenuTitle', obj)
      },
      openSetting() {
        this.$bus.$emit('openSettingDrawer')
        this.$emit('menuSelect', {}) // 通知父级（移动端可关闭抽屉）
      }
    }
  }
</script>
<style lang="less" scoped>

  /* update_begin author:sunjianlei date:20190509 for: 修改侧边导航栏滚动条的样式 */
  .sider {
    @scrollBarSize: 10px;

    ul.ant-menu {

      /* 定义滚动条高宽及背景 高宽分别对应横竖滚动条的尺寸*/
      &::-webkit-scrollbar {
        width: @scrollBarSize;
        height: @scrollBarSize;
        background-color: transparent;
        display: none;
      }

      & .-o-scrollbar {
        display: none;
      }

      /* 兼容IE */
      -ms-overflow-style: none;
      -ms-scroll-chaining: chained;
      -ms-content-zooming: zoom;
      -ms-scroll-rails: none;
      -ms-content-zoom-limit-min: 100%;
      -ms-content-zoom-limit-max: 500%;
      -ms-scroll-snap-type: proximity;
      -ms-scroll-snap-points-x: snapList(100%, 200%, 300%, 400%, 500%);

      /* 定义滚动条轨道 */
      &::-webkit-scrollbar-track {
        background-color: transparent;
      }

      /* 定义滑块 */
      &::-webkit-scrollbar-thumb {
        border-radius: @scrollBarSize;
        background-color: #eee;
        box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.1);

        &:hover {
          background-color: #dddddd;
        }

        &:active {
          background-color: #bbbbbb;
        }
      }
    }

    /** 暗色系滚动条样式 */
    &.dark ul.ant-menu {
      &::-webkit-scrollbar-thumb {
        background-color: #666666;

        &:hover {
          background-color: #808080;
        }

        &:active {
          background-color: #999999;
        }
      }
    }

  }

  /* update_end author:sunjianlei date:20190509 for: 修改侧边导航栏滚动条的样式 */

  .sider-content {
    display: flex;
    flex-direction: column;
    height: 100%;
  }

  .sider-setting-entry {
    flex-shrink: 0;
    display: flex;
    align-items: center;
    padding: 0 24px;
    height: 48px;
    cursor: pointer;
    transition: all 0.3s;
    line-height: 48px;
    border-top: 1px solid rgba(0, 0, 0, 0.06);

    .anticon { margin-right: 12px; font-size: 16px; }
    .sider-setting-text { white-space: nowrap; }

    &:hover { background: rgba(0, 0, 0, 0.04); }

    &.dark {
      color: rgba(255, 255, 255, 0.65);
      border-top-color: rgba(255, 255, 255, 0.08);
      &:hover { background: rgba(255, 255, 255, 0.08); color: #fff; }
    }
  }
</style>

<!-- update_begin author:sunjianlei date:20190530 for: 选中首页的时候不显示背景颜色 -->
<style lang="less">
   // 选中首页的时候不显示背景颜色，只应用于左侧菜单
  .sider .ant-menu.ant-menu-root {
    & > .ant-menu-item:first-child {
      background-color: transparent;

      & > a, & > a:hover {
        color: rgba(0, 0, 0, 0.65);
      }

      &.ant-menu-item-selected {
        & > a, & > a:hover {
          color: @primary-color;
        }
      }
    }

    &.ant-menu-dark > .ant-menu-item:first-child {
      & > a, & > a:hover {
        color: rgba(255, 255, 255, 0.65);
      }

      &.ant-menu-item-selected {
        & > a, & > a:hover {
          color: rgba(255, 255, 255, 1);
        }
      }
    }
  }
</style>
<!-- update_end author:sunjianlei date:20190530 for: 选中首页的时候不显示背景颜色 -->
