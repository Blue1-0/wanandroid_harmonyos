import { Logger } from '@nzy/logger';
import axios, { AxiosError, AxiosInstance, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
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

  Logger.info("====request start====", NET_TAG)
  Logger.info("method: " + config.method + " url : " + config.url, NET_TAG)
  if (config.data) {
    Logger.info("" + config.data, NET_TAG)
  }
  Logger.info("====request end====", NET_TAG)
  return config
}, (error: AxiosError) => {
  Logger.info("====request error==== code: " + error.code + "msg: " + error.message, NET_TAG)
  Logger.info("====request end====", NET_TAG)
  return Promise.reject(error)
});

axiosApi.interceptors.response.use((response: AxiosResponse) => {
  Logger.info("====response start==== status: " + response.status, NET_TAG)
  Logger.json(JSON.stringify(response.data), NET_TAG)
  Logger.info("====response end====", NET_TAG)
  return response
}, (error: AxiosError) => {
  Logger.info("====response error==== code " + error.code + " msg: " + error.message, NET_TAG);
  if (error.response) {
    Logger.json(JSON.stringify(error.response.data), NET_TAG)
  }
  Logger.info("====response end====", NET_TAG)
  return Promise.reject(error)
})











