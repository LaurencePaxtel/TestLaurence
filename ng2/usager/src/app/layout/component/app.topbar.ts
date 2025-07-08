import {Component} from '@angular/core';
import {MenuItem} from 'primeng/api';
import {RouterModule} from '@angular/router';
import {CommonModule} from '@angular/common';
import {StyleClassModule} from 'primeng/styleclass';
import {AppConfigurator} from './app.configurator';
import {LayoutService} from '../service/layout.service';
import {MenubarModule} from "primeng/menubar";
import {UserConnected} from "../../model/user-connected.model";
import {UserService} from "../../service/user.service";
import {DialogService, DynamicDialogRef} from "primeng/dynamicdialog";
import {ToastService} from "../../service/toast.service";
import {ChangePlatformComponent} from "../../pages/usager/change-platform/change-platform.component";

@Component({
    selector: 'app-topbar',
    standalone: true,
    imports: [RouterModule, CommonModule, StyleClassModule, AppConfigurator, MenubarModule],
    styles: [`

      .logo {
        color: #fad932;
        font-weight: bold;
      }

    `],
    template: `
        <div class="layout-topbar">
            <div class="layout-topbar-logo-container">
                <a class="layout-topbar-logo logo" href="/home">
                    <span>{{ user?.nomStructure }}</span>
                </a>
            </div>

            <div class="layout-topbar-actions">
                <app-configurator/>
                <button class="layout-topbar-menu-button layout-topbar-action" pStyleClass="@next"
                        enterFromClass="hidden" enterActiveClass="animate-scalein" leaveToClass="hidden"
                        leaveActiveClass="animate-fadeout" [hideOnOutsideClick]="true">
                    <i class="pi pi-ellipsis-v"></i>
                </button>

                <div class="layout-topbar-menu hidden lg:block">

                    <div class="layout-topbar-menu-content">
                        <p-menubar [model]="items"/>
                    </div>
                </div>
            </div>
        </div>`
})
export class AppTopbar {
    items!: MenuItem[];
    user: UserConnected | null;
    ref: DynamicDialogRef | undefined;

    constructor(public layoutService: LayoutService,
                public userService: UserService,
                public dialogService: DialogService,
                private toastService: ToastService) {
        this.user = this.userService.currentUser;
        this.items = [
            {
                label: 'Transmissions',
                target: '_blank',
                url: '/INT?action=transmission'
            },
            {
                label: 'Usagers',
                target: '_self',
                url: '/home'
            },
            {
                label: 'Tableau de bord',
                items: [
                    {
                        label: 'Traitement collectif d’usagers',
                        target: '_blank',
                        url: '/usager/page/statistique'
                    },
                    ...(this.user?.hasPrivilege('VEILLE') ? [{
                        label: 'Tableau de bord général',
                        target: '_blank',
                        url: '/INT?action=tableau-de-bord'
                    }] : []),
                    {
                        label: 'Situation financière usagers',
                        target: '_blank',
                        url: '/INT?action=situation-financiere-usagers'
                    },
                    ...(this.user?.hasPrivilege('Statistiques Web') ? [{
                        label: 'Données et Statistiques',
                        target: '_blank',
                        url: '/INT?action=HeberGement_statistiqueGenerer'
                    }] : [])
                ]
            },
            {
                label: 'Disponibilité des centres',
                target: '_blank',
                url: '/INT?action=centres'
            },
            {
                label: 'Gestion immobilière',
                items: [
                    {
                        label: 'Biens',
                        target: '_blank',
                        url: '/GL?action=biens'
                    },
                    {
                        label: 'Locations',
                        target: '_blank',
                        url: '/GL?action=locations'
                    },
                    {
                        label: 'Interventions',
                        target: '_blank',
                        url: '/GL?action=interventions'
                    },
                    {
                        label: 'Équipements',
                        target: '_blank',
                        url: '/GL?action=equipements_biens'
                    },
                    {
                        label: 'Sinistres',
                        target: '_blank',
                        url: '/GL?action=sinistres'
                    },
                    {
                        label: 'Locataires',
                        target: '_blank',
                        url: '/GL?action=usager-list'
                    },
                    {
                        label: 'Propriétaires',
                        target: '_blank',
                        url: '/GL?action=proprietaires'
                    },
                    {
                        label: 'Factures',
                        target: '_blank',
                        url: '/GL?action=factures'
                    },
                    {
                        label: 'Règlements',
                        target: '_blank',
                        url: '/GL?action=reglements'
                    },
                    {
                        label: 'Gestion de stock',
                        target: '_blank',
                        url: '/GL?action=stocks'
                    },
                    {
                        label: 'Base documentaire',
                        target: '_blank',
                        url: '/GL?action=base_documentaire'
                    },
                    {
                        label: 'Paramétrage des équipements',
                        target: '_blank',
                        url: '/GL?action=equipements',
                        icon: 'pi pi-fw pi-cog'
                    },
                    {
                        label: 'Paramétrage IRL',
                        target: '_blank',
                        url: '/GL?action=irl',
                        icon: 'pi pi-fw pi-cog'
                    },

                ]
            },
            {
                label: 'Planning',
                target: '_blank',
                url: '/USR?action=planning'
            },
            {
                label: this.user?.login,
                icon: 'pi pi-fw pi-user',
                items: [
                    {
                        label: 'Modifier la plateforme',
                        command: () => this.onUserMenuClick(),
                        icon: 'pi pi-fw pi-pencil'
                    },
                    {
                        label: 'Réintialiser le mot de passe',
                        target: '_self',
                        url: '/INT?action=usager-list&login=true&resetPassword=Vrai',
                        icon: 'pi pi-fw pi-sync'
                    },
                    {
                        label: 'Deconnexion',
                        target: '_self',
                        url: '/deconnexion',
                        icon: 'pi pi-fw pi-sign-out',
                        styleClass: 'logout-menu-item'
                    },
                ]
            },
        ]
    }

    toggleDarkMode() {
        this.layoutService.layoutConfig.update((state) => ({...state, darkTheme: !state.darkTheme}));
    }

    onUserMenuClick() {
        this.ref = this.dialogService.open(ChangePlatformComponent, {
            focusOnShow: false,
            header: 'Gestion des plateformes',
            modal: true,
            width: '60vw',
        });

        this.ref.onClose.subscribe((result: any) => {
            this.handleMessageOnCloseDynamicDialog(result);
        });
    }

    private handleMessageOnCloseDynamicDialog(result: any) {
        if (result) {
            if (result.success) {
                this.toastService.success(result.message);
                window.location.reload();
            } else {
                this.toastService.warn(result.message);
            }
        }
        this.ref = undefined;
    }
}
