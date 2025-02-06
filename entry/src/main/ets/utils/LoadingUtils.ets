import { NavBar, PkLoadingManager, STATUS_BAR_HEIGHT } from '@peakmain/library';
import { AppUtil } from '@pura/harmony-utils';


export default class LoadingUtils {
  static loading: PkLoadingManager = new PkLoadingManager(AppUtil.getUIContext())

  static showLoading(): void {
    LoadingUtils.loading.setTitle("加载中").open()
  }


  static hideLoading(): void {
    LoadingUtils.loading.close()
  }
}