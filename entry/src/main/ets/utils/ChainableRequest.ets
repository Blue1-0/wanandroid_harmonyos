import { AxiosResponse, AxiosError, Method } from '@ohos/axios'
import { ResponseData } from '../models/models';
import { HashMap } from '@kit.ArkTS';
import { axiosApi } from './AxiosUtils';
// import LoadingUtils from './LoadingUtils';
import { LogUtil } from '@pura/harmony-utils';
import LoadingDialog from '@lyb/loading-dialog';

export default class ChainableRequest<T> {
  private onSuccessCallbacks: ((data: T) => void)[]
  private onFailedCallbacks: ((errorCode: number | string, errorMsg: string, data: T | null) => void)[]

  constructor(
    url: string,
    method: Method = 'GET',
    onSuccess?: (data: T) => void,
    onFailed?: (errorCode: number | string, errorMsg: string, data: T | null) => void
  ) {
    this.onSuccessCallbacks = []
    this.onFailedCallbacks = []

    if (onSuccess) {
      this.onSuccess(onSuccess);
    }
    if (onFailed) {
      this.onFailed(onFailed)
    }
    this.execute(url, method)
  }

  private execute(url: string, method: Method, data?: HashMap<string, string | number | boolean>) {
    //show loading
    this.showLoading()
    let axiosRequest: Promise<AxiosResponse<T>>
    if (method == 'GET') {
      axiosRequest = axiosApi.get<T>(url)
    } else {
      axiosRequest = axiosApi.post<T>(url, data)
    }
    axiosRequest.then((response: AxiosResponse<T>) => {
      //hide loading
      this.hideLoading()
      if (response.status == 200) {
        const responseData = response.data as ResponseData<T>
        if (responseData.errorCode == 0) {
          this.onSuccessCallbacks.forEach(callback => callback(responseData.data))
        } else {
          this.onFailedCallbacks.forEach(callback => callback(responseData.errorCode, responseData.errorMsg,
            responseData.data))
        }
      } else {
        this.onFailedCallbacks.forEach(callback => callback(response.status, response.statusText, null))
      }
    }).catch((error: AxiosError) => {
      //hide loading
      this.hideLoading()
      if (error.response) {
        this.onFailedCallbacks.forEach(callback => callback(error.response?.status || '', error.message, null));
      } else {
        this.onFailedCallbacks.forEach(callback => callback(error.code || '', error.message, null));
      }
    })
  }

  onSuccess(callback: (data: T) => void): ChainableRequest<T> {
    this.onSuccessCallbacks.push(callback)
    return this
  }

  onFailed(callback: (errorCode: number | string, errorMsg: string, data: T | null) => void): ChainableRequest<T> {
    this.onFailedCallbacks.push(callback)
    return this
  }

  private showLoading() {
    LogUtil.info("============showLoading===========")
    // LoadingUtils.showLoading()
    LoadingDialog.showLoading("loading...")
  }

  private hideLoading() {
    LogUtil.info("===========hideLoading============")
    // LoadingUtils.hideLoading()
    LoadingDialog.hide()
  }
}