import WanAndroidApi from "./WanAndroidApi";
import { ArticleEntity, BannerBean, KHEntity } from "../models/models";
import AbsNetManager from "./AbsNetManager";
import ChainableRequest from "../utils/ChainableRequest";
import AxiosUtils from "../utils/AxiosUtils";

/**
 * 建议是统一管理所有的网络请求以及数据存取
 */
class DataManager implements AbsNetManager {
  //banner list
  fetchBannerList(): ChainableRequest<BannerBean[]> {
    return AxiosUtils.get<BannerBean[]>(WanAndroidApi.bannerList)
  }

  //知识体系
  fetchTreeList(): ChainableRequest<KHEntity[]> {
    return AxiosUtils.get<KHEntity[]>(WanAndroidApi.treeList)
  }

  fetchArticleList(num: number): ChainableRequest<ArticleEntity> {
    const url = WanAndroidApi.articleList.replace('{num}', num.toString())
    return AxiosUtils.get<ArticleEntity>(url)
    // axiosApi.get<ResponseData<ArticleEntity>>(url)
    //   .then((response: AxiosResponse<ResponseData<ArticleEntity>>) => {
    //     let artEntity = response.data
    //     if (artEntity) {
    //       if (this.pageIndex == 0) {
    //         this.articleEntityList = artEntity.data.datas
    //       } else {
    //         this.articleEntityList = [...this.articleEntityList, ...artEntity.data.datas]
    //       }
    //     }
    //     this.finishRefresh()
    //   })
    //   .catch((error: AxiosError) => {
    //     this.finishRefresh()
    //     // 处理错误
    //     console.log('请求失败：', error);
    //   })
  }
}

const dataManager = new DataManager()

export default dataManager;