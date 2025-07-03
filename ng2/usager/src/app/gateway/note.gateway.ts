import { inject, Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Note, NoteType } from '../model/note.model';
import { map } from 'rxjs/operators';
import { createDateFromTime, isValidDateFormatAsDDMMYYYY, parseDate } from '../utils/date.utils';
import {environment} from "../../environments/environment";

@Injectable({
    providedIn: 'root'
})
export class NoteGateway {
    private httpClient = inject(HttpClient);

    constructor() {}

    getNotesType(hebergeID: string | number): Observable<NoteType[]> {
        const params = new HttpParams().set('action', 'chargeTypeNote').set('hebergeID', hebergeID);

        return this.httpClient.get(environment.apiUrl +'/4DACTION/outilsWebHebergeListeAjax', { params }).pipe(
            map((response: any) => {
                if (!response || !response.data) {
                    return [];
                }
                const result: NoteType[] = [];
                for (const value of response.data) {
                    result.push(
                        NoteType.from({
                            label: value.lib,
                            value: value.value
                        })
                    );
                }
                return result;
            })
        );
    }

    getNotesByUsager(hebergeID: string | number): Observable<Note[]> {
        const params = new HttpParams().set('action', 'chargeNote').set('hebergeID', hebergeID);

        return this.httpClient.get(environment.apiUrl +'/4DACTION/outilsWebHebergeListeAjax', { params }).pipe(
            map((response: any) => {
                if (!response || !response.data) {
                    return [];
                }
                const result: Note[] = [];
                for (const value of response.data) {
                    result.push(
                        Note.from({
                            noteNumber: value['0'],
                            type: value['1'],
                            date: isValidDateFormatAsDDMMYYYY(value['2']) ? parseDate(value['2']) : undefined,
                            content: value['3'],
                            userName: value['4'],
                            uuid: value['5'],
                            hour: createDateFromTime(value['6']),
                            editable: !!(value['7'] && value['7'] === 'Vrai')
                        })
                    );
                }
                return result;
            })
        );
    }

    updateNote(hebergeId: string, note: Note, form: any) {
        const paramsObject = {
            typeNoteEdit: form.type,
            dateNoteEdit: this.formatDate(form.date),
            heureNoteEdit: this.formatTime(form.hour),
            contenuNoteEdit: form.content,
            action: 'editNote',
            noteEditUUID: note.uuid,
            hebergeID: hebergeId
        };

        const params = new HttpParams({ fromObject: paramsObject });
        return this.httpClient.get(environment.apiUrl +'/4DACTION/outilsWebHebergeListeAjax', { params });
    }

    createNote(hebergeId: string, form: any) {
        const paramsObject = {
            typeNoteEdit: form.type,
            dateNoteEdit: this.formatDate(form.date),
            heureNoteEdit: this.formatTime(form.hour),
            contenuNoteEdit: form.content,
            action: 'createNote',
            hebergeID: hebergeId
        };

        const params = new HttpParams({ fromObject: paramsObject });
        return this.httpClient.get(environment.apiUrl +'/4DACTION/outilsWebHebergeListeAjax', { params });
    }

    deleteNote(hebergeId: string | number, note: Note) {
        const paramsObject = {
            noteEditUUID: note.uuid,
            typeNoteEdit: note.type,
            action: 'dropNote',
            hebergeID: hebergeId
        };

        const params = new HttpParams({ fromObject: paramsObject });
        return this.httpClient.get(environment.apiUrl +'/4DACTION/outilsWebHebergeListeAjax', { params });
    }

    private formatDate(date: Date): string {
        if (!date) return '';
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    }

    private formatTime(date: Date): string {
        if (!date) return '';
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        return `${hours}:${minutes}`;
    }
}
