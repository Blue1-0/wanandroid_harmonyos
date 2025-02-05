import { AxiosError, AxiosResponse } from "@ohos/axios";
import { axiosApi } from "../utils/AxiosUtils";
import WanAndroidApi from "../wan_android_api";
import { KHEntity, ResponseData } from "./models";


export default class NetworkUtils {
 static  fetchTreeList(callback: (entity: KHEntity[]|null,error:AxiosError|null) => void): void {
    axiosApi.get(WanAndroidApi.treeList)
      .then((response: AxiosResponse<ResponseData<KHEntity[]>>) => {

        if (response) {
          callback(response.data.data,null)
        }
      })
      .catch((error: AxiosError) => {
        callback(null,error);
      })
  }
}