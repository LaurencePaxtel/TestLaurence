import {Injectable} from "@angular/core";
import {HttpClient} from "@angular/common/http";
import {map, Observable} from "rxjs";
import {Service, Transmission, TransmissionFilters, TransmissionForm, TransmissionResult} from "../model/transmission";
import {environment} from "../../../environments/environment";
import {Usager} from "../model/usager";
import {User} from "../model/user";
import moment from "moment";

@Injectable({
    providedIn: 'root',
})
export class TransmissionGateway {
    constructor(private http: HttpClient) {
    }

    public getTransmissions(refStructure: string, pageNumber: number, nbResultatParPage: number, filters: TransmissionFilters): Observable<TransmissionResult> {
        let queryParams: any = {
            action: 'getRecordsMessagerie',
            refStructure: refStructure,
            page: pageNumber,
            nbResultatParPage: nbResultatParPage
        }
        if (filters.date) {
            queryParams.date = moment(filters.date).format('DD/MM/YYYY');
            queryParams.dateSigneComparaison = '='
        }
        if (filters.priorite !== null && filters.priorite !== undefined) {
            queryParams.priorite = filters.priorite;
        }
        if (filters.service) {
            queryParams.service = filters.service;
        }

        if (filters.keyword) {
            queryParams.keyword = filters.keyword;
        }

        return this.http.get<any>(environment.apiUrl + '/4DACTION/outilsWebManageData', {
            params: queryParams
        }).pipe(map(result => {
            let items: Transmission[] = [];
            if (result?.data?.length) {
                result.data.forEach((transmission: any) => {
                    let item: Transmission = Transmission.fromJson(transmission);
                    items.push(item)
                })
            }
            return {
                totalRecords: result.totalRecords,
                data: items
            }
        }));
    }

    public getGroupes(refStructure: string): Observable<string[]> {
        return this.http.get<any>(environment.apiUrl + '/4DACTION/outilsWebManageEnumeration?action=getEnumeration&enumerationLib=FM Groupe&refStructure=' + refStructure)
            .pipe(
                map(result => {
                    return result?.data?.length ? result?.data : [];
                })
            );
    }

    public getUserConnected(): Observable<User> {
        return this.http.get<any>(environment.apiUrl + '/4DACTION/outilsWebManageData?action=getInfoUserConnected')
            .pipe(map((res) => {
                return {
                    refStructure: res?.intervenant?.Ref_Structure,
                    plateFormeServiceCode: res?.intervenant?.IN_Plateforme,
                    login: res?.intervenant?.IN_Login,
                    id: res?.intervenant?.ID
                }
            }));
    }


    public getAutocompleteUsagerList(filterQuery?: string): Observable<Usager[]> {
        const json: any = {
            zone: "globale",
            action: "get_autocomplete",
            data: {
                data_first: filterQuery,
                data_second: ""
            }
        }
        return this.http.get<Usager[]>(environment.apiUrl + '/GB', {
            params: {
                action: 'get_autocomplete_locataires',
                json: JSON.stringify(json)
            },
        })
    }

    public createNewTransmission(transmissionForm: TransmissionForm) {
        return this.http.post(environment.apiUrl + '/4DACTION/outilsWebManageData', {
            action: "newRecordMessagerie",
            hebergeID: transmissionForm?.usagerID,
            data: transmissionForm
        })
    }

    public updateTransmission(transmissionForm: TransmissionForm) {
        return this.http.post(environment.apiUrl + '/4DACTION/outilsWebManageData', {
            action: "modifyRecordMessagerie",
            hebergeID: transmissionForm?.usagerID,
            data: transmissionForm
        })
    }

    deleteTransmission(id: string) {
        return this.http.post(environment.apiUrl + '/4DACTION/outilsWebManageData', {
            action: "deleteRecord",
            data: {
                table: "Messagerie",
                id: id
            }
        })
    }
}
