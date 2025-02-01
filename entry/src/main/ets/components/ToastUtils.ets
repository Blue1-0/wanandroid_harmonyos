import { promptAction } from "@kit.ArkUI";

/**
 * toast
 */
export default class ToastUtils {
  static showToast(str: string): void {
    promptAction.showToast({
      message: str,
      duration: 1500
    })
  }
}