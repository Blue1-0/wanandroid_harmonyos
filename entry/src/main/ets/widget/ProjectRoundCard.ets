@Component
export default struct ProjectRoundCard {
  @Prop text: string
  onItemClick: () => void = () => {
  }

  build() {
    Column() {
      Text(this.text.replace(/&amp;/g, "&"))
        .fontSize(14)
        .maxLines(1)
        .fontColor($r("app.color.text_black"))
    }
    .width("100%")
    .padding({
      top: 15,
      bottom: 15,
      left: 10,
      right: 10
    })
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.white'))
    .borderRadius(8)
    .onClick(() => {
      this.onItemClick()
    })
  }
}