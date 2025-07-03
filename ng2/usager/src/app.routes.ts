import { Routes } from '@angular/router';
import { AppLayout } from './app/layout/component/app.layout';
import { Notfound } from './app/pages/notfound/notfound';
import { UsagerComponent } from './app/pages/usager/usager.component';
import { NoteComponent } from './app/pages/usager/note/note.component';
import { DocumentsComponent } from './app/pages/usager/documents/documents.component';
import {StatistiqueComponent} from "./app/pages/usager/statistique/statistique.component";

export const appRoutes: Routes = [
    {
        path: '',
        component: AppLayout,
        children: [
            { path: '', redirectTo: 'home', pathMatch: 'full' },
            { path: 'home', component: UsagerComponent },
            {
                path: 'usager/page/:usagerId/notes',
                component: NoteComponent
            },
            {
                path: 'usager/page/:usagerId/documents',
                component: DocumentsComponent
            },
            {
                path: 'usager/page/statistique',
                component: StatistiqueComponent
            }
        ]
    },
    { path: 'notfound', component: Notfound },
    { path: '**', redirectTo: '/notfound' }
];
