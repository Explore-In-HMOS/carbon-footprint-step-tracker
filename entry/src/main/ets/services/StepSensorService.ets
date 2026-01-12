import { sensor } from '@kit.SensorServiceKit';
import { BusinessError } from '@kit.BasicServicesKit';

export default class StepSensorService {

  startPedometer(callback: (steps: number) => void) {
    const INTERVAL = 100000000;

    try {
      sensor.on(sensor.SensorId.PEDOMETER, (data: sensor.PedometerResponse) => {
        callback(data.steps)
        console.info(`Succeeded in invoking once. Step count: ${data.steps}`);
      },{ interval: INTERVAL });
    } catch (error) {
      let e: BusinessError = error as BusinessError;
      console.error(`Failed to invoke once. Code: ${e.code}, message: ${e.message}`);
    }
  }

  stopPedometer() {
    try {
      sensor.off(sensor.SensorId.PEDOMETER);
      console.info('All pedometer subscriptions stopped.');
    } catch (error) {
      console.error(`Subscriptions could not be stopped:,${error}`);
    }
  }
}
