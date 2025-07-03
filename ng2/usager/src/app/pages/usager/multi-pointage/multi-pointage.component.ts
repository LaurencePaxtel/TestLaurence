import {Component, OnInit} from '@angular/core';
import {DatePicker} from 'primeng/datepicker';
import {Fluid} from 'primeng/fluid';
import {FormArray, FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators} from '@angular/forms';
import {DynamicDialogConfig, DynamicDialogRef} from 'primeng/dynamicdialog';
import {UsagerGateway} from '../../../gateway/usager.gateway';
import {Usager} from '../../../model/usager.model';
import {Groupe} from '../../../model/groupe.model';
import {Centre} from '../../../model/centre.model';
import {SelectModule} from 'primeng/select';
import {MultiSelectModule} from 'primeng/multiselect';
import {ConfirmationService, SelectItem, SelectItemGroup} from 'primeng/api';
import {Button} from 'primeng/button';
import {tap} from 'rxjs';
import {ConfirmDialogModule} from 'primeng/confirmdialog';
import {CheckboxChangeEvent, CheckboxModule} from 'primeng/checkbox';
import {TabsModule} from "primeng/tabs";
import {DividerModule} from "primeng/divider";
import {ScrollPanelModule} from "primeng/scrollpanel";
import {InputTextModule} from "primeng/inputtext";

@Component({
    selector: 'app-multi-pointage',
    imports: [DatePicker, Fluid, FormsModule, MultiSelectModule, ReactiveFormsModule, SelectModule, Button, ConfirmDialogModule, CheckboxModule, TabsModule, DividerModule, ScrollPanelModule, InputTextModule],
    providers: [ConfirmationService],
    templateUrl: './multi-pointage.component.html',
    styleUrl: './multi-pointage.component.scss'
})
export class MultiPointageComponent implements OnInit {
    form!: FormGroup;
    usager!: Usager;
    groupes: Groupe[] = [];
    prestations: any[] = [];
    prestationCategoriesTabs: any[] = []
    saveLoading = false;

    centresMap: Map<number, number> = new Map();

    activeTabValue: number = 1;

    private _currentTabPrestations: any[] = [];
    private _lastActiveTab: number = -1;

    private _fixedScrollHeight: string | null = null;

    searchTerm: string = '';

    constructor(
        public ref: DynamicDialogRef,
        public config: DynamicDialogConfig,
        private fb: FormBuilder,
        private usagerGateway: UsagerGateway,
        private confirmationService: ConfirmationService
    ) {
        this.initForm();
    }

    // Getter pour accéder au FormArray
    get array(): FormArray {
        return this.form.get('array') as FormArray;
    }

    ngOnInit(): void {
        this.usager = this.config.data?.usager;
        this.groupes = this.config.data?.groupes;
        console.log(this.groupes);
        this.centresMap = new Map(this.config.data?.centres.map((item: Centre) => [item.id, item.value]));
        this.prestations = this.buildPrestations(this.config.data?.centres);
        this.prestationCategoriesTabs = this.buildDistinctCategoriesTabs(this.config.data?.centres);

        // IMPORTANT : Définir l'onglet actif APRÈS avoir construit les tabs
        if (this.prestationCategoriesTabs.length > 0) {
            this.activeTabValue = this.prestationCategoriesTabs[0].value;
            console.log('Onglet actif initialisé à :', this.activeTabValue);
        }
    }

    initForm() {
        this.form = this.fb.group({
            date: [new Date(), [Validators.required]],
            dispositif: [null, [Validators.required]],
            array: this.fb.array([], [Validators.minLength(1)])
        });
    }

    updateArray() {
        this.form.setControl('array', this.fb.array([]));
        const prestations = this.form.get('prestations')?.value;
        if (prestations?.length) {
            for (const prestation of prestations) {
                this.array.push(this.createFormGroup(prestation));
            }
        }
    }

    createFormGroup(prestation: SelectItem): FormGroup {
        return this.fb.group({
            prestation: {
                id: prestation.value,
                value: prestation.label
            },
            quantite: [1],
            montant: [0]
        });
    }

    private buildPrestations(centres: Centre[], filterStartWith?: string) {
        const result = [];
        for (const centre of centres) {
            result.push({
                label: centre.value,
                labelWithCategory: `${centre.value} (${centre.categorie})`,
                prestation: centre.prestation,
                id: centre.id,
                categorie: centre.categorie,
                display: true,
                selected: false,
            });
        }

        // Tri par catégorie puis par nom
        result.sort((a, b) => {
            // D'abord par catégorie
            const categoryCompare = a.categorie.localeCompare(b.categorie);
            if (categoryCompare !== 0) {
                return categoryCompare;
            }
            // Puis par nom si même catégorie
            return a.label.localeCompare(b.label);
        });

        return result;
    }

    cancel() {
        this.ref.close();
    }

    onConfirmSaving(event: Event) {
        const message = `Êtes-vous sûr de vouloir créer ces fiches pour A${this.usager?.hb_cle} ?`;

        this.confirmationService.confirm({
            target: event.target as EventTarget,
            message: message,
            header: 'Confirmation de création de fiches',
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
                this.save();
            },
            reject: () => {}
        });
    }

    save() {
        this.saveLoading = true;
        this.usagerGateway
            .saveMultiPointage(this.usager.hb_referenceid, this.form.getRawValue())
            .pipe(
                tap({
                    next: (response) => {
                        if (response.status === 'Failed') {
                            this.ref.close({
                                success: false,
                                message: response.message
                            });
                        } else {
                            this.ref.close({
                                success: true,
                                message: 'Multi pointage effectué avec succes.'
                            });
                        }
                    },
                    error: (error) => {
                        this.ref.close({
                            success: false,
                            message: 'Une erreur est survenue lors du multi pointage.'
                        });
                    }
                })
            )
            .subscribe();
    }

    onGroupeChange(groupe: Groupe) {
        // Réinitialiser le FormArray quand on change de groupe
        const array = this.form.get('array') as FormArray;
        array.clear();

        // Décocher toutes les prestations
        this.prestations.forEach(prestation => {
            prestation.selected = false;
        });

        // Appliquer le filtre selon le groupe
        this.filterPrestationsAccordingGroupe(groupe);

        // Invalider le cache pour forcer le recalcul
        this._lastActiveTab = -1;
    }

    filterPrestationsAccordingGroupe(groupe: Groupe) {
        if (!groupe || !groupe.value || groupe.value.length < 2) {
            // Aucun groupe sélectionné : afficher toutes les prestations
            this.prestations.forEach(prestation => {
                prestation.display = true;
            });
            return;
        }

        const twoFirstCharacters = groupe.value.substring(0, 2);

        if (this.isTwoFirstCharNumbers(twoFirstCharacters)) {
            // Filtrer les prestations selon les 2 premiers caractères
            this.prestations.forEach(prestation => {
                prestation.display = prestation.label.startsWith(twoFirstCharacters);
            });

            console.log(`Filtrage appliqué pour "${twoFirstCharacters}":`,
                this.prestations.filter(p => p.display).length, 'prestations affichées');
        } else {
            // Si les 2 premiers caractères ne sont pas des nombres : afficher tout
            this.prestations.forEach(prestation => {
                prestation.display = true;
            });
        }
    }

    isTwoFirstCharNumbers(str: string) {
        return /^\d{2}$/.test(str);
    }

    private buildDistinctCategoriesTabs(centres: Centre[]): any[] {
        const result = new Set<string>();
        for (const centre of centres) {
            if (centre.categorie) {
                result.add(centre.categorie);
            }
        }
        const sorted = [...result].sort();

        const tabs = [];
        tabs.push({
            label: 'Toutes',
            disabled: false,
            value: 0 // Valeur 0 pour "Toutes"
        });
        let index = 1;
        for (const item of sorted) {
            tabs.push({
                label: item,
                disabled: false,
                value: index
            });
            index++;
        }
        return tabs;
    }


    onPrestationSelected(event: CheckboxChangeEvent, prestation: any) {
        if (event.checked) {
            // Ajouter la prestation au FormArray
            this.addPrestationToArray(prestation);
        } else {
            // Supprimer la prestation du FormArray
            this.removePrestationFromArray(prestation);
        }

        console.log('FormArray mis à jour:', this.array.value);
    }

    private addPrestationToArray(prestation: any): void {
        const prestationFormGroup = this.fb.group({
            prestationId: [prestation.id], // ← ID pour identifier la prestation
            prestation: [{
                id: prestation.id,
                value: prestation.label
            }],
            quantite: [1],
            montant: [0]
        });

        this.array.push(prestationFormGroup);
    }

    private removePrestationFromArray(prestation: any): void {
        const index = this.array.controls.findIndex(
            control => control.get('prestationId')?.value === prestation.id
        );

        if (index !== -1) {
            this.array.removeAt(index);
        }
    }

    removeFromArrayByIndex(index: number): void {
        // Récupérer l'ID de la prestation avant suppression
        const prestationId = this.array.at(index).get('prestationId')?.value;

        // Supprimer du FormArray
        this.array.removeAt(index);

        // Décocher la checkbox correspondante
        const prestation = this.prestations.find(p => p.id === prestationId);
        if (prestation) {
            prestation.selected = false;
        }
    }

    onTabChange(tabValue: any) {
        if (this.activeTabValue !== tabValue) {
            this.activeTabValue = tabValue;
            console.log('Onglet changé vers :', this.activeTabValue);
        }
    }

    getCurrentTab() {
        return this.prestationCategoriesTabs.find(tab => tab.value === this.activeTabValue);
    }

    getCurrentTabPrestations(): any[] {
        if (this._lastActiveTab !== this.activeTabValue) {
            const currentTab = this.getCurrentTab();
            if (currentTab) {
                if (currentTab.value === 0) {
                    // Onglet "Toutes" : filtre par groupe + recherche, tri par label
                    let filteredPrestations = this.prestations.filter(prestation => {
                        const matchesGroup = this.isDisplayedByGroup(prestation);
                        const matchesSearch = this.searchTerm.length === 0 ||
                            prestation.label.toLowerCase().includes(this.searchTerm.toLowerCase());
                        return matchesGroup && matchesSearch;
                    });

                    // Tri par label uniquement pour l'onglet "Toutes"
                    this._currentTabPrestations = filteredPrestations.sort((a, b) =>
                        a.label.localeCompare(b.label)
                    );
                } else {
                    // Autres onglets : comportement normal (déjà trié par catégorie+label)
                    this._currentTabPrestations = this.prestations.filter(
                        prestation => prestation.categorie === currentTab.label && prestation.display
                    );
                }
            } else {
                this._currentTabPrestations = [];
            }
            this._lastActiveTab = this.activeTabValue;
        }
        return this._currentTabPrestations;
    }

    onSearch(event: any): void {
        this.searchTerm = event.target.value.trim();

        if (this.searchTerm.length > 0) {
            this.activeTabValue = 0;

            // Appliquer la recherche en tenant compte du filtre groupe existant
            this.prestations.forEach(prestation => {
                const matchesSearch = prestation.label.toLowerCase().includes(this.searchTerm.toLowerCase());
                const matchesGroup = this.isDisplayedByGroup(prestation);
                prestation.display = matchesSearch && matchesGroup;
            });

            this.prestationCategoriesTabs.forEach(tab => {
                tab.disabled = tab.value !== 0;
            });
        } else {
            // Restaurer le filtre groupe quand la recherche est vidée
            const selectedGroup = this.form.get('dispositif')?.value;
            this.filterPrestationsAccordingGroupe(selectedGroup);

            this.prestationCategoriesTabs.forEach(tab => {
                tab.disabled = false;
            });
        }

        this._lastActiveTab = -1;
    }

    private isDisplayedByGroup(prestation: any): boolean {
        const selectedGroup = this.form.get('dispositif')?.value;

        if (!selectedGroup || !selectedGroup.value || selectedGroup.value.length < 2) {
            return true; // Aucun filtre groupe
        }

        const twoFirstCharacters = selectedGroup.value.substring(0, 2);

        if (this.isTwoFirstCharNumbers(twoFirstCharacters)) {
            return prestation.label.startsWith(twoFirstCharacters);
        }

        return true; // Pas de filtre si les 2 premiers chars ne sont pas des nombres
    }


}
