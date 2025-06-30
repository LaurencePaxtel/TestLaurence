import {Injectable} from '@angular/core';
import {StatistiqueGateway} from "./statistique.gateway";
import {Observable} from "rxjs";
import {EnumerationItem, TableColumn} from "../model/enumeration-item";
import {StatisticCountResult, StatisticResult} from "../model/statistic-data";
import {ChartType} from "../model/chart";
import {SearchForm} from "./search-form.service";
import {FormGroup} from "@angular/forms";
import {CentreHebergementPrestation} from "../model/centre";
import {SearchItem} from "../model/search-item";
import {present} from "./lang.utils";

export interface DropdownYesNoOption {
  label: string;
  value: boolean | null | string
}

export type StatisticResultType = 'other-criteria' | 'HG_CentreNom' | 'mois' | 'états civils fusionnés' | 'tranches d’âges';

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

  computeColumnOptions(enumerations: EnumerationItem[], enumerationsWithoutItemsMap: Map<string, EnumerationItem>): TableColumn[] {
    const options: TableColumn[] = [
      {
        libelle: 'Date',
        value: 'HG_Date',
        defaultDisplay: true
      },
      {
        libelle: 'Nom',
        value: 'HG_Nom',
        defaultDisplay: true
      },
      {
        libelle: 'Prénom',
        value: 'HG_Prénom',
        defaultDisplay: true
      },
      {
        libelle: 'Né le',
        value: 'HG_DateNéLe',
        defaultDisplay: true
      },
      {
        libelle: 'Clé de lien de famille',
        value: 'HG_FamClé',
        defaultDisplay: true
      },
      {
        libelle: 'Chef de famille',
        value: 'HG_FamChef',
        defaultDisplay: true
      },
      {
        libelle: 'Age',
        value: 'HG_Age',
        defaultDisplay: true
      },
      {
        libelle: 'Hebergement ou Prestation',
        value: 'HG_CentreNom',
        defaultDisplay: false
      },
      {
        libelle: 'Date entrée',
        value: 'HG_DateEntree',
        defaultDisplay: false
      },
      {
        libelle: 'Date sortie',
        value: 'HG_DateSortie',
        defaultDisplay: false
      },
      {
        libelle: 'Date 1er contact',
        value: 'HG_DatePremierContact',
        defaultDisplay: false
      },
      {
        libelle: 'Nuit en cours',
        value: 'HG_NuitenCours',
        defaultDisplay: false
      },
      {
        libelle: 'Nuit totales',
        value: 'HG_NuitTOTAL',
        defaultDisplay: false
      },
      {
        libelle: 'Approuvée',
        value: 'HG_Cloturée',
        defaultDisplay: false
      },
      {
        libelle: present(enumerationsWithoutItemsMap.get('HG_Coordinateur')) ? enumerationsWithoutItemsMap.get('HG_Coordinateur')?.libelle : 'HG_Coordinateur',
        value: 'HG_Coordinateur',
        defaultDisplay: false
      },
      {
        libelle: present(enumerationsWithoutItemsMap.get('HG_AssistSocial')) ? enumerationsWithoutItemsMap.get('HG_AssistSocial')?.libelle : 'HG_AssistSocial',
        value: 'HG_AssistSocial',
        defaultDisplay: false
      },
      {
        libelle: 'Plateforme',
        value: 'HG_Plateforme',
        defaultDisplay: false
      },
      {
        libelle: present(enumerationsWithoutItemsMap.get('HG_DernierEmplo')) ? enumerationsWithoutItemsMap.get('HG_DernierEmplo')?.libelle : 'HG_DernierEmplo',
        value: 'HG_DernierEmplo',
        defaultDisplay: false
      },
      {
        libelle: present(enumerationsWithoutItemsMap.get('HG_Commentaires')) ? enumerationsWithoutItemsMap.get('HG_Commentaires')?.libelle : 'HG_Commentaires',
        value: 'HG_Commentaires',
        defaultDisplay: false
      },
    ]
    for (const enumeration of enumerations) {
      let byDefault = false;
      if (columnInEnumerationsByDefault.includes(enumeration.champNom)) {
        byDefault = true;
      }
      options.push({
        libelle: enumeration.libelle,
        value: enumeration.champNom,
        defaultDisplay: byDefault
      });
    }


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
    const PREFIX = 'Statistique_';

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

  computeCounterResults(result: StatisticResult): StatisticCountResult {
    console.log(result);
    if (!result?.colonne?.length) {
      return StatisticCountResult.empty();
    }

    const nbFiches = result?.colonne?.length;

    const uniqueIDs = new Set(result.colonne.map(item => item['HG_HB_ID'])).size;
    const nbPersonnes = uniqueIDs;

    const uniqueChefIDs = new Set(
      result.colonne
        .filter(item => item['HG_FamChef'] === true)
        .map(item => item['HG_HB_ID'])
    );

    const nbFamChef = uniqueChefIDs.size;

    return StatisticCountResult.fromValues({
      nbFiches: nbFiches,
      nbPersonnes: nbPersonnes,
      nbFamChef: nbFamChef,
    })
  }
}
