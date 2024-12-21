import { InputMethodExtensionAbility } from '@kit.IMEKit';
import keyboardController from '../model/KeyboardController';

export default class EncryputService extends InputMethodExtensionAbility {
  onCreate() {
    keyboardController.onCreate(this.context)
  }

  onDestroy() {
    keyboardController.onDestroy()
  }
}