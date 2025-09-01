import { AVERAGE_CO2_PER_KM, AVG_STEP_LENGTH_METERS } from '../common/constants';

export default class EcoDataModel {
  steps: number = 0;
  distanceKm: number = 0;
  co2SavedKg: number = 0;
  date: string = '';

  constructor(steps: number) {
    this.steps = steps;
    this.distanceKm = parseFloat(((steps * AVG_STEP_LENGTH_METERS) / 1000).toFixed(2));
    this.co2SavedKg = parseFloat((this.distanceKm * AVERAGE_CO2_PER_KM).toFixed(2));
    this.date = new Date().toDateString();
  }
}
