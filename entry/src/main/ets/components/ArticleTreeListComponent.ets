@Component
export default struct ArticleTreeListComponent {
  build() {

    Column() {

      Column() {
      }
      .height(200)
      .width('100%')
      .backgroundColor($r('app.color.text_blue'))

      Column() {
      }
      .height('200')
      .width('100%')
      // .flexGrow(1)
      .backgroundColor($r('app.color.yellow'))

      Column() {
        Text('内容区域')
          .fontSize(16)
          .fontColor(Color.Black)
      }
      // .height('100%')
      .width('100%')
      .flexGrow(1)
      .margin({ top: 10, bottom: 10 })
      .backgroundColor($r('app.color.text_blue'))

    }
    .width('100%')
    .height('100%')
    .clip(false)
  }
}