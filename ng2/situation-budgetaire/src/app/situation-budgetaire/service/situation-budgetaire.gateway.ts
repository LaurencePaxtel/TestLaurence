import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";
import {Usager} from "../model/user";
import {map, Observable} from "rxjs";
import {Participation} from "../model/participation";
import {isValidDate, ParticipationDette, ParticipationDetteInfo} from "../model/participation-dette";
import {environment} from "../../../environments/environment";
import moment from "moment";

@Injectable({
  providedIn: 'root',
})
export class SituationBudgetaireGateway {

  constructor(private http: HttpClient) {
  }

  getUsageByHebergeId(hebergeId: number): Observable<Usager> {
    return this.http.get<any>(environment.apiUrl + '/4DACTION/outilsWebManageData?action=getRecordHeberge&hebergeID=' + hebergeId)
      .pipe(map((res) => {
        return {
          id: res.ID,
          referenceId: res.HB_ReferenceID,
          key: res['HB_Clé'],
          refStructure: res.Ref_Structure
        }
      }))
  }

  getParticipations(hebergeId: number): Observable<Participation[]> {
    return this.http.get<any>(environment.apiUrl + '/4DACTION/outilsWebManageData?action=getRecordsParticipationWeb&hebergeID=' + hebergeId)
      .pipe(map((res) => {
        let result: Participation[] = [];
        if (res?.data?.length) {
          res.data.forEach((participation: any) => {
            let item: Participation = Participation.fromJson(participation)
            result.push(item);
          })
        }
        return result;
      }))
  }

  getForfaitParticipations(refStructure: string): Observable<number[]> {
    return this.http.get<any>(environment.apiUrl + '/4DACTION/outilsWebManageEnumeration?action=getEnumeration&enumerationLib=FM Distri5&typeReturn=numeric&refStructure=' + refStructure)
      .pipe(map((res) => {
        return res.data?.length ? res.data : []
      }))
  }

  getParticipationDettes(hebergeId: number): Observable<ParticipationDette> {
    return this.http.get<any>(environment.apiUrl + '/4DACTION/outilsWebManageData?action=getRecordsParticipationDette&hebergeID='+ hebergeId)
      .pipe(
        map(result => {
          if (result?.data?.length) {
            let res = result?.data[0];
            let participationDette: ParticipationDette = ParticipationDette.fromJson(
              (res.dateSitBudget && moment(res.dateSitBudget, "YYYY-MM-DD", true).isValid() ? new Date(res.dateSitBudget) : new Date()),
              res.commentaire,
              res.nbPersonneMenage,
              res.modeFacturation,
              res.dettes
            )
            return participationDette
          } else {
            return ParticipationDette.new()
          }

        })
      )
  }

  saveParticipationWeb(hebergeId: number, participations: any[]): Observable<any> {
    return this.http.post(environment.apiUrl + '/4DACTION/outilsWebManageData', {
      action : "newOrModifyRecordParticipationWeb",
      hebergeID: hebergeId,
      data: participations
    })
  }

  saveParticipationDette(hebergeId: number, participationDette: ParticipationDette): Observable<any> {
    return this.http.post(environment.apiUrl + '/4DACTION/outilsWebManageData', {
      action : "newOrModifyRecordParticipationDette",
      hebergeID: hebergeId,
      data: participationDette
    })
  }
}
