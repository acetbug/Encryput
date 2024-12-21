import Constants from '../constants/Constants'
import keyboardController from '../model/KeyboardController'
import { keyValueLists, keyValueType } from '../model/KeyboardKeyData'

@ComponentV2
struct keyItem {
  @Param @Require @Once label: string
  @Param @Require @Once onclick: () => void

  build() {
    Button(this.label)
      .margin(Constants.KEY_MARGIN)
      .borderRadius($r('sys.float.ohos_id_corner_radius_default_xs'))
      .backgroundColor($r('sys.color.ohos_id_color_floating_button_bg_normal'))
      .fontSize($r('sys.float.ohos_id_button_font_size'))
      .fontColor($r('sys.color.ohos_id_color_text_primary'))
      .onClick(this.onclick)
  }
}

@Entry
@ComponentV2
struct Index {
  @Builder
  keysItem(content: string, width: string, height: string, onClick: () => void) {
    Button(content)
      .fontSize($r('sys.float.ohos_id_button_font_size'))
      .fontColor($r('sys.color.ohos_id_color_text_primary'))
      .backgroundColor($r('sys.color.ohos_id_color_floating_button_bg_normal'))
      .borderRadius($r('sys.float.ohos_id_corner_radius_default_xs'))
      .width(width)
      .height(height)
      .onClick(onClick)
  }

  build() {
    Column() {
      ForEach(keyValueLists, (keyValueList: keyValueType[]) => {
        Row() {
          ForEach(keyValueList, (keyValue: keyValueType) => {
            keyItem({
              label: keyValue.content,
              onclick: () => {
                keyboardController.insertText(keyValue.content)
              }
            })
              .width(Constants.KEY_WIDTH)
              .height(Constants.KEY_HEIGHT)
          })
        }
        .justifyContent(FlexAlign.Center)
      })
      Row() {
        keyItem({
          label: Constants.KEY_BACKSPACE_CONTENT,
          onclick: () => {
            keyboardController.deleteForward(1)
          }
        })
          .width(Constants.KEY_WIDTH)
          .height(Constants.KEY_HEIGHT)
      }
      .justifyContent(FlexAlign.Center)
    }
  }
}