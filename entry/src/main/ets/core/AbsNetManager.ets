import { ArticleEntity, BannerBean, KHDetailListEntity, KHEntity, ProjectListEntity } from "../models/models"
import ChainableRequest from "../utils/ChainableRequest"
/**
 * @author wzg
 * desc:
 */
export default interface AbsNetManager {


  fetchBannerList(): ChainableRequest<BannerBean[]>

  fetchArticleList(num: number): ChainableRequest<ArticleEntity>

  fetchTreeList(): ChainableRequest<KHEntity[]>

  fetchProjectTypeLst(cid: string, page: number): ChainableRequest<ProjectListEntity>

  getArticleListPageDetail(cid: string, page: number): ChainableRequest<KHDetailListEntity>
}