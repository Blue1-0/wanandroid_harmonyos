import { HMRouter, HMRouterMgr } from "@hadss/hmrouter"
import { NavBar } from "@peakmain/library"
import RoutePath from "../RoutePath"
import { pasteboard } from "@kit.BasicServicesKit"
import { LogUtil, ToastUtil } from "@pura/harmony-utils"

/**
 * @author wzg
 * desc:声明
 */

@HMRouter({ pageUrl: RoutePath.StatementPageComponent })
@Component
export default struct StatementPageComponent {
  build() {

    Column() {
      NavBar({
        title: "声明与介绍",
        showLeftClose: false,
        backgroundColorResource: $r('app.color.CE7E7E7'),
        leftClick: () => {
          HMRouterMgr.pop()
        }
      })
      //detail
      Column() {
        Text("1.此app是基于HarmonyOS 5.0.0开发的。")
          .fontColor($r('app.color.text_black'))
          .maxLines(4)
          .margin({ top: 10 })
          .width('100%')
          .textAlign(TextAlign.Start)
          .fontSize(20)
        Text("2.代码都是开源的，非盈利性质的。")
          .fontColor($r('app.color.text_black'))
          .textAlign(TextAlign.Start)
          .margin({ top: 10 })
          .width('100%')
          .maxLines(4)
          .fontSize(20)
        Text("3.此项目是学习过程开发的项目，诸多不足请海涵，欢迎提出改进意见。")
          .fontColor($r('app.color.text_blue'))
          .textAlign(TextAlign.Start)
          .width('100%')
          .margin({ top: 10 })
          .maxLines(4)
          .fontSize(20)


        Text("4.项目开源不具备入侵性，任何非作者改动，造成任何影响概不负责。")
          .fontColor($r('app.color.text_blue'))
          .textAlign(TextAlign.Start)
          .width('100%')
          .margin({ top: 20 })
          .maxLines(4)
          .fontSize(20)
        Text("5.项目讨论和技术交流，欢迎联系我，首页作者页附带联系方式。")
          .fontColor($r('app.color.text_blue'))
          .textAlign(TextAlign.Start)
          .width('100%')
          .margin({ top: 20 })
          .maxLines(4)
          .fontSize(20)

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