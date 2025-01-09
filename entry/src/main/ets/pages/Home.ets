import { common, Want } from '@kit.AbilityKit'
import Constants from '../constants/Constants'

@Entry
@ComponentV2
struct Home {
  build() {
    Column() {
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
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.SpaceEvenly)
    .backgroundColor($r('sys.color.ohos_id_color_background'))
  }
}