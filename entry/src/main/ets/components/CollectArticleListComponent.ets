import { LitheRefresh, RefreshController } from "@abner/lithe_refresh"
import { HMRouter, HMRouterMgr } from "@hadss/hmrouter"
import { NavBar } from "@peakmain/library"
import { LogUtil, ToastUtil } from "@pura/harmony-utils"
import DataManager from "../core/DataManager"
import { KHDetailListEntity, KHDetailListEntityDatas, KHEntity, WebPageModel } from "../models/models"
import RoutePath from "../RoutePath"
import ArticleItemCard from "../widget/ArticleItemCard"


/**
 * @author wzg
 * desc: 收藏
 */
@HMRouter({ pageUrl: RoutePath.CollectArticleTypeListComponent })
@Component
export default struct CollectArticleTypeListComponent {
  @State khEntity: KHEntity = {
    articleList: [],
    author: "",
    children: [],
    courseId: 0,
    cover: "",
    desc: "",
    id: 0,
    lisense: "",
    lisenseLink: "",
    name: "",
    order: 0,
    parentChapterId: 0,
    type: null,
    userControlSetTop: false,
    visible: 0,
    expanded: false
  }
  @State title: string = ''
  @State entityList: KHDetailListEntityDatas[] = []
  private pageIndex: number = 0
  private controller: RefreshController = new RefreshController()
  private scroller: Scroller = new Scroller()

  build() {

    Column() {
      NavBar({
        title: this.title,
        showLeftClose: false,
        backgroundColorResource: $r('app.color.CE7E7E7'),
        leftClick: () => {
          HMRouterMgr.pop()
        }
      })

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
        .layoutWeight(1)
    }
    .backgroundColor($r('app.color.CE7E7E7'))
    .width('100%')
    .height('100%')
  }

  aboutToAppear(): void {
    LogUtil.info("=======aboutToAppear=======")

    this.khEntity = HMRouterMgr.getCurrentParam() as KHEntity

    this.fetchArticleList()

  }

  fetchArticleList(): void {
    if (this.khEntity) {
      this.title = this.khEntity.name
      DataManager.getArticleListPageDetail("" + this.khEntity.id, this.pageIndex)
        .onSuccess((data: KHDetailListEntity) => {
          if (data) {
            if (this.pageIndex == 0) {
              this.entityList = data.datas
            } else {
              this.entityList = [...this.entityList, ...data.datas]
            }
          }
          if (this.pageIndex == 0) {
            this.controller.finishRefresh()
          } else {
            this.controller.finishLoadMore()
          }
        })
        .onFailed((errCode, errMsg, _) => {
          if (this.pageIndex == 0) {
            this.controller.finishRefresh()
          } else {
            this.controller.finishLoadMore()
          }
          ToastUtil.showToast(errCode + " " + errMsg)
        })
    }
  }

  @Builder
  buildItemLayout() {

    List({ space: 10, scroller: this.scroller }) {
      ForEach(this.entityList, (entity: KHDetailListEntityDatas) => {
        ListItem() {
          ArticleItemCard({
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
      }, (entity: KHDetailListEntityDatas) => (entity.id + ""))
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