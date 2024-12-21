import Constants from '../constants/Constants'
import keyboardController from '../model/KeyboardController'
import { keyValueLists, keyValueType } from '../model/KeyboardKeyData'

@ComponentV2
struct keyItem {
  @Param @Require @Once label: ResourceStr
  @Param @Require @Once onclick: () => void

  build() {
    Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Button(this.label)
        .fontSize($r('sys.float.ohos_id_button_font_size'))
        .fontColor($r('sys.color.ohos_id_color_text_primary'))
        .width(Constants.FULL_PERCENT)
        .height(Constants.FULL_PERCENT)
        .padding(Constants.KEY_MARGIN)
        .backgroundColor($r('sys.color.ohos_id_color_background'))
        .onClick(this.onclick)
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
    .padding(Constants.KEY_MARGIN)
  }
}

@Entry
@ComponentV2
struct Index {
  build() {
    Column() {
      ForEach(keyValueLists, (keyValueList: keyValueType[]) => {
        Row() {
          ForEach(keyValueList, (keyValue: keyValueType) => {
            keyItem({
              label: keyValue.label,
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
          label: $r('sys.symbol.delete_left'),
          onclick: () => {
            keyboardController.deleteForward(1)
          }
        })
          .width(Constants.KEY_BACKSPACE_WIDTH)
          .height(Constants.KEY_HEIGHT)
        keyItem({
          label: $r('sys.symbol.square_and_arrow_down_1'),
          onclick: () => {
            keyboardController.hide()
          }
        })
          .width(Constants.KEY_HIDE_WIDTH)
          .height(Constants.KEY_HEIGHT)
      }
      .justifyContent(FlexAlign.End)
    }
    .padding({
      left: $r('sys.float.ohos_id_default_padding_start'),
      right: $r('sys.float.ohos_id_default_padding_end')
    })
  }
}