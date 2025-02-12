import { LitheRefresh, RefreshController } from '@abner/lithe_refresh';
import { ArticleEntityDatas, BannerBean, RowItemBean, WebPageModel } from '../models/models';
import RoundCard from '../widget/RoundCard';
import ArticleCard from '../widget/ArticleCard';
import dataManager from '../core/DataManager';
import { ToastUtil } from '@pura/harmony-utils';
import RoutePath from '../RoutePath';
import { HMRouterMgr } from '@hadss/hmrouter/src/main/ets/api/HMRouterMgr';
import { it, when } from '@ohos/hypium';

/**
 * @author wzg
 * desc:
 */

@Component
export default struct HomePageComponent {
  @Prop mHeight: number;
  private mSwiperController: SwiperController = new SwiperController();
  private refreshController: RefreshController = new RefreshController();
  private scroller: Scroller = new Scroller()
  @State bannerList: BannerBean[] = [];
  @State articleEntityList: ArticleEntityDatas[] = [];
  @State pageIndex: number = 0
  rowItemList: RowItemBean[] = [
    { id: "1", name: "公众号", image: $r('app.media.icon_oa') },
    { id: "2", name: "收藏", image: $r('app.media.icon_collect') },
    { id: "3", name: "导航", image: $r('app.media.icon_daohang') },
    { id: "4", name: "作者介绍", image: $r('app.media.icon_author') }];

  build() {

    Column() {
      //banner
      Swiper(this.mSwiperController) {
        if (this.bannerList) {
          ForEach(this.bannerList, (banner: BannerBean) => {
            Image(banner.imagePath)
              .objectFit(ImageFit.Cover)
              .height(200)
              .width('100%')
              .onClick(() => {
                //跳转
                HMRouterMgr.push({
                  pageUrl: RoutePath.WebViewPage,
                  param: new WebPageModel(banner.url, banner.title)
                })
              })
          }, (banner: BannerBean) => banner.id)
        } else {
          LoadingProgress()
            .width(60)
            .height(60)
          // Text('loading...')
          //   .fontSize(20)
        }
      }
      .loop(true)
      .autoPlay(true)
      .duration(1000)
      .indicator(true)
      .vertical(false)
      .height(200)
      .width('100%')

      //卡片
      Row() {
        ForEach(this.rowItemList, (item: RowItemBean) => {
          this.BuildCard(item.name, item.image, () => {
            if (item.id == '1') {
              HMRouterMgr.push({
                pageUrl: RoutePath.WechatArticleComponent,
                param: item
              })
            } else if (item.id == '2' || '3' == item.id) {
              ToastUtil.showToast("该功能计划中！！！")
            } else if (item.id == '4') {
              HMRouterMgr.push({
                pageUrl: RoutePath.AuthorComponent,
                param: item
              })
            }
          })
        }, (item: RowItemBean) => item.id)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 10 })
      .padding({ left: 10, right: 10 })

      //article list new
      LitheRefresh({
        scroller: this.scroller,
        controller: this.refreshController,
        enableRefresh: true,
        enableLoadMore: true,
        itemLayout: () => this.itemLayout(),
        onRefresh: () => {
          this.pageIndex = 0
          this.fetchArticleList()
        },
        onLoadMore: () => {
          this.pageIndex++;
          this.fetchArticleList()
        }
      })
        .flexGrow(1)
        .width('100%')
        .margin({ top: 10, bottom: 10 })
        .clip(false)
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Start)
    .height('100%')
    .width('100%')
    .backgroundColor($r("app.color.CE7E7E7"))
    .clip(false)

  }

  @Builder
  itemLayout() {
    // 最新的文章列表
    List({ scroller: this.scroller, space: 10 }) {
      // 使用 ArticleCard 组件并传入属性值
      ForEach(this.articleEntityList, (item: ArticleEntityDatas) => {
        ListItem() {
          ArticleCard({
            title: item.superChapterName + "/" + item.chapterName,
            content: item.title,
            author: item.author,
            lg: item.collect, // 根据实际情况传入布尔值
            time: item.niceDate,
            onProcess: () => {
              //跳转
              HMRouterMgr.push({
                pageUrl: RoutePath.WebViewPage,
                param: new WebPageModel(item.link, item.title)
              })
            }
          })
        }
      }, (item: ArticleEntityDatas) => "" + item.id)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.PARENT_FIRST
    })
    .margin({ bottom: 10 })
    .padding({ left: 10, right: 10, bottom: 10 })

  }

  @Builder
  BuildCard(itemStr: string, img: Resource, onItemClick: () => void) {
    Row() {
      RoundCard({
        image: img,
        text: itemStr
      })
    }
    .onClick(() => onItemClick())
    .backgroundColor($r('app.color.white'))
    .width('23%')
    .borderRadius(8)
  }

  aboutToAppear(): void {
    this.fetchBannerList();
    this.fetchArticleList();
  }

  fetchBannerList(): void {
    dataManager.fetchBannerList()
      .onSuccess((data) => {
        this.bannerList = data
      })
      .onFailed((errCode, errMsg, _) => {
        ToastUtil.showToast(errCode + " " + errMsg)
      })
  }

  fetchArticleList(): void {
    dataManager.fetchArticleList(this.pageIndex)
      .onSuccess((data) => {
        if (this.pageIndex == 0) {
          this.articleEntityList = data.datas
        } else {
          this.articleEntityList = [...this.articleEntityList, ...data.datas]
        }
        this.finishRefresh()
      })
      .onFailed((errCode, errMsg, _) => {
        ToastUtil.showToast(errCode + " " + errMsg)
        this.finishRefresh()
      })
  }

  finishRefresh(): void {
    if (this.pageIndex == 0) {
      this.refreshController.finishRefresh()
    } else {
      this.refreshController.finishLoadMore()
    }
  }
}


