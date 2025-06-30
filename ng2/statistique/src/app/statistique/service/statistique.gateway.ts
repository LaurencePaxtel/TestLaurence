import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {map, Observable, switchMap} from "rxjs";
import {EnumerationItem} from "../model/enumeration-item";
import {StatisticResult} from "../model/statistic-data";
import {present} from "./lang.utils";
import {CentreHebergementPrestation} from "../model/centre";
import moment from "moment/moment";
import {SearchItem} from "../model/search-item";
import {environment} from "../../../environments/environment";


export interface SearchQuery {
  affichageNom?: string;
  filtreRecherche?: any;
  dataRetour: string[];
  typeGraph: string;
}


@Injectable({
  providedIn: 'root',
})
export class StatistiqueGateway {

  constructor(private http: HttpClient) {
  }

  getEnumerations(): Observable<EnumerationItem[]> {
    return this.http.get<any>(environment.apiUrl + '/session/enumeration')
      .pipe(map(enumerations => {
        if (enumerations && enumerations.length > 0) {
          let result = [];
          for (const enumeration of enumerations) {
            if (enumeration.champNom && enumeration.libelle) {
              result.push(EnumerationItem.fromValues(enumeration))
            }
          }
          return result.sort((a, b) => {
            const libelleA = a.libelle || '';
            const libelleB = b.libelle || '';
            return libelleA.localeCompare(libelleB, 'fr');
          });
          ;
        } else {
          return [];
        }
      }));
  }

  getCentreHebergementPrestations(): Observable<CentreHebergementPrestation[]> {
    return this.http.get<any>(environment.apiUrl + '/session/centre')
      .pipe(map(centreHebergements => {
        if (centreHebergements && centreHebergements?.list?.length > 0) {
          let result = [];
          for (const centre of centreHebergements.list) {
            result.push(CentreHebergementPrestation.fromValues(centre))
          }
          return result;
        } else {
          return [];
        }
      }));
  }

  getSearchList(): Observable<SearchItem[]> {
    return this.http.get<any>(environment.apiUrl + '/statistiques/list')
      .pipe(map(searchList => {
        if (searchList && searchList?.data?.length > 0) {
          let result = [];
          for (const item of searchList.data) {
            result.push(SearchItem.fromValues(item))
          }
          return result;
        } else {
          return [];
        }
      }));
  }


  search(requestBody: any) {
    return this.http.get<any>(environment.apiUrl + '/statistiques/generer', {
      params: {
        login: true,
        query: JSON.stringify(requestBody)
      }
    })
      .pipe(map(result => {
        let columns = [];
        if (result?.colonne?.length) {
          columns = result?.colonne;
        }
        let statistique = [];
        let totalQuantity = 0;

        if (result?.statistique?.length) {
          statistique = result?.statistique;
          for (const statistique of result?.statistique) {
            totalQuantity += statistique.quantite;
          }
        }
        return StatisticResult.fromValues({
          status: result?.status,
          message: result?.message,
          typeGraph: result?.typeGraph,
          colonne: columns,
          statistique: statistique,
          statistiqueTotal: totalQuantity
        })
      }));
  }

  createRequestObject(searchForm: any, otherCriteriaMapOptionsByField: Map<String, EnumerationItem>): any {
    let filtreRecherche: any = {};
    if (present(searchForm.dateDu)) {
      filtreRecherche.HG_DateMin = moment(searchForm.dateDu).format('YYYY-MM-DD');
    }
    if (present(searchForm.dateAu)) {
      filtreRecherche.HG_DateMax = moment(searchForm.dateAu).format('YYYY-MM-DD');
    }
    if (present(searchForm.famChef) && searchForm.famChef !== 'any') {
      filtreRecherche.HG_FamChef = searchForm.famChef
    }
    if (present(searchForm.ageMin)) {
      filtreRecherche.HG_AgeMin = searchForm.ageMin;
    }
    if (present(searchForm.ageMax)) {
      filtreRecherche.HG_AgeMax = searchForm.ageMax;
    }
    if (present(searchForm.dateContactDu)) {
      filtreRecherche.HG_DatePremierContactMin = moment(searchForm.dateContactDu).format('YYYY-MM-DD');
    }
    if (present(searchForm.dateContactAu)) {
      filtreRecherche.HG_DatePremierContactMax = moment(searchForm.dateContactAu).format('YYYY-MM-DD');
    }
    if (present(searchForm.dateEntreeDu)) {
      filtreRecherche.HG_DateEntreeMin = moment(searchForm.dateEntreeDu).format('YYYY-MM-DD');
    }
    if (present(searchForm.dateEntreeAu)) {
      filtreRecherche.HG_DateEntreeMax = moment(searchForm.dateEntreeAu).format('YYYY-MM-DD');
    }
    if (present(searchForm.dateSortieDu)) {
      filtreRecherche.HG_DateSortieMin = moment(searchForm.dateSortieDu).format('YYYY-MM-DD');
    }
    if (present(searchForm.dateSortieAu)) {
      filtreRecherche.HG_DateSortieMax = moment(searchForm.dateSortieAu).format('YYYY-MM-DD');
    }
    if (searchForm.fiche === false && present(searchForm.centreHebergemements) && searchForm.centreHebergemements?.length > 0 ) {
      filtreRecherche.HG_CentreNom = searchForm.centreHebergemements;
    }
    if (searchForm.fiche === true && present(searchForm.prestations) && searchForm.prestations?.length > 0) {
      filtreRecherche.HG_CentreNom = searchForm.prestations;
    }
    if (searchForm.ficheEntree === true) {
      filtreRecherche.HG_NuitenCours = 1;
    }

    filtreRecherche.HG_Nuit = present(searchForm.fiche) ? searchForm.fiche : false
    filtreRecherche.HG_Cloturée = searchForm.approuve;
    for (const otherCriteria of searchForm.autreCriteres) {
      if (present(otherCriteria.type) && present(otherCriteria.criteria)) {
        filtreRecherche[otherCriteria.type] = otherCriteria.criteria
      }
    }
    let statistiqueType;
    if (present(searchForm.resultatType)) {
      if (searchForm.resultatType === 'other-criteria' && present(searchForm.resultatAutreCritereValeur)) {
        const otherCriteriaObject = otherCriteriaMapOptionsByField.get(searchForm.resultatAutreCritereValeur);
        if (present(otherCriteriaObject)) {
          statistiqueType = otherCriteriaObject.champNom;
        }
      } else if (searchForm.resultatType === 'HG_CentreNom') {
        statistiqueType = 'HG_CentreNom';
      } else if (searchForm.resultatType === 'états civils fusionnés') {
        statistiqueType = 'états civils fusionnés';
      } else if (searchForm.resultatType === 'tranches d’âges') {
        statistiqueType = 'tranches d’âges';
      } else if (searchForm.resultatType === 'mois') {
        statistiqueType = 'mois';
      }
    }
    let statistiqueComptage = searchForm.chiffres;
    let statistiqueFicheUnique = searchForm.statistiqueFicheUnique
    let typeGraph;

    if (searchForm.typeGraph === 'pie') {
      typeGraph = 'Pie'
    } else {
      typeGraph = 'Bar'
    }


    let dataRetour = searchForm.tableColonnes;

    return {
      filtreRecherche: filtreRecherche,
      dataRetour: dataRetour,
      typeGraph: typeGraph,
      statistiqueComptage: statistiqueComptage,
      statistiqueFicheUnique: statistiqueFicheUnique,
      statistiqueType: statistiqueType
    }
  }


  deleteSearchItem(item: SearchItem) {
    return this.http.get(environment.apiUrl + '/statistiques/delete', {
      params: {
        ID: item.ID
      }
    })
  }

  updateSearchItemName(searchItemId: number, affichageNom: string) {
    return this.getSearchItemById(searchItemId)
      .pipe(
        switchMap(searchItem => {
          return this.http.get(environment.apiUrl + '/statistiques/update', {
            params: {
              ID: searchItemId,
              statParam: JSON.stringify({
                affichageNom: affichageNom,
                Ref_Structure: searchItem.Ref_Structure,
                dataRetour: searchItem.dataRetour,
                filtreRecherche: JSON.stringify(searchItem.filtreRecherche),
                statistiqueComptage: searchItem.statistiqueComptage,
                statistiqueFicheUnique: searchItem.statistiqueFicheUnique,
                statistiqueType: searchItem.statistiqueType,
                typeGraph: searchItem.typeGraph,
              }),
            }
          })
        })
      )
  }

  updateSearchItem(searchItemId: number, searchQuery: any) {
    return this.getSearchItemById(searchItemId)
      .pipe(
        switchMap(searchItem => {
          return this.http.get(environment.apiUrl + '/statistiques/update', {
            params: {
              ID: searchItemId,
              statParam: JSON.stringify({
                affichageNom: searchItem.affichageNom,
                dataRetour: searchQuery.dataRetour,
                filtreRecherche: JSON.stringify(searchQuery.filtreRecherche),
                statistiqueComptage: searchQuery.statistiqueComptage,
                statistiqueFicheUnique: searchQuery.statistiqueFicheUnique,
                statistiqueType: searchQuery.statistiqueType,
                typeGraph: searchQuery.typeGraph,
              }),
            }
          })
        })
      )

  }

  getSearchItemById(id: number): Observable<SearchItem> {
    return this.http.get<SearchItem>(environment.apiUrl + '/statistiques/read', {
      params: {
        ID: id
      }
    }).pipe(map(response => {
      return SearchItem.fromValues({
        ID: response.ID,
        affichageNom: response.affichageNom,
        Ref_Structure: response.Ref_Structure,
        dataRetour: response.dataRetour,
        filtreRecherche: response.filtreRecherche,
        statistiqueComptage: response.statistiqueComptage,
        statistiqueFicheEntree: response.statistiqueFicheEntree,
        statistiqueFicheUnique: response.statistiqueFicheUnique,
        statistiqueType: response.statistiqueType,
        typeGraph: response.typeGraph,
      });
    }))
  }

  createSearchItem(affichageNom: string, searchQuery?: SearchItem) {
    let params;
    if (present(searchQuery)) {
      params = {
        statParam: JSON.stringify({
          affichageNom: affichageNom,
          dataRetour: searchQuery.dataRetour,
          filtreRecherche: JSON.stringify(searchQuery.filtreRecherche),
          statistiqueComptage: searchQuery.statistiqueComptage,
          statistiqueFicheUnique: searchQuery.statistiqueFicheUnique,
          statistiqueType: searchQuery.statistiqueType,
          typeGraph: searchQuery.typeGraph,
        }),
      }
    } else {
      params = {
        statParam: JSON.stringify({
          affichageNom: affichageNom,
        }),
      }
    }
    return this.http.get(environment.apiUrl + '/statistiques/update', {
      params: params
    })
  }
}
