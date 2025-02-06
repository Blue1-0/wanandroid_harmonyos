import RoutePath from '../RoutePath'
import { HMPageParam, HMRouter, HMRouterMgr } from '@hadss/hmrouter'
import web_webview from '@ohos.web.webview'
import { ArticleEntityDatas } from '../models/models'
import AppBarComponent from './AppBarComponent'
import { LogUtil } from '@pura/harmony-utils'
import LoadingUtils from '../utils/LoadingUtils'


@HMRouter({ pageUrl: RoutePath.WebViewPage })
@Component
export default struct WebViewPage {
  @State webUrl: string = ''
  @State title: string = ''
  private webController: WebviewController = new web_webview.WebviewController()

  build() {
    Column() {
      AppBarComponent({
        title: this.title || "网页加载中",
        leftButtonText: "返回",
        leftClick: () => {
          HMRouterMgr.pop()
        }
      })
      // 组件创建时，加载www.example.com
      Web({ src: 'about:blank', controller: this.webController })
        .width('100%')
        .height('100%')
        .flexGrow(1)
        .onPageBegin(() => {
          LoadingUtils.showLoading()
          // 在 Web 组件初始化完成后加载 URL
          if (this.webUrl) {
            this.webController.loadUrl(this.webUrl)
          }
        })
        .onPageEnd(() => {
          LoadingUtils.hideLoading()
        })
    }
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height('100%')
  }

  aboutToAppear(): void {
    LogUtil.warn('===onPageShow===', 'WebViewPage')
    const param = HMRouterMgr.getCurrentParam() as ArticleEntityDatas
    LogUtil.warn('param: ' + JSON.stringify(param), 'WebViewPage')
    if (param) {
      this.webUrl = param.link
      this.title = param.chapterName
    }
  }

  aboutToDisappear(): void {
    LogUtil.warn('===onPageHide===', 'WebViewPage')
  }
}