import { AxiosError, AxiosResponse } from "@ohos/axios";
import { ParamProjectsItemPageModel, ProjectTreeEntity, ResponseData } from "../models/models";
import { axiosApi } from "../utils/AxiosUtils";
import WanAndroidApi from "../core/WanAndroidApi";
import ProjectRoundCard from "../widget/ProjectRoundCard";
import { HMRouterMgr } from "@hadss/hmrouter";
import RoutePath from "../RoutePath";


@Component
export default struct ProjectsPageComponent {
  @State mProjectTreeEntity: ProjectTreeEntity[] = [];

  build() {
    Column() {
      List({ space: 10 }) {
        ForEach(this.mProjectTreeEntity, (item: ProjectTreeEntity) => {
          ListItem() {
            ProjectRoundCard({
              text: item.name,
              onItemClick: () => {
                //跳转
                HMRouterMgr.push({
                  pageUrl: RoutePath.ProjectListItemPage,
                  param: new ParamProjectsItemPageModel(item.id, item.name)
                })
              }
            })
          }
        }, (item: ProjectTreeEntity) => "" + item.id)
      }
      .width('100%')
      .height("100%")
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
      .padding({
        top: 10,
        bottom: 10,
        left: 10,
        right: 10
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.CE7E7E7'))
  }

  aboutToAppear(): void {
    this.fetchProjects()
  }

  fetchProjects(): void {

    axiosApi.get(WanAndroidApi.projectTree)
      .then((response: AxiosResponse<ResponseData<ProjectTreeEntity[]>>) => {
        if (response) {
          this.mProjectTreeEntity = response.data.data
        }
      })
      .catch((error: AxiosError) => {
        console.log('请求失败：', error);
      })

  }
}


