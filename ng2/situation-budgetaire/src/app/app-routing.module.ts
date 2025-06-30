import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {SituationBudgetaireComponent} from "./situation-budgetaire/situation-budgetaire.component";

const routes: Routes = [
  { path: 'INT', component: SituationBudgetaireComponent },
  { path: '',   redirectTo: '/INT', pathMatch: 'prefix'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
