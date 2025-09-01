import { MainViewModel } from '../viewmodel/MainViewModel';
import EcoStatCard from '../components/EcoStatCard';
import EcoBadge from '../components/EcoBadge';
import { ArcScrollBar } from '@kit.ArkUI';

@Entry
@Component
struct MainPage {
  vm: MainViewModel = new MainViewModel();
  private scroller: Scroller = new Scroller()
  @State context: Context  | undefined = undefined

  aboutToAppear() {
    this.vm.fetchStepData()
    this.context = this.getUIContext().getHostContext()
    if(this.context) {
      console.error('tag color : ' + this.context.resourceManager.getColorSync($r('app.color.eco_hero').id))
    }

    console.error('tag','aboutToAppear')
  }

  aboutToDisappear(): void {
    this.vm.stopSensor()

    console.error('tag','aboutToDisappear')

  }

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Scroll(this.scroller) {
          Column({ space: 5 }) {
            Text('🌍 ' + this.context?.resourceManager.getStringSync($r('app.string.app_name').id))
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .textAlign(TextAlign.Center)
              .width('100%')
              .margin({ top: 6 })
              .padding(10)
              .fontColor(Color.White)

            Row({ space: 10 }) {
              EcoStatCard({
                label:  this.context?.resourceManager.getStringSync($r('app.string.steps_label').id),
                value: this.vm.ecoData.steps.toString(),
                unit: this.context?.resourceManager.getStringSync($r('app.string.steps_unit').id)
              })
                .layoutWeight(1)

              EcoStatCard({
                label:  this.context?.resourceManager.getStringSync($r('app.string.co2_saved_label').id),
                value: this.vm.ecoData.co2SavedKg.toString(),
                unit: this.context?.resourceManager.getStringSync($r('app.string.kg_unit').id)
              })
                .layoutWeight(1)
            }

            EcoBadge({ co2Saved: this.vm.ecoData.co2SavedKg, context: this.getUIContext().getHostContext() })
          }
          .width('100%')
          .padding(16)
        }
        .width('95%')
        .scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Vertical)
        .edgeEffect(EdgeEffect.Spring)

        ArcScrollBar({ scroller: this.scroller, state: BarState.Auto })
      }
      .width('100%')
      .height('100%')
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}
