import RoutePath from '../RoutePath'
import { HMRouter, HMRouterMgr } from '@hadss/hmrouter'
import web_webview from '@ohos.web.webview'
import { LogUtil } from '@pura/harmony-utils'
import { NavBar } from '@peakmain/library/src/main/ets/components'
import { WebPageModel } from '../models/models'
import LoadingDialog from '@lyb/loading-dialog'


@HMRouter({ pageUrl: RoutePath.WebViewPage })
@Component
export default struct WebViewPage {
  @State webUrl: string = ''
  @State title: string = ''
  private webController: WebviewController = new web_webview.WebviewController()

  build() {
    Column() {
      NavBar({
        title: this.title || "网页加载中",
        showLeftClose: false,
        backgroundColorResource: $r('app.color.CE7E7E7'),
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
          // LoadingDialog.showLoading("网页加载中...")
          // 在 Web 组件初始化完成后加载 URL
          if (this.webUrl) {
            this.webController.loadUrl(this.webUrl)
          }
        })
        .onPageEnd(() => {
          // LoadingDialog.hide()
        })
    }
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height('100%')
  }

  aboutToAppear(): void {
    LogUtil.warn('===onPageShow===')
    const param = HMRouterMgr.getCurrentParam() as WebPageModel
    if (param) {
      this.webUrl = param.url
      this.title = param.title
    }
  }

  aboutToDisappear(): void {
    LogUtil.warn('===onPageHide===')
  }
}