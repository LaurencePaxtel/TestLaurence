import {Injectable} from "@angular/core";
import {StatisticData} from "./statistic-data";

export interface ColumnConfig {
    key: string;
    label: string;
}

@Injectable({
    providedIn: 'root',
})
export class ExcelService {

    private columnsConfig: ColumnConfig[] = [
        { key: 'nom', label: 'Nom' },
        { key: 'prenom', label: 'Prénom' },
        { key: 'dateNaissance', label: 'Né(e) le' },
        { key: 'age', label: 'Age' },
        { key: 'famChef', label: 'Chef de famille' },
    ];

    exportExcel(statisticData: StatisticData[]): void {
        import('xlsx').then(xlsx => {
            const data = this.prepareDataForExport(this.columnsConfig, statisticData);
            const worksheet = xlsx.utils.json_to_sheet(data);

            const headerLabels = this.columnsConfig.map(config => config.label);
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

    prepareDataForExport(columnsConfig: ColumnConfig[], data: StatisticData[]): any[] {
        return data.map(item => {
            const exportRow: any = {};
            columnsConfig.forEach(config => {
                let value = item[config.key as keyof StatisticData];

                // Formatage spécifique selon le type de données
                switch (config.key) {
                    case 'dateNaissance':
                        // Formatage de la date en format français
                        if (value instanceof Date) {
                            value = value.toLocaleDateString('fr-FR');
                        } else if (typeof value === 'string') {
                            const date = new Date(value);
                            value = date.toLocaleDateString('fr-FR');
                        }
                        break;

                    case 'famChef':
                        // Conversion du boolean en texte français
                        value = value ? 'Oui' : 'Non';
                        break;

                    case 'age':
                        // S'assurer que l'âge est affiché comme un nombre
                        value = typeof value === 'number' ? value : Number(value) || 0;
                        break;

                    default:
                        // Pour les autres champs (nom, prenom), garder la valeur telle quelle
                        value = value || '';
                        break;
                }

                exportRow[config.label] = value;
            });
            return exportRow;
        });
    }

    saveAsExcelFile(buffer: any, fileName: string): void {
        const EXCEL_TYPE = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=UTF-8';
        const EXCEL_EXTENSION = '.xlsx';
        const data: Blob = new Blob([buffer], {
            type: EXCEL_TYPE
        });

        const now = new Date();
        const date = now.toLocaleDateString('fr-FR').replace(/\//g, '_');
        const time = now.toLocaleTimeString('fr-FR').replace(/:/g, '_');
        const timestampedFileName = `${fileName}_${date}_${time}`;

        const link = document.createElement('a');
        link.href = window.URL.createObjectURL(data);
        link.download = `${timestampedFileName}${EXCEL_EXTENSION}`;
        link.click();

        window.URL.revokeObjectURL(link.href);
    }
}
