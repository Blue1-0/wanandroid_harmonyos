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
              .flexShrink(1)
              .ellipsisMode(EllipsisMode.END)
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')

          Column() {
            Text(this.content)
              .fontSize(12)
              .fontColor($r('app.color.text_black'))
              .maxLines(4)
              .ellipsisMode(EllipsisMode.END)
              .flexShrink(1)
          }
          .margin({ right: 10, top: 5, bottom: 5 })
          .padding({ bottom: 5 })
          .width('100%')
          .backgroundColor($r('app.color.white'))
          .layoutWeight(1)
          // .clip(true)

          Row() {
            Text(this.time)
              .fontSize(12)
              .fontColor($r('app.color.text_blue'))
            Text(this.author)
              .fontSize(12)
              .fontColor($r('app.color.text_black'))
            Text("无")
              .fontSize(12)
              .fontColor($r('app.color.text_yellow'))
          }
          .width('100%')
          // .flexGrow(1)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .layoutWeight(1)
        .padding({ left: 10, right: 10 })
      }
    }
    .padding({
      left: 10,
      right: 10,
      top: 8,
      bottom: 8
    })
    .height(120)
    .width('100%')
    .backgroundColor($r("app.color.CE7E7E7"))
    .borderRadius(8)
  }
}