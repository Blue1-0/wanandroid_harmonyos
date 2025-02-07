import { ArticleEntity, BannerBean, KHEntity, ProjectListEntity } from "../models/models"
import ChainableRequest from "../utils/ChainableRequest"

export default interface AbsNetManager {


  fetchBannerList(): ChainableRequest<BannerBean[]>

  fetchArticleList(num: number): ChainableRequest<ArticleEntity>

  fetchTreeList(): ChainableRequest<KHEntity[]>

  fetchProjectTypeLst(cid:string,page:number):ChainableRequest<ProjectListEntity>
}