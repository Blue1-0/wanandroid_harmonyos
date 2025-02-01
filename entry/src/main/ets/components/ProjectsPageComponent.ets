import { AxiosError, AxiosResponse } from "@ohos/axios";
import { ProjectTreeEntity, ResponseData } from "../models/models";
import { axiosApi } from "../utils/AxiosUtils";
import WanAndroidApi from "../wan_android_api";

@Component
struct RoundCard {
  @Prop text: string

  build() {
    Column() {
      Text(this.text.replace(/&amp;/g, "&"))
        .fontSize(14)
        .maxLines(1)
        .fontColor($r("app.color.text_black"))
    }
    .width("100%")
    .padding({
      top: 15,
      bottom: 15,
      left: 10,
      right: 10
    })
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.white'))
    .borderRadius(8)
  }
}

@Component
export default struct ProjectsPageComponent {
  @State mProjectTreeEntity: ProjectTreeEntity[] = [];

  build() {
    Column() {
      List({ space: 10 }) {
        ForEach(this.mProjectTreeEntity, (item: ProjectTreeEntity) => {
          ListItem() {
            RoundCard({ text: item.name })
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


