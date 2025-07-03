import {AfterViewInit, Component, ElementRef, OnInit, ViewChild} from '@angular/core';
import {ConfirmationService, MessageService} from "primeng/api";
import {
  ChartTypeOption,
  DropdownYesNoOption,
  NumberType,
  ResultType,
  StatistiqueSandbox
} from "./service/statistique.sandbox";
import {ActivatedRoute} from "@angular/router";
import {FormArray, FormControl, FormGroup} from "@angular/forms";
import {SearchFormService} from "./service/search-form.service";
import {catchError, combineLatest, EMPTY, tap} from "rxjs";
import {EnumerationItem, TableColumn} from "./model/enumeration-item";
import {StatisticCountResult, StatisticData, StatisticResult} from "./model/statistic-data";
import {ChartService} from "./service/chart.service";
import {Chart} from "./model/chart";
import {CentreHebergementPrestation} from "./model/centre";
import {SearchItem} from "./model/search-item";
import {ListboxChangeEvent} from "primeng/listbox";
import {absent, present} from "./service/lang.utils";
import {ChartType} from "chart.js";
import {ExcelService} from "./service/excel.service";
import {Table} from "primeng/table";
import ChartDataLabels from "chartjs-plugin-datalabels";

//stat component

@Component({
  selector: 'statistique',
  templateUrl: './statistique.component.html',
  styleUrl: './statistique.component.scss',
  providers: [
    {
      provide: SearchFormService,
      useFactory: () => SearchFormService.newInstance(),
    },
    MessageService,
    ConfirmationService
  ]
})
export class StatistiqueComponent implements OnInit, AfterViewInit  {

  protected readonly ChartDataLabels = ChartDataLabels;
  @ViewChild('dt') table!: Table;
  @ViewChild('topScrollbar') topScrollbar!: ElementRef;
  searchForm: FormGroup;
  modifySearchItemForm: FormGroup | undefined;
  selectedSearchItem: SearchItem | undefined;
  searchText: string = '';
  get criteriaControls() {
    return (this.searchForm.get('autreCriteres') as FormArray).controls;
  }

  loader = false;
  loaderComputeResult = false
  editSearchItemVisible = false
  searchError = false;

  yesNoOptions: DropdownYesNoOption[];
  ficheOptions: DropdownYesNoOption[];
  typeResultats: ResultType[];
  typeChiffres: NumberType[];
  typeChart: ChartTypeOption[];
  columnOptions?: TableColumn[];
  columnLabels?: Map<string, string | undefined> = new Map();
  tableColumns: string[] = [];
  centreHebergementOptions: CentreHebergementPrestation[] = [];
  prestationOptions: CentreHebergementPrestation[] = [];

  otherCriteriaOptions?: EnumerationItem[];
  otherCriteriaMapOptionsByLabel: Map<String, EnumerationItem> = new Map();
  otherCriteriaMapOptionsByField: Map<String, EnumerationItem> = new Map();
  chart: Chart | undefined;
  searchList: SearchItem[] = [];
  filteredSearchList: SearchItem[] = [];

  result: StatisticResult;
  counterResult: StatisticCountResult;

  selectedData?: StatisticData;

  ngAfterViewInit() {
    // Récupérer les éléments DOM

  }

  constructor(
    private route: ActivatedRoute,
    private searchFormService: SearchFormService,
    private chartService: ChartService,
    private messageService: MessageService,
    private sandbox: StatistiqueSandbox,
    private confirmationService: ConfirmationService,
    private excelService: ExcelService,
    private el: ElementRef) {
    this.yesNoOptions = this.sandbox.getYesNoOptions();
    this.ficheOptions = this.sandbox.getFicheOptions();
    this.typeResultats = this.sandbox.getTypeResultats()
    this.typeChiffres = this.sandbox.getTypeChiffres();
    this.typeChart = this.sandbox.getTypeCharts()
    this.searchForm = this.searchFormService.form;
    this.result = StatisticResult.empty();
    this.counterResult = StatisticCountResult.empty();
    this.loader = true;
    combineLatest([
        this.sandbox.getEnumerations(),
        this.sandbox.getCentreHebergementPrestations(),
        this.sandbox.getSearchList(),
      ]
    )
      .pipe(
        tap(([enumerations, centres, searchList]: [EnumerationItem[], CentreHebergementPrestation[], SearchItem[]]) => {
            const enumerationsWithoutItem = new Map(enumerations.map(enumeration => [enumeration.champNom, enumeration]));
            const enumerationsWithItems  = enumerations.filter(item => item.item?.length > 0);
            this.otherCriteriaMapOptionsByLabel = new Map(enumerationsWithItems.map(enumeration => [enumeration.libelle, enumeration]));
            this.otherCriteriaMapOptionsByField = new Map(enumerationsWithItems.map(enumeration => [enumeration.champNom, enumeration]));
            this.otherCriteriaOptions = enumerationsWithItems;
            this.columnOptions = this.sandbox.computeColumnOptions(enumerationsWithItems, enumerationsWithoutItem);
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
          }
        ),
      ).subscribe();
  }

  ngOnInit(): void {
  }

  isValidDate(dateStr: string): boolean {
    const regex = /^\d{4}-\d{2}-\d{2}$/;
    if (!regex.test(dateStr)) return false;

    const date = new Date(dateStr);
    return date instanceof Date && !isNaN(date.getTime());
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

  resetFilters() {
    this.loader = true;
    setTimeout(() => {
      this.searchFormService.resetForm();
      this.loader = false;
    }, 200);
  }

  addCriteria() {
    this.searchFormService.addCriteria();
  }

  removeCriteria(index: number) {
    this.searchFormService.removeCriteria(index)
  }

  search() {
    this.loaderComputeResult = true;
    this.loader = true;
    this.searchError = false;
    this.resetStatisticResultAndChart();
    this.sandbox.search(this.searchForm, this.otherCriteriaMapOptionsByField)
      .pipe(
        tap((result: StatisticResult) => {

          this.result = result;
          let typeGraph: ChartType = result.typeGraph === 'Pie' ? 'pie' : 'bar';
          this.chart = this.chartService.computeChart(typeGraph, result.statistique);
          let tableColumns = [];

          for (const column of this.searchForm.get('tableColonnes')?.value) {
            tableColumns.push(column);
          }
          this.tableColumns = tableColumns;
          this.counterResult = this.sandbox.computeCounterResults(result);

          setTimeout(() => {
            const tableScrollBody = this.el.nativeElement.querySelector('.p-datatable-wrapper');
            const topScrollContainer = this.el.nativeElement.querySelector('.top-scrollbar-container');

            if (tableScrollBody && topScrollContainer) {
              // Synchroniser la largeur du contenu de la scrollbar du haut
              const tableWidth = tableScrollBody.scrollWidth;
              const topScrollContent = topScrollContainer.querySelector('.top-scrollbar-content');
              if (topScrollContent) {
                topScrollContent.style.width = tableWidth + 'px';
              }

              // Ajouter les écouteurs d'événements pour synchroniser les scrolls
              topScrollContainer.addEventListener('scroll', () => {
                tableScrollBody.scrollLeft = topScrollContainer.scrollLeft;
              });

              tableScrollBody.addEventListener('scroll', () => {
                topScrollContainer.scrollLeft = tableScrollBody.scrollLeft;
              });
            }
          }, 1500);



        }),
        catchError((error) => {
          console.error('An error occured during searching results', error);
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

  resetStatisticResultAndChart() {
    this.result = StatisticResult.empty();
    this.chart = undefined;
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
                this.messageService.add({
                  severity: 'success',
                  summary: 'Succès',
                  detail: 'Votre modèle de recherche a été crée avec succès'
                });
                this.sandbox.getSearchList()
                  .pipe(tap(searchList => {
                    this.searchList = [...searchList].sort((a, b) => a.ID - b.ID);
                    this.filterItems()
                  }))
                  .subscribe()
                this.loader = false;
              },
              error: (error) => {
                this.messageService.add({
                  severity: 'error',
                  summary: 'Erreur',

                });
                this.loader = false;
              },
            }
          )
        )
        .subscribe()
    } catch (e) {
      this.messageService.add({
        severity: 'error',
        summary: 'Erreur',
        detail: 'Une erreur est survenue lors de la création de votre modèle de recherche'
      });
      this.loader = false;
    }

  }

  saveSearch() {
    if (absent(this.selectedSearchItem)) {
      this.messageService.add({
        severity: 'error',
        summary: 'Erreur',
        detail: 'Vous devez selectionnez une recherche'
      });
      return;
    }
    this.loader = true;
    try {
      const searchQuery = this.sandbox.createRequestObject(this.searchForm, this.otherCriteriaMapOptionsByField)
      this.sandbox.updateSearchItem(this.selectedSearchItem.ID, searchQuery)
        .pipe(
          tap({
              next: (result: any) => {
                this.messageService.add({
                  severity: 'success',
                  summary: 'Succès',
                  detail: 'Votre recherche a été sauvegardée avec succès'
                });
                this.loader = false;
              },
              error: (error) => {
                this.messageService.add({
                  severity: 'error',
                  summary: 'Erreur',
                  detail: 'Une erreur est survenue lors de la sauvegarde de votre recherche'
                });
                this.loader = false;
              },
            }
          )
        )
        .subscribe()
    } catch (e) {
      this.messageService.add({
        severity: 'error',
        summary: 'Erreur',
        detail: 'Une erreur est survenue lors de la sauvegarde de votre recherche'
      });
      this.loader = false;
    }
  }

  onItemSelect($event: ListboxChangeEvent) {
    if (present(this.selectedSearchItem)) {
      this.resetStatisticResultAndChart()
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

  onListboxRowClick(data: SearchItem, event: Event) {
    event.preventDefault();
  }

  editItem(event: Event, item: SearchItem) {
    event.preventDefault();
    event.stopPropagation();
    this.startModifyingSearchItem(item);
  }


  confirmDelete(event: Event, item: SearchItem) {
    event.preventDefault();
    event.stopPropagation();
    this.confirmationService.confirm({
      header: 'Etes vous sur(e)?',
      message: 'Confirmez la suppression de la recherche (' + item.affichageNom + ')',
      accept: () => {
        this.deleteSearchItem(item);
      },
      reject: () => {
      }
    });
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
              this.messageService.add({
                severity: 'success',
                summary: 'Succès',
                detail: 'Votre modèle de recherche a été supprimé avec succès'
              });

            },
            error: (error) => {
              this.messageService.add({
                severity: 'error',
                summary: 'Erreur',
                detail: 'Une erreur est survenue lors de la suppression de votre modèle de recherche'
              });
            },
          })
        )
        .subscribe()
    } catch (e) {
      this.messageService.add({
        severity: 'error',
        summary: 'Erreur',
        detail: 'Une erreur est survenue lors de la suppression de votre modèle de recherche'
      });
    }
  }

  startModifyingSearchItem(item: SearchItem) {
    this.editSearchItemVisible = true;
    this.modifySearchItemForm = new FormGroup({
      affichageNom: new FormControl(item.affichageNom),
      ID: new FormControl(item.ID),
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
                this.messageService.add({
                  severity: 'success',
                  summary: 'Succès',
                  detail: 'Votre modèle de recherche a été renommé avec succès'
                });
                this.loader = false;
                this.computeSearchListAfterEdit(result?.data?.ID, this.modifySearchItemForm?.get('affichageNom')?.value)
              },
              error: (error) => {
                this.messageService.add({
                  severity: 'error',
                  summary: 'Erreur',
                  detail: 'Une erreur est survenue lors du renommage de votre modèle de recherche'
                });
                this.loader = false;
              },
            }
          )
        )
        .subscribe()
    } catch (e) {
      this.messageService.add({
        severity: 'error',
        summary: 'Erreur',
        detail: 'Une erreur est survenue lors du renommage de votre modèle de recherche'
      });
      this.loader = false;
    }
  }

  resetModifySearchItemForm() {
    this.modifySearchItemForm = new FormGroup({
      affichageNom: new FormControl(null),
      ID: new FormControl(null),
    });
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


  exportXls() {
    this.excelService.exportChartDataInXls(this.result.statistique, this.chart?.type)
  }

  onFilterInput(event: Event, column: string): void {
    const target = event.target as HTMLInputElement;
    const value = target?.value ?? '';
    this.table.filter(value, column, 'contains');
  }
  exportDataOnExcel(){
    this.excelService.exportExcel(this.tableColumns, this.columnLabels, this.result.colonne)
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

  redirectToFiche(data: StatisticData) {
    const hbId = data['HG_HB_ID'];
    const id = data['ID']
    const baseUrl = window.location.origin;
    const url = `${baseUrl}/INT?action=usager-fiche&id=${id}&hb_id=${hbId}`;
    window.open(url, '_blank');
  }

  patchTodayDate() {
    this.searchFormService.form.patchValue({
      dateDu: new Date(),
      dateAu: new Date(),
    })
  }

  patchCurrentYearDate() {
    const today  = new Date()
    const firstDayOfYear = new Date(today.getFullYear(), 0, 1);
    const lastDayOfYear = new Date(today.getFullYear(), 11, 31);
    this.searchFormService.form.patchValue({
      dateDu:firstDayOfYear,
      dateAu: lastDayOfYear,
    })
  }

}
