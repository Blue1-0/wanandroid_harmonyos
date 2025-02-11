import { KHEntityChildren } from "../models/models"
/**
 * @author wzg
 * desc:
 */
@Component
export default struct TreeItem {
  @Prop text: string
  @Prop childList: KHEntityChildren[] = []
  @Prop expanded: boolean
  onChildClick: () => void = () => {
  }

  build() {
    Column() {
      Text(this.text)
        .fontColor($r('app.color.text_black'))
        .fontSize(12)
        .margin({ top: 10, left: 15, right: 15 })
        .textAlign(TextAlign.Start)
        .maxLines(1)
        .width('100%')
        .onClick(() => this.expanded = !this.expanded)

      // 画一条水平线
      Divider()
        .strokeWidth(0.5)// 线的宽度
        .color($r('app.color.CE7E7E7'))// 线的颜色
        .margin({ left: 10, right: 10, top: 10 })

      //显示与隐藏的子列表
      List() {
        ForEach(this.childList, (item: KHEntityChildren) => {
          ListItem() {
            Column() {
              Text(item.name)
                .fontColor($r('app.color.text_blue'))
                .fontSize(12)
                .textAlign(TextAlign.Start)
                .margin({
                  left: 15,
                  right: 15,
                  top: 10,
                  bottom: 10
                })
                .padding({ left: 10 })
                .maxLines(1)
                .width('100%')
                .onClick(() => this.onChildClick())

              Divider()
                .margin({ left: 10, right: 10 })
                .strokeWidth('0.5')
                .color($r('app.color.text_blue'))
                .visibility((this.childList.indexOf(item) == this.childList.length - 1) ? Visibility.None :
                Visibility.Visible)


            }.width('100%')
            .alignItems(HorizontalAlign.Start)
            .backgroundColor($r("app.color.CE7E7E7"))
          }
        }, (item: KHEntityChildren) => "" + item.id)
      }
      .width('100%')
      .visibility(this.isVisibility() ? Visibility.Visible : Visibility.None)
    }
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.white'))
    .width('100%')
  }

  isVisibility(): boolean {
    return this.childList.length > 0 && this.expanded
  }
}