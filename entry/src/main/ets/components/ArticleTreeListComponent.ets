import { ToastUtil } from '@pura/harmony-utils'
import { KHEntity } from '../models/models'
import DataManager from '../core/DataManager'
import TreeItem from '../widget/TreeItem'
import { HMRouterMgr } from '@hadss/hmrouter'
import RoutePath from '../RoutePath'


@Component
export default struct ArticleTreeListComponent {
  @State entityList: KHEntity[] = []

  build() {
    Column() {
      List({ space: 0 }) {
        ForEach(this.entityList, (item: KHEntity) => {
          ListItem() {
            TreeItem({
              text: item.name,
              childList: item.children,
              expanded: item.expanded,
              onChildClick: () => {
                //跳转到文章列表
                HMRouterMgr.push({
                  pageUrl: RoutePath.ArticleTypeListComponent,
                  param: item
                })
              }
            })
          }
        }, (itme: KHEntity) => "" + itme.id)
      }.width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

    }
    .width('100%')
    .height('100%')
    .padding({ bottom: 10 })
    .clip(false)
  }

  aboutToAppear(): void {
    //知识体系
    this.fetchTreeList()
  }

  fetchTreeList(): void {
    DataManager.fetchTreeList()
      .onSuccess((data: KHEntity[]) => {
        this.entityList = data;
      })
      .onFailed((errCode, errMsg, _) => {
        ToastUtil.showToast(errCode + " " + errMsg)
      })
  }
}