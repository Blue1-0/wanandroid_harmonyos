import { LitheRefresh, RefreshController } from "@abner/lithe_refresh"
import { TabLayout } from "@abner/tab"
import { HMRouter, HMRouterMgr } from "@hadss/hmrouter"
import { NavBar } from "@peakmain/library"
import { ToastUtil } from "@pura/harmony-utils"
import DataManager from "../core/DataManager"
import { ProjectListEntityDatas, WebPageModel, WxArticleDetailEntity, WxArticleEntity } from "../models/models"
import RoutePath from "../RoutePath"
import WxArticleItemCard from "../widget/WxArticleItemCard"

/**
 * @author: wzg
 * desc: 公众号列表
 */
@HMRouter({ pageUrl: RoutePath.WechatArticleComponent })
@Component
export default struct WechatArticleComponent {
  private textValue: string = ''
  private controller: RefreshController = new RefreshController()
  private scroller: Scroller = new Scroller()
  //
  @State wxChapters: WxArticleEntity[] = []
  //当前公众号id
  private wxId: number = 0
  private pageIndex: number = 0
  //文章列表
  @State entityList: ProjectListEntityDatas[] = []

  build() {
    Column() {

      //topBar
      NavBar({
        title: '公众号',
        showLeftClose: false,
        backgroundColorResource: $r('app.color.CE7E7E7'),
        leftClick: () => {
          HMRouterMgr.pop()
        }
      })

      //tabs
      TabLayout({
        tabBar: this.mapForNameNewList(),
        itemPage: (index, item) => this.itemPage(() => {
          //搜索
          this.wxId = this.wxChapters[index].id
          this.pageIndex = 0
          this.fetchArticleList()

        }),
        tabAttribute: (tab) => {
          tab.tabItemWidth = undefined
          tab.tabItemMargin = { left: 10, right: 10 }
          //更改下划线的宽度
          tab.tabDividerWidth = undefined
        },
        onChangePage: (position) => {
          //页面改变
          console.log("===页面改变:" + position)
          this.wxId = this.wxChapters[position].id
          this.pageIndex = 0
          this.fetchArticleList()
        },
        onTabBarClick: (position) => {
          //点击改变
          console.log("===点击改变:" + position)
          this.wxId = this.wxChapters[position].id
          this.pageIndex = 0
          this.fetchArticleList()
        }
      })


    }
  }

  /**
   *
   * @returns 取name作为一个新的集合展示
   */
  mapForNameNewList(): string[] {
    return this.wxChapters.map(article => article.name).filter(name => name)
  }

  aboutToAppear(): void {
    this.fetchWxChapters()
  }

  /**
   * tabs
   */
  fetchWxChapters() {
    DataManager.getWxChapters()
      .onSuccess((data: WxArticleEntity[]) => {
        if (data) {
          this.wxChapters = data

          //默认拉取第一个公众号的数据
          if (this.wxChapters) {
            this.pageIndex = 0
            this.wxId = this.wxChapters[0].id
            this.fetchArticleList()
          }

        }
      })
      .onFailed((errCode, errMsg, _) => {
        ToastUtil.showToast(errCode + " " + errMsg)
      })
  }

  /**
   * 文章列表
   */
  fetchArticleList() {
    DataManager.wxArticleListFormId(this.wxId, this.pageIndex, this.textValue)
      .onSuccess((data: WxArticleDetailEntity) => {
        if (data) {
          if (this.pageIndex == 0) {
            this.entityList = data.datas
          } else {
            this.entityList = [...this.entityList, ...data.datas]
          }
        }
        this.finishRefresh()
      })
      .onFailed((errCode, errMsg, _) => {
        this.finishRefresh()
        ToastUtil.showToast(errCode + " " + errMsg)
      })
  }

  finishRefresh(): void {
    if (this.pageIndex == 0) {
      this.controller.finishRefresh()
    } else {
      this.controller.finishLoadMore()
    }
  }

  @Builder
  itemPage(onSearchClick: (text: string) => void) {
    Column() {
      //search
      Row() {
        TextInput({
          placeholder: "请输入内容"
        })
          .height(40)
          .width('80%')
          .fontColor($r('app.color.text_black'))
          .maxLines(1)
          .type(InputType.Normal)
          .fontSize(12)
          .textAlign(TextAlign.Center)
          .placeholderColor($r('app.color.text_gray'))
          .onChange((value) => {
            this.textValue = value
          })
          .margin({ right: 10 })
          .borderRadius(5)

        Button('搜索')
          .height(40)
          .flexGrow(1)
          .borderRadius(8)
          .backgroundColor($r('app.color.text_blue'))
          .onClick(() => onSearchClick(this.textValue))
      }
      .width('100%')
      .height('50')
      .padding({ left: 10, right: 10 })
      .margin({ top: 10 })

      //list
      Column() {
        LitheRefresh({
          enableRefresh: true,
          enableLoadMore: true,
          onRefresh: () => {
            this.pageIndex = 0;
            this.fetchArticleList()
          },
          onLoadMore: () => {
            this.pageIndex++
            this.fetchArticleList();
          },
          itemLayout: () => this.buildItemLayout(),
          controller: this.controller,
          scroller: this.scroller
        })
          .margin({ top: 10 })
          .width('100%')
      }.width('100%')
      .height('100%')
      .backgroundColor($r('app.color.CE7E7E7'))

    }
    .width('100%')
    .height('100%')

  }

  @Builder
  buildItemLayout() {
    List({ space: 10, scroller: this.scroller }) {
      ForEach(this.entityList, (entity: ProjectListEntityDatas) => {
        ListItem() {
          WxArticleItemCard({
            author: entity.author,
            time: entity.niceDate,
            type: entity.superChapterName + "/" + entity.chapterName,
            content: entity.title,
            img: $r('app.media.icon_author_default'),
            lgImg: entity.collect ? $r('app.media.lg_checked') : $r('app.media.lg_default'),
            onItemClick: () => {
              //跳转
              HMRouterMgr.push({
                pageUrl: RoutePath.WebViewPage,
                param: new WebPageModel(entity.link, entity.title)
              })
            }
          })
        }
      }, (entity: ProjectListEntityDatas) => (entity.id + ""))
    }
    .padding({ left: 10, right: 10 })
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.PARENT_FIRST
    })
    .width('100%')
    .height('100%')
  }
}


