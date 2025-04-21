import { HMRouter, HMRouterMgr } from "@hadss/hmrouter"
import { NavBar } from "@peakmain/library"
import RoutePath from "../RoutePath"
import { pasteboard } from "@kit.BasicServicesKit"
import { LogUtil, ToastUtil } from "@pura/harmony-utils"

/**
 * @author wzg
 * desc:声明
 */

@Component
export default struct MePageComponent {
  private name: string = 'WanAndroid-harmonyOS'
  private sex: string = '男'
  private other: string = '2025.01.01'

  build() {
    Column() {
      Column() {
        Row() {
          Image($r('app.media.startIcon'))
            .width(90)
            .width(90)
            .borderRadius(90)
            .objectFit(ImageFit.Fill)

          Column() {
            this.SingleText(this.name)
            this.SingleText(this.sex)
            this.SingleText(this.other)
            this.SingleText("玩Android的HarmonyOS版本,欢迎探讨。")

          }
          .width('100%')
          .height(90)
          .padding({
            top: 5,
            bottom: 5,
            right: 5,
            left: 0
          })
          .margin({ left: 12 })
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')

        // Text("玩Android的HarmonyOS版本,欢迎探讨。")
        //   .fontSize(12)
        //   .maxLines(1)
        //   .margin({ top: 12 })
        //   .width('100%')
        //   .textAlign(TextAlign.Start)
        //   .fontColor($r('app.color.text_blue'))
      }
      .padding({
        left: 10,
        top: 10,
        right: 10,
        bottom: 10
      })
      .width('100%')
      .borderRadius(8)
      .backgroundColor($r('app.color.white'))


      Row() {
        Text("收藏")
          .fontSize(12)
          .textAlign(TextAlign.Center)
          .fontColor($r('app.color.text_gray'))

        Image($r('app.media.lg_checked'))
          .width(25)
          .height(24)
          .objectFit(ImageFit.Fill)
          .onClick(() => {
            ToastUtil.showToast("该功能计划中！！！")
          })

      }
      .commonRowStyle()
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Text("介绍与声明")
          .fontSize(12)
          .textAlign(TextAlign.Center)
          .fontColor($r('app.color.text_gray'))

        Text("查看")
          .fontSize(12)
          .textAlign(TextAlign.Center)
          .fontColor($r('app.color.text_blue'))
          .onClick(() => {
            HMRouterMgr.push({
              pageUrl: RoutePath.StatementPageComponent
            })
          })

      }
      .commonRowStyle()
      .justifyContent(FlexAlign.SpaceBetween)


      Row() {
        Text("版本")
          .fontSize(12)
          .textAlign(TextAlign.Center)
          .fontColor($r('app.color.text_gray'))

        Text("1.0.0")
          .fontSize(12)
          .textAlign(TextAlign.Center)
          .fontColor($r('app.color.text_blue'))
      }
      .commonRowStyle()
      .justifyContent(FlexAlign.SpaceBetween)


      Column() {

        Row() {
          Text("退出登录")
            .textAlign(TextAlign.Center)
            .fontColor($r('app.color.white'))
            .fontSize(14)
        }
        .height(44)
        .justifyContent(FlexAlign.Center)
        .width('90%')
        .backgroundColor($r('app.color.text_blue'))
        .margin({ bottom: 25 })
        .borderRadius(40)
        .onClick(() => {
          ToastUtil.showToast("该功能计划中！！！")
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .layoutWeight(1)

    }
    .padding({ left: 10, right: 10, top: 10 })
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.CE7E7E7'))
  }

  @Styles  commonRowStyle(){
    .width('100%')
    .height(45)
    .padding({ left: 10, right: 10 })
    .borderRadius(8)
    .backgroundColor($r('app.color.white'))
    .margin({ top: 10 })
  }

  @Builder
  SingleText(text: string) {
    Text(text)
      .fontSize(12)
      .maxLines(1)
      .textAlign(TextAlign.Start)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
      .fontColor($r('app.color.text_blue'))
  }
}