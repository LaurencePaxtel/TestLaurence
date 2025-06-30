import {Injectable} from '@angular/core';

@Injectable({
  providedIn: 'root',
})

export class SituationBudgetaireService {


  constructor() {
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

  /**
   * Calcul du total participation
   * @param totalRessources
   * @param forfaitParticipation
   */
  computeTotalParticipation(totalRessources: number, forfaitParticipation: number): number {
    const totalParticipation = ((totalRessources * forfaitParticipation) / 100);
    return isNaN(totalParticipation) ? 0 : parseFloat(totalParticipation.toFixed(2));
  }

  /**
   * Calcul du reste a vivre por personne
   * @param totalRessources
   * @param totalCharges
   * @param nbPersonneMenage
   */
  computeResteAVivre(totalRessources: number, totalCharges: number, nbPersonneMenage: number): number {
    const resteAVivre = ((totalRessources - totalCharges) / nbPersonneMenage);
    return isNaN(resteAVivre) ? 0 : parseFloat(resteAVivre.toFixed(2));
  }

  /**
   * Calcul du taux d'effort sur le loyer
   * @param totalRessources
   * @param apl
   * @param loyer
   */
  computeTauxEffortLoyer(totalRessources: number, apl: number, loyer: number) {
    const tauxEffortLoyer = ((loyer * 100) / (totalRessources - apl));
    return Number.isFinite(tauxEffortLoyer) && !Number.isNaN(tauxEffortLoyer) ? parseFloat(tauxEffortLoyer.toFixed(2)) : 0

  }

  /**
   * Calcul du taux d'endettement
   * @param totalRessources
   * @param totalCharges
   */
  computeTauxEndettement(totalRessources: number, totalCharges: number) {
    const tauxEndettement = ((totalCharges * 100) / totalRessources);
    return Number.isFinite(tauxEndettement) && !Number.isNaN(tauxEndettement) ? parseFloat(tauxEndettement.toFixed(2)) : 0;
  }

  /**
   * Calcul du loyer max
   * @param totalRessources
   * @param apl
   */
  computeLoyerMax(totalRessources: number, apl: number) {
    const loyerMax = ((totalRessources - apl) * 0.30);
    return isNaN(loyerMax) ? 0 : parseFloat(loyerMax.toFixed(2));
  }
}
