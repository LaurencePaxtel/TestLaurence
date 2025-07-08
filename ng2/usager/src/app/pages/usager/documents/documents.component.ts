import { Component } from '@angular/core';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ConfirmationService, FilterService } from 'primeng/api';
import { ActivatedRoute } from '@angular/router';
import { CommonModule } from '@angular/common';
import { Card } from 'primeng/card';
import { TableModule } from 'primeng/table';
import { catchError, forkJoin, of, switchMap, tap } from 'rxjs';
import { DocumentGateway } from '../../../gateway/document.gateway';
import { CleanDocument, DocumentTypeValue } from '../../../model/document.model';
import { ButtonModule } from 'primeng/button';
import { TooltipModule } from 'primeng/tooltip';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { ToastModule } from 'primeng/toast';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { WriteDocumentComponent } from './write-document/write-document.component';
import { UsagerDetails } from '../../../model/usager.model';
import { UsagerGateway } from '../../../gateway/usager.gateway';
import { filter } from 'rxjs/operators';
import { BreadcrumbComponent } from '../breadcrumb/breadcrumb.component';
import { Divider } from 'primeng/divider';
import { BreadcrumbService } from '../breadcrumb/breadcrumb.service';
import {ToastService} from "../../../service/toast.service";
import {UserConnected} from "../../../model/user-connected.model";
import {UserService} from "../../../service/user.service";

@Component({
    selector: 'app-documents',
    imports: [CommonModule, FormsModule, ReactiveFormsModule, Card, TableModule, ButtonModule, TooltipModule, ConfirmDialogModule, ToastModule, BreadcrumbComponent, Divider],
    providers: [DocumentGateway, ConfirmationService, FilterService],
    templateUrl: './documents.component.html',
    styleUrl: './documents.component.scss'
})
export class DocumentsComponent {
    ref: DynamicDialogRef | undefined;
    usager!: UsagerDetails;
    documents: CleanDocument[] = [];
    documentTypes: DocumentTypeValue[] = [];
    user?: UserConnected | null

    constructor(
        private documentGateway: DocumentGateway,
        private usagerGateway: UsagerGateway,
        private route: ActivatedRoute,
        public dialogService: DialogService,
        private confirmationService: ConfirmationService,
        private toastService: ToastService,
        private breadcrumbService: BreadcrumbService,
        private readonly userService: UserService
    ) {
        this.user = this.userService.currentUser;
        const usagerId = this.route.snapshot.paramMap.get('usagerId');
        if (usagerId == null) {
            throw new Error('usagerId ID is missing');
        }
        this.usagerGateway
            .loadUsager(usagerId)
            .pipe(
                filter((usager) => usager !== undefined),
                tap((usager) => {
                    this.usager = usager;
                }),
                switchMap((usager) => {
                    return forkJoin({
                        documents: this.documentGateway.loadDocuments(usager.hb_referenceid, 0, 20),
                        documentTypes: this.documentGateway.getDocumentTypes(usager.ref_structure)
                    });
                }),
                tap(({ documents, documentTypes }) => {
                    this.documents = documents;
                    this.documentTypes = documentTypes;
                    this.breadcrumbService.setBreadcrumb([
                        {
                            label: 'Usagers',
                            route: '/home'
                        },
                        { label: this.usager.hb_cle },
                        {
                            label: 'Documents',
                            icon: 'pi pi-file',
                            route: '../documents'
                        }
                    ]);
                })
            )
            .subscribe();
    }

    loadDocuments() {
        this.documentGateway
            .loadDocuments(this.usager.hb_referenceid, 0, 20)
            .pipe(
                tap((documents: CleanDocument[]) => {
                    this.documents = documents;
                })
            )
            .subscribe();
    }

    onNewDocument() {

        console.log('USAGER DOCUMENT', this.usager)
        this.ref = this.dialogService.open(WriteDocumentComponent, {
            focusOnShow: false,
            header: 'Nouveau document',
            modal: true,
            width: '60vw',
            data: {
                usagerId: this.usager.hb_referenceid,
                documentTypes: this.documentTypes
            }
        });

        this.ref.onClose.subscribe((result: any) => {
            this.handleMessageOnCloseDynamicDialog(result);
            this.loadDocuments();
        });
    }

    editDocument(document: any) {
        console.log('this.usager.hb_referenceid', this.usager.hb_referenceid);
        this.documentGateway
            .getDocumentData(document.id)
            .pipe(
                tap((document) => {
                    this.ref = this.dialogService.open(WriteDocumentComponent, {
                        focusOnShow: false,
                        header: 'Editer un document',
                        modal: true,
                        width: '60vw',
                        data: {
                            usagerId: this.usager.hb_referenceid,
                            documentTypes: this.documentTypes,
                            document: document
                        }
                    });
                    this.ref.onClose.subscribe((result: any) => {
                        this.handleMessageOnCloseDynamicDialog(result);
                        this.loadDocuments();
                    });
                })
            )
            .subscribe();
    }

    private handleMessageOnCloseDynamicDialog(result: any) {
        if (result) {
            if (result.success) {
               this.toastService.success(result.message,)
            } else {
                this.toastService.warn(result.message,)
            }
        }
        this.ref = undefined;
    }

    download(document: CleanDocument) {
        this.documentGateway.handleFileDownload(document.id);
    }

    onConfirmDeleteDocument(document: any, event: MouseEvent) {
        const message = `Souhaitez-vous vraiment supprimer ce document ?`;

        this.confirmationService.confirm({
            target: event.target as EventTarget,
            message: message,
            header: 'Supprimer une note',
            closable: true,
            closeOnEscape: true,
            icon: 'pi pi-exclamation-triangle',
            rejectButtonProps: {
                label: 'NON',
                severity: 'secondary',
                outlined: true
            },
            acceptButtonProps: {
                label: 'OUI'
            },
            accept: () => {
                this.deleteDocument(document);
            },
            reject: () => {}
        });
    }

    deleteDocument(document: CleanDocument) {
        this.documentGateway
            .deleteDocument(document.id, this.usager.hb_referenceid)
            .pipe(
                tap((response) => {
                   this.toastService.success('Le document a été supprimé avec succès');
                    this.loadDocuments();
                }),
                catchError((error) => {
                    console.error('Erreur lors de la suppression:', error);
                  this.toastService.warn('Une erreur est survenue lors de la suppression du document')
                    return of(null);
                })
            )
            .subscribe();
    }
}
