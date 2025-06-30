import {NgModule} from "@angular/core";
import {BrowserModule} from "@angular/platform-browser";
import {ButtonModule} from "primeng/button";
import {StatistiqueComponent} from "./statistique.component";
import {DividerModule} from "primeng/divider";
import {TableModule} from "primeng/table";
import {InputNumberModule} from "primeng/inputnumber";
import {FormsModule, ReactiveFormsModule} from "@angular/forms";
import {TooltipModule} from "primeng/tooltip";
import {CalendarModule} from "primeng/calendar";
import {BrowserAnimationsModule} from "@angular/platform-browser/animations";
import {DropdownModule} from "primeng/dropdown";
import {InputSwitchModule} from "primeng/inputswitch";
import {InputTextModule} from "primeng/inputtext";
import {ToastModule} from "primeng/toast";
import {StatistiqueSandbox} from "./service/statistique.sandbox";
import {StatistiqueGateway} from "./service/statistique.gateway";
import {ProgressBarModule} from "primeng/progressbar";
import {CardModule} from "primeng/card";
import {MultiSelectModule} from "primeng/multiselect";
import {CheckboxModule} from "primeng/checkbox";
import {FloatLabelModule} from "primeng/floatlabel";
import {StepperModule} from "primeng/stepper";
import {ChipModule} from "primeng/chip";
import {ChartModule} from "primeng/chart";
import {ListboxModule} from "primeng/listbox";
import {RippleModule} from "primeng/ripple";
import {ConfirmDialogModule} from "primeng/confirmdialog";
import {DialogModule} from "primeng/dialog";
import {ProgressSpinnerModule} from "primeng/progressspinner";
import {MessageModule} from "primeng/message";

@NgModule({
  declarations: [StatistiqueComponent],
  imports: [
    BrowserAnimationsModule,
    BrowserModule,
    ReactiveFormsModule,
    FormsModule,
    ButtonModule,
    DividerModule,
    TableModule,
    InputNumberModule,
    TooltipModule,
    CalendarModule,
    InputSwitchModule,
    InputTextModule,
    ToastModule,
    DropdownModule,
    MultiSelectModule,
    ProgressBarModule,
    CheckboxModule,
    FloatLabelModule,
    StepperModule,
    CardModule,
    ChipModule,
    ChartModule,
    ListboxModule,
    RippleModule,
    ConfirmDialogModule,
    DialogModule,
    ProgressSpinnerModule,
    MessageModule
  ],
  providers: [StatistiqueSandbox, StatistiqueGateway],
  exports: [StatistiqueComponent],
})
export class StatistiqueModule { }
