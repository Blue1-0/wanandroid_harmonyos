import { HMDefaultGlobalAnimator, HMNavigation, HMRouterMgr } from '@hadss/hmrouter';
import router from '@ohos.router'
import RoutePath from '../RoutePath'
import { AttributeUpdater } from '@kit.ArkUI';


/**
 * 界面样式公用函数
 */
class NavModifier extends AttributeUpdater<NavigationAttribute> {
  initializeModifier(instance: NavigationAttribute): void {
    instance.mode(NavigationMode.Stack);
    instance.navBarWidth('100%');
    instance.hideTitleBar(true);
    instance.hideToolBar(true);
  }
}


@Entry
@Component
struct Index {
  modifier: NavModifier = new NavModifier()
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
    Column() {
      HMNavigation({
        navigationId: 'mainNavigation',
        homePageUrl: RoutePath.MainPage,
        options: {
          standardAnimator: HMDefaultGlobalAnimator.STANDARD_ANIMATOR,
          dialogAnimator: HMDefaultGlobalAnimator.DIALOG_ANIMATOR,
          modifier: this.modifier
        }
      }) {
        Text("Let's go,HarmonyOS Next..." + this.count)
          .fontSize('25vp')
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
      }
    }
    .height('100%')
    .width('100%')
  }
}