import EcoDataModel from '../model/EcoDataModel';
import StepSensorService from '../services/StepSensorService';
import PermissionsUtil from '../utils/PermissionsUtil';

@ObservedV2
export class MainViewModel {
  @Trace ecoData: EcoDataModel = new EcoDataModel(0);
  private stepSensor: StepSensorService = new StepSensorService();

  fetchStepData() {

    PermissionsUtil.requestPermissions(['ohos.permission.ACTIVITY_MOTION', 'ohos.permission.ACCELEROMETER',])

    this.stepSensor.startPedometer((steps: number) => {
      this.ecoData = new EcoDataModel(steps);
    });
  }

  stopSensor(): void {
    this.stepSensor.stopPedometer();
  }
}
