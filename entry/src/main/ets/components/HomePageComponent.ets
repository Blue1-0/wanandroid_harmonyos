import { LitheRefresh, RefreshController } from "@abner/lithe_refresh";
import { AxiosError, AxiosResponse } from "@ohos/axios";
import { it } from "@ohos/hypium";
import { ArticleEntity, ArticleEntityDatas, BannerBean, ResponseData } from "../models/models";
import { axiosApi } from "../utils/AxiosUtils";
import WanAndroidApi from "../wan_android_api";


//row item
interface RowItemBean {
  id: string
  name: string
  image: Resource
}

@Component
struct RoundCard {
  @Prop image: Resource
  @Prop text: string

  build() {

    Column() {

      Image(this.image)
        .width(40)
        .height(40)
        .objectFit(ImageFit.Contain)
      // .tintColor(Color.Blue)

      Text(this.text)
        .fontSize(16)
        .fontColor(Color.Blue)
        .margin({ top: 8 })


    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
    // .height(120)
    .padding({ top: 10, bottom: 10 })
    .borderRadius(8)
  }
}

//文章卡片
@Component
struct ArticleCard {
  @Prop title: string
  @Prop content: string
  @Prop author: string
  @Prop lg: boolean
  @Prop time: string

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.title)
            .maxLines(1)
            .fontColor($r('app.color.text_black'))
            .fontSize(12)

          Text(this.content)
            .maxLines(2)
            .fontColor($r('app.color.text_gray'))
            .fontSize(12)
            .margin({ top: 5 })
        }
        .flexBasis('80%')
        .flexGrow(0)
        .flexShrink(1)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Start)

        Column() {
          Image(this.lg ? $r('app.media.icon_home_active') : $r('app.media.icon_home'))
            .height(24)
            .width(24)
            .objectFit(ImageFit.Contain)
            .alignSelf(ItemAlign.End)
        }
        .flexBasis('20%')
        .flexGrow(1)
        .flexShrink(1)
        .alignItems(HorizontalAlign.Center)
        .justifyContent(FlexAlign.Center)

        // .backgroundColor($r('app.color.text_gray'))
      }
      .width('100%')

      Row() {
        Text(this.author)
          .maxLines(1)
          .fontColor($r('app.color.text_black'))
          .fontSize(12)
        Text(this.time)
          .maxLines(1)
          .fontColor($r('app.color.text_black'))
          .fontSize(12)
      }
      .width("100%")
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 5 })

    }
    .width('100%')
    .borderRadius(8)
    .backgroundColor($r('app.color.white'))
    .padding(10)
  }
}

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
      .onChange((index) => {
      })

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
        .height('100%')
        .flexGrow(1)
        .width('100%')
        .padding({ top: 10 })// .margin({bottom:100})
        .backgroundColor($r('app.color.text_hint_gray'))


    }
    // .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    // .height(this.mHeight)
    .height('100%')
    .width('100%')
    // .flexBasis(1)
    // .margin({ bottom: 100 })
    .flexGrow(1)
    // .flexShrink(1)
    .backgroundColor($r("app.color.CE7E7E7"))

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
    // .margin({ /*top: 10,*/ bottom: 100 })
    // .flexShrink(1)
    .flexGrow(1)
    .padding({ left: 10, right: 10, bottom: 10 })

    // .backgroundColor($r('app.color.text_blue'))

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
    axiosApi.get <ResponseData<BannerBean[]>>(WanAndroidApi.bannerList)
      .then((response: AxiosResponse<ResponseData<BannerBean[]>>) => {
        // 处理成功响应
        console.log('请求成功：', JSON.stringify(response.data, null, 2));
        this.bannerList = response.data.data

      }).catch((error: AxiosError) => {
      // 处理错误
      console.log('请求失败：', error);
    });
  }

  fetchArticleList(num: number): void {
    const url = WanAndroidApi.articleList.replace('{num}', num.toString())
    axiosApi.get<ResponseData<ArticleEntity>>(url)
      .then((response: AxiosResponse<ResponseData<ArticleEntity>>) => {
        let artEntity = response.data
        if (artEntity) {
          this.articleEntityList = artEntity.data.datas
        }
        this.finishRefresh()
      })
      .catch((error: AxiosError) => {
        this.finishRefresh()
        // 处理错误
        console.log('请求失败：', error);
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


