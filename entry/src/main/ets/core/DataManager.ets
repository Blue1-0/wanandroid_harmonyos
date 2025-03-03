import WanAndroidApi from "./WanAndroidApi";
import {
  ArticleEntity,
  BannerBean,
  KHDetailListEntity,
  KHEntity,
  NavJsonEntity,
  ProjectListEntity,
  WxArticleDetailEntity,
  WxArticleEntity
} from "../models/models";
import AbsNetManager from "./AbsNetManager";
import ChainableRequest from "../utils/ChainableRequest";
import AxiosUtils from "../utils/AxiosUtils";
import AbsCacheManager from "./AbsCacheManager";
import { LogUtil } from "@pura/harmony-utils";

/**
 * @author wzg
 * desc:
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

  //根据项目分类拉取列表
  fetchProjectTypeLst(cid: string, page: number): ChainableRequest<ProjectListEntity> {
    const url = WanAndroidApi.projectList.replace('{page}', page.toString()) + "?cid=" + cid
    return AxiosUtils.get<ProjectListEntity>(url)
  }

  //根据分类拉取最新的文章列表
  getArticleListPageDetail(cid: string, page: number): ChainableRequest<KHDetailListEntity> {
    const url = WanAndroidApi.articleListPageDetail.replace('{page}', page.toString()) + "?cid=" + cid
    return AxiosUtils.get<KHDetailListEntity>(url)
  }

  //
  getWxChapters(): ChainableRequest<WxArticleEntity[]> {
    return AxiosUtils.get<WxArticleEntity[]>(WanAndroidApi.wxChapters)
  }

  //
  wxArticleListFormId(id: number, page: number, k: string): ChainableRequest<WxArticleDetailEntity> {
    const url = WanAndroidApi.wxListFormId.replace('{page}', page.toString()).replace('{id}', id.toString())
    const finalUrl = k ? url + "?k=" + k : url
    LogUtil.error("====wxArticleListFormId===" + finalUrl)
    return AxiosUtils.get<WxArticleDetailEntity>(finalUrl)
  }

  //
   getNaviJson(): ChainableRequest<NavJsonEntity[]> {
     return AxiosUtils.get<NavJsonEntity[]>(WanAndroidApi.naviJson)
    }
}

const dataManager = new DataManager()

export default dataManager;