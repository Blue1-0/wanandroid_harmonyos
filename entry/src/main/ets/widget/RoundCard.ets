@Component
export default struct RoundCard {
  @Prop image: Resource
  @Prop text: string

  build() {

    Column() {
      Image(this.image)
        .width(40)
        .height(40)
        .objectFit(ImageFit.Contain)
      // .tintColor(Color.Blue)
      Text(this.text)
        .fontSize(16)
        .fontColor($r('app.color.text_blue'))
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .padding({ top: 10, bottom: 10 })
    .borderRadius(8)
  }
}
