import Constants from '../constants/Constants'
import keyboardController from '../model/KeyboardController'
import { keyValueLists, keyValueType } from '../model/KeyboardKeyData'

@ComponentV2
struct keyItem {
  @Param @Require label: ResourceStr
  @Param @Require onclick: () => void

  build() {
    Button(this.label)
      .width(Constants.FULL_PERCENT)
      .height(Constants.FULL_PERCENT)
      .padding(0)
      .fontSize($r('sys.float.ohos_id_button_font_size'))
      .fontColor($r('sys.color.ohos_id_color_text_primary'))
      .backgroundColor($r('sys.color.ohos_id_color_background'))
      .onClick(this.onclick)
  }
}

@Entry
@ComponentV2
struct Index {
  @Local upper: number = 0

  build() {
    Column() {
      ForEach(keyValueLists[this.upper], (keyValueList: keyValueType[]) => {
        Row() {
          ForEach(keyValueList, (keyValue: keyValueType) => {
            keyItem({
              label: keyValue.label,
              onclick: () => {
                keyboardController.insertText(keyValue.content)
              }
            })
              .width(Constants.KEY_WIDTH_PERCENT)
              .padding($r('app.float.key_padding'))
          })
        }
        .width(Constants.FULL_PERCENT)
        .height(Constants.KEY_HEIGHT_PERCENT)
        .justifyContent(FlexAlign.Center)
      })
      Row() {
        keyItem({
          label: $r(this.upper == 0 ? 'sys.symbol.arrowshape_up' : 'sys.symbol.arrowshape_up_fill'),
          onclick: () => {
            this.upper ^= 1
          }
        })
          .width(Constants.KEY_SHIFT_WIDTH_PERCENT)
          .padding($r('app.float.key_padding'))
        keyItem({
          label: $r('sys.symbol.space_1'),
          onclick: () => {
            keyboardController.insertText(' ')
          }
        })
          .width(Constants.KEY_SPACE_WIDTH_PERCENT)
          .padding($r('app.float.key_padding'))
        keyItem({
          label: $r('sys.symbol.delete_left'),
          onclick: () => {
            keyboardController.deleteForward(1)
          }
        })
          .width(Constants.KEY_BACKSPACE_WIDTH_PERCENT)
          .padding($r('app.float.key_padding'))
        keyItem({
          label: $r('sys.symbol.chevron_down_circle'),
          onclick: () => {
            keyboardController.hide()
          }
        })
          .width(Constants.KEY_HIDE_WIDTH_PERCENT)
          .padding($r('app.float.key_padding'))
      }
      .height(Constants.KEY_HEIGHT_PERCENT)
    }
    .padding({
      left: $r('sys.float.ohos_id_default_padding_start'),
      right: $r('sys.float.ohos_id_default_padding_end')
    })
  }
}