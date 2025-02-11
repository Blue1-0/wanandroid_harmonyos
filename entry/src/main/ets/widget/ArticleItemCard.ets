@Component
export default struct ArticleItemCard {
  @Prop img: ResourceStr
  @Prop type: string
  @Prop content: string
  @Prop time: string
  @Prop lgImg: ResourceStr
  onItemClick: () => void = () => {
  }

  build() {
    Column() {
      Row() {
        Image(this.img)
          .width(25)
          .height(25)
          .objectFit(ImageFit.Fill)
          .borderRadius(25)

        Text(this.type)
          .fontSize(12)
          .fontColor($r('app.color.text_black'))

      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Text(this.content)
        .maxLines(3)
        .fontSize(12)
        .margin({ top: 5 })
        .fontColor($r('app.color.text_gray'))
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
      Row() {


        Text(this.time)
          .fontSize(12)
          .fontColor($r('app.color.text_gray'))

        Image(this.lgImg)
          .width(20)
          .height(20)
          .objectFit(ImageFit.Fill)

      }
      .width('100%')
      .margin({ top: 5 })
      .alignItems(VerticalAlign.Bottom)
      .justifyContent(FlexAlign.SpaceBetween)

    }
    .width('100%')
    .padding({
      left: 8,
      right: 8,
      top: 5,
      bottom: 5
    })
    // .margin({ left: 8, right: 8 })
    .borderRadius(8)
    .backgroundColor($r('app.color.white'))
    .onClick(() => this.onItemClick())
  }
}