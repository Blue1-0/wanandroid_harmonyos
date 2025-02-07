//文章卡片
@Component
export default struct ArticleCard {
  @Prop title: string
  @Prop content: string
  @Prop author: string
  @Prop lg: boolean
  @Prop time: string
  onProcess: () => void = () => {
  };

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.title)
            .maxLines(1)
            .fontColor($r('app.color.text_black'))
            .fontSize(12)

          Text(this.content)
            .maxLines(2)
            .fontColor($r('app.color.text_gray'))
            .fontSize(12)
            .margin({ top: 5 })
        }
        .flexBasis('80%')
        .flexGrow(0)
        .flexShrink(1)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Start)

        Column() {
          Image(this.lg ? $r('app.media.lg_checked') : $r('app.media.lg_default'))
            .height(24)
            .width(24)
            .objectFit(ImageFit.Contain)
            .alignSelf(ItemAlign.End)
        }
        .flexBasis('20%')
        .flexGrow(1)
        .flexShrink(1)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        // .backgroundColor($r('app.color.text_gray'))
      }
      .width('100%')

      Row() {
        Text(this.author)
          .maxLines(1)
          .fontColor($r('app.color.text_black'))
          .fontSize(12)
        Text(this.time)
          .maxLines(1)
          .fontColor($r('app.color.text_black'))
          .fontSize(12)
      }
      .width("100%")
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 5 })

    }
    .width('100%')
    .borderRadius(8)
    .backgroundColor($r('app.color.white'))
    .padding(10)
    .onClick(() => {
      this.onProcess();
    })
  }
}