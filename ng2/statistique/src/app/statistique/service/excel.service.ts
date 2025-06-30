import {Injectable} from "@angular/core";
import {StatisticChartData, StatisticData} from "../model/statistic-data";
import {ChartType} from "chart.js";
import * as XLSX from 'xlsx';


interface XlsResultsData {
  type: string;
  result: string | number;
}

type ResultType = 'absolute' | 'percentage';

@Injectable({
  providedIn: 'root',
})
export class ExcelService {

  private columns = [
    { header: 'Type de résultats', key: 'enumeration', width: 50 },
    { header: 'Résultats', key: 'resultat', width: 20 }
  ];

  public exportChartDataInXls(data: StatisticChartData[], type: ChartType | undefined) {
    try {
      let typeResult: ResultType = type === 'pie' ? 'percentage' : 'absolute';
      const transformedData = this.transformData(data, typeResult);
      const worksheet: XLSX.WorkSheet = this.createWorksheet(transformedData);
      this.applyStyles(worksheet, typeResult);
      const workbook: XLSX.WorkBook = {
        Sheets: { 'Résultats': worksheet },
        SheetNames: ['Résultats']
      };

      this.generateAndSave(workbook, typeResult);
    } catch (error) {
      console.error('Erreur lors de l\'export:', error);
    }
  }

  private transformData(data: StatisticChartData[], type: ResultType): any[] {
    const total = data.reduce((sum, item) => sum + item.quantite, 0);

    return data.map(item => ({
      enumeration: `${item.enumeration}`,
      resultat: type === 'absolute'
        ? item.quantite
        : Number(((item.quantite / total) * 100).toFixed(2)) // Arrondi à 2 décimales
    }));
  }

  private createWorksheet(data: any[]): XLSX.WorkSheet {
    const headers = [
      this.columns[0].header,
      'Résultats'
    ];

    const worksheet = XLSX.utils.json_to_sheet(data, {
      header: ['enumeration', 'resultat']
    });

    XLSX.utils.sheet_add_aoa(worksheet, [headers], { origin: 'A1' });

    worksheet['!cols'] = this.columns.map(col => ({ wch: col.width }));

    return worksheet;
  }

  private applyStyles(worksheet: XLSX.WorkSheet, type: ResultType): void {
    const headerStyle = {
      font: {
        bold: true,
        color: { auto: 1 }  // Couleur auto pour le texte
      },
      fill: {
        patternType: 'solid',
        fgColor: { rgb: "B8CCE4" },  // Bleu clair plus compatible
        bgColor: { indexed: 64 }
      },
      alignment: {
        horizontal: "center",
        vertical: "center"
      },
      border: {
        top: { style: 'thin' },
        bottom: { style: 'thin' },
        left: { style: 'thin' },
        right: { style: 'thin' }
      }
    };

    const enumerationStyle = {
      alignment: { horizontal: "left" },
      font: { color: { auto: 1 } }
    };

    const resultStyle = {
      alignment: { horizontal: "center" },
      font: { color: { auto: 1 } },
      numFmt: type === 'absolute' ? '0' : '0.00"%"'
    };

    const range = XLSX.utils.decode_range(worksheet['!ref'] || 'A1');

    for (let col = range.s.c; col <= range.e.c; col++) {
      const headerCell = XLSX.utils.encode_cell({ r: 0, c: col });
      worksheet[headerCell].s = headerStyle;

      for (let row = 1; row <= range.e.r; row++) {
        const cell = XLSX.utils.encode_cell({ r: row, c: col });
        if (worksheet[cell]) {
          worksheet[cell].s = col === 0 ? enumerationStyle : resultStyle;
        }
      }
    }

    worksheet['!margins'] = {
      left: 0.7,
      right: 0.7,
      top: 0.75,
      bottom: 0.75,
      header: 0.3,
      footer: 0.3
    };
  }

  private generateAndSave(workbook: XLSX.WorkBook, type: ResultType): void {
    const excelBuffer: any = XLSX.write(workbook, {
      bookType: 'xlsx',
      type: 'array',
      bookSST: false,
      compression: true
    });

    const data: Blob = new Blob([excelBuffer], {
      type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    });

    const now = new Date();
    const date = now.toLocaleDateString('fr-FR').split('/').join('_');
    const time = now.toLocaleTimeString('fr-FR').split(':').join('_');
    const fileName = `statistique_${date}_${time}`;

    const link = document.createElement('a');
    link.href = window.URL.createObjectURL(data);
    link.download = `${fileName}.xlsx`;
    link.click();

    window.URL.revokeObjectURL(link.href);
  }

  exportExcel(columns: string[], columnLabels: Map<string, string | undefined> | undefined, statisticData: StatisticData[]): void {
    import('xlsx').then(xlsx => {
      const data = this.prepareDataForExport(columns, columnLabels, statisticData);
      console.log(data);

      const worksheet = xlsx.utils.json_to_sheet(data);

      const headerLabels: string[] = [];
      columns.forEach(column => {
        const label = columnLabels?.get(column);
        if (label) {
          headerLabels.push(label);
        }
      });

      const colWidths = this.calculateColumnWidths(data, headerLabels);
      worksheet['!cols'] = colWidths.map(width => ({ width }));

      const workbook = { Sheets: { 'data': worksheet }, SheetNames: ['data'] };

      const excelBuffer: any = xlsx.write(workbook, { bookType: 'xlsx', type: 'array' });
      this.saveAsExcelFile(excelBuffer, 'export_donnees');
    });
  }

  calculateColumnWidths(data: any[], headerLabels: string[]): number[] {
    const widths = headerLabels.map(label => label.length);

    data.forEach(row => {
      let colIndex = 0;
      for (const key in row) {
        if (row.hasOwnProperty(key) && colIndex < widths.length) {
          const value = row[key]?.toString() || '';
          const valueLength = value.length + 2;
          if (valueLength > widths[colIndex]) {
            widths[colIndex] = valueLength;
          }
          colIndex++;
        }
      }
    });

    return widths.map(width => Math.min(width, 50));
  }

  prepareDataForExport(columns: string[], columnLabels: Map<string, string | undefined> | undefined, data: StatisticData[]): any[] {
    return data.map(item => {
      const exportRow: any = {};
      columns.forEach(column => {
        const label: string | undefined = columnLabels?.get(column);
        if (label) {
          exportRow[label] = item[column];
        }
      });

      return exportRow;
    });
  }

  saveAsExcelFile(buffer: any, fileName: string): void {
    let EXCEL_TYPE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=UTF-8';
    let EXCEL_EXTENSION = '.xlsx';
    const data: Blob = new Blob([buffer], {
      type: EXCEL_TYPE
    });
    const now = new Date();
    const date = now.toLocaleDateString('fr-FR').split('/').join('_');
    const time = now.toLocaleTimeString('fr-FR').split(':').join('_');
    const newFileName = `statistique_${date}_${time}`;

    const link = document.createElement('a');
    link.href = window.URL.createObjectURL(data);
    link.download = `${fileName}.xlsx`;
    link.click();

    window.URL.revokeObjectURL(link.href);
  }

}
