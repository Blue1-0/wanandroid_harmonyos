import { HMRouter, HMRouterMgr } from "@hadss/hmrouter"
import { NavBar } from "@peakmain/library"
import RoutePath from "../RoutePath"
import { pasteboard } from "@kit.BasicServicesKit"
import { LogUtil, ToastUtil } from "@pura/harmony-utils"

/**
 * @author wzg
 * desc:
 */

@HMRouter({ pageUrl: RoutePath.AuthorComponent })
@Component
export default struct AuthorComponent {
  build() {

    Column() {
      NavBar({
        title: "作者介绍",
        showLeftClose: false,
        backgroundColorResource: $r('app.color.CE7E7E7'),
        leftClick: () => {
          HMRouterMgr.pop()
        }
      })
      //detail
      Column() {
        Text("1.作者是专注移动开发的developer，擅长java,kotlin,dart,arkTs,了解C++,C,js,html的使用,主要实战于原始android,原生harmonyOs,跨平台flutter的开发.")
          .fontColor($r('app.color.text_black'))
          .maxLines(4)
          .margin({ top: 10 })
          .width('100%')
          .textAlign(TextAlign.Start)
          .fontSize(20)
        Text("2.关于本开源项目的问提随时交流，欢迎探讨.")
          .fontColor($r('app.color.text_black'))
          .textAlign(TextAlign.Start)
          .margin({ top: 10 })
          .width('100%')
          .maxLines(4)
          .fontSize(20)
        Text("3.联系方式：718603390@qq.com")
          .fontColor($r('app.color.text_blue'))
          .textAlign(TextAlign.Start)
          .width('100%')
          .margin({ top: 10 })
          .maxLines(4)
          .fontSize(20)


        Text("点我复制联系方式")
          .fontColor($r('app.color.text_blue'))
          .textAlign(TextAlign.Start)
          .width('100%')
          .margin({ top: 20 })
          .maxLines(4)
          .fontSize(20)
          .onClick(() => {
            let pasteData: pasteboard.PasteData =
              pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, "718603390@qq.com")
            let systemPasteboard: pasteboard.SystemPasteboard = pasteboard.getSystemPasteboard()
            systemPasteboard.setData(pasteData, (err, data) => {
              if (err) {
                LogUtil.error("===复制失败==")
                ToastUtil.showToast("复制失败：err=" + err.message)
                return
              }
              ToastUtil.showToast("复制成功，请前往粘贴")
            })
          })
      }.width('100%')
      .padding({ top: 10, left: 10, right: 10 })
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')

    .backgroundColor($r('app.color.white'))
  }
}