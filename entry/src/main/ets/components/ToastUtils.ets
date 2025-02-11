import { promptAction } from "@kit.ArkUI";

/**
 * @author wzg
 * desc: toast
 */
export default class ToastUtils {
  static showToast(str: string): void {
    promptAction.showToast({
      message: str,
      duration: 1500
    })
  }
}