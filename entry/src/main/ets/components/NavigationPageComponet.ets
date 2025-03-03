import { HMRouter, HMRouterMgr } from "@hadss/hmrouter";
import { NavBar } from "@peakmain/library";
import { ToastUtil } from "@pura/harmony-utils";
import dataManager from "../core/DataManager";
import { NavJsonEntity, NavJsonEntityArticles } from "../models/models";
import RoutePath from "../RoutePath";

// 定义类型别名
interface ContentItem {
  title: string;
  items: string[];
}

@HMRouter({ pageUrl: RoutePath.NavigationPageComponent })
@Component
export default struct NavigationPageComponent {
  @State private dataList: NavJsonEntity[] = []
  @State private currentSection: number = 0
  // 滚动控制器
  leftScrollController: Scroller = new Scroller();
  rightScrollController: Scroller = new Scroller();

  build() {
    Column() {
      NavBar({
        title: "导航",
        showLeftClose: false,
        backgroundColorResource: $r('app.color.CE7E7E7'),
        leftClick: () => HMRouterMgr.pop()
      })

      Row() {
        // 左侧分类列表
        this.BuildLeftCategories()

        // 右侧内容区
        this.BuildRightContent()
      }
      .height('90%')
    }
    .width('100%')
    .height('100%')
  }

  aboutToAppear(): void {
    dataManager.getNaviJson()
      .onSuccess((data: NavJsonEntity[]) => {
        if (data) {
          this.dataList = data
        }
      })
      .onFailed((_, errMsg) => {
        ToastUtil.showToast(errMsg)
      })
  }

  @Builder
  BuildLeftCategories() {
    Scroll(this.leftScrollController) {
      Column() {
        ForEach(this.dataList, (category: NavJsonEntity, index: number) => {
          ListItem() {
            Text(category.name)
              .fontSize(16)
              .padding(10)
          }
          .onClick(() => {
            // 点击时滚动到对应位置
            this.currentSection = index
            this.ScrollToSection(index)
          })
          .backgroundColor(index === this.currentSection ? '#f0f4ff' : '#fff')
        })
      }
    }
    .width('30%')
    .height('100%')
    .scrollBar(BarState.Off)
  }

  @Builder
  BuildRightContent() {
    Scroll(this.rightScrollController) {
      Column() {
        ForEach(this.dataList, (indexEntity: NavJsonEntity) => {
          Column() {
            Text(indexEntity.name)
              .fontSize(20)
              .margin({ bottom: 10 });

            Column() {
              ForEach(indexEntity.articles, (item: NavJsonEntityArticles) => {
                Text(item.title)
                  .fontSize(12)
                  .padding(10)
                  .maxLines(1)
                  .ellipsisMode(EllipsisMode.END)
              })
            }
            .width('100%')
            .borderRadius(8)
            .backgroundColor('#f8f9fa')
            .margin({ bottom: 20 })
          }
          .id(indexEntity.cid + "") // 为每个分类设置锚点
        })
      }
    }
    .width('70%')
  }

  // 滚动到指定分类
  private ScrollToSection(index: number) {
    // 计算目标位置
    // const targetOffset = index * 200
    // 根据实际内容高度调整
    // this.rightScrollController.scrollTo({
    //   yOffset: targetOffset,
    //   animation: { duration: 300, curve: Curve.Ease },
    //   xOffset: "0"
    // })
    this.rightScrollController.scrollToIndex(index)
  }
}

