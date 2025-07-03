

export interface StatisticData {
    age: number | null | undefined;
    dateNaissance: Date | null | undefined;
    famChef: boolean | null | undefined;
    hghbId:number;
    nom: string;
    prenom: string;
    id: number | null | undefined,
    adresse1: string,
    adresse2: string,
    adresse3: string,
    codePostal : number,
    email: string,
    genre: string,
    modeFacturation: string,
    ville: string
}


export interface StatisticChartData {
  enumeration: string;
  quantite: number;
}

export class StatisticResult {
  constructor(
    readonly status: boolean,
    readonly message: string,
    readonly typeGraph: string,
    readonly colonne: StatisticData[],
    readonly statistique: StatisticChartData[],
    readonly statistiqueTotal: number
  ) {
  }

  static empty(): StatisticResult {
    return StatisticResult.fromValues({
      colonne: [],
      statistique: [],
    })
  }

  static fromValues(values: Partial<StatisticResult>): Readonly<StatisticResult> {
    const v = values as StatisticResult;
    return Object.freeze(new StatisticResult(v.status,
      v.message,
      v.typeGraph,
      v.colonne,
      v.statistique,
      v.statistiqueTotal))
  }
}

export class StatisticCountResult {
  constructor(
    readonly nbFiches: number,
    readonly nbPersonnes: number,
    readonly nbFamChef: number,
  ) {
  }

  static empty(): StatisticCountResult {
    return StatisticCountResult.fromValues({
      nbFiches: 0,
      nbPersonnes: 0,
      nbFamChef: 0
    })
  }

  static fromValues(values: Partial<StatisticCountResult>): Readonly<StatisticCountResult> {
    const v = values as StatisticCountResult;
    return Object.freeze(new StatisticCountResult(v.nbFiches,
      v.nbPersonnes,
      v.nbFamChef));
  }
}


export interface StatisticDataItem {
  ID: number,
  Ref_Structure: string,
  affichageNom: string,
  dataRetour: string[],
  statistiqueComptage: string,
  statistiqueFicheEntree: boolean
  statistiqueFicheUnique: boolean,
  statistiqueType: string,
  typeGraph: string,
}
