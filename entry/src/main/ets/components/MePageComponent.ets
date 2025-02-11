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
  private name: string = 'wzg-harmonyOs'
  private sex: string = '男'
  private other: string = '2025.02.3'

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
            Text(this.name)
              .fontSize(12)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .fontColor($r('app.color.text_blue'))
            Text(this.sex)
              .fontSize(12)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .fontColor($r('app.color.text_blue'))
            Text(this.other)
              .fontSize(12)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .fontColor($r('app.color.text_blue'))
          }.width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')

        Text("玩Android的HarmonyOS版本")
          .fontSize(12)
          .fontColor($r('app.color.text_blue'))


      }
      .width('100%')
      .borderRadius(8)
      .backgroundColor($r('app.color.CE7E7E7'))


      Row()
        .width('100%')
        .height(40)
        .borderRadius(8)
        .backgroundColor($r('app.color.CE7E7E7'))
        .margin({top:10})

    }
    .width('100%')
    .height('100%')

    .backgroundColor($r('app.color.white'))
  }
}