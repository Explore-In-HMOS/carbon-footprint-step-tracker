interface BadgeInfo {
  text: string
  color: string
}

@Component
export default struct EcoBadge {
  @Prop co2Saved: number;
  context: Context | undefined

  private getBadge(): BadgeInfo {
    if (this.co2Saved > 1) {
      return {
        text: `🌍 ${this.context?.resourceManager.getStringSync($r('app.string.eco_hero').id)}`,
        color: '#4CAF50'
      }
    }
    if (this.co2Saved > 0.5) {
      return {
        text: `🌿 ${this.context?.resourceManager.getStringSync($r('app.string.green_walker').id)}`,
        color: '#81C784'
      }
    }
    return {
      text: `🚶 ${this.context?.resourceManager.getStringSync($r('app.string.keep_going').id)}`,
      color: '#FFB74D'
    }
  }

  build() {
    Row() {
      Text(this.getBadge().text)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
    }
    .padding(10)
    .backgroundColor(this.getBadge().color)
    .borderRadius(12)
    .justifyContent(FlexAlign.Center)
    .width('70%')
  }
}