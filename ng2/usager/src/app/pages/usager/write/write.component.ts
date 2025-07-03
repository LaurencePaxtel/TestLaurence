import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { DynamicDialogConfig, DynamicDialogRef } from 'primeng/dynamicdialog';
import { UsagerGateway } from '../../../gateway/usager.gateway';
import { FluidModule } from 'primeng/fluid';
import { DatePickerModule } from 'primeng/datepicker';
import { ButtonModule } from 'primeng/button';
import { InputTextModule } from 'primeng/inputtext';
import { tap } from 'rxjs';

@Component({
    selector: 'app-write',
    imports: [FormsModule, ReactiveFormsModule, FluidModule, DatePickerModule, ButtonModule, InputTextModule],
    templateUrl: './write.component.html',
    styleUrl: './write.component.scss'
})
export class WriteComponent implements OnInit {
    form!: FormGroup;
    hebergeId!: number;
    saveLoading = false;
    unknownUsagerLoading = false;

    constructor(
        public ref: DynamicDialogRef,
        public config: DynamicDialogConfig,
        private fb: FormBuilder,
        private usagerGateway: UsagerGateway
    ) {
        this.initForm();
    }

    ngOnInit(): void {}

    initForm() {
        this.form = this.fb.group({
            name: ['', [Validators.required]],
            firstname: ['', [Validators.required]],
            birthDate: ['', [Validators.required]],
            lienFamille: [{value: '', disabled: true}],
            phone: ['']
        });
    }

    generateUnknowUsager() {
        this.unknownUsagerLoading = true;
        this.usagerGateway
            .generateUnknownUsagerData()
            .pipe(
                tap((unknowUsager) => {
                    this.unknownUsagerLoading = false;
                    this.form.patchValue({
                        name: unknowUsager?.nom,
                        firstname: unknowUsager?.prenom,
                        birthDate: unknowUsager?.dateNaissance
                    });
                })
            )
            .subscribe();
    }

    cancel() {
        this.ref.close();
    }

    save() {
        this.saveLoading = true;
        this.usagerGateway
            .createUsager(this.form.getRawValue())
            .pipe(
                tap({
                    next: (response: any) => {
                        if (response.Status === 'Failed') {
                            this.ref.close({
                                success: false,
                                message: response.message,
                                data: this.form.getRawValue()
                            });
                        } else {
                            this.ref.close({
                                success: true,
                                message: 'Usager crée avec succès.',
                                data: this.form.getRawValue()
                            });
                        }

                    },
                    error: (error) => {
                        this.ref.close({
                            success: false,
                            message: "Une erreur est survenue lors de la création de l'usager."
                        });
                    }
                })
            )
            .subscribe();
    }
}
