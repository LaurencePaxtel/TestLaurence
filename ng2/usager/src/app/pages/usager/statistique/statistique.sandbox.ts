import {Injectable} from '@angular/core';
import {StatistiqueGateway} from "./statistique.gateway";
import {Observable} from "rxjs";
import {SearchForm} from "./search-form.service";
import {FormGroup} from "@angular/forms";
import {ChartType} from "chart.js";
import {EnumerationItem, TableColumn} from "./enumeration-item";
import {CentreHebergementPrestation} from "./centre";
import {StatisticCountResult, StatisticResult} from "./statistic-data";
import {SearchItem} from './search-item';
import {present} from '../../../utils/lang.utils';

export interface DropdownYesNoOption {
    label: string;
    value: boolean | null | string
}

export type StatisticResultType =
    'other-criteria'
    | 'HG_CentreNom'
    | 'mois'
    | 'états civils fusionnés'
    | 'tranches d’âges';

export interface ResultType {
    value: StatisticResultType
    label: string;
}

export type StatisticNumberType = 'personne' | 'fiche'

export interface NumberType {
    value: StatisticNumberType
    label: string;
}

export interface ChartTypeOption {
    value: ChartType
    label: string;
}

export const columnInEnumerationsByDefault = ['HG_EtatCivil', 'HG_CentreNom']

@Injectable({
    providedIn: 'root',
})
export class StatistiqueSandbox {


    constructor(private gateway: StatistiqueGateway) {
    }

    public getMonthList() {
        return [
            {
                "code": 1,
                "label": "Janvier"
            },
            {
                "code": 2,
                "label": "Fevrier"
            },
            {
                "code": 3,
                "label": "Mars"
            },
            {
                "code": 4,
                "label": "Avril"
            },
            {
                "code": 5,
                "label": "Mai"
            },
            {
                "code": 6,
                "label": "Juin"
            },
            {
                "code": 7,
                "label": "Juillet"
            },
            {
                "code": 8,
                "label": "Aout"
            },
            {
                "code": 9,
                "label": "Septembre"
            },
            {
                "code": 10,
                "label": "Octobre"
            },
            {
                "code": 11,
                "label": "Novembre"
            },
            {
                "code": 12,
                "label": "Decembre"
            },
        ];
    }

    public getYesNoOptions() {
        return [
            {
                value: 'any',
                label: "Tous"
            },
            {
                value: true,
                label: "Oui"
            },
            {
                value: false,
                label: "Non"
            },
        ]
    }

    public getFicheOptions(): DropdownYesNoOption[] {

        return [
            {
                value: false,
                label: "Fiches Hébergement"
            },
            {
                value: true,
                label: "Fiches Prestations"
            },
        ]
    }

    public getEnumerations(): Observable<EnumerationItem[]> {
        return this.gateway.getEnumerations();
    }

    public getCentreHebergementPrestations(): Observable<CentreHebergementPrestation[]> {
        return this.gateway.getCentreHebergementPrestations();
    }

    public getSearchList(): Observable<SearchItem[]> {
        return this.gateway.getSearchList();
    }

    public search(form: FormGroup,
                  otherCriteriaMapOptionsByLabel: Map<String, EnumerationItem>)
        : Observable<StatisticResult> {
        const searchFormObject: SearchForm = form.getRawValue();
        const requestBody = this.gateway.createRequestObject(
            searchFormObject,
            otherCriteriaMapOptionsByLabel
        );
        return this.gateway.search(requestBody);
    }

    public createRequestObject(form: FormGroup,
                               otherCriteriaMapOptionsByField: Map<String, EnumerationItem>): any {
        const searchFormObject: SearchForm = form.getRawValue();
        return this.gateway.createRequestObject(
            searchFormObject,
            otherCriteriaMapOptionsByField
        );
    }

    computeColumnOptions(): TableColumn[] {
        const options: TableColumn[] = [
            {
                libelle: 'Prénom',
                value: 'HG_Prénom',
                defaultDisplay: true
            },
            {
                libelle: 'Nom',
                value: 'HG_Nom',
                defaultDisplay: true
            },
            {
                libelle: 'Né le',
                value: 'HG_DateNéLe',
                defaultDisplay: true
            },
            {
                libelle: 'Age',
                value: 'HG_Age',
                defaultDisplay: true
            },
            {
                libelle: 'Chef de famille',
                value: 'HG_FamChef',
                defaultDisplay: true
            },
        ]
        return options;
    }

    getTypeResultats(): ResultType[] {
        return [
            {
                value: 'other-criteria',
                label: 'Autre critère',
            },
            {
                value: 'HG_CentreNom',
                label: 'Hebergement ou Prestation',
            },
            {
                value: 'états civils fusionnés',
                label: 'Etats civils fusionnés',
            },
            {
                value: 'tranches d’âges',
                label: 'Tranches d’âges',
            },
            {
                value: 'mois',
                label: 'Mois',
            }
        ];
    }

    getTypeChiffres(): NumberType[] {
        return [
            {
                value: 'personne',
                label: 'Nb de demandeurs',
            },
            {
                value: 'fiche',
                label: 'Nb de fiches',
            },
        ];
    }

    getTypeCharts(): ChartTypeOption[] {
        return [
            {
                value: 'pie',
                label: 'Camembert',
            },
            {
                value: 'bar',
                label: 'Barres',
            },
        ];
    }

    deleteSearchItem(item: SearchItem): Observable<any> {
        return this.gateway.deleteSearchItem(item);
    }

    updateSearchItemName(searchItemId: number, affichageNom: string) {
        return this.gateway.updateSearchItemName(searchItemId, affichageNom)
    }

    updateSearchItem(searchItemId: number, searchQuery: any) {
        return this.gateway.updateSearchItem(searchItemId, searchQuery)
    }


    createSearchItem(affichageNom: string, searchQuery: any) {
        return this.gateway.createSearchItem(affichageNom, searchQuery)
    }

    getSearchItemById(id: number): Observable<SearchItem> {
        return this.gateway.getSearchItemById(id);
    }

    generateSearchName(searchList: SearchItem[]) {
        const PREFIX = 'Liste_';

        const numbers = searchList
            .map(item => item.affichageNom)
            .filter(name => name.startsWith(PREFIX))
            .map(name => {
                const numberStr = name.substring(PREFIX.length);
                const number = parseInt(numberStr);
                return isNaN(number) ? 0 : number;
            });

        const maxNumber = numbers.length > 0 ? Math.max(...numbers) : 0;
        return `${PREFIX}${maxNumber + 1}`;
    }


    computeColumnsLabels(columnOptions: TableColumn[]): Map<string, string | undefined> {
        let result: Map<string, string | undefined> = new Map
        for (const option of columnOptions) {
            result.set(option.value, option.libelle);
        }
        return result
    }
}
