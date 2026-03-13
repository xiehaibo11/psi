/**
 * 建行企业银行跳转配置
 * 建行企业网银官方地址：https://b2bbank.ccb.com
 */
export const CCB_EBANK_URL = 'https://b2bbank.ccb.com'

/**
 * 一键跳转建行企业银行，新窗口打开
 */
export function goToCcbEbank() {
  window.open(CCB_EBANK_URL, '_blank', 'noopener,noreferrer')
}
