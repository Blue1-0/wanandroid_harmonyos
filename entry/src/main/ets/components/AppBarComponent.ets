// 定义AppBar组件
@Component
export default struct AppBarComponent {
  // 标题文本
  @Prop title: string = '';
  // 左边按钮的文本
  @Prop leftButtonText: string = '';
  // 右边按钮的文本
  @Prop rightButtonText: string = '';
  leftClick: () => void = () => {
  };
  rightClick: () => void = () => {
  };

  build() {
    Row() {
      if (this.leftButtonText) {
        Text(this.leftButtonText)
          .onClick(() => {
            this.leftClick();
          })
          .fontColor($r("app.color.white"))
          .fontSize(16)
          .padding(10);
      }
      Text(this.title)
        .fontSize(20)
        .fontColor($r("app.color.white"))
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
        .width("auto")
        .flexGrow(1)
        .margin({ left: this.leftButtonText ? 0 : 'auto', right: this.rightButtonText ? 0 : 'auto' });
      if (this.rightButtonText) {
        Text(this.rightButtonText)
          .onClick(() => {
            this.rightClick();
          })
          .fontColor($r("app.color.white"))
          .fontSize(16)
          .padding(10);
      }
    }
    .width("100%")
    .height(47)
    .backgroundColor($r("app.color.blue"))
    .justifyContent(FlexAlign.SpaceBetween);
  }
}


