import HomePageComponent from '../components/HomePageComponent';
import * as size from '../theme/size'
import { DisplayUtil } from '@pura/harmony-utils';
import ProjectsPageComponent from '../components/ProjectsPageComponent';
import ArticleTreeListComponent from '../components/ArticleTreeListComponent';
import { HMRouter } from '@hadss/hmrouter';
import RoutePath from '../RoutePath';
import MePageComponent from './MePageComponent';

/**
 * @author wzg
 * desc:
 */

@HMRouter({ pageUrl: RoutePath.MainPage })
@Component
export default struct MainPageComponent {
  @State activeIndex: number = 0;
  @State isInitPage: Array<boolean> = [true, false, false, false];

  build() {
    Column() {

      Tabs({
        index: this.activeIndex,
        barPosition: BarPosition.End
      }) {
        TabContent() {
          HomePageComponent({
            mHeight: this.calcHeight()
          })
        }
        // .padding({ bottom: 100 })
        // .margin({ bottom: 100 })
        .height(this.calcHeight())
        .tabBar(this.tabBuilder(0, '首页', $r('app.media.icon_home_checked'), $r('app.media.icon_home_default')))

        TabContent() {
          ProjectsPageComponent()
        }
        .height(this.calcHeight())
        .tabBar(this.tabBuilder(1, '项目', $r('app.media.icon_project_checked'), $r('app.media.icon_project')))

        TabContent() {
          ArticleTreeListComponent()
        }
        .height(this.calcHeight())
        .tabBar(this.tabBuilder(2, '知识体系', $r('app.media.icon_zhishi_checked'), $r('app.media.icon_zhishi_default')))

        TabContent() {
          MePageComponent()
        }
        .height(this.calcHeight())
        .tabBar(this.tabBuilder(3, '我的', $r('app.media.icon_me_checked'), $r('app.media.icon_me')))
      }
      .barHeight(70)
      .barWidth('100%')
      .barMode(BarMode.Fixed)
      .onChange((index) => {
        this.isInitPage[index] = true;
        this.activeIndex = index;
      });

    }
    .width('100%')
    .height('100%')
  }

  calcHeight(): number {
    const barHeightValue = 70; // 这里的 70 对应 barHeight(size.vp_70)
    const screenHeight: number = DisplayUtil.getHeight() - barHeightValue; // 获取屏幕高度
    return screenHeight
  }

  @Builder
  tabBuilder(index: number, title: string, selectedImage: Resource, normalImage: Resource) {
    Column() {
      Image(this.activeIndex == index ? selectedImage : normalImage)
        .width(32)
        .height(32)
        .objectFit(ImageFit.Contain)
        .margin({ top: size.vp_10, bottom: size.vp_10 });
      Text(title)
        .fontColor(this.activeIndex == index ? $r('app.color.text_blue') : $r('app.color.text_black'))
        .fontSize(size.fp_16)
        .padding({ bottom: size.vp_20 });
    }.width('100%')
    .height(size.vp_70)
    // .backgroundColor($r('app.color.CC9E6FF'))
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