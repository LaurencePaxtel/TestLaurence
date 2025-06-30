import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {TransmissionComponent} from "./transmission/transmission.component";

const routes: Routes = [
  { path: 'INT', component: TransmissionComponent },
  { path: '',   redirectTo: '/INT', pathMatch: 'prefix'}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
