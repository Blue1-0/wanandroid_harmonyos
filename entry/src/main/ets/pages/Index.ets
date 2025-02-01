import router from '@ohos.router'
import RoutePath from '../RoutePath'

@Entry
@Component
struct Index {
  @State count: number = 6;
  private timerId: number = -1;

  startCountdown() {
    this.timerId = setInterval(() => {
      if (this.count > 0) {
        this.count -= 1;
      } else {
        this.stopCountdown();
        //跳转
        router.replaceUrl({ url: RoutePath.MainPage });
      }
    }, 1000)
  }

  stopCountdown() {
    if (this.timerId != -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }

  onPageShow(): void {
    this.startCountdown();
  }

  build() {
    RelativeContainer() {
      Text("Let's go,HarmonyOS Next..." + this.count)
        .fontSize('25vp')
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}