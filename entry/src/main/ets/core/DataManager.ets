import WanAndroidApi from "./WanAndroidApi";
import { ArticleEntity, BannerBean, KHEntity } from "../models/models";
import AbsNetManager from "./AbsNetManager";
import ChainableRequest from "../utils/ChainableRequest";
import AxiosUtils from "../utils/AxiosUtils";
import AbsCacheManager from "./AbsCacheManager";

/**
 * 建议是统一管理所有的网络请求以及数据存取
 */
class DataManager implements AbsNetManager, AbsCacheManager {
  //banner list
  fetchBannerList(): ChainableRequest<BannerBean[]> {
    return AxiosUtils.get<BannerBean[]>(WanAndroidApi.bannerList)
  }

  //分页拉取最新的文章列表
  fetchArticleList(num: number): ChainableRequest<ArticleEntity> {
    const url = WanAndroidApi.articleList.replace('{num}', num.toString())
    return AxiosUtils.get<ArticleEntity>(url)
  }

  //知识体系
  fetchTreeList(): ChainableRequest<KHEntity[]> {
    return AxiosUtils.get<KHEntity[]>(WanAndroidApi.treeList)
  }
}

const dataManager = new DataManager()

export default dataManager;