import {Component, OnInit} from '@angular/core';
import {
  newCharge,
  newRessource,
  Participation,
  SimulateurInformation
} from "./model/participation";
import {MessageService} from "primeng/api";
import {SituationBudgetaireService} from "./service/situation-budgetaire.service";
import {SituationBudgetaireGateway} from "./service/situation-budgetaire.gateway";
import {combineLatest, skip, tap} from "rxjs";
import {Usager} from "./model/user";
import {ActivatedRoute} from "@angular/router";
import {ParticipationDette, ParticipationDetteInfo} from "./model/participation-dette";

@Component({
  selector: 'situation-budgetaire',
  templateUrl: './situation-budgetaire.component.html',
  styleUrl: './situation-budgetaire.component.scss',
  providers: [MessageService]
})
export class SituationBudgetaireComponent implements OnInit {

  _monthList: any[] = [];

  loader = false;
  saveLoader = false;

  yearList: any[] = [];
  forfaitParticipationList: number [] = [];
  selectedYear: number = 0;
  selectedMonth: number = 0;

  simulateurInformation: SimulateurInformation;
  resetParticipationLoader = false;
  duplicateAllMonthsLoader = false;
  duplicateNextMonthLoader = false;

  canEditRessourceAndCharge = false;

  participationByMonthAndYear: Map<number, Map<string, Participation>> = new Map();

  usager: Usager = Usager.new();
  participations: Participation[] = [];
  participationDette: ParticipationDette;
  planApurementOptions = ['Oui', 'Non'];

  constructor(
    private route: ActivatedRoute,
    private messageService: MessageService,
    private service: SituationBudgetaireService,
    private gateway: SituationBudgetaireGateway) {
    this.selectedYear = new Date().getFullYear();
    this.selectedMonth = new Date().getMonth();
    this._monthList = this.service.getMonthList();
    this.participationDette = ParticipationDette.new();
    this.simulateurInformation = {
      resteAVivre: 0,
      tauxEffortLoyer: 0,
      tauxEndettement: 0,
      loyerMax: 0
    }

  }

  ngOnInit(): void {
    //compute value later
    this.enableLoader();
    this.route.queryParams
      .pipe(
        skip(1),
        tap(params => {
          const hebergeId = params['hebergeId'];
          this.gateway.getUsageByHebergeId(hebergeId)
            .pipe(
              tap((usager: Usager) => {
                this.usager = usager;
                combineLatest([
                  this.gateway.getForfaitParticipations(this.usager.refStructure),
                  this.gateway.getParticipations(this.usager.id),
                  this.gateway.getParticipationDettes(this.usager.id)])
                  .pipe(
                    tap(([forfaitParticipations, participations, participationDette]) => {
                      this.forfaitParticipationList = forfaitParticipations;
                      this.participations = participations;
                      this.participationDette = participationDette;
                      this.constructParticipationMap(forfaitParticipations, participations);
                      this.initParticipationList()
                      this.computeCurrentAdditionalInformations();
                      this.disableLoader();
                    })
                  )
                  .subscribe()
              })
            )
            .subscribe()


        })).subscribe();




  }

  private constructParticipationMap(forfaitParticipations: number[], participations: Participation[]) {
    let years: Set<number> = new Set<number>();

    years.add(2024);
    years.add(this.selectedYear);

    participations.forEach(participation => {
      if (participation.annee) {
        years.add(participation.annee);
      }
    })

    years.forEach(year => {
      let mapByMonths = new Map();
      this.participationByMonthAndYear.set(year, mapByMonths);
      this._monthList.forEach(month => {
        let participation = participations.find(par => par.annee === year && par.mois === month.code);
        if (!participation) {
          participation = Participation.newParticipation(month.code, year, forfaitParticipations[0]);
        } else {
          participation.totalRessource = this.computeTotalRessource(participation);
          participation.totalCharge = this.computeTotalCharge(participation);
          if (!participation.ressource?.length) {
            participation.ressource = []
          }
          if (!participation.ressource?.length) {
            participation.charge = []
          }
        }
        mapByMonths.set(month.code, participation);
        if (year === this.selectedYear) {
          this.participations.push(participation);
        }
      })
      this.yearList.push(year);
    })

  }

  initParticipationList() {
    let participations: Participation[] = [];
    const participationsByYears = this.participationByMonthAndYear.get(this.selectedYear);
    participationsByYears?.forEach((value: Participation | undefined, key: string) => {
      if (value) {
        participations.push(value);
      }
    });
    this.participations = participations;
  }

  public enableLoader(): void {
    this.loader = true;
  }

  public disableLoader(): void {
    this.loader = false;
  }

  public computeTotalRessourceForParticipation(participation: Participation) {
    participation.totalRessource = this.computeTotalRessource(participation);
  }

  public computeTotalChargeForParticipation(participation: Participation) {
    participation.totalCharge = this.computeTotalCharge(participation);
  }


  private computeTotalRessource(participation: Participation): number {
    let totalNewRessource = 0;
    participation.ressource?.forEach((element, index) => {
      if (element.value)
        totalNewRessource += element.value
    });
    return totalNewRessource + participation.salaire + participation.apl;
  }

  private computeTotalCharge(participation: Participation): number {
    let totalNewCharge = 0;
    participation.charge?.forEach((element, index) => {
      if (element.value)
        totalNewCharge += element.value
    });
    return totalNewCharge + participation.loyer;
  }

  public computeCurrentAdditionalInformations() {
    const participation = this.participations[this.selectedMonth];
    this.computeAdditionalInformations(participation);
  }

  private computeAdditionalInformations(participation: Participation) {
    const resteAVivre = this.service.computeResteAVivre(participation.totalRessource, participation.totalCharge, this.participationDette.nbPersonneMenage)
    const tauxEffortLoyer = this.service.computeTauxEffortLoyer(participation.totalRessource, participation.apl, participation.loyer);
    const tauxEndettement = this.service.computeTauxEndettement(participation.totalRessource, participation.totalCharge);
    const loyerMax = this.service.computeLoyerMax(participation.totalRessource, participation.apl);

    this.updateSimulateurInformation(resteAVivre, tauxEffortLoyer, tauxEndettement, loyerMax);

    participation.totalParticipation = this.service.computeTotalParticipation(participation.totalRessource, participation.forfaitParticipation);
  }

  addRessource(participation: Participation) {
    participation.ressource.push(newRessource());
  }

  removeRessource(participation: Participation, index: number): void {
    participation.ressource.splice(index, 1);
    participation.totalRessource = this.computeTotalRessource(participation);
  }

  addCharge(participation: Participation) {
    participation.charge.push(newCharge());
  }

  removeCharge(participation: Participation, index: number): void {
    participation.charge.splice(index, 1);
    participation.totalCharge = this.computeTotalCharge(participation);
  }

  addParticipationDetteInfo() {
    this.participationDette.dettes.push(ParticipationDetteInfo.new())
  }

  removeParticipationDetteInfo(index: number) {
    this.participationDette.dettes.splice(index, 1);
    this.computeTotalParticipationDette();
  }

  /**
   * Event emis lorsque on click sur un nouveau mois dans le système d'onglet
   * @param event
   */
  onTabMonthChange(event: any) {
    this.selectedMonth = event.index;
    this.computeCurrentAdditionalInformations();
  }

  duplicateParticipationOnNextMonth() {
    this.duplicateNextMonthLoader = true;
    let nextMonth = this._monthList[this.selectedMonth + 1];
    const participation = this.participations[this.selectedMonth];
    let nextParticipation = this.participations[this.selectedMonth + 1];
    nextParticipation.copy(nextMonth.code, this.selectedYear, participation);


    setTimeout(() => {
      this.duplicateNextMonthLoader = false
      this.messageService.add({
        severity: 'success',
        summary: "Succès",
        detail: 'Le tableau d informations ont été correctement dupliqué sur le mois suivant'
      });
    }, 250);
  }

  duplicateParticipationOnAllMonths() {
    this.duplicateAllMonthsLoader = true;
    let participations: Participation[] = [];
    const participationToCopy = this.participations[this.selectedMonth];
    this.participations.forEach((participation, index) => {
      if ((participation.mois !== participationToCopy.mois && participation.annee === participationToCopy.annee)
        && index > this.participations.indexOf(this.participations[this.selectedMonth])) {
        participation.copyParticipation(participationToCopy)
        participations.push(participation);
      } else {
        participations.push(participation)
      }
    })

    this.participations = participations;

    setTimeout(() => {
      this.duplicateAllMonthsLoader = false
      this.messageService.add({
        severity: 'success',
        summary: "Succès",
        detail: 'Les informations ont été correctement dupliqué sur tous les mois de l\'année en cours'
      });
    }, 250);

  }

  resetParticipation() {
    this.resetParticipationLoader = true;
    const currentParticipation = this.participations[this.selectedMonth];
    currentParticipation.reset();
    this.resetSimulateurInformation();
    setTimeout(() => {
      this.resetParticipationLoader = false
    }, 250);
  }

  resetSimulateurInformation() {
    this.simulateurInformation = {
      resteAVivre: 0,
      tauxEffortLoyer: 0,
      tauxEndettement: 0,
      loyerMax: 0
    }
  }

  private updateSimulateurInformation(resteAVivre: number, tauxEffortLoyer: number, tauxEndettement: number, loyerMax: number) {
    this.simulateurInformation = {
      resteAVivre: resteAVivre,
      tauxEffortLoyer: tauxEffortLoyer,
      tauxEndettement: tauxEndettement,
      loyerMax: loyerMax
    }
  }

  print() {
    window.print();
  }

  onCompleteEditDettes($event: any) {
    const field = $event.field;
    const index = $event.index;
    let currentParticipationDette = this.participationDette.dettes[index]

    if (field === 'duree' || field === 'dateDebut') {
      currentParticipationDette.computeDateFin()
    }

    if (field === 'duree' || field === 'montant') {
      currentParticipationDette.computeMontantMensuel()
    }

    currentParticipationDette.computeView();
    currentParticipationDette.computeMontantRestant();
    this.computeTotalParticipationDette();
  }


  private computeTotalParticipationDette() {
    this.participationDette.computeTotal();
  }

  public saveData() {
    this.saveLoader = true;


    combineLatest([
      this.gateway.saveParticipationWeb(this.usager.id, this.participations),
      this.gateway.saveParticipationDette(this.usager.id, this.participationDette)])
      .pipe(
        tap(([result1, result2]) => {
          this.saveLoader = false;
          this.messageService.add({
            severity: 'success',
            summary: "Enregistrement OK",
            detail: 'Les participations et dettes ont été correctement enregistrés'
          });
        })
      )
      .subscribe()
  }
}
