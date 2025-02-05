import { ArticleEntity, BannerBean, KHEntity } from "../models/models"
import ChainableRequest from "../utils/ChainableRequest"

export default interface AbsNetManager {


  fetchBannerList(): ChainableRequest<BannerBean[]>

  fetchArticleList(num: number): ChainableRequest<ArticleEntity>

  fetchTreeList(): ChainableRequest<KHEntity[]>
}