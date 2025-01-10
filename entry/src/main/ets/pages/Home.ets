import { common, Want } from '@kit.AbilityKit'
import Constants from '../constants/Constants'

@Entry
@ComponentV2
struct Home {
  build() {
    Column({ space: Constants.SPACE_BETWEEN_ELEMENTS }) {
      Text($r('app.string.welcome'))
        .fontSize($r('sys.float.ohos_id_text_size_headline4'))
        .fontWeight(FontWeight.Bolder)

      Button($r('app.string.tip'))
        .onClick(() => {
          let context = getContext(this) as common.UIAbilityContext
          let wantInfo: Want = {
            bundleName: 'com.huawei.hmos.settings',
            abilityName: 'com.huawei.hmos.settings.MainAbility',
            uri: 'set_input'
          }
          context.startAbility(wantInfo)
        })

      TextArea({ placeholder: $r('app.string.try') })
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
    .padding($r('sys.float.padding_level12'))
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('sys.color.ohos_id_color_background'))
  }
}