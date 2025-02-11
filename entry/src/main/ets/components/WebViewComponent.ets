import RoutePath from '../RoutePath'
import { HMRouter, HMRouterMgr } from '@hadss/hmrouter'
import web_webview from '@ohos.web.webview'
import { LogUtil } from '@pura/harmony-utils'
import { WebPageModel } from '../models/models'
import { NavBar } from '@peakmain/library'


@HMRouter({ pageUrl: RoutePath.WebViewPage })
@Component
export default struct WebViewPage {
  @State webUrl: string = ''
  @State title: string = ''
  @State webProgress: number = 0
  @State hideProgress: boolean = false
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

      Progress({ value: this.webProgress, total: 100 })
        .width('100%')
        .height(2)
        .color($r('app.color.text_blue_press'))
        .visibility(this.hideProgress ? Visibility.None : Visibility.Visible)

      // 组件创建时，加载www.example.com
      Web({ src: 'about:blank', controller: this.webController })
        .width('100%')
        .height('100%')
        .flexGrow(1)
        .onProgressChange(e => {
          this.webProgress = e.newProgress
          if (this.webProgress == 100) {
            this.hideProgress = true
          } else {
            this.hideProgress = false
          }
        })
        .onPageBegin(() => {
          // 在 Web 组件初始化完成后加载 URL
          if (this.webUrl) {
            this.webController.loadUrl(this.webUrl)
          }
        })
        .onPageEnd(() => {
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