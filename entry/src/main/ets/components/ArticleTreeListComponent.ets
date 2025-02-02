import { ToastUtil } from "@pura/harmony-utils"
import { KHEntity, KHEntityChildren } from "../models/models"
import NetworkUtils from "../models/net_work_util"

@Component
struct TreeItem {
  @Prop text: string
  @Prop childList: KHEntityChildren[] = []
  @Prop expanded: boolean

  // @State childOnClick: (item: KHEntityChildren) => void = () => {
  // }


  build() {
    Column() {
      Text(this.text)
        .fontColor($r('app.color.text_black'))
        .fontSize(12)
        .margin({ top: 10 })
        .textAlign(TextAlign.Start)
        .maxLines(1)
        .onClick(() => {
          this.expanded = !this.expanded
        })
      // 画一条水平线
      Divider()
        .strokeWidth(1)// 线的宽度
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
                  .margin({ top: 10 })
                  .padding({ left: 15, right: 15 })
                  .maxLines(1)
                  .onClick(() => {
                    // this.childOnClick(item)
                  })
                Divider()
                  .margin({ left: 10, right: 10, top: 10 })
                  .strokeWidth(1)
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

@Component
export default struct ArticleTreeListComponent {
  @State entityList: KHEntity[] = []

  // @State handlerOnClick: (item: KHEntityChildren) => void = (item) => {
  //   // 处理点击逻辑
  // }

  build() {

    Column() {

      List({ space: 0 }) {
        ForEach(this.entityList, (item: KHEntity) => {
          ListItem() {

            TreeItem({
              text: item.name,
              childList: item.children,
              expanded: item.expanded,
              // childOnClick:()=>{}
            })

          }
        }, (itme: KHEntity) => "" + itme.id)
      }.width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

    }
    .width('100%')
    .height('100%')
    .padding({ bottom: 10 })
    .clip(false)
  }

  aboutToAppear(): void {
    //知识体系
    NetworkUtils.fetchTreeList((entity: KHEntity[]) => {
      this.entityList = entity;
    })
  }
}