@Component
export default struct ProjectListItemCard {
  @Prop img: string
  @Prop userImg: string
  @Prop title: string
  @Prop content: string
  @Prop time: string
  @Prop author: string
  @Prop apkUrl: string
  onImgClick: (img: string) => void = () => {
  }

  build() {

    Column() {


      Row() {
        Image(this.img)
          .width(50)
          .height(100)
          .objectFit(ImageFit.Fill)
          .onClick(() => {
            this.onImgClick(this.img);
          })
        Column() {
          Row() {
            Image(this.userImg)
              .width(20)
              .height(20)
              .objectFit(ImageFit.Fill)
              .borderRadius(10)
            Text(this.title)
              .fontSize(12)
              .fontColor($r('app.color.text_black'))
              .maxLines(1)
              .margin({ left: 5 })
              .ellipsisMode(EllipsisMode.END)
          }.width('100%')

          Row() {
            Text(this.content)
              .fontSize(12)
              .fontColor($r('app.color.text_black'))
              .maxLines(5)
              .ellipsisMode(EllipsisMode.END)
          }
          .flexGrow(1)
          .width('100%')

          Row() {
            Text(this.time)
              .fontSize(12)
              .fontColor($r('app.color.text_blue'))
              .maxLines(1)
              .ellipsisMode(EllipsisMode.END)
            Text(this.author)
              .fontSize(12)
              .fontColor($r('app.color.text_black'))
              .maxLines(1)
              .ellipsisMode(EllipsisMode.END)
            Text("无")
              .fontSize(12)
              .fontColor($r('app.color.text_gray'))
              .maxLines(1)
              .ellipsisMode(EllipsisMode.END)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width('100%')
        .flexGrow(1)
        // .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 10, right: 10 })
      }
      .width('100%')

    }
    .padding({
      left: 10,
      right: 10,
      top: 8,
      bottom: 8
    })
    .width('100%')
    .backgroundColor($r("app.color.CE7E7E7"))
    .borderRadius(8)
  }
}