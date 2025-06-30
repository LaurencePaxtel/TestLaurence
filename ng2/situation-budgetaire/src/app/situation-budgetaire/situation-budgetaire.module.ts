import {NgModule} from "@angular/core";
import {BrowserModule} from "@angular/platform-browser";
import {ButtonModule} from "primeng/button";
import {SituationBudgetaireComponent} from "./situation-budgetaire.component";
import {DividerModule} from "primeng/divider";
import {TableModule} from "primeng/table";
import {TabViewModule} from "primeng/tabview";
import {InputNumberModule} from "primeng/inputnumber";
import {FormsModule, ReactiveFormsModule} from "@angular/forms";
import {TooltipModule} from "primeng/tooltip";
import {CalendarModule} from "primeng/calendar";
import {BrowserAnimationsModule} from "@angular/platform-browser/animations";
import {InputTextareaModule} from "primeng/inputtextarea";
import {DropdownModule} from "primeng/dropdown";
import {InputSwitchModule} from "primeng/inputswitch";
import {InputTextModule} from "primeng/inputtext";
import {ToastModule} from "primeng/toast";
import {SituationBudgetaireService} from "./service/situation-budgetaire.service";
import {SituationBudgetaireGateway} from "./service/situation-budgetaire.gateway";
import {ProgressBarModule} from "primeng/progressbar";
import {CardModule} from "primeng/card";

@NgModule({
  declarations: [SituationBudgetaireComponent],
  imports: [
    BrowserAnimationsModule,
    BrowserModule,
    ReactiveFormsModule,
    FormsModule,
    ButtonModule,
    DividerModule,
    TableModule,
    TabViewModule,
    InputNumberModule,
    TooltipModule,
    CalendarModule,
    InputTextareaModule,
    InputSwitchModule,
    InputTextModule,
    ToastModule,
    DropdownModule,
    ProgressBarModule,
    CardModule
  ],
  providers: [SituationBudgetaireService, SituationBudgetaireGateway],
  exports: [SituationBudgetaireComponent],
})
export class SituationBudgetaireModule { }
