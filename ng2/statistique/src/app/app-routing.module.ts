import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {StatistiqueComponent} from "./statistique/statistique.component";

const routes: Routes = [
  // { path: 'INT', component: StatistiqueComponent },
  { path: '',   redirectTo: 'statistiques/page', pathMatch: 'full'},
  { path: 'statistiques/page', component: StatistiqueComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
