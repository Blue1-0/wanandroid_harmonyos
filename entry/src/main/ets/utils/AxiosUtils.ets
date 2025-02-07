import axios, { AxiosError, AxiosInstance, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
import { LogUtil } from '@pura/harmony-utils';
import AppConfigCenter from '../AppConfigCenter';
import ChainableRequest from './ChainableRequest';


export default class AxiosUtils {
  static get<T>(
    url: string,
    onSuccess?: (data: T) => void,
    onFailed?: (errorCode: number | string, errorMsg: string, data: T | null) => void) {
    return new ChainableRequest<T>(url, 'GET', onSuccess, onFailed)
  }

  static post<T>(url: string,
    onSuccess?: (data: T) => void,
    onFailed?: (errorCode: number | string, errorMsg: string, data: T | null) => void) {
    return new ChainableRequest<T>(url, 'POST', onSuccess, onFailed)
  }
}

/**
 * network
 */


const NET_TAG = "NetWork"

export const axiosApi: AxiosInstance = axios.create({
  baseURL: AppConfigCenter.httpIp,
  timeout: 1000 * 60,
  readTimeout: 1000 * 60,
  connectTimeout: 1000 * 60,
  headers: {
    'Content-Type': 'application/json;charset=utf-8',
    'Content-Language': 'zh_CN'
  }
})

axiosApi.interceptors.request.use((config: InternalAxiosRequestConfig) => {

  //show loading

  // console.log()
  // if (condition) {
  //   config.headers['Access_token']=''
  // }

  LogUtil.info("====request start====")
  LogUtil.info("method: " + config.method + " url : " + config.url)
  if (config.data) {
    LogUtil.info("" + config.data)
  }
  LogUtil.info("====request end====")
  return config
}, (error: AxiosError) => {
  LogUtil.info("====request error==== code: " + error.code + "msg: " + error.message)
  LogUtil.info("====request end====")
  return Promise.reject(error)
});

axiosApi.interceptors.response.use((response: AxiosResponse) => {
  LogUtil.info("====response start==== status: " + response.status)
  LogUtil.print(JSON.stringify(response.data))
  LogUtil.info("====response end====")
  return response
}, (error: AxiosError) => {
  LogUtil.info("====response error==== code " + error.code + " msg: " + error.message);
  if (error.response) {
    LogUtil.print(JSON.stringify(error.response.data))
  }
  LogUtil.info("====response end====")
  return Promise.reject(error)
})











