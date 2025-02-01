import HomePageComponent from '../components/HomePageComponent';
import * as size from '../theme/size'

@Entry
@Component
struct MainPage {
  @State activeIndex: number = 0;
  @State isInitPage: Array<boolean> = [true, false, false, false];

  //测试提交
  build() {
    Column() {

      Tabs({
        index: this.activeIndex,
        barPosition: BarPosition.End
      }) {
        TabContent() {
          HomePageComponent()
        }
        .tabBar(this.tabBuilder(0, '首页', $r('app.media.icon_home_active'), $r('app.media.icon_home')))

        TabContent() {
          this.TestItem('项目')
        }
        .tabBar(this.tabBuilder(1, '项目', $r('app.media.icon_home_active'), $r('app.media.icon_home')))

        TabContent() {
          this.TestItem('知识体系')
        }
        .tabBar(this.tabBuilder(2, '知识体系', $r('app.media.icon_home_active'), $r('app.media.icon_home')))

        TabContent() {
          this.TestItem('我的')
        }
        .tabBar(this.tabBuilder(3, '我的', $r('app.media.icon_home_active'), $r('app.media.icon_home')))
      }
      .barHeight(size.vp_70)
      .barMode(BarMode.Fixed)
      .onChange((index) => {
        this.isInitPage[index] = true;
        this.activeIndex = index;
      });

    }
    .width('100%')
    .height('100%')
  }

  @Builder
  tabBuilder(index: number, title: string, selectedImage: Resource, normalImage: Resource) {
    Column() {
      Image(this.activeIndex == index ? selectedImage : normalImage)
        .width(size.vp_30)
        .height(size.vp_30)
        .margin({ top: size.vp_10, bottom: size.vp_10 });
      Text(title)
        .fontColor(this.activeIndex == index ? $r('app.color.text_blue') : $r('app.color.text_black'))
        .fontSize(size.fp_16)
        .padding({ bottom: size.vp_20 });
    }.width('100%')
    .height(size.vp_70)
    .backgroundColor($r('app.color.white'))
    .justifyContent(FlexAlign.Center);
  }

  @Builder
  TestItem(title: string) {
    Column() {
      Text(title)
        .fontSize(50)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.text_hint_gray'))
    .height('100%')
    .width('100%')
  }
}