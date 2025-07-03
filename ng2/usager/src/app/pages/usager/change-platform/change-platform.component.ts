import {Component, OnInit} from '@angular/core';
import {DynamicDialogConfig, DynamicDialogRef} from 'primeng/dynamicdialog';
import {FormBuilder, ReactiveFormsModule} from '@angular/forms';
import {CommonModule} from '@angular/common';
import {ButtonModule} from 'primeng/button';
import {UsagerGateway} from '../../../gateway/usager.gateway';
import {UserService} from "../../../service/user.service";
import {UserConnected} from "../../../model/user-connected.model";
import {TableModule} from "primeng/table";
import {tap} from "rxjs";

@Component({
    selector: 'app-change-platform',
    imports: [ReactiveFormsModule, CommonModule, ButtonModule, TableModule],
    providers: [UsagerGateway],
    templateUrl: './change-platform.component.html',
    styleUrl: './change-platform.component.scss'
})
export class ChangePlatformComponent implements OnInit {
    saveLoading = false;
    user?: UserConnected | null

    plateforms = [
        {numero: '@'},
        {numero: '00'},
        {numero: '02'},
        {numero: '08'},
        {numero: '15'},
        {numero: '24'},
        {numero: '50'}
    ];

    selectedPlateform?: any;

    constructor(
        public ref: DynamicDialogRef,
        public config: DynamicDialogConfig,
        private fb: FormBuilder,
        private usagerGateway: UsagerGateway,
        private readonly userService: UserService
    ) {
        this.user = this.userService.currentUser;
    }

    ngOnInit(): void {
        for (const platform of this.plateforms) {
            if (platform.numero && platform.numero === this.user?.plateforme) {
                this.selectedPlateform = platform;
            }
        }
    }

    cancel() {
        this.ref.close();
    }

    save() {
        if (this.user === undefined || this.user === null) {
            console.log('Intervenant is undefined');
            return;
        }

        this.saveLoading = true;
        this.usagerGateway.savePlatform(this.user.id, this.selectedPlateform.numero)
            .pipe(
                tap({
                    next: (response) => {
                        this.ref.close({
                            success: true,
                            message: 'La plateforme a été changée avec succès'
                        });
                    },
                    error: (error) => {
                        this.ref.close({
                            success: false,
                            message: 'Une erreur est survenue lors de la mise à jour de la plateforme.'
                        });
                    }
                })
            )
            .subscribe();

    }
}
