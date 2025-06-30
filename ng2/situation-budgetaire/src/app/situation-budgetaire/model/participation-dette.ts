import moment from "moment";

export class ParticipationDette {

  constructor(public dateSitBudget: Date,
              public commentaire: string,
              public nbPersonneMenage: number,
              public modeFacturation : string,
              public dettes: ParticipationDetteInfo[],
              public totalMontant: number,
              public totalMontantMensualite: number,
              public totalMontantDetteRestante: number) {
    this.computeTotal();
  }

  public static new(): ParticipationDette {
    return new ParticipationDette(
      new Date(),
      '',
      1,
      '',
      [],
      0,
      0,
      0);

  }

  public computeTotal() {
    let totalMontant = 0;
    let totalMontantMensualite = 0;
    let totalMontantDetteRestante = 0;

    this.dettes?.forEach(dette => {
      if (dette.montant) {
        totalMontant += dette.montant;
      }
      if (dette.montantMensuel) {
        totalMontantMensualite += dette.montantMensuel;
      }
      if (dette.montantRestant) {
        totalMontantDetteRestante += dette.montantRestant;
      }
    })

    this.totalMontant = parseFloat(totalMontant.toFixed(2));
    this.totalMontantMensualite =  parseFloat(totalMontantMensualite.toFixed(2));
    this.totalMontantDetteRestante =  parseFloat(totalMontantDetteRestante.toFixed(2));
  }

  public static fromJson(
    dateSitBudget: Date, 
    commentaire: string,  
    nbPersonneMenage: number, 
    modeFacturation:string, 
    dettes: any[]): ParticipationDette {
      let result: ParticipationDetteInfo[] = [];
      if (dettes?.length) {
        dettes.forEach((dette: any) => {
        let item: ParticipationDetteInfo = new ParticipationDetteInfo(
          dette.lib,
          dette.montant,
          dette.planApurement,
          dette.duree,
          isValidDate(dette.dateDebut) ? new Date(dette?.dateDebut) : null,
          isValidDate(dette.dateFin) ? new Date(dette.dateFin) : null,
          dette.montantMensuel,
          dette.arretAvantTerme,
          isValidDate(dette.dateDerniereMensualite) ? new Date(dette.dateDerniereMensualite) : null,
          dette.montantRestant);
        result.push(item)
      })
    }

    return new ParticipationDette(
      dateSitBudget,
      commentaire,
      nbPersonneMenage,
      modeFacturation,
      result,
      0,
      0,
      0
    )

  }


}

export class ParticipationDetteInfo {


  view?: any

  constructor(public lib: string,
              public montant: number | null,
              public planApurement: string | null,
              public duree: number | null,
              public dateDebut: Date | null,
              public dateFin: Date | null,
              public montantMensuel: number,
              public arretAvantTerme: string | null,
              public dateDerniereMensualite: Date | null,
              public montantRestant: number) {
    this.computeView()
  }

  public static new(): ParticipationDetteInfo {
    return new ParticipationDetteInfo('',
      null,
      null,
      null,
      null,
      null,
      0,
      null,
      null,
      0);
  }

  public computeView(): any {
    let showWarning = false;
    let showSuccess = false
    if (this.dateFin) {
      showWarning = this.arretAvantTerme !== 'Oui' && new Date() < this.dateFin;
      showSuccess = this.arretAvantTerme !== 'Oui' && new Date() > this.dateFin;
    }
    this.view = {
      showWarning: showWarning,
      showSuccess: showSuccess
    }
  }

  computeDateFin() {
    let newDate = null;
    if (this.dateDebut && this.duree) {
      const date = this.dateDebut;
      newDate=  moment(date).add(this.duree, 'months').toDate();
    }
    this.dateFin = newDate;
  }

  computeMontantMensuel() {
    if (this.duree && this.montant) {
      this.montantMensuel= parseFloat((this.montant / this.duree).toFixed(2));
    }
  }

  computeMontantRestant() {

    if (!this.montantMensuel) {
      this.montantRestant = 0;
      return;
    }

    let nbMonth = 0;
    if (this.arretAvantTerme === 'Oui') {
      if (!this.dateFin || !this.dateDerniereMensualite) {
        this.montantRestant = 0;
        return;
      }
      nbMonth = moment(this.dateFin).diff(moment(this.dateDerniereMensualite), 'months', true);
    } else {
      if (!this.dateFin) {
        this.montantRestant = 0;
        return;
      }
      nbMonth = moment(this.dateFin).diff(moment(new Date()), 'months', true);
    }

    const rounded = (Math.trunc(nbMonth) * this.montantMensuel).toFixed(2);
    const result = parseFloat(rounded);
    this.montantRestant=  result <= 0 ? 0 : result;
  }
}

export function isValidDate(date: string): boolean {
  var timestamp = Date.parse(date);
  return !isNaN(timestamp);
}
