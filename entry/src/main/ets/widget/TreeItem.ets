import { KHEntityChildren } from "../models/models"

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

      if (this.childList.length > 0 && this.expanded) {
        List() {
          ForEach(this.childList, (item: KHEntityChildren) => {
            ListItem() {
              Column() {
                Text(item.name)
                  .fontColor($r('app.color.text_blue'))
                  .fontSize(12)
                  .textAlign(TextAlign.Start)
                  .margin({ left: 15, right: 15, top: 10 })
                  .padding({ left: 10 })
                  .maxLines(1)
                  .width('100%')
                  .onClick(() => this.onChildClick())
                Divider()
                  .margin({ left: 10, right: 10, top: 10 })
                  .strokeWidth('0.5')
                  .color($r('app.color.text_blue'))
              }.width('100%')
              .alignItems(HorizontalAlign.Start)
              .backgroundColor($r("app.color.CE7E7E7"))
            }
          }, (item: KHEntityChildren) => "" + item.id)
        }
        .width('100%')
      }
    }
    .alignItems(HorizontalAlign.Start)
    .backgroundColor($r('app.color.white'))
    .width('100%')
  }
}