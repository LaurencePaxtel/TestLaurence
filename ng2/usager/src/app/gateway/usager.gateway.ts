import { inject, Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { UnknownUsager, Usager, UsagerDetails } from '../model/usager.model';
import { Fiche } from '../model/fiche.model';
import { formatDate, isValidDateFormat, isValidISODateString, parseDate } from '../utils/date.utils';
import { SearchUsagerCommand } from './comand/search-usager.command';
import { Centre } from '../model/centre.model';
import { Groupe } from '../model/groupe.model';
import {environment} from "../../environments/environment";

@Injectable({
    providedIn: 'root'
})
export class UsagerGateway {
    private httpClient = inject(HttpClient);
    constructor() {}

    searchUsagers(searchCommand: SearchUsagerCommand): Observable<Usager[]> {
        let params = new HttpParams();
        Object.entries(searchCommand.toHttpParams()).forEach(([key, value]) => {
            if (value !== undefined && value !== null && value !== '') {
                params = params.append(key, value.toString());
            }
        });

        console.log('PARAMS', params);
        return this.httpClient.get<Usager[]>(environment.apiUrl +'/INT', { params }).pipe(
            map((data) => {
                if (!data || data.length === 0) {
                    return [];
                }
                const result = [];
                for (const value of data) {
                    result.push(
                        Usager.from({
                            id: value.id,
                            hb_cle: value.hb_cle,
                            clefamille: value.clefamille,
                            hb_referenceid: value.hb_referenceid,
                            count_fiches: value.count_fiches,
                            noteSP: value.noteSP,
                            isFamChief: value.isFamChief,
                            hg_genre: value.hg_genre,
                        })
                    );
                }
                return result;
            })
        );
    }

    loadUsagerFiches(hbReferenceId: number): Observable<Fiche[]> {
        const params = new HttpParams().set('action', 'usager_list_json_rt').set('cle', hbReferenceId).set('filtre', 'jour_nuit');
        return this.httpClient.get<Fiche[]>(environment.apiUrl +'/INT', { params }).pipe(
            map((data: any[]) => {
                if (!data || data.length === 0) {
                    return [];
                }
                const result = [];
                for (const value of data) {
                    result.push(
                        Fiche.from({
                            id: value.id,
                            date: isValidDateFormat(value.date) ? new Date(value.date) : undefined,
                            prestation: value.prestation,
                            Sortie: value.Sortie,
                            reservation: value.reservation,
                            c: value.c,
                            hg_hb_id: value.hg_hb_id,
                            plateforme: value.plateforme,
                            autresolution: value.autresolution,
                            edit: value.edit,
                            checkbox: value.checkbox
                        })
                    );
                }
                return result;
            })
        );
    }

    deleteUsagerFiches(hbReferenceId: number, ficheIDs: (string | undefined)[]): Observable<any> {
        const params = new HttpParams().set('action', 'deleteHebergement').set('hebergeID', hbReferenceId).set('hebergementIDS', JSON.stringify(ficheIDs));
        return this.httpClient.get(environment.apiUrl +'/4DACTION/outilsWebHebergeListeAjax', { params });
    }

    loadUsager(hbReferenceId: number | string | undefined): Observable<UsagerDetails | undefined> {
        const params = new HttpParams().set('action', 'get_heberge').set(
            'json',
            JSON.stringify({
                zone: 'heberge',
                action: 'get_heberge',
                data: {
                    heberge: {
                        hg_hb_id: hbReferenceId
                    }
                }
            })
        );
        return this.httpClient.get<Fiche[]>(environment.apiUrl +'/INT', { params }).pipe(
            map((results: any[]) => {
                if (!results || results.length === 0) {
                    return undefined;
                }
                let result = results[0];
                return UsagerDetails.from({
                    hb_referenceid: result.hb_referenceid,
                    hb_nom: result.hb_nom,
                    hb_prenom: result.hb_prenom,
                    hb_cle: result.hb_cle,
                    adresse1: result.adresse1,
                    adresse2: result.adresse2,
                    adresse3: result.adresse3,
                    codePostal: result.codePostal,
                    ville: result.ville,
                    hb_telephone: result.hb_telephone,
                    hb_email: result.hb_email,
                    hb_datenele: parseDate(result.hb_datenele),
                    hb_piececni: result.hb_piececni,
                    hb_piecenationalite: result.hb_piecenationalite,
                    hb_pieceneou: result.hb_pieceneou,
                    hb_piecepasseport: result.hb_piecepasseport,
                    hb_cas1: result.hb_cas1,
                    hb_cas2: result.hb_cas2,
                    hb_cas3: result.hb_cas3,
                    hb_cas4: result.hb_cas4,
                    hb_cas5: result.hb_cas5,
                    hb_cas6: result.hb_cas6,
                    hb_cas7: result.hb_cas7,
                    hb_cas8: result.hb_cas8,
                    hb_cas9: result.hb_cas9,
                    hb_cas10: result.hb_cas10,
                    hb_casdt1: isValidISODateString(result.hb_casdt1) ? new Date(result.hb_casdt1) : undefined,
                    hb_casdt2: isValidISODateString(result.hb_casdt2) ? new Date(result.hb_casdt2) : undefined,
                    hb_casdt3: isValidISODateString(result.hb_casdt3) ? new Date(result.hb_casdt3) : undefined,
                    hb_casdt4: isValidISODateString(result.hb_casdt4) ? new Date(result.hb_casdt4) : undefined,
                    hb_casdt5: isValidISODateString(result.hb_casdt5) ? new Date(result.hb_casdt5) : undefined,
                    hb_casdt6: isValidISODateString(result.hb_casdt6) ? new Date(result.hb_casdt6) : undefined,
                    hb_casdt7: isValidISODateString(result.hb_casdt7) ? new Date(result.hb_casdt7) : undefined,
                    hb_casdt8: isValidISODateString(result.hb_casdt8) ? new Date(result.hb_casdt8) : undefined,
                    hb_casdt9: isValidISODateString(result.hb_casdt9) ? new Date(result.hb_casdt9) : undefined,
                    hb_casdt10: isValidISODateString(result.hb_casdt10) ? new Date(result.hb_casdt10) : undefined,
                    hb_caslib1: result.hb_caslib1,
                    hb_caslib2: result.hb_caslib2,
                    hb_caslib3: result.hb_caslib3,
                    hb_caslib4: result.hb_caslib4,
                    hb_caslib5: result.hb_caslib5,
                    hb_caslib6: result.hb_caslib6,
                    hb_caslib7: result.hb_caslib7,
                    hb_caslib8: result.hb_caslib8,
                    hb_caslib9: result.hb_caslib9,
                    hb_caslib10: result.hb_caslib10,
                    ref_structure: result.ref_structure
                });
            })
        );
    }

    generateUnknownUsagerData() {
        return this.httpClient.get(environment.apiUrl +'/4DACTION/outilsWebGenerateInconnu').pipe(
            map((response: any) => {
                if (!response || !response.inconnu) {
                    return undefined;
                }
                return UnknownUsager.from({
                    nom: response.inconnu?.nom,
                    prenom: response.inconnu?.prenom,
                    dateNaissance: parseDate(response.inconnu?.dateNaissance)
                });
            })
        );
    }

    createUsager(form: any) {
        const params = new HttpParams().set('action', 'usager_fiche_add').set(
            'json',
            JSON.stringify({
                zone: 'heberge',
                action: 'set_heberge',
                data: {
                    heberge: {
                        hb_telephone: form.phone,
                        hb_datenele: this.formatDate(form.birthDate),
                        hb_nom: form.name,
                        hb_prenom: form.firstname,
                        date_client: this.formatDate(new Date()),
                        jour_nuit: 'J',
                        hb_locataire: false
                    }
                }
            })
        );
        return this.httpClient.get(environment.apiUrl +'/INT', { params });
    }

    saveContactDetails(hbReferenceId: number, form: any): Observable<any> {
        const params = new HttpParams().set('action', 'usager_coordonnees_valider').set(
            'json',
            JSON.stringify({
                zone: 'heberge',
                action: 'set_heberge',
                data: {
                    heberge: {
                        hg_hb_id: hbReferenceId,
                        adresse1: form.adresse1,
                        adresse2: form.adresse2,
                        adresse3: form.adresse3,
                        codePostal: form.codePostal,
                        ville: form.ville,
                        nom: form.nom,
                        prenom: form.prenom,
                        dateNaissance: form.dateNaissance,
                        lieuNaissance: form.cni,
                        nationalite: form.numeroSecu,
                        numCNI: form.personneConfiance,
                        numPassport: form.piecePasseport,
                        email: form.email,
                        telephone: form.telephone
                    }
                }
            })
        );
        return this.httpClient.get(environment.apiUrl +'/INT', { params });
    }

    saveNotesSp(hbReferenceId: number, values: any): Observable<any> {
        const params = new HttpParams().set('action', 'usager_sp_valider').set(
            'json',
            JSON.stringify({
                zone: 'heberge',
                action: 'action',
                data: {
                    heberge: {
                        hg_hb_id: hbReferenceId,
                        ...values
                    }
                }
            })
        );
        return this.httpClient.get(environment.apiUrl +'/INT', { params });
    }

    saveMultiPointage(hbReferenceId: number, form: any): Observable<any> {
        const dispositif = form.dispositif.value;
        const idCentres = [];
        const centreDetails = [];
        for (const item of form.array) {
            idCentres.push(item.prestation.id);
            centreDetails.push({
                idItem: item.prestation.id.toString(),
                quantite: item.quantite.toString(),
                montant: item.montant.toString()
            });
        }
        const params = new HttpParams().set('action', 'hg_multi_pointage').set(
            'json',
            JSON.stringify({
                zone: 'usr',
                action: 'set_pla',
                data: {
                    pla: {
                        dateCreation: formatDate(form.date),
                        hb_id: hbReferenceId.toString(),
                        groupe: dispositif,
                        ids_centres: idCentres.join(';'),
                        ids_centresDetail: centreDetails
                    }
                }
            })
        );
        return this.httpClient.get(environment.apiUrl +'/USR', { params });
    }

    getCentres(): Observable<Centre[]> {
        const params = new HttpParams().set('action', 'get_json_mp_centre_hg');
        return this.httpClient.get(environment.apiUrl +'/INT', { params }).pipe(
            map((response: any) => {
                if (!response || !response.list) {
                    return [];
                }
                const result: Centre[] = [];
                for (const value of response.list) {
                    result.push(
                        Centre.from({
                            id: value.id,
                            value: value.value,
                            categorie: value.categorie,
                            prestation: value.prestation
                        })
                    );
                }
                return result;
            })
        );
    }

    getGroupes(): Observable<Groupe[]> {
        const params = new HttpParams().set('action', 'get_json_mp_groupe_hg');
        return this.httpClient.get(environment.apiUrl +'/INT', { params }).pipe(
            map((response: any) => {
                if (!response || !response.list) {
                    return [];
                }
                const result: Groupe[] = [];
                for (const value of response.list) {
                    result.push(
                        Groupe.from({
                            id: value.id,
                            value: value.value
                        })
                    );
                }
                return result;
            })
        );
    }

    private formatDate(date: Date): string {
        if (!date) return '';
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return `${day}/${month}/${year}`;
    }

    public savePlatform(intervenantId: number | undefined, plateform: string): Observable<any> {
        const params = new HttpParams()
            .set('action', 'sauvegarder')
            .set('propriete', 'plateforme')
            .set('valeur', plateform)
            .set('intervenantID', intervenantId ? intervenantId : 0);
        return this.httpClient.get(environment.apiUrl +'/4DACTION/Web_Manage_User_Preferences', { params });
    }


}
