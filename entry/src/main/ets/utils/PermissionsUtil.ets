import { abilityAccessCtrl, bundleManager, common, PermissionRequestResult, Permissions } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

const domain = 0x0000;

class PermissionsUtil {

  async checkPermissions(permissions: Array<Permissions>): Promise<void> {
    let applyResult: boolean = false;
    for (let permission of permissions) {
      let grantStatus: abilityAccessCtrl.GrantStatus = await this.checkAccessToken(permission);
      if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
        hilog.info(domain, 'testTag', '%{public}s', 'CheckPermission is granted');
        applyResult = true;
      } else {
        hilog.info(domain, 'testTag', '%{public}s', 'CheckPermission is not granted');
        applyResult = false;
      }
    }
    if (!applyResult) {
      this.requestPermissions(permissions);
    }
  }

  async checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    let grantStatus: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;

    let tokenId: number = 0;
    try {
      let bundleInfo: bundleManager.BundleInfo =
        await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      tokenId = appInfo.accessTokenId;
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      hilog.error(0x0000,'',`Failed to get bundle info for self. Code is ${err.code}, message is ${err.message}`);
    }

    try {
      grantStatus = await atManager.checkAccessToken(tokenId, permission);
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      hilog.error(0x0000,'',`Failed to check access token. Code is ${err.code}, message is ${err.message}`);
    }
    return grantStatus;
  }


  requestPermissions(permissions: Array<Permissions>): void {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    atManager.requestPermissionsFromUser(getContext() as common.UIAbilityContext, permissions)
      .then((data: PermissionRequestResult) => {
        hilog.info(0x0000,'','request Permissions success')
      })
      .catch((err: BusinessError) => {
        hilog.error(0x0000,'',`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
      })
  }

  async requestPermission(permissions: Permissions[],
    context: common.UIAbilityContext): Promise<boolean> {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    const result = await atManager.requestPermissionsFromUser(context, permissions);
    return !!result.authResults.length && result.authResults.every(authResults => authResults === 0);
  }
}

export default new PermissionsUtil();