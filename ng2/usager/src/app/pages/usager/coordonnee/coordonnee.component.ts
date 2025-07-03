import { Component, OnInit } from '@angular/core';
import { DynamicDialogConfig, DynamicDialogRef } from 'primeng/dynamicdialog';
import { FormBuilder, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { InputTextModule } from 'primeng/inputtext';
import { DatePickerModule } from 'primeng/datepicker';
import { ButtonModule } from 'primeng/button';
import { TabsModule } from 'primeng/tabs';
import { TextareaModule } from 'primeng/textarea';
import { FluidModule } from 'primeng/fluid';
import { FloatLabelModule } from 'primeng/floatlabel';
import { CheckboxModule } from 'primeng/checkbox';
import { UsagerDetails } from '../../../model/usager.model';
import { UsagerGateway } from '../../../gateway/usager.gateway';
import { tap } from 'rxjs';
import {UserService} from "../../../service/user.service";
import {UserConnected} from "../../../model/user-connected.model";

@Component({
    selector: 'app-coordonnee',
    imports: [ReactiveFormsModule, CommonModule, TabsModule, InputTextModule, DatePickerModule, ButtonModule, FluidModule, TextareaModule, FloatLabelModule, CheckboxModule],
    providers: [UsagerGateway],
    templateUrl: './coordonnee.component.html',
    styleUrl: './coordonnee.component.scss'
})
export class CoordonneeComponent implements OnInit {
    form!: FormGroup;
    hebergeId!: number;
    saveLoading = false;
    user?: UserConnected | null

    constructor(
        public ref: DynamicDialogRef,
        public config: DynamicDialogConfig,
        private fb: FormBuilder,
        private usagerGateway: UsagerGateway,
        private readonly userService: UserService
    ) {
        this.user = this.userService.currentUser;
        this.initForm();
    }

    ngOnInit(): void {
        const heberge: UsagerDetails = this.config.data;
        this.hebergeId = heberge.hb_referenceid;
        this.form.patchValue({
            nom: heberge.hb_nom,
            prenom: heberge.hb_prenom,
            dateNaissance: heberge.hb_datenele,
            adresse1: heberge.adresse1,
            adresse2: heberge.adresse2,
            adresse3: heberge.adresse3,
            codePostal: heberge.codePostal,
            ville: heberge.ville,
            email: heberge.hb_email,
            telephone: heberge.hb_telephone,
            cni: heberge.hb_pieceneou,
            numeroSecu: heberge.hb_piecenationalite,
            personneConfiance: heberge.hb_piececni,
            piecePasseport: heberge.hb_piecepasseport
        });
    }

    initForm() {
        this.form = this.fb.group({
            nom: [{ value: '', disabled: true }],
            prenom: [{ value: '', disabled: true }],
            dateNaissance: [{ value: '', disabled: true }],
            editUser: [false],
            adresse1: [''],
            adresse2: [''],
            adresse3: [''],
            codePostal: [''],
            ville: [''],
            email: [''],
            telephone: [''],
            cni: [''],
            numeroSecu: [''],
            personneConfiance: [''],
            piecePasseport: ['']
        });
    }

    onEditCheckboxChange(event: any) {
        if (event.checked) {
            this.form.get('nom')?.enable();
            this.form.get('prenom')?.enable();
            this.form.get('dateNaissance')?.enable();
        } else {
            this.form.get('nom')?.disable();
            this.form.get('prenom')?.disable();
            this.form.get('dateNaissance')?.disable();
        }
    }

    cancel() {
        this.ref.close();
    }

    save() {
        this.saveLoading = true;
        this.usagerGateway.saveContactDetails(this.hebergeId, this.form.getRawValue())
            .pipe(
                tap({
                    next: (response) => {
                        this.ref.close({
                            success: true,
                            message: 'Les coordonnées ont été mises à jour avec succès.'
                        });
                    },
                    error: (error) => {
                        this.ref.close({
                            success: false,
                            message: 'Une erreur est survenue lors de la mise à jour des coordonnées.'
                        });
                    }
                })
            )
            .subscribe();

    }
}
