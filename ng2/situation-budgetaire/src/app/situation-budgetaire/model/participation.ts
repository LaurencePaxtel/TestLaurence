export class Participation {

  constructor(public ID: number | null,
              public mois: number,
              public annee: number,
              public salaire: number,
              public apl: number,
              public loyer: number,
              public charge: Charge[],
              public ressource: Ressource[],
              public forfaitParticipation: number,
              public totalParticipation: number,
              public totalRessource: number,
              public totalCharge: number) {
  }

  public static newParticipation(mois: number, annee: number, forfaitParticipation: number): Participation {
    return new Participation(null, mois, annee, 0, 0, 0, [], [], forfaitParticipation, 0, 0, 0);
  }

  public static fromJson(participation: any) {
    return new Participation(participation.ID,
      participation.mois,
      participation.annee,
      participation.salaire,
      participation.apl,
      participation.loyer,
      participation.charge,
      participation.ressource,
      participation.forfaitParticipation,
      participation.totalParticipation,
      participation.totalRessource,
      participation.totalCharge);;
  }

  public copy(mois: number, annee: number, participation: Participation) {
    this.mois = mois;
    this.annee = annee;
    this.salaire = participation.salaire;
    this.apl = participation.apl;
    this.loyer = participation.loyer;
    this.charge = participation.charge;
    this.ressource = participation.ressource;
    this.forfaitParticipation = participation.forfaitParticipation;
    this.totalParticipation = participation.totalParticipation;
    this.totalRessource = participation.totalRessource;
    this.totalCharge = participation.totalCharge
  }

  public copyParticipation(participation: Participation) {
    this.salaire = participation.salaire;
    this.apl = participation.apl;
    this.loyer = participation.loyer;
    this.charge = participation.charge;
    this.ressource = participation.ressource;
    this.forfaitParticipation = participation.forfaitParticipation;
    this.totalParticipation = participation.totalParticipation;
    this.totalRessource = participation.totalRessource;
    this.totalCharge = participation.totalCharge
  }

  public reset() {
    this.salaire = 0;
    this.apl = 0;
    this.loyer = 0;
    this.totalParticipation = 0;
    this.charge = [];
    this.ressource = [];
    this.totalRessource = 0;
    this.totalCharge = 0;
  }


}


export interface Charge {
  lib: string;
  value: number | null;
}

export interface Ressource {
  lib: string;
  value: number | null;
}

export interface SimulateurInformation {
  resteAVivre: number;
  tauxEffortLoyer: number;
  tauxEndettement: number;
  loyerMax: number;
}

export function newRessource() {
  return {
    lib: '',
    value: null
  }
}

export function newCharge() {
  return {
    lib: '',
    value: null
  }
}
