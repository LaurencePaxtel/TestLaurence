import {NgModule} from '@angular/core';
import {CommonModule, NgIf} from '@angular/common';
import {TransmissionComponent} from './transmission.component';
import {TransmissionGateway} from "./service/transmission.gateway";
import {BrowserAnimationsModule} from "@angular/platform-browser/animations";
import {BrowserModule} from "@angular/platform-browser";
import {FormsModule, ReactiveFormsModule} from "@angular/forms";
import {CardModule} from "primeng/card";
import {TableModule} from "primeng/table";
import {ButtonModule} from "primeng/button";
import {TooltipModule} from "primeng/tooltip";
import {IconFieldModule} from "primeng/iconfield";
import {InputTextModule} from "primeng/inputtext";
import {InputIconModule} from "primeng/inputicon";
import {DropdownModule} from "primeng/dropdown";
import {CalendarModule} from "primeng/calendar";
import {ConfirmDialogModule} from "primeng/confirmdialog";
import {ToastModule} from "primeng/toast";
import {DialogModule} from "primeng/dialog";
import {InputTextareaModule} from "primeng/inputtextarea";
import {DividerModule} from "primeng/divider";
import {MentionModule} from "angular-mentions";
import {AutoCompleteModule} from "primeng/autocomplete";
import {TransmissionService} from "./service/transmission.service";


@NgModule({
    declarations: [
        TransmissionComponent
    ],
    imports: [
        CommonModule,
        BrowserAnimationsModule,
        BrowserModule,
        ReactiveFormsModule,
        FormsModule,
        CardModule,
        TableModule,
        ButtonModule,
        TooltipModule,
        IconFieldModule,
        InputTextModule,
        InputIconModule,
        DropdownModule,
        CalendarModule,
        ConfirmDialogModule,
        DialogModule,
        InputTextareaModule,
        DividerModule,
        ToastModule,
        MentionModule,
        AutoCompleteModule,
        FormsModule,
        InputTextModule,
        NgIf
    ],
    providers: [TransmissionGateway, TransmissionService],
    exports: [TransmissionComponent],
})
export class TransmissionModule {
}
