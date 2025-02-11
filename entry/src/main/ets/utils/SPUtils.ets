import dataPreferences from '@ohos.data.preferences'

let context = getContext(this)
let preference: dataPreferences.Preferences
const defaultPreferenceName: string = "ohos.db"
/**
 * @author wzg
 * desc:
 */

class SPUtils {
  async getPreferenceFromsStorage(dbName: string = defaultPreferenceName) {
    try {
      preference = await dataPreferences.getPreferences(context, dbName)
    } catch (err) {
    }
  }

  async putString(key: string, value: string) {

    if (!preference) {
      await this.getPreferenceFromsStorage()
    }

    try {
      await preference.put(key, value)
    } catch (err) {
    }
    await preference.flush()
  }

  async getString(key: string, defaultValue: string = '') {
    if (!preference) {
      await this.getPreferenceFromsStorage()
    }
    return await preference.get(key, defaultValue)
  }

  async removeKey(key: string) {
    if (!preference) {
      await this.getPreferenceFromsStorage()
    }
    await preference.delete(key)
  }
}

export default new SPUtils();