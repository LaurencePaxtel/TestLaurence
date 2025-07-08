import {Component, OnInit, OnDestroy} from '@angular/core';
import {DynamicDialogConfig, DynamicDialogRef} from 'primeng/dynamicdialog';
import {FormBuilder, ReactiveFormsModule} from '@angular/forms';
import {CommonModule} from '@angular/common';
import {ButtonModule} from 'primeng/button';
import {UsagerGateway} from '../../../gateway/usager.gateway';
import {UserService} from "../../../service/user.service";
import {UserConnected} from "../../../model/user-connected.model";
import {TableModule} from "primeng/table";
import {tap, Subscription} from "rxjs";

@Component({
    selector: 'app-change-platform',
    imports: [ReactiveFormsModule, CommonModule, ButtonModule, TableModule],
    providers: [UsagerGateway],
    templateUrl: './change-platform.component.html',
    styleUrl: './change-platform.component.scss'
})
export class ChangePlatformComponent implements OnInit, OnDestroy {
    saveLoading = false;
    user?: UserConnected | null

    plateforms : any[] = [];

    selectedPlateform?: any;

    private userSub?: Subscription;

    constructor(
        public ref: DynamicDialogRef,
        public config: DynamicDialogConfig,
        private fb: FormBuilder,
        private usagerGateway: UsagerGateway,
        private readonly userService: UserService
    ) {
        this.user = this.userService.currentUser;
        this.plateforms = this.buildPlatforms();
        for (const platform of this.plateforms) {
            if (platform.numero && platform.numero === this.user?.plateforme) {
                this.selectedPlateform = platform;
            }
        }
    }

    ngOnInit(): void {
        this.userSub = this.userService.currentUser$.subscribe((user) => {
            this.user = user;
            this.plateforms = this.buildPlatforms();
            this.selectedPlateform = this.plateforms.find(p => p.numero === this.user?.plateforme);
        });
    }

    ngOnDestroy(): void {
        this.userSub?.unsubscribe();
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
                    next: () => {
                        this.userService.loadUser().then(() => {
                            this.ref.close({
                                success: true,
                                message: 'La plateforme a été changée avec succès'
                            });
                        });
                    },
                    error: () => {
                        this.ref.close({
                            success: false,
                            message: 'Une erreur est survenue lors de la mise à jour de la plateforme.'
                        });
                    }
                })
            )
            .subscribe();

    }

    private buildPlatforms(): any[] {
        if (!this.user?.plateformes) {
            return [];
        }
        const result = [];
        for (const platform of this.user?.plateformes) {
            result.push({
                numero: platform
            })
        }
        return result;
    }
}
