import { inject, Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { catchError, Observable, of } from 'rxjs';
import { map } from 'rxjs/operators';
import { PrintDocumentType } from '../model/document-type.model';
import { CleanDocument, DocumentData, DocumentTypeValue, LegacyApiResponse } from '../model/document.model';
import { formatDate, isValidDateFormat } from '../utils/date.utils';
import {environment} from "../../environments/environment";

@Injectable({
    providedIn: 'root'
})
export class DocumentGateway {
    private httpClient = inject(HttpClient);

    constructor() {}

    getPrintDocumentTypes(hebergeID: number): Observable<PrintDocumentType[]> {
        const params = new HttpParams().set('action', 'chargeDocument').set('hebergeID', hebergeID);

        return this.httpClient.get(environment.apiUrl + '/4DACTION/outilsWebHebergeDocumentAjax?', { params }).pipe(
            map((response: any) => {
                if (!response || !response.data) {
                    return [];
                }
                const result: PrintDocumentType[] = [];
                for (const value of response.data) {
                    result.push(
                        PrintDocumentType.from({
                            id: value.value,
                            value: value.lib
                        })
                    );
                }
                return result;
            })
        );
    }

    getDocumentTypes(refStructure: string): Observable<DocumentTypeValue[]> {
        const params = new HttpParams().set('action', 'getEnumeration').set('typeReturn', 'text').set('enumerationLib', 'Type Document Upload').set('refStructure', refStructure);

        return this.httpClient.get(environment.apiUrl +'/4DACTION/outilsWebManageEnumeration?', { params }).pipe(
            map((response: any) => {
                if (!response || !response.data) {
                    return [];
                }
                const result: DocumentTypeValue[] = [];
                for (const value of response.data) {
                    result.push(
                        DocumentTypeValue.from({
                            label: value,
                            value: value
                        })
                    );
                }
                return result;
            })
        );
    }

    getDocumentData(documentId: string | number): Observable<DocumentData | undefined> {
        const params = new HttpParams().set('action', 'basedoc_get_record').set(
            'json',
            JSON.stringify({
                zone: 'gl',
                action: 'action',
                data: {
                    ligne: {
                        id: documentId
                    }
                }
            })
        );

        return this.httpClient.get<DocumentData[]>(environment.apiUrl +'/GL', { params }).pipe(
            map((results: any[]) => {
                if (!results || results.length === 0) {
                    return undefined;
                }
                let result = results[0];
                return DocumentData.from({
                    id: result.id,
                    refStructure: result.ref_structure,
                    type: result.doc_document_type,
                    origineId: result.doc_origine_id,
                    tableNo: result.doc_table_no,
                    name: result.doc_document_nom,
                    date: isValidDateFormat(result.doc_date) ? new Date(result.doc_date) : undefined,
                    title: result.doc_titre,
                    notes: result.doc_notes,
                    document: result.doc_document,
                    extension: result.doc_extension,
                    immeubleId: result.doc_immeuble_id,
                    bienId: result.doc_bien_id,
                    namePrevious: result.doc_name_previous,
                    version: result.doc_version
                });
            })
        );
    }

    uploadDocument(hebergeId: string | number, formData: FormData): Observable<any | undefined> {
        const params = new HttpParams()
            .set('action', 'basedoc_save_document')
            .set('table_name', 'Documents usagers')
            .set('doc_name_previous', '')
            .set('doc_origine_id', hebergeId);

        return this.httpClient.post(environment.apiUrl + `/GL`, formData, { params });
    }

    updateUploadDocument(hebergeId: string | number, previousDocumentName: string, formData: FormData): Observable<any | undefined> {
        const params = new HttpParams()
            .set('action', 'basedoc_save_document')
            .set('table_name', 'Documents usagers')
            .set('doc_name_previous', previousDocumentName)
            .set('doc_origine_id', hebergeId);

        return this.httpClient.post(environment.apiUrl + `/GL`, formData, { params });
    }

    createDocument(hebergeId: string | number, form: any) {
        const params = new HttpParams()
            .set('action', 'basedoc_ligne_valider')
            .set('table_num', 4)
            .set(
                'json',
                JSON.stringify({
                    zone: 'gl',
                    action: 'set_bien_ligne',
                    data: {
                        ligne: {
                            id_piece: hebergeId,
                            doc_titre: form.title,
                            doc_document_type: form.type,
                            doc_date: formatDate(form.date),
                            doc_extension: form.extension,
                            doc_version: form.version,
                            doc_notes: form.notes,
                            doc_document_nom: form.name,
                            doc_immeuble_id: '0',
                            doc_bien_id: '0'
                        }
                    }
                })
            );

        return this.httpClient.get(environment.apiUrl +'/GL', { params }).pipe(
            map((response: any) => {
                if (response.status === 'success') {
                    return {
                        success: true,
                        id: response.id
                    };
                }
                return {
                    success: false,
                    id: undefined
                };
            }),
            catchError(error => {
                return of({
                    success: false,
                    id: undefined
                });
            })
        );
    }

    updateDocument(hebergeId: string | number, documentId: string | number, form: any) {
        const params = new HttpParams()
            .set('action', 'basedoc_ligne_valider')
            .set('table_num', 4)
            .set(
                'json',
                JSON.stringify({
                    zone: 'gl',
                    action: 'set_bien_ligne',
                    data: {
                        ligne: {
                            id_piece: hebergeId,
                            id_ligne: documentId,
                            doc_titre: form.title,
                            doc_document_type: form.type,
                            doc_date: formatDate(form.date),
                            doc_extension: form.extension,
                            doc_version: form.version,
                            doc_notes: form.notes,
                            doc_document_nom: form.name,
                            doc_immeuble_id: '0',
                            doc_bien_id: '0'
                        }
                    }
                })
            );

        return this.httpClient.get(environment.apiUrl +'/GL', { params }).pipe(
            map((response: any) => {
                if (response.status === 'success') {
                    return {
                        success: true,
                        id: response.id
                    };
                }
                return {
                    success: false,
                    id: undefined
                };
            }),
            catchError(error => {
                return of({
                    success: false,
                    id: undefined
                });
            })
        );
    }

    deleteDocument(documentId: string | number, usagerId: string | number): Observable<any> {
        const params = new HttpParams()
            .set('action', 'basedoc_delete_document')
            .set('table_name', 'Documents usagers')
            .set(
                'json',
                JSON.stringify({
                    zone: 'gl',
                    action: 'basedoc_delete_document',
                    data: {
                        ligne: {
                            id_piece: usagerId,
                            id: documentId
                        }
                    }
                })
            );

        return this.httpClient.get(environment.apiUrl +'/GL', { params });
    }

    downloadFile(documentId: string | number) {
        const params = new HttpParams()
            .set('action', 'get_file')
            .set('type', 'Documents usagers')
            .set('id', documentId)

        return this.httpClient.get(environment.apiUrl + '/GB', {
            params,
            responseType: 'blob',
            observe: 'response'
        });
    }

    // Méthode pour gérer le téléchargement/affichage
    handleFileDownload(documentId: string | number, fileName?: string) {
        this.downloadFile(documentId).subscribe({
            next: (response) => {
                if (!response.body) {
                    console.error('Aucun contenu reçu');
                    return;
                }

                const blob = response.body;
                const contentType = response.headers.get('content-type') || '';
                const contentDisposition = response.headers.get('content-disposition') || '';

                let extractedFileName = fileName;
                if (!extractedFileName && contentDisposition) {
                    const matches = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/.exec(contentDisposition);
                    if (matches && matches[1]) {
                        extractedFileName = matches[1].replace(/['"]/g, '');
                    }
                }

                if (this.shouldDisplayInBrowser(contentType)) {
                    this.displayInBrowser(blob, contentType);
                } else {
                    this.downloadToDevice(blob, extractedFileName || 'document');
                }
            },
            error: (error) => {
                console.error('Erreur lors du téléchargement:', error);
            }
        });
    }

    private downloadToDevice(blob: Blob, fileName: string) {
        const url = window.URL.createObjectURL(blob);
        const link = document.createElement('a');

        link.href = url;
        link.download = fileName;
        link.style.display = 'none';

        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);

        window.URL.revokeObjectURL(url);
    }

    private displayInBrowser(blob: Blob, contentType: string) {
        const url = window.URL.createObjectURL(blob);

        if (contentType.includes('pdf')) {
            // Ouvrir le PDF dans un nouvel onglet
            window.open(url, '_blank');
        } else {
            // Pour les images et autres fichiers
            const newWindow = window.open('', '_blank');
            if (newWindow) {
                if (contentType.startsWith('image/')) {
                    newWindow.document.write(`<img src="${url}" style="max-width: 100%; height: auto;">`);
                } else {
                    newWindow.location.href = url;
                }
            }
        }

        setTimeout(() => window.URL.revokeObjectURL(url), 1000);
    }

    private shouldDisplayInBrowser(contentType: string): boolean {
        const viewableTypes = [
            'application/pdf',
            'image/jpeg',
            'image/png',
            'image/gif',
            'image/webp',
            'text/plain',
            'text/html',
            'text/csv'
        ];

        return viewableTypes.some(type => contentType.includes(type));
    }


    loadDocumentTemplatePath(hebergeID: number, documentType: string): Observable<string | undefined> {
        const params = new HttpParams().set('action', 'createNewVersion').set('hebergeID', hebergeID).set('nomDocument', documentType);

        return this.httpClient.get(environment.apiUrl +'/4DACTION/outilsWProSendAjax?', { params }).pipe(
            map((response: any) => {
                if (!response || !response.modelePath) {
                    return undefined;
                }
                return response.modelePath;
            })
        );
    }

    loadDocumentTemplate(urlPath: string): Observable<string | undefined> {
        //todo for local dev replace by
        // return this.httpClient.get(environment.apiUrl + '/' + urlPath, {
        //     responseType: 'text'
        // });
        return this.httpClient.get(this.buildFullUrl(urlPath), {
            responseType: 'text'
        });
    }

    buildFullUrl(path: string): string {
        const baseUrl = window.location.origin;
        const cleanPath = path.startsWith('/') ? path : '/' + path;

        return baseUrl + cleanPath;
    }



    loadDocuments(hebergeId: string | number, pageNumber: number, pageSize: number): Observable<CleanDocument[]> {
        const params = new HttpParams().set('action', 'basedoc_list_ts_json').set('page', pageNumber).set('size', pageSize).set('record_id', hebergeId).set('table_num', 4).set('module', 'Usagers');

        return this.httpClient.get<LegacyApiResponse>(environment.apiUrl +'/GL', { params }).pipe(map((response) => this.cleanApiResponse(response)));
    }

    private cleanApiResponse(response: LegacyApiResponse): CleanDocument[] {
        return response.rows.map((row) => this.extractCleanData(row));
    }


    private extractCleanData(row: any): CleanDocument {
        const cleanDocument: CleanDocument = {
            id: this.extractId(this.findProperty(row, '&nbsp;') || row['&nbsp;'] || ''),
            titre: this.extractTextFromDiv(this.findProperty(row, 'Titre du document') || row['Titre &nbsp;du &nbsp;document'] || ''),
            type: this.extractTextFromDiv(this.findProperty(row, 'Type') || row['Type'] || ''),
            dateCreation: this.extractTextFromDiv(this.findProperty(row, 'Créé Le') || row['Créé &nbsp;Le'] || ''),
            format: this.extractTextFromDiv(this.findProperty(row, 'Format') || row['Format'] || ''),
            selected: false
        };

        return cleanDocument;
    }

    private findProperty(obj: any, searchKey: string): string | undefined {
        if (obj[searchKey]) {
            return obj[searchKey];
        }

        const normalizeKey = (key: string) =>
            key
                .replace(/&nbsp;/g, ' ')
                .replace(/\s+/g, ' ')
                .trim()
                .toLowerCase();
        const normalizedSearch = normalizeKey(searchKey);

        for (const [key, value] of Object.entries(obj)) {
            if (normalizeKey(key) === normalizedSearch) {
                return value as string;
            }
        }

        return undefined;
    }

    private extractId(htmlString: string): string {
        const parser = new DOMParser();
        const doc = parser.parseFromString(htmlString, 'text/html');
        const hiddenInput = doc.querySelector('input[type="hidden"]');

        if (hiddenInput) {
            const value = hiddenInput.getAttribute('value');
            return value || '';
        }
        return '';
    }

    private extractTextFromDiv(htmlString: string): string {
        const parser = new DOMParser();
        const doc = parser.parseFromString(htmlString, 'text/html');
        const div = doc.querySelector('div');

        return div ? div.textContent?.trim() || '' : '';
    }
}
