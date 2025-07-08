import { Component, OnInit } from '@angular/core';
import { Usager, UsagerDetails } from '../../model/usager.model';
import { UsagerGateway } from '../../gateway/usager.gateway';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { InputTextModule } from 'primeng/inputtext';
import { ButtonModule } from 'primeng/button';
import { CardModule } from 'primeng/card';
import { FloatLabelModule } from 'primeng/floatlabel';
import { DatePickerModule } from 'primeng/datepicker';
import { atLeastOneFieldFilledValidator } from '../../utils/form.utils';
import { DividerModule } from 'primeng/divider';
import { tap } from 'rxjs';
import { TableModule } from 'primeng/table';
import { Fiche } from '../../model/fiche.model';
import { TooltipModule } from 'primeng/tooltip';
import { findDateRange } from '../../utils/date.utils';
import { ConfirmationService, MenuItem } from 'primeng/api';
import { ToastModule } from 'primeng/toast';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { CoordonneeComponent } from './coordonnee/coordonnee.component';
import { FluidModule } from 'primeng/fluid';
import { SearchUsagerCommand } from '../../gateway/comand/search-usager.command';
import { NoteSpComponent } from './note-sp/note-sp.component';
import { Centre } from '../../model/centre.model';
import { MultiPointageComponent } from './multi-pointage/multi-pointage.component';
import { Groupe } from '../../model/groupe.model';
import { RouterModule } from '@angular/router';
import { PrintDocumentType } from '../../model/document-type.model';
import { PrintDocumentComponent } from './print-document/print-document.component';
import { DocumentGateway } from '../../gateway/document.gateway';
import { BreadcrumbService } from './breadcrumb/breadcrumb.service';
import { WriteComponent } from './write/write.component';
import { ConfirmDialogModule } from 'primeng/confirmdialog';
import { MessageModule } from 'primeng/message';
import { BreadcrumbComponent } from './breadcrumb/breadcrumb.component';
import { Select } from 'primeng/select';
import { UserConnected } from '../../model/user-connected.model';
import {ToastService} from "../../service/toast.service";
import {UserService} from "../../service/user.service";

@Component({
    selector: 'app-usager',
    imports: [
        CommonModule,
        ReactiveFormsModule,
        RouterModule,
        FluidModule,
        InputTextModule,
        DatePickerModule,
        ButtonModule,
        CardModule,
        FloatLabelModule,
        DividerModule,
        TableModule,
        TooltipModule,
        ToastModule,
        ConfirmDialogModule,
        MessageModule,
        BreadcrumbComponent,
        Select
    ],
    providers: [UsagerGateway, DocumentGateway, ConfirmationService],
    templateUrl: './usager.component.html',
    styleUrl: './usager.component.scss'
})
export class UsagerComponent implements OnInit {
    items: MenuItem[] | undefined;
    ref: DynamicDialogRef | undefined;

    searchForm!: FormGroup;
    searchButtonLoader = false;
    ficheTableLoading = false;
    contactDetailsLoading = false;
    notesSpLoading = false;
    printLoading = false;

    usagerList: Usager[] = [];
    selectedUsager: Usager | null = null;
    ficheList: Fiche[] = [];
    selectedFiches: Fiche[] = [];
    centres: Centre[] = [];
    groupes: Groupe[] = [];
    sexeTypes: any[] = ['Féminin', 'Masculin', 'Non genré', 'Autre'];
    identityStatusTypes: any[] = ['Identité provisoire', 'Identité vérifiée', 'Identité qualifiée'];
    pieceVerifieesTypes: any[] = ['CNI', 'Passeport', 'Aucune', 'Identité douteuse'];
    user?: UserConnected | null

    constructor(
        private fb: FormBuilder,
        private usagerGateway: UsagerGateway,
        private documentGateway: DocumentGateway,
        private confirmationService: ConfirmationService,
        private toastService: ToastService,
        public dialogService: DialogService,
        private readonly breadcrumbService: BreadcrumbService,
        private readonly userService: UserService
    ) {
        this.user = this.userService.currentUser;
        this.breadcrumbService.setBreadcrumb([
            { route: '/home', icon: 'pi pi-home' },
            { label: 'Liste des usagers', route: '/home' }
        ]);

        this.initForm();
        this.usagerGateway
            .getCentres()
            .pipe(
                tap((centres) => {
                    this.centres = centres;
                })
            )
            .subscribe();
        this.usagerGateway
            .getGroupes()
            .pipe(
                tap((groupes) => {
                    this.groupes = groupes;
                })
            )
            .subscribe();
    }

    initForm() {
        this.searchForm = this.fb.group(
            {
                nom: [''],
                prenom: [''],
                dateNaissance: [''],
                lienFamille: [''],
                telephone: [''],
                filtre: ['']
            },
            {
                validators: atLeastOneFieldFilledValidator()
            }
        );
    }

    ngOnInit() {}

    searchUsagers() {
        if (this.searchForm.invalid) {
            return;
        }

        this.selectedFiches = [];
        this.selectedUsager = null;
        this.usagerList = [];
        this.enableSearchButtonLoader();
        const searchCommand = SearchUsagerCommand.from({
            nom: this.searchForm.getRawValue().nom,
            prenom: this.searchForm.getRawValue().prenom,
            dateNaissance: this.searchForm.getRawValue().dateNaissance,
            lienFamille: this.searchForm.getRawValue().lienFamille,
            telephone: this.searchForm.getRawValue().telephone,
            filtre: 'jour_nuit'
        });
        this.usagerGateway
            .searchUsagers(searchCommand)
            .pipe(
                tap((usagers: Usager[]) => {
                    console.log('usagers', usagers);
                    this.disableSearchButtonLoader();
                    if (usagers.length > 0) {
                        this.selectedUsager = usagers[0];
                        this.showUsagerFiches(this.selectedUsager);
                    }

                    this.usagerList = usagers;
                })
            )
            .subscribe();
    }

    loadUsagerFiches(hbReferenceId: number) {
        this.ficheTableLoading = true;
        this.selectedFiches = [];
        this.usagerGateway
            .loadUsagerFiches(hbReferenceId)
            .pipe(
                tap((fiches: Fiche[]) => {
                    this.ficheList = fiches;
                    this.ficheTableLoading = false;
                })
            )
            .subscribe();
    }

    onConfirmDeleteSelectedFiches(event: Event) {
        const dates = this.selectedFiches.filter((fiche) => fiche.date instanceof Date && !isNaN(fiche.date.getTime())).map((fiche) => fiche.date as Date);
        const rangeDate = findDateRange(dates);
        const message = `Êtes-vous sûr de vouloir supprimer ${this.selectedFiches.length} fiche(s) de ${this.selectedUsager?.hb_cle} sur cette plage de dates : Du ${rangeDate.oldest} au ${rangeDate.newest} ?`;

        this.confirmationService.confirm({
            target: event.target as EventTarget,
            message: message,
            header: 'Pointage',
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
                this.deleteSelectedFiches();
            },
            reject: () => {}
        });
    }

    deleteSelectedFiches() {
        if (this.selectedUsager === null || this.selectedFiches.length === 0) {
            throw Error('Unexpected null selected Usager or selected Fiches');
        }
        const ficheIds = this.selectedFiches.map((fiche) => fiche.id?.toString());
        this.usagerGateway
            .deleteUsagerFiches(this.selectedUsager.hb_referenceid, ficheIds)
            .pipe(
                tap(() => {
                    this.toastService.success('Suppression effectuée avec succès !');
                    if (this.selectedUsager) {
                        this.loadUsagerFiches(this.selectedUsager.hb_referenceid);
                    }
                })
            )
            .subscribe();
    }

    showUsagerFiches(usager: Usager) {
        this.selectedUsager = usager;
        this.loadUsagerFiches(usager.hb_referenceid);
    }

    enableSearchButtonLoader() {
        this.searchButtonLoader = true;
    }

    disableSearchButtonLoader() {
        this.searchButtonLoader = false;
    }

    openCreateUsagerModal() {
        this.ref = this.dialogService.open(WriteComponent, {
            focusOnShow: false,
            header: 'Créer un usager',
            modal: true,
            width: '60vw'
        });

        this.ref.onClose.subscribe((result: any) => {
            this.handleMessageOnCloseDynamicDialog(result);
            this.searchForm.reset();
            this.searchForm.patchValue({
                nom: result?.data?.name,
                prenom: result?.data?.firstname,
                dateNaissance: result?.data?.birthDate,
            })
            this.searchUsagers();
        });
    }

    loadHebergeAndShowCoordonnesModal() {
        if (!this.selectedUsager) {
            console.log('ERROR: unexpected selected usager undefined');
        }
        this.contactDetailsLoading = true;
        this.usagerGateway
            .loadUsager(this.selectedUsager?.hb_referenceid)
            .pipe(
                tap((heberge) => {
                    this.contactDetailsLoading = false;
                    this.openCoordonnesModal(heberge);
                })
            )
            .subscribe();
    }

    openCoordonnesModal(heberge: UsagerDetails | undefined) {
        this.ref = this.dialogService.open(CoordonneeComponent, {
            focusOnShow: false,
            header: 'Gestion des coordonnées',
            modal: true,
            width: '60vw',
            data: heberge
        });

        this.ref.onClose.subscribe((result: any) => {
            this.handleMessageOnCloseDynamicDialog(result);
        });
    }

    loadHebergeAndShowSpModal() {
        if (!this.selectedUsager) {
            console.log('ERROR: unexpected selected usager undefined');
            return;
        }
        this.notesSpLoading = true;
        this.usagerGateway
            .loadUsager(this.selectedUsager.hb_referenceid)
            .pipe(
                tap((heberge) => {
                    this.notesSpLoading = false;
                    this.openSpModal(heberge);
                })
            )
            .subscribe();
    }

    openSpModal(heberge: UsagerDetails | undefined) {
        this.ref = this.dialogService.open(NoteSpComponent, {
            focusOnShow: false,
            header: 'Note SP',
            modal: true,
            width: '60vw',
            data: heberge
        });

        this.ref.onClose.subscribe((result: any) => {
            this.handleMessageOnCloseDynamicDialog(result);
        });
    }

    private handleMessageOnCloseDynamicDialog(result: any) {
        if (result) {
            if (result.success) {
                this.toastService.success(result.message);
            } else {
                this.toastService.warn(result.message);
            }
        }
        this.ref = undefined;
    }

    openMultiPointageModal() {
        const usager = this.selectedUsager;
        if (!usager) {
            return
        }
        this.ref = this.dialogService.open(MultiPointageComponent, {
            focusOnShow: false,
            header: "Création des fiches pour l'usager " + usager?.hb_cle,
            modal: true,
            width: '60vw',
            height: '100vh',
            data: {
                usager: usager,
                centres: this.centres,
                groupes: this.groupes
            }
        });

        this.ref.onClose.subscribe((result: any) => {
            this.handleMessageOnCloseDynamicDialog(result);
            this.loadUsagerFiches(usager.hb_referenceid);
        });
    }

    navigateToNotes() {
        const heberge = this.selectedUsager;
        if (!heberge) {
            return
        }
        window.open(`/usager/page/${heberge.hb_referenceid}/notes`, '_blank');
    }

    navigateToDocuments() {
        const heberge = this.selectedUsager;
        if (!heberge) {
            return
        }
        window.open(`/usager/page/${heberge.hb_referenceid}/documents`, '_blank');
    }

    loadDocumentTypeAndPrintAction() {
        if (!this.selectedUsager) {
            console.log('ERROR: unexpected number of selected usagers');
            return;
        }
        this.printLoading = true;
        this.documentGateway
            .getPrintDocumentTypes(this.selectedUsager?.hb_referenceid)
            .pipe(
                tap((documentTypes) => {
                    this.printLoading = false;
                    this.openPrintModal(this.selectedUsager, documentTypes);
                })
            )
            .subscribe();
    }

    openPrintModal(usager: Usager | null, printDocumentTypes: PrintDocumentType[]) {
        this.ref = this.dialogService.open(PrintDocumentComponent, {
            focusOnShow: false,
            header: 'Imprimer un document pour ' + usager?.hb_cle,
            modal: true,
            width: '60vw',
            data: {
                usager: usager,
                printDocumentTypes: printDocumentTypes
            }
        });

        this.ref.onClose.subscribe((result: any) => {
            this.handleMessageOnCloseDynamicDialog(result);
        });
    }

    redirectOnFiche(fiche: Fiche) {
        const fullUrl = `/INT?action=usager-fiche&id=${fiche.id}&hb_id=${fiche.hg_hb_id}`;
        window.open(fullUrl, '_blank');
    }

    redirectOnNewHebergement() {
        const fullUrl = `/INT?action=usager-fiche&id=-1&hb_id=${this.selectedUsager?.hb_referenceid}&type=hebergement`;
        window.open(fullUrl, '_blank');
    }

    redirectOnNewPrestation() {
        const fullUrl = `/INT?action=usager-fiche&id=-1&hb_id=${this.selectedUsager?.hb_referenceid}&type=prestation`;
        window.open(fullUrl, '_blank');
    }

    redirectOnSituationBudgetaire() {
        const fullUrl = `/INT?action=situation-budgetaire&hebergeId=${this.selectedUsager?.hb_referenceid}`;
        window.open(fullUrl, '_blank');
    }

    onUsagerSelect(event: any) {
        this.selectedUsager = event.data;
    }
}
