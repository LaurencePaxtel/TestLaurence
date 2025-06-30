import {Injectable} from "@angular/core";
import {Chart, ChartData, ChartType} from "../model/chart";
import {StatisticChartData} from "../model/statistic-data";
import {TooltipItem} from "chart.js";


@Injectable({
  providedIn: 'root',
})
export class ChartService {


  constructor() {
  }

  computeChart(chartType: ChartType, statisticChartData: StatisticChartData[]): Chart {
    if (chartType === 'pie') {
      return this.computeChartOfTypePie(chartType, statisticChartData);
    } else {
      return this.computeChartOfTypeBar(chartType, statisticChartData);
    }
  }

  computeChartOfTypePie(chartType: ChartType, statisticChartData: StatisticChartData[]): Chart {
    let labels: string[] = [];
    let datasets: any[] = []
    let data: number[] = [];
    for (const item of statisticChartData) {
      if (item.quantite > 0) {
        labels.push(item.enumeration);
        data.push(item.quantite)
      }
    }
    const numberOfDataPoints = data.length;
    datasets.push({
      data: data,
      backgroundColor: this.generateColors(numberOfDataPoints)
    })

    return {
      data: {
        labels: labels,
        datasets: datasets
      },
      type: chartType,
      options: {
        plugins: {
          datalabels: {
            color: '#2d3436',
            font: {
              weight: 'bold',
              size: 9
            },
            textAlign: 'center',
            // Ajustement du positionnement
            anchor: 'end', // Position par rapport à la portion ('start', 'center', 'end')
            align: 'center', // Alignement du texte ('start', 'center', 'end', 'right', 'left')
            offset: 0,
            formatter: (value: number, context: any) => {
              const dataset = context.dataset;
              const total = dataset.data.reduce((acc: number, data: number) => acc + data, 0);
              const val = dataset.data[context.dataIndex];
              const percentage = ((value / total) * 100).toFixed(2);
              return `${context.chart.data.labels[context.dataIndex]}: ${val} (${percentage}%)`;
            }
          },
          tooltip: {
            callbacks: {
              label: function(context: TooltipItem<'pie'>) {
                const dataset = context.dataset;
                const total = dataset.data.reduce((acc: number, data: number) => acc + data, 0);
                const value = dataset.data[context.dataIndex];
                const percentage = ((value / total) * 100).toFixed(2);
                return `${context.label}: ${percentage}%`;
              }
            }
          },
          legend: {
            labels: {
              usePointStyle: true,
            }
          }
        }
      }
    }
  }

  computeChartOfTypeBar(chartType: ChartType, statisticChartData: StatisticChartData[]): Chart {
    let labels: string[] = [];
    let datasets: any[] = []
    let data: number[] = [];
    for (const item of statisticChartData) {
        labels.push(item.enumeration);
        data.push(item.quantite)
    }
    datasets.push({
      data: data,
      label: 'Histogramme'
    })

    const documentStyle = getComputedStyle(document.documentElement);
    const textColor = documentStyle.getPropertyValue('--text-color');
    const textColorSecondary = documentStyle.getPropertyValue('--text-color-secondary');
    const surfaceBorder = documentStyle.getPropertyValue('--surface-border');

    return {
      data: {
        labels: labels,
        datasets: datasets
      },
      type: chartType,
      options: {
        indexAxis: 'y',
        maintainAspectRatio: false,
        aspectRatio: 0.8,
        plugins: {
          legend: {
            labels: {
              color: textColor
            }
          }
        },
        scales: {
          x: {
            ticks: {
              color: textColorSecondary,
              font: {
                weight: 500
              }
            },
            grid: {
              color: surfaceBorder,
              drawBorder: false
            }
          },
          y: {
            ticks: {
              color: textColorSecondary
            },
            grid: {
              color: surfaceBorder,
              drawBorder: false
            }
          }
        }
      }
    }
  }

  generateColors(count: number) {
    const baseColors = [
      // Couleurs primaires et secondaires très vives
      '#FF0000',  // Rouge pur
      '#0000FF',  // Bleu pur
      '#FFD700',  // Or
      '#00FF00',  // Vert pur
      '#FF00FF',  // Magenta
      '#00FFFF',  // Cyan
      // Couleurs tertiaires contrastées
      '#FF4500',  // Rouge-Orange vif
      '#4B0082',  // Indigo foncé
      '#00FF7F',  // Vert Spring
      '#8B0000',  // Rouge foncé
      '#FF1493',  // Rose profond
      '#FF8C00',  // Orange foncé
      '#008000',  // Vert foncé
      '#800080',  // Violet
      '#000080',  // Bleu marine
      '#8B4513',  // Marron
      '#FF69B4',  // Rose chaud
      '#006400'   // Vert forêt
    ];

    if (count > baseColors.length) {
      const extraColors = [];
      for (let i = 0; i < (count - baseColors.length); i++) {
        const hue = (i * 137.508) % 360;
        // Saturation à 100% et luminosité à 50% pour un maximum de contraste
        extraColors.push(`hsl(${hue}, 100%, 50%)`);
      }
      return [...baseColors, ...extraColors];
    }

    return baseColors.slice(0, count);
  }

}
