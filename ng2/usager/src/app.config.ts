import { provideHttpClient, withFetch } from '@angular/common/http';
import { APP_INITIALIZER, ApplicationConfig, LOCALE_ID } from '@angular/core';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { provideRouter, withEnabledBlockingInitialNavigation, withInMemoryScrolling } from '@angular/router';
import { PrimeNG, providePrimeNG } from 'primeng/config';
import { appRoutes } from './app.routes';
import { DialogService } from 'primeng/dynamicdialog';
import { MessageService } from 'primeng/api';
import {UserService} from "./app/service/user.service";

export function initializePrimeNG(primengConfig: PrimeNG) {
    return () => {
        primengConfig.setTranslation({
            firstDayOfWeek: 1,
            dayNames: ['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'],
            dayNamesShort: ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'],
            dayNamesMin: ['Di', 'Lu', 'Ma', 'Me', 'Je', 'Ve', 'Sa'],
            monthNames: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
            monthNamesShort: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun', 'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'],
            today: "Aujourd'hui",
            clear: 'Effacer'
        });
    };
}

function initializeApp(userService: UserService) {
    return () => userService.loadUser();
}

export const appConfig: ApplicationConfig = {
    providers: [
        provideRouter(
            appRoutes,
            withInMemoryScrolling({
                anchorScrolling: 'enabled',
                scrollPositionRestoration: 'enabled'
            }),
            withEnabledBlockingInitialNavigation()
        ),
        provideHttpClient(withFetch()),
        provideAnimationsAsync(),
        providePrimeNG({
            theme: {
                options: {
                    darkModeSelector: '.app-dark'
                }
            }
        }),
        { provide: LOCALE_ID, useValue: 'fr-FR' },
        {
            provide: APP_INITIALIZER,
            useFactory: initializePrimeNG,
            deps: [PrimeNG],
            multi: true
        },
        DialogService,
        MessageService,
        {
            provide: APP_INITIALIZER,
            useFactory: initializeApp,
            deps: [UserService],
            multi: true
        }
    ]
};
