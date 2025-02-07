import { LitheRefresh, RefreshController } from "@abner/lithe_refresh"
import { HMRouter, HMRouterMgr } from "@hadss/hmrouter"
import { NavBar } from "@peakmain/library"
import { ToastUtil } from "@pura/harmony-utils"
import DataManager from "../core/DataManager"
import { ParamProjectsItemPageModel, ProjectListEntity, ProjectListEntityDatas } from "../models/models"
import RoutePath from "../RoutePath"
import ProjectListItemCard from "../widget/ProjectListItemCard"

@HMRouter({ pageUrl: RoutePath.ProjectListItemPage })
@Component
export default struct ProjectListComponent {
  @State title: string = ''
  @State cid: number = -1
  pageIndex: number = 0
  @State entityList: ProjectListEntityDatas[] = []
  private mSwiperController: SwiperController = new SwiperController();
  private refreshController: RefreshController = new RefreshController();
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
        isScrollSpring: true,
        enableRefresh: true,
        enableLoadMore: true,
        itemLayout: () => this.itemLayout(),
        scroller: this.scroller,
        controller: this.refreshController,
        onRefresh: () => {
          this.pageIndex = 0
          this.queryProjectListItem(this.pageIndex)
        },
        onLoadMore: () => {
          this.pageIndex++;
          this.queryProjectListItem(this.pageIndex)
        }
      })
        .flexGrow(1)
        .width('100%')
        .margin({ top: 10, bottom: 10 })
        .clip(false)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  itemLayout() {
    // 最新的文章列表
    // Column({ space: 10 }) {
    List({ scroller: this.scroller, space: 10 }) {
      // 使用 ArticleCard 组件并传入属性值
      ForEach(this.entityList, (item: ProjectListEntityDatas) => {
        ListItem() {
          ProjectListItemCard({
            img: item.envelopePic,
            userImg: item.envelopePic,
            title: item.title,
            author: item.author,
            apkUrl: item.apkLink,
            content: item.desc,
            time: item.niceDate
          })

        }
      }, (item: ProjectListEntityDatas) => "" + item.id)
    }
    .width('100%')
    .height('100%')
    .margin({ bottom: 10 })
    .padding({ left: 10, right: 10, bottom: 10 })

  }

  aboutToAppear(): void {
    const param = HMRouterMgr.getCurrentParam() as ParamProjectsItemPageModel
    if (param) {
      this.cid = param.cid
      this.title = param.title
    }
    this.queryProjectListItem(this.pageIndex)

  }

  private queryProjectListItem(page: number) {
    if (this.cid == -1) {
      return
    }
    DataManager.fetchProjectTypeLst("" + this.cid, page)
      .onSuccess((data: ProjectListEntity) => {
        if (data) {
          this.entityList = data.datas
        }
      })
      .onFailed((errCode, errMsg, _) => {
        ToastUtil.showToast(errCode + " " + errMsg)
      })
  }
}