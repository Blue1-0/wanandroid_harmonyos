import { LitheRefresh, RefreshController } from '@abner/lithe_refresh';
import { ArticleEntityDatas, BannerBean, RowItemBean } from '../models/models';
import RoundCard from '../widget/RoundCard';
import ArticleCard from '../widget/ArticleCard';
import dataManager from '../core/DataManager';
import { ToastUtil } from '@pura/harmony-utils';


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
    { id: "1", name: "公众号", image: $r('app.media.icon_home') },
    { id: "2", name: "收藏", image: $r('app.media.icon_home') },
    { id: "3", name: "导航", image: $r('app.media.icon_home') },
    { id: "4", name: "作者介绍", image: $r('app.media.icon_home') }];

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
          this.BuildCard(item.name, item.image)
        }, (item: RowItemBean) => item.id)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 10 })
      .padding({ left: 10, right: 10 })

      //view Filer
      LitheRefresh({
        isScrollSpring: true,
        enableRefresh: true,
        enableLoadMore: true,
        itemLayout: () => this.itemLayout(),
        scroller: this.scroller,
        controller: this.refreshController,
        onRefresh: () => {
          this.pageIndex = 0
          this.fetchArticleList(this.pageIndex)
        },
        onLoadMore: () => {
          this.pageIndex++;
          this.fetchArticleList(this.pageIndex)
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
    // Column({ space: 10 }) {
    List({ scroller: this.scroller, space: 10 }) {
      // 使用 ArticleCard 组件并传入属性值
      ForEach(this.articleEntityList, (item: ArticleEntityDatas) => {
        ListItem() {
          ArticleCard({
            title: item.superChapterName + "/" + item.chapterName,
            content: item.title,
            author: item.author,
            lg: item.collect, // 根据实际情况传入布尔值
            time: item.niceDate
          })
        }
      }, (item: ArticleEntityDatas) => "" + item.id)
    }
    .width('100%')
    .height('100%')
    .margin({ bottom: 10 })
    .padding({ left: 10, right: 10, bottom: 10 })

  }

  @Builder
  BuildCard(itemStr: string, img: Resource) {
    Row() {
      RoundCard({
        image: img,
        text: itemStr
      })
    }
    .backgroundColor($r('app.color.white'))
    .width('23%')
    .borderRadius(8)
  }

  aboutToAppear(): void {
    console.log('homePage', "=====response.data11=====");
    this.fetchBannerList();
    this.fetchArticleList(this.pageIndex);
    console.log('homePage', "=====response.data22=====");
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

  fetchArticleList(num: number): void {
    dataManager.fetchArticleList(num)
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


