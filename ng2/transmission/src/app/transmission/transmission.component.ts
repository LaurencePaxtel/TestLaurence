import {ChangeDetectorRef, Component, OnInit, ViewChild} from '@angular/core';
import {Transmission, TransmissionAction, TransmissionFilters, TransmissionResult} from "./model/transmission";
import {TransmissionGateway} from "./service/transmission.gateway";
import {map, tap} from "rxjs";
import {Table} from 'primeng/table'
import {ConfirmationService, MessageService} from "primeng/api";
import {FormBuilder, FormGroup} from "@angular/forms";
import {Usager} from "./model/usager";
import {AutoCompleteCompleteEvent} from "primeng/autocomplete";
import {MentionConfig} from "angular-mentions";
import {TransmissionService} from "./service/transmission.service";
import {User} from "./model/user";
import moment from "moment";

@Component({
    selector: 'transmission',
    templateUrl: './transmission.component.html',
    styleUrl: './transmission.component.scss',
    providers: [ConfirmationService, MessageService]
})
export class TransmissionComponent implements OnInit {

    transmissionResult: TransmissionResult;
    actionType: TransmissionAction = 'create';
    groupes: string[] = []
    groupeFilters: any[] = []
    priorities: any[] | undefined;
    prioritiesFilters: any[] | undefined;


    userConnected = User.new();


    dialogVisible: boolean = false;
    form?: FormGroup;

    usagers: Usager[] = [];
    mentions: string[] = [];
    @ViewChild('transmissionTable') table: Table | undefined;

    saveLoading = false;
    tableLoading = false;
    startLoadingData = false;

    tableState: any;
    mentionConfig: MentionConfig = {
        disableSearch: true,
        dropUp: true
    }

    tranmissionViewDialog = false;
    selectedTransmission?: Transmission;


    constructor(private gateway: TransmissionGateway,
                private service: TransmissionService,
                private confirmationService: ConfirmationService,
                private messageService: MessageService,
                private formBuilder: FormBuilder,
                private cd: ChangeDetectorRef) {
        this.mentionConfig = {
            disableSearch: true,
        }
        this.transmissionResult = {
            data: [],
            totalRecords: 0
        }
    }


    ngOnInit(): void {
        this.gateway.getUserConnected()
            .pipe(
                tap(user => {
                    this.userConnected = user;
                    this.startLoadingData = true;
                    this.gateway.getGroupes(this.userConnected.refStructure)
                        .pipe(
                            tap(groupes => {
                                this.groupes = groupes;
                                this.initGroupeFilters(groupes);
                            })
                        )
                        .subscribe()


                })
            )
            .subscribe()
        this.priorities = this.service.getPriorites();
        this.prioritiesFilters = this.service.getPrioritesFilters();
    }

    private initGroupeFilters(groupes: string[]) {
        let filters = [];
        filters.push({
            label: 'Tous',
            value: null,
        });
        groupes.forEach(groupe => {
            filters.push({
                label: groupe,
                value: groupe
            })
        });
        this.groupeFilters = filters;
    }

    filterTable($event: any) {
        this.table?.filterGlobal($event.target.value, 'contains');
    }


    loadTransmissions(event: any) {
        this.tableLoading = true;
        let currentPage = this.getCurrentTablePage(event);
        let filters: TransmissionFilters = {
            date: event.filters?.date?.value,
            priorite: event.filters?.priorite?.value,
            service: event.filters?.service?.value,
            keyword: event.filters?.global?.value
        };
        this.gateway.getTransmissions(this.userConnected.refStructure, currentPage, event.rows, filters)
            .pipe(tap(transmissions => {
                this.tableState = {
                    currentPage: currentPage,
                    rows: event.rows,
                    filters: filters
                }
                this.transmissionResult = transmissions;
                console.log(this.transmissionResult);
                this.tableLoading = false;
            }))
            .subscribe()
    }

    loadTransmissionsAccordingState() {
        this.tableLoading = true;
        this.gateway.getTransmissions(this.userConnected.refStructure, this.tableState.currentPage, this.tableState.rows, this.tableState.filters)
            .pipe(tap(transmissions => {
                this.transmissionResult = transmissions;
                this.tableLoading = false;
            }))
            .subscribe()
    }

    getCurrentTablePage(event: any): number {
        let page = 1;
        if (event.first) {
            page = (event.first / event.rows) + 1;
        }
        return page;
    }

    onSearchUsagers(event: AutoCompleteCompleteEvent) {
        this.gateway.getAutocompleteUsagerList(event.query)
            .pipe(
                tap((data: Usager[]) => {
                    this.usagers = data;
                })
            )
            .subscribe();

    }

    openNewTransmission() {
        this.createForm('create');
    }

    public createForm(action: TransmissionAction, transmission?: Transmission) {
        let code = this.userConnected.plateFormeServiceCode;
        let groupe = null;
        if (code?.length > 1) {
            groupe = this.groupes.find(groupe => groupe.startsWith(code));
        }

        this.form = this.formBuilder.group({
            id: action === 'create' ? null : transmission?.id,
            date: action === 'create' ? new Date() : transmission?.date,
            intervenant: [action === 'create' ? this.userConnected.login : transmission?.intervenantLogin],
            intervenantId: [action === 'create' ? this.userConnected.id : transmission?.intervenantId],
            groupe: [action === 'create' ? groupe : transmission?.service],
            priorite: [action === 'create' ? 0 : transmission?.priorite],
            usager: [action === 'create' ? null : {
                id: transmission?.usagerId, value: transmission?.usagerCle
            }],
            message: [action === 'create' ? null : transmission?.message]
        });
    }

    onMentionSearch(event: any) {
        this.gateway.getAutocompleteUsagerList(event)
            .pipe(
                map(val => val.map(item => item.value)),
                tap((data: string[]) => {
                    this.mentions = data;
                    this.cd.detectChanges();
                })
            )
            .subscribe();
    }

    openDialog() {
        this.dialogVisible = true;
    }

    removeTransmission(transmission: Transmission) {
        this.confirmationService.confirm({
            header: 'Êtes vous sur(e)?',
            message: 'Veuillez confirmer la suppression de la transmission',
            accept: () => {
                // call remove service + toast
                this.gateway.deleteTransmission(transmission.id)
                    .pipe(
                        tap(res => {
                            this.loadTransmissionsAccordingState()
                            this.messageService.add({
                                severity: 'success',
                                summary: 'Transmission supprimée',
                                detail: 'La transmission a été supprimée avec succès',
                                life: 3000
                            });
                        })
                    )
                    .subscribe()
            },
            reject: () => {
            }
        });
    }


    saveForm() {
        if (this.form?.get('id')?.value) {
            this.editTransmission();
        } else {
            this.createNewTransmission()
        }
    }

    private createNewTransmission() {
        this.gateway.createNewTransmission({
            usagerID: this.form?.get('usager')?.value?.id,
            groupe:this.form?.get('groupe')?.value ? this.form?.get('groupe')?.value : undefined,
            date: moment(this.form?.get('date')?.value).format('DD/MM/YYYY'),
            intervenantID: this.form?.get('intervenantId')?.value,
            message: this.form?.get('message')?.value ? this.form?.get('message')?.value : undefined,
            priorite: this.form?.get('priorite')?.value ? this.form?.get('priorite')?.value : undefined
        })
            .pipe(
                tap((result: any) => {
                    this.dialogVisible = false;
                    this.saveLoading = false;
                    if (!result.success && result.notificationWarning) {
                        this.messageService.add({
                            severity: 'error',
                            summary: 'Erreur',
                            detail: result.notificationWarning,
                            life: 3000
                        });
                    } else {
                        this.loadTransmissionsAccordingState();
                        this.messageService.add({
                            severity: 'success',
                            summary: 'Transmission créee',
                            detail: 'La transmission a été créee avec succès',
                            life: 3000
                        });
                    }
                })
            )
            .subscribe()
    }

    editTransmission() {
        this.gateway.updateTransmission({
            id: this.form?.get('id')?.value,
            usagerID: this.form?.get('usager')?.value?.id,
            groupe: this.form?.get('groupe')?.value,
            date: moment(this.form?.get('date')?.value).format('DD/MM/YYYY'),
            intervenantID: this.form?.get('intervenantId')?.value,
            message: this.form?.get('message')?.value ? this.form?.get('message')?.value : undefined,
            priorite: this.form?.get('priorite')?.value ? this.form?.get('priorite')?.value : undefined
        })
            .pipe(
                tap((result: any) => {
                    this.dialogVisible = false;
                    this.saveLoading = false;
                    if (!result.success && result.notificationWarning) {
                        this.messageService.add({
                            severity: 'error',
                            summary: 'Erreur',
                            detail: result.notificationWarning,
                            life: 3000
                        });
                    } else {
                        this.loadTransmissionsAccordingState();
                        this.messageService.add({
                            severity: 'success',
                            summary: 'Transmission modifiée',
                            detail: 'La transmission a été modifiée avec succès',
                            life: 3000
                        });
                    }
                })
            )
            .subscribe()
    }

    onRowSelect($event: any) {
        this.tranmissionViewDialog = true;
    }

    onRowUnselect($event: any) {
        this.tranmissionViewDialog = false;
    }
}
