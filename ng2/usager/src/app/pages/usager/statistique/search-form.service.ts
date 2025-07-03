import {Injectable} from "@angular/core";
import {FormArray, FormControl, FormGroup, Validators} from "@angular/forms";
import moment from "moment/moment";
import {SearchItem} from "./search-item";
import {present} from "../../../utils/lang.utils";
import {TableColumn} from "./enumeration-item";

export type SearchForm = FormGroup<{
  dateDu: FormControl<Date | null | undefined>;
  dateAu: FormControl<Date | null | undefined>;
  approuve: FormControl<boolean | null | undefined>;
  familyHead: FormControl<boolean | null | undefined>;
  ageMin: FormControl<number | null | undefined>;
  ageMax: FormControl<number | null | undefined>;
  dateContactDu: FormControl<Date | null | undefined>;
  dateContactAu: FormControl<Date | null | undefined>;
  dateEntreeDu: FormControl<Date | null | undefined>;
  dateEntreeAu: FormControl<Date | null | undefined>;
  dateSortieDu: FormControl<Date | null | undefined>;
  dateSortieAu: FormControl<Date | null | undefined>;
  fiche: FormControl<boolean | null | undefined>;
  ficheEntree: FormControl<boolean | null | undefined>;
  centreHebergemement: FormControl<any | null | undefined>;
  prestations: FormControl<any | null | undefined>;
  tableColonnes: FormControl<any | null | undefined>;
  statistiqueFicheUnique: FormControl<boolean | null | undefined>;
  autreCriteres: FormArray;
}>;

@Injectable({
  providedIn: 'root',
})
export class SearchFormService {
  private constructor(
    readonly form: FormGroup
  ) {
  }

  static newInstance(): SearchFormService {
    const firstDayOfYear = moment().startOf('year').toDate();
    const lastDayOfYear = moment().endOf('year').toDate();
    return new SearchFormService(new FormGroup({
      dateDu: new FormControl(firstDayOfYear),
      dateAu: new FormControl(lastDayOfYear),
      approuve: new FormControl(true),
      famChef: new FormControl('any'),
      ageMin: new FormControl(null, Validators.min(0)),
      ageMax: new FormControl(null),
      dateContactDu: new FormControl(null),
      dateContactAu: new FormControl(null),
      dateEntreeDu: new FormControl(null),
      dateEntreeAu: new FormControl(null),
      dateSortieDu: new FormControl(null),
      dateSortieAu: new FormControl(null),
      fiche: new FormControl(false),
      ficheEntree: new FormControl(false),
      centreHebergemements: new FormControl(null),
      prestations: new FormControl(null),
      tableColonnes: new FormControl(null),
      resultatType: new FormControl('other-criteria'),
      resultatAutreCritereValeur: new FormControl({value: null, disabled: false}),
      chiffres: new FormControl('personne'),
      typeGraph: new FormControl('bar'),
      statistiqueFicheUnique: new FormControl(false),
      autreCriteres: new FormArray([
        new FormGroup({
          type: new FormControl(null),
          criteria: new FormControl({value: null, disabled: true})
        })
      ])
    }));
  }

  resetForm(): void {
    this.form.patchValue({
      dateDu:  moment().startOf('year').toDate(),
      dateAu: moment().endOf('year').toDate(),
      approuve: true,
      famChef: 'any',
      ageMin: undefined,
      ageMax: undefined,
      dateContactDu: undefined,
      dateContactAu: undefined,
      dateEntreeDu: undefined,
      dateEntreeAu: undefined,
      dateSortieDu: undefined,
      dateSortieAu: undefined,
      fiche: false,
      ficheEntree: false,
      centreHebergemements: undefined,
      prestations: undefined,
      chiffres: 'personne',
      statistiqueFicheUnique: false,
      typeGraph: 'pie',
      resultatType: 'other-criteria',
      resultatAutreCritereValeur: {value: null, disabled: false},
    })
    const criteriaArray = this.form.get('autreCriteres') as FormArray;
    criteriaArray.clear();
    criteriaArray.push(this.createOtherCriteria())
  }

  updateFromSearchItemFilters(searchItem: SearchItem): void {
    let dataRetour: string[];
    if (present(searchItem.dataRetour)) {
      const elementToRemove = 'HG_HB_ID';
      dataRetour = searchItem.dataRetour.filter(item => item !== elementToRemove);
    } else {
      dataRetour = [];
    }

    let statistiqueComptage
    if (present(searchItem.statistiqueComptage)) {
      statistiqueComptage = searchItem.statistiqueComptage
    }
    let typeGraph = searchItem.typeGraph === 'Pie' ? 'pie' : 'bar'
    let resultatType = 'other-criteria';
    let resultatAutreCritereValeur;
    if (present(searchItem.statistiqueType)) {
      if (searchItem.statistiqueType === 'mois') {
        resultatType = 'mois'
      } else if (searchItem.statistiqueType === 'HG_CentreNom') {
        resultatType = 'HG_CentreNom'
      }  else if (searchItem.statistiqueType === 'états civils fusionnés') {
        resultatType = 'états civils fusionnés'
      } else if (searchItem.statistiqueType === 'tranches d’âges') {
        resultatType = 'tranches d’âges'
      } else {
        resultatAutreCritereValeur = searchItem.statistiqueType
      }
    }

    let dateDu;
    let dateAu;
    let famChef = 'any'
    let ageMin;
    let ageMax;
    let dateContactDu;
    let dateContactAu;
    let dateEntreeDu;
    let dateEntreeAu;
    let dateSortieDu;
    let dateSortieAu;
    let fiche = false;
    let centreHebergements = [];
    let prestations = [];
    let approuve = false;
    let ficheEntree = false;
    const criteriaArray = this.form.get('autreCriteres') as FormArray;
    criteriaArray.clear();
    if (present(searchItem.filtreRecherche)) {
      for (const key in searchItem.filtreRecherche) {
        const value = searchItem.filtreRecherche[key];
        if (key === 'HG_DateMin') {
          dateDu = moment(value, 'YYYY-MM-DD').toDate();
        }
        else if (key === 'HG_DateMax') {
          dateAu = moment(value, 'YYYY-MM-DD').toDate();
        }
        else if (key === 'HG_FamChef') {
          famChef = value;
        }
        else if (key === 'HG_AgeMin') {
          ageMin = value;
        }
        else if (key === 'HG_AgeMax') {
          ageMax = value;
        }
        else if (key === 'HG_DatePremierContactMin') {
          dateContactDu = moment(value, 'YYYY-MM-DD').toDate();
        }
        else if (key === 'HG_DatePremierContactMax') {
          dateContactAu = moment(value, 'YYYY-MM-DD').toDate();
        }
        else if (key === 'HG_DateEntreeMin') {
          dateEntreeDu = moment(value, 'YYYY-MM-DD').toDate();
        }
        else if (key === 'HG_DateEntreeMax') {
          dateEntreeAu = moment(value, 'YYYY-MM-DD').toDate();
        }
        else if (key === 'HG_DateSortieMin') {
          dateSortieDu = moment(value, 'YYYY-MM-DD').toDate();
        }
        else if (key === 'HG_DateSortieMax') {
          dateSortieAu = moment(value, 'YYYY-MM-DD').toDate();
        }
        else if (key === 'HG_Nuit') {
          fiche = value;
        }
        else if (key === 'HG_CentreNom') {
          centreHebergements = value;
          prestations = value;
        }
        else if (key === 'HG_Cloturée') {
          approuve = value
        } else if (key === 'HG_NuitenCours' && value === 1) {
          ficheEntree = true
        }else {
          criteriaArray.insert(0, this.createOtherCriteriaNotDisabled(key, value));
        }
      }
    }

    if (fiche) {
      centreHebergements = [];
    } else  {
      prestations = [];
    }

    this.form.patchValue({
      dateDu: dateDu,
      dateAu: dateAu,
      famChef: famChef,
      ageMin: ageMin,
      ageMax: ageMax,
      dateContactDu: dateContactDu,
      dateContactAu: dateContactAu,
      dateEntreeDu: dateEntreeDu,
      dateEntreeAu: dateEntreeAu,
      dateSortieDu: dateSortieDu,
      dateSortieAu: dateSortieAu,
      fiche: fiche,
      ficheEntree: ficheEntree,
      centreHebergemements: centreHebergements,
      prestations: prestations,
      approuve: approuve,
      chiffres: statistiqueComptage,
      statistiqueFicheUnique: searchItem.statistiqueFicheUnique,
      typeGraph: typeGraph,
      resultatType: resultatType,
      resultatAutreCritereValeur: resultatAutreCritereValeur,
      tableColonnes: dataRetour
    })

  }

  createOtherCriteria(): FormGroup {
    return new FormGroup({
      type: new FormControl(null),
      criteria: new FormControl({value: null, disabled: true})
    })
  }

  createOtherCriteriaNotDisabled(type: string, value: string[]): FormGroup {
    return new FormGroup({
      type: new FormControl(type),
      criteria: new FormControl({value: value, disabled: false})
    })
  }

  addCriteria() {
    const criteriaArray = this.form.get('autreCriteres') as FormArray;
    criteriaArray.push(this.createOtherCriteria());
  }

  removeCriteria(index: number) {
    const criteriaArray = this.form.get('autreCriteres') as FormArray;
    criteriaArray.removeAt(index);
  }

  updateColumnTables(columnOptions: TableColumn[]) {
    let values: string[] = []
    for (const columnOption of columnOptions) {
      if (columnOption.defaultDisplay) {
        values.push(columnOption.value)
      }
    }
    this.form.patchValue({
      tableColonnes: values
    })
  }

}
