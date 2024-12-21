import { inputMethodEngine, InputMethodExtensionContext } from '@kit.IMEKit'
import { display } from '@kit.ArkUI'
import Constants from '../constants/Constants'

const inputMethodAbility = inputMethodEngine.getInputMethodAbility()

export class KeyboardController {
  private mContext?: InputMethodExtensionContext
  private panel?: inputMethodEngine.Panel
  private textInputClient?: inputMethodEngine.InputClient
  private keyboardController?: inputMethodEngine.KeyboardController

  constructor() {
  }

  public onCreate(context: InputMethodExtensionContext) {
    this.mContext = context
    this.initWindow()
    this.registerListener()
  }

  public onDestroy() {
    this.unRegisterListener()
    if (this.panel) {
      inputMethodAbility.destroyPanel(this.panel)
    }
    this.mContext?.destroy()
  }

  public insertText(text: string) {
    this.textInputClient?.insertText(text)
  }

  public deleteForward(length: number) {
    this.textInputClient?.deleteForward(length)
  }

  public hide() {
    this.keyboardController?.hide()
  }

  private initWindow() {
    if (this.mContext === undefined) {
      return
    }
    let mDisplay = display.getDefaultDisplaySync()
    let dWidth = mDisplay.width
    let dHeight = mDisplay.height
    let keyHeight = dHeight * Constants.KEYBOARD_HEIGHT_RATE
    let nonBarPosition = dHeight - keyHeight
    let panelInfo: inputMethodEngine.PanelInfo = { type: inputMethodEngine.PanelType.SOFT_KEYBOARD }
    inputMethodAbility.createPanel(this.mContext, panelInfo).then(async (inputPanel) => {
      this.panel = inputPanel
      await this.panel?.resize(dWidth, keyHeight)
      await this.panel?.moveTo(0, nonBarPosition)
      await this.panel?.setUiContent(Constants.KEYBOARD_UI_CONTENT)
    })
  }

  private registerListener() {
    inputMethodAbility.on('inputStart', (keyboardController, textInputClient) => {
      this.keyboardController = keyboardController
      this.textInputClient = textInputClient
    })
    inputMethodAbility.on('inputStop', () => {
      this.onDestroy()
    })
  }

  private unRegisterListener() {
    inputMethodAbility.off('inputStart')
    inputMethodAbility.off('inputStop', () => {
    })
  }
}

const keyboardController = new KeyboardController()

export default keyboardController