export type ChartType = 'pie' | 'bar';
export interface Chart {
  data: ChartData;
  options: any;
  type: ChartType;
}

export interface ChartData {
  labels: string[];
  datasets: ChartDataset[]
}

export interface ChartDataset {
  data: any[]
}
