import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { DynamicDialogConfig, DynamicDialogRef } from 'primeng/dynamicdialog';
import { UsagerGateway } from '../../../gateway/usager.gateway';
import { TableModule } from 'primeng/table';
import { TextareaModule } from 'primeng/textarea';
import { CommonModule } from '@angular/common';
import { DatePickerModule } from 'primeng/datepicker';
import { ButtonModule } from 'primeng/button';
import { CheckboxModule } from 'primeng/checkbox';
import { tap } from 'rxjs';

@Component({
    selector: 'app-note-sp',
    imports: [ReactiveFormsModule, CommonModule, DatePickerModule, TableModule, TextareaModule, ButtonModule, CheckboxModule],
    templateUrl: './note-sp.component.html',
    styleUrl: './note-sp.component.scss'
})
export class NoteSpComponent implements OnInit {
    form!: FormGroup;
    hebergeId!: number;
    saveLoading = false;
    casItems = Array.from({ length: 5 }, (_, i) => i + 1);

    constructor(
        public ref: DynamicDialogRef,
        public config: DynamicDialogConfig,
        private fb: FormBuilder,
        private usagerGateway: UsagerGateway
    ) {
        this.initForm();
    }

    cancel() {
        this.ref.close();
    }

    initForm() {
        const formConfig: any = {};

        for (let i = 1; i <= 5; i++) {
            formConfig[`hb_cas${i}`] = [false]; // checkbox
            formConfig[`hb_casdt${i}`] = ['']; // date
            formConfig[`hb_caslib${i}`] = ['']; // textarea
        }
        this.form = this.fb.group(formConfig);
    }

    ngOnInit(): void {
        const heberge: any = this.config.data;
        this.hebergeId = heberge.hb_referenceid;
        for (let i = 1; i <= 5; i++) {
            if (heberge[`hb_cas${i}`] !== undefined) {
                const checkboxValue = heberge[`hb_cas${i}`] === 'true' || heberge[`hb_cas${i}`] === true;
                this.form.patchValue({ [`hb_cas${i}`]: checkboxValue });
            }

            if (heberge[`hb_casdt${i}`] !== undefined) {
                let dateValue = null;
                if (heberge[`hb_casdt${i}`] && heberge[`hb_casdt${i}`] !== '') {
                    dateValue = new Date(heberge[`hb_casdt${i}`]);
                }
                this.form.patchValue({ [`hb_casdt${i}`]: dateValue });
            }

            if (heberge[`hb_caslib${i}`] !== undefined) {
                this.form.patchValue({ [`hb_caslib${i}`]: heberge[`hb_caslib${i}`] });
            }
        }
    }

    save() {
        if (!this.form.valid) {
            return;
        }
        const formValue = this.form.getRawValue();

        const submissionData = { ...formValue };
        for (let i = 1; i <= 5; i++) {
            const checkboxValue = submissionData[`hb_cas${i}`];
            submissionData[`hb_cas${i}`] = checkboxValue === true ? 'true' : 'false';
        }
        this.saveLoading = true;
        this.usagerGateway.saveNotesSp(this.hebergeId, submissionData)
            .pipe(
                tap({
                    next: (response) => {
                        this.ref.close({
                            success: true,
                            message: 'Les notes ont été mises à jour avec succès.'
                        });
                    },
                    error: (error) => {
                        this.ref.close({
                            success: false,
                            message: 'Une erreur est survenue lors de la mise à jour des notes.'
                        });
                    }
                })
            )
            .subscribe();
    }
}
