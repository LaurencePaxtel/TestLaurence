import {Component, ElementRef, OnDestroy, ViewChild} from "@angular/core";
import {CommonModule, NgIf} from "@angular/common";
import {FormArray, FormControl, FormGroup, FormsModule, ReactiveFormsModule} from "@angular/forms";
import {CardModule} from "primeng/card";
import {Table, TableModule} from "primeng/table";
import {Button, ButtonDirective, ButtonModule} from "primeng/button";
import {TooltipModule} from "primeng/tooltip";
import {ConfirmDialogModule} from "primeng/confirmdialog";
import {ToastModule} from "primeng/toast";
import {DividerModule} from "primeng/divider";
import {ConfirmationService, PrimeTemplate} from "primeng/api";
import {DropdownModule} from "primeng/dropdown";
import {InputNumberModule} from "primeng/inputnumber";
import {InputTextModule} from "primeng/inputtext";
import {ListboxChangeEvent, ListboxModule} from "primeng/listbox";
import {MessageModule} from "primeng/message";
import {MultiSelectModule} from "primeng/multiselect";
import {ProgressSpinnerModule} from "primeng/progressspinner";
import {RippleModule} from "primeng/ripple";
import {ActivatedRoute} from "@angular/router";
import {SearchFormService} from "./search-form.service";
import {ToastService} from "../../../service/toast.service";
import {ChartTypeOption, DropdownYesNoOption, NumberType, ResultType, StatistiqueSandbox} from "./statistique.sandbox";
import {ExcelService} from "./excel.service";
import {StatisticData, StatisticResult} from "./statistic-data";
import {catchError, combineLatest, EMPTY, of, tap} from "rxjs";
import {EnumerationItem, TableColumn} from "./enumeration-item";
import {CentreHebergementPrestation} from "./centre";
import {SearchItem} from "./search-item";
import {absent, present} from "../../../utils/lang.utils";
import {UsagerGateway} from "../../../gateway/usager.gateway";
import {UsagerDetails} from "../../../model/usager.model";
import {CoordonneeComponent} from "../coordonnee/coordonnee.component";
import {DialogService, DynamicDialogRef} from "primeng/dynamicdialog";
import {UserConnected} from "../../../model/user-connected.model";
import {DocumentGateway} from "../../../gateway/document.gateway";
import {UserService} from "../../../service/user.service";
import {PrintDocumentType} from "../../../model/document-type.model";
import {PrintDocumentComponent} from "../print-document/print-document.component";
import {DatePickerModule} from "primeng/datepicker";
import {CheckboxModule} from "primeng/checkbox";
import {FluidModule} from "primeng/fluid";
import {DialogModule} from "primeng/dialog";
import {PaginatorModule} from "primeng/paginator";
import {IconFieldModule} from "primeng/iconfield";
import {InputIconModule} from "primeng/inputicon";

@Component({
    selector: 'app-statistique',
    imports: [CommonModule,
        FormsModule,
        ReactiveFormsModule,
        TableModule,
        ButtonModule,
        TooltipModule,
        ConfirmDialogModule,
        ToastModule,
        ButtonDirective,
        DatePickerModule,
        CheckboxModule,
        FluidModule,
        CardModule,
        DividerModule,
        DropdownModule,
        InputNumberModule,
        InputTextModule,
        ListboxModule,
        MessageModule,
        MultiSelectModule,
        PrimeTemplate,
        ProgressSpinnerModule,
        RippleModule,
        ConfirmDialogModule,
        DialogModule,
        PaginatorModule, IconFieldModule, InputIconModule],
    providers: [
        {
            provide: SearchFormService,
            useFactory: () => SearchFormService.newInstance()
        },
        ConfirmationService
    ],
    templateUrl: './statistique.component.html',
    styleUrl: './statistique.component.scss'
})
export class StatistiqueComponent implements OnDestroy {
    @ViewChild('dt') table!: Table;
    user?: UserConnected | null
    ref: DynamicDialogRef | undefined;

    get filteredDataCount(): number {
        if (this.table && this.table.filteredValue) {
            return this.table.filteredValue.length;
        }
        return this.data?.length || 0;
    }

    get criteriaControls() {
        return (this.searchForm.get('autreCriteres') as FormArray).controls;
    }

    loader = false;
    loaderComputeResult = false
    editSearchItemVisible = false
    searchError = false;
    printLoading = false;
    contactDetailsLoading = false;

    selectedSearchItem: SearchItem | undefined;

    searchText: string = '';


    searchForm: FormGroup;
    modifySearchItemForm: FormGroup | undefined;

    yesNoOptions: DropdownYesNoOption[];
    ficheOptions: DropdownYesNoOption[];
    typeResultats: ResultType[];
    typeChiffres: NumberType[];
    typeChart: ChartTypeOption[];

    result: StatisticResult;

    otherCriteriaOptions?: EnumerationItem[];
    otherCriteriaMapOptionsByLabel: Map<String, EnumerationItem> = new Map();
    otherCriteriaMapOptionsByField: Map<String, EnumerationItem> = new Map();

    columnOptions?: TableColumn[];
    columnLabels?: Map<string, string | undefined> = new Map();
    tableColumns: string[] = [];

    centreHebergementOptions: CentreHebergementPrestation[] = [];
    prestationOptions: CentreHebergementPrestation[] = [];

    searchList: SearchItem[] = [];
    filteredSearchList: SearchItem[] = [];

    selectedUsagers: StatisticData[] = [];
    data: StatisticData[] = [];

    chefFamilleOptions = [
        {label: 'Oui', value: true},
        {label: 'Non', value: false}
    ];

    private topScrollHandler?: () => void;
    private tableScrollHandler?: () => void;
    private resizeObserver?: ResizeObserver;


    constructor(
        private route: ActivatedRoute,
        private searchFormService: SearchFormService,
        private toastService: ToastService,
        private sandbox: StatistiqueSandbox,
        private confirmationService: ConfirmationService,
        private excelService: ExcelService,
        private el: ElementRef,
        private usagerGateway: UsagerGateway,
        public dialogService: DialogService,
        private documentGateway: DocumentGateway,
        private userService: UserService,
        ) {
        this.user = this.userService.currentUser;
        this.yesNoOptions = this.sandbox.getYesNoOptions();
        this.ficheOptions = this.sandbox.getFicheOptions();
        this.typeResultats = this.sandbox.getTypeResultats()
        this.typeChiffres = this.sandbox.getTypeChiffres();
        this.typeChart = this.sandbox.getTypeCharts()
        this.searchForm = this.searchFormService.form;
        this.patchTodayDate();
        this.patchFiche(false)
        this.result = StatisticResult.empty();
        this.loader = true;
        combineLatest([
                this.sandbox.getEnumerations(),
                this.sandbox.getCentreHebergementPrestations(),
                //todo restore
                this.sandbox.getSearchList(),
                //of([])
            ]
        )
            .pipe(
                tap(([enumerations, centres, searchList]: [EnumerationItem[], CentreHebergementPrestation[], SearchItem[]]) => {
                        const enumerationsWithItems = enumerations.filter(item => item.item?.length > 0);
                        this.otherCriteriaMapOptionsByLabel = new Map(enumerationsWithItems.map(enumeration => [enumeration.libelle, enumeration]));
                        this.otherCriteriaMapOptionsByField = new Map(enumerationsWithItems.map(enumeration => [enumeration.champNom, enumeration]));
                        this.otherCriteriaOptions = enumerationsWithItems;
                        this.columnOptions = this.sandbox.computeColumnOptions();
                        this.columnLabels = this.sandbox.computeColumnsLabels(this.columnOptions);
                        this.searchFormService.updateColumnTables(this.columnOptions);
                        this.centreHebergementOptions = centres
                            .filter(d => !d.prestation)
                            .sort((a, b) => a.value.localeCompare(b.value));
                        this.prestationOptions = centres
                            .filter(d => d.prestation)
                            .sort((a, b) => a.value.localeCompare(b.value));
                        this.searchList = [...searchList].sort((a, b) => a.ID - b.ID);
                        this.filteredSearchList = this.searchList;
                        this.loader = false;
                        this.search();
                    }
                ),
            ).subscribe();
    }

    filterDistinctAndSortOptimized(data: StatisticData[]): StatisticData[] {
        const uniqueMap = new Map<number, StatisticData>();

        data.forEach(item => {
            if (!uniqueMap.has(item.hghbId)) {
                uniqueMap.set(item.hghbId, item);
            }
        });

        return Array.from(uniqueMap.values()).sort((a, b) => {
            const nomComparison = a.nom.localeCompare(b.nom, 'fr', {sensitivity: 'base'});
            if (nomComparison === 0) {
                return a.prenom.localeCompare(b.prenom, 'fr', {sensitivity: 'base'});
            }
            return nomComparison;
        });
    }

    search() {
        this.loaderComputeResult = true;
        this.loader = true;
        this.searchError = false;
        this.resetStatisticResult();
        this.sandbox.search(this.searchForm, this.otherCriteriaMapOptionsByField)
            .pipe(
                tap((result: StatisticResult) => {
                    this.data = this.filterDistinctAndSortOptimized(result.colonne);
                    this.result = result;
                    setTimeout(() => {
                        this.setupTableScrollSync();
                    }, 100);
                }),
                catchError((error) => {
                    this.searchError = true;
                    this.loaderComputeResult = false;
                    this.loader = false;
                    return EMPTY;
                })
            )
            .subscribe({
                next: (res) => {
                    this.loaderComputeResult = false;
                    this.loader = false;
                },
            });
    }

    private setupTableScrollSync() {
        const tableWrapper = this.el.nativeElement.querySelector('.p-datatable-table-container');
        const topScrollContainer = this.el.nativeElement.querySelector('.top-scrollbar-container');

        if (!tableWrapper || !topScrollContainer) {
            setTimeout(() => this.setupTableScrollSync(), 200);
            return;
        }

        const tableWidth = tableWrapper.scrollWidth;
        const topScrollContent = topScrollContainer.querySelector('.top-scrollbar-content');

        if (topScrollContent) {
            topScrollContent.style.width = `${tableWidth}px`;
        }

        this.cleanupScrollListeners();

        this.topScrollHandler = () => {
            tableWrapper.scrollLeft = topScrollContainer.scrollLeft;
        };

        this.tableScrollHandler = () => {
            topScrollContainer.scrollLeft = tableWrapper.scrollLeft;
        };

        topScrollContainer.addEventListener('scroll', this.topScrollHandler);
        tableWrapper.addEventListener('scroll', this.tableScrollHandler);

        if (window.ResizeObserver) {
            this.resizeObserver = new ResizeObserver(() => {
                const newTableWidth = tableWrapper.scrollWidth;
                if (topScrollContent) {
                    topScrollContent.style.width = `${newTableWidth}px`;
                }
            });
            this.resizeObserver.observe(tableWrapper);
        }
    }

    private cleanupScrollListeners() {
        const topScrollContainer = this.el.nativeElement.querySelector('.top-scrollbar-container');
        const tableWrapper = this.el.nativeElement.querySelector('.p-datatable-wrapper, .p-datatable-scrollable-wrapper, [data-pc-section="wrapper"]');

        if (this.topScrollHandler && topScrollContainer) {
            topScrollContainer.removeEventListener('scroll', this.topScrollHandler);
        }

        if (this.tableScrollHandler && tableWrapper) {
            tableWrapper.removeEventListener('scroll', this.tableScrollHandler);
        }

        if (this.resizeObserver) {
            this.resizeObserver.disconnect();
        }
    }

    redirectOnSituationBudgetaire() {
        const fullUrl = `/INT?action=situation-budgetaire&hebergeId=${this.selectedUsagers[0].hghbId}`;
        window.open(fullUrl, '_blank');
    }

    ngOnDestroy() {
        this.cleanupScrollListeners();
    }

    filterItems() {
        if (!this.searchText.trim()) {
            this.filteredSearchList = [...this.searchList];
        } else {
            const searchLower = this.searchText.toLowerCase();
            this.filteredSearchList = this.searchList.filter(item =>
                item.affichageNom.toLowerCase().includes(searchLower)
            );
        }
    }

    onItemSelect($event: ListboxChangeEvent) {
        if (present(this.selectedSearchItem)) {
            this.resetStatisticResult()
            this.loader = true;
            this.sandbox.getSearchItemById(this.selectedSearchItem.ID)
                .pipe(
                    tap((searchItem: SearchItem) => {
                        this.searchFormService.updateFromSearchItemFilters(searchItem);
                        this.loader = false;
                    })
                ).subscribe()
        }
    }

    resetStatisticResult() {
        this.result = StatisticResult.empty();
    }

    onListboxRowClick(data: SearchItem, event: Event) {
        event.preventDefault();
    }

    editItem(event: Event, item: SearchItem) {
        event.preventDefault();
        event.stopPropagation();
        this.startModifyingSearchItem(item);
    }

    startModifyingSearchItem(item: SearchItem) {
        this.editSearchItemVisible = true;
        this.modifySearchItemForm = new FormGroup({
            affichageNom: new FormControl(item.affichageNom),
            ID: new FormControl(item.ID),
        });
    }

    resetModifySearchItemForm() {
        this.modifySearchItemForm = new FormGroup({
            affichageNom: new FormControl(null),
            ID: new FormControl(null),
        });
    }

    confirmDelete(event: Event, item: SearchItem) {
        event.preventDefault();
        event.stopPropagation();
        this.confirmationService.confirm({
            header: 'Etes vous sur(e)?',
            message: 'Confirmez la suppression de la recherche (' + item.affichageNom + ')',
            rejectButtonProps: {
                label: 'Non',
                severity: 'secondary',
                outlined: true,
            },
            acceptButtonProps: {
                label: 'Oui',
            },
            accept: () => {
                this.deleteSearchItem(item);
            },
            reject: () => {
            }
        });
    }

    updateSearchItemName() {
        this.loader = true;
        try {
            this.sandbox.updateSearchItemName(this.modifySearchItemForm?.get('ID')?.value, this.modifySearchItemForm?.get('affichageNom')?.value)
                .pipe(
                    tap({
                            next: (result: any) => {
                                this.editSearchItemVisible = false;
                                this.toastService.success('Votre modèle de recherche a été renommé avec succès')
                                this.loader = false;
                                this.computeSearchListAfterEdit(result?.data?.ID, this.modifySearchItemForm?.get('affichageNom')?.value)
                            },
                            error: (error) => {
                               this.toastService.error('Une erreur est survenue lors du renommage de votre modèle de recherche')
                                this.loader = false;
                            },
                        }
                    )
                )
                .subscribe()
        } catch (e) {
           this.toastService.error('Une erreur est survenue lors du renommage de votre modèle de recherche');
            this.loader = false;
        }
    }

    private computeSearchListAfterEdit(id: number, searchName: string) {
        let result = [];
        for (let searchItem of this.filteredSearchList) {
            if (searchItem.ID === id) {
                result.push(SearchItem.fromValues({
                    ID: id,
                    affichageNom: searchName
                }))
            } else {
                result.push(searchItem);
            }
        }
        this.filteredSearchList = result;
    }

    deleteSearchItem(item: SearchItem) {
        try {
            this.sandbox.deleteSearchItem(item)
                .pipe(
                    tap({
                        next: () => {
                            this.sandbox.getSearchList()
                                .pipe(tap(searchList => {
                                    this.searchList = searchList;
                                    this.filterItems()
                                }))
                                .subscribe()
                            this.toastService.success('Votre modèle de recherche a été supprimé avec succès');

                        },
                        error: (error) => {
                            this.toastService.error('Une erreur est survenue lors de la suppression de votre modèle de recherche');
                        },
                    })
                )
                .subscribe()
        } catch (e) {
            this.toastService.error('Une erreur est survenue lors de la suppression de votre modèle de recherche')
        }
    }

    patchTodayDate() {
        this.searchFormService.form.patchValue({
            dateDu: new Date(),
            dateAu: new Date(),
        })
    }

    patchFiche(value: boolean) {
        this.searchFormService.form.patchValue({
            fiche: value
        })
    }

    removeCriteria(index: number) {
        this.searchFormService.removeCriteria(index)
    }

    addCriteria() {
        this.searchFormService.addCriteria();
    }

    saveSearch() {
        if (absent(this.selectedSearchItem)) {
            this.toastService.error('Vous devez selectionnez une recherche');
            return;
        }
        this.loader = true;
        try {
            const searchQuery = this.sandbox.createRequestObject(this.searchForm, this.otherCriteriaMapOptionsByField)
            this.sandbox.updateSearchItem(this.selectedSearchItem.ID, searchQuery)
                .pipe(
                    tap({
                            next: (result: any) => {
                                this.toastService.success('Votre recherche a été sauvegardée avec succès')
                                this.loader = false;
                            },
                            error: (error) => {
                                this.toastService.error('Une erreur est survenue lors de la sauvegarde de votre recherche')
                                this.loader = false;
                            },
                        }
                    )
                )
                .subscribe()
        } catch (e) {
            this.toastService.error('Une erreur est survenue lors de la sauvegarde de votre recherche')
            this.loader = false;
        }
    }

    createNewSearch() {
        this.loader = true;
        try {
            const searchName = this.sandbox.generateSearchName(this.searchList)
            const searchQuery = this.sandbox.createRequestObject(this.searchForm, this.otherCriteriaMapOptionsByField)
            this.sandbox.createSearchItem(searchName, searchQuery)
                .pipe(
                    tap({
                            next: (result: any) => {
                                this.toastService.success('Votre modèle de recherche a été crée avec succès')
                                this.sandbox.getSearchList()
                                    .pipe(tap(searchList => {
                                        this.searchList = [...searchList].sort((a, b) => a.ID - b.ID);
                                        this.filterItems()
                                    }))
                                    .subscribe()
                                this.loader = false;
                            },
                            error: (error) => {
                                this.toastService.error('Erreur')
                                this.loader = false;
                            },
                        }
                    )
                )
                .subscribe()
        } catch (e) {
            this.toastService.error('Une erreur est survenue lors de la création de votre modèle de recherche')
            this.loader = false;
        }

    }

    resetFilters() {
        this.loader = true;
        setTimeout(() => {
            this.searchFormService.resetForm();
            this.loader = false;
        }, 200);
    }

    print() {
        const sidebar = document.querySelector('.sidebar') as HTMLElement;
        const buttons = document.querySelectorAll('button, .p-button') as NodeListOf<HTMLElement>;
        const dataTable = document.querySelector('.table-container') as HTMLElement;
        const body = document.querySelector('body') as HTMLElement;

        const originalStyles = {
            sidebar: sidebar?.style.display,
            buttons: Array.from(buttons).map(btn => btn.style.display),
            dataTable: dataTable?.style.display,
            bodyOverflow: body?.style.overflow
        };

        if (sidebar) sidebar.style.display = 'none';
        if (dataTable) dataTable.style.display = 'none';
        if (body) body.style.overflow = 'visible';
        buttons.forEach(btn => btn.style.display = 'none');

        window.print();

        setTimeout(() => {
            if (sidebar) sidebar.style.display = originalStyles.sidebar || '';
            if (dataTable) dataTable.style.display = originalStyles.dataTable || '';
            if (body) body.style.overflow = originalStyles.bodyOverflow || '';
            buttons.forEach((btn, i) => {
                btn.style.display = originalStyles.buttons[i] || '';
            });
        }, 100);
    }

    exportDataOnExcel() {
        this.excelService.exportExcel(this.data)
    }

    loadHebergeAndShowCoordonnesModal() {
        if (!this.selectedUsagers.length || this.selectedUsagers.length > 1) {
            console.log('ERROR: unexpected number of selected usagers');
        }
        this.contactDetailsLoading = true;
        this.usagerGateway
            .loadUsager(this.selectedUsagers[0].hghbId)
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

    loadDocumentTypeAndPrintAction() {
        if (!this.selectedUsagers.length || this.selectedUsagers.length > 1) {
            console.log('ERROR: unexpected number of selected usagers');
        }
        this.printLoading = true;
        this.documentGateway
            .getPrintDocumentTypes(this.selectedUsagers[0].hghbId)
            .pipe(
                tap((documentTypes) => {
                    this.printLoading = false;
                    this.openPrintModal(this.selectedUsagers[0], documentTypes);
                })
            )
            .subscribe();
    }

    openPrintModal(usager: StatisticData, printDocumentTypes: PrintDocumentType[]) {
        this.ref = this.dialogService.open(PrintDocumentComponent, {
            focusOnShow: false,
            header: 'Imprimer un document pour ' + usager?.nom + ' ' + usager?.prenom,
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
}
