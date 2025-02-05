import RoutePath from '../RoutePath'
import { HMRouter } from '@hadss/hmrouter'
import {web_webview} from



@HMRouter({ pageUrl: RoutePath.WebViewPage })
@Component
export  default  struct WebViewPage{
  private webUrl: string = ''
  controller: web_webview.WebviewController = new web_webview.WebviewController()

  build() {
    Column() {
      // 组件创建时，加载www.example.com
      Web({ src: 'https//:www.baidu.com', controller: this.controller })
    }
    .width('100%')
    .height('100%')
  }

  onPageShow(): void {
    // const params = router.getParams()
    // if (params) {
    //   this.webUrl = params.webUrl as string
    //
    // }
  }

  onPageHide(): void {
  }
}