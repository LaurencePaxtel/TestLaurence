import { ChangeDetectorRef, Component, OnInit, ViewChild } from '@angular/core';
import { Note, NoteType } from '../../../model/note.model';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { UsagerGateway } from '../../../gateway/usager.gateway';
import { ConfirmationService, FilterService } from 'primeng/api';
import { DialogService, DynamicDialogRef } from 'primeng/dynamicdialog';
import { ActivatedRoute } from '@angular/router';
import { catchError, of, tap } from 'rxjs';
import { CommonModule } from '@angular/common';
import { InputTextModule } from 'primeng/inputtext';
import { DatePickerModule } from 'primeng/datepicker';
import { ButtonModule } from 'primeng/button';
import { FluidModule } from 'primeng/fluid';
import { Table, TableModule } from 'primeng/table';
import { TooltipModule } from 'primeng/tooltip';
import { ToastModule } from 'primeng/toast';
import { CardModule } from 'primeng/card';
import { ConfirmDialog } from 'primeng/confirmdialog';
import { IconField } from 'primeng/iconfield';
import { InputIcon } from 'primeng/inputicon';
import { SelectModule } from 'primeng/select';
import { WriteNoteComponent } from './write/write.component';
import { DomSanitizer, SafeHtml } from '@angular/platform-browser';
import { NoteGateway } from '../../../gateway/note.gateway';
import { BreadcrumbComponent } from '../breadcrumb/breadcrumb.component';
import { DividerModule } from 'primeng/divider';
import { UsagerDetails } from '../../../model/usager.model';
import { filter } from 'rxjs/operators';
import { BreadcrumbService } from '../breadcrumb/breadcrumb.service';
import {ToastService} from "../../../service/toast.service";
import {UserConnected} from "../../../model/user-connected.model";
import {UserService} from "../../../service/user.service";

@Component({
    selector: 'app-note',
    imports: [
        CommonModule,
        FormsModule,
        ReactiveFormsModule,
        InputTextModule,
        DatePickerModule,
        ButtonModule,
        FluidModule,
        TableModule,
        ToastModule,
        CardModule,
        ConfirmDialog,
        IconField,
        InputIcon,
        SelectModule,
        BreadcrumbComponent,
        DividerModule,
        TooltipModule
    ],
    providers: [UsagerGateway, ConfirmationService, FilterService],
    templateUrl: './note.component.html',
    styleUrl: './note.component.scss'
})
export class NoteComponent implements OnInit {
    @ViewChild('tableNote') table!: Table;
    ref: DynamicDialogRef | undefined;
    usagerDetails!: UsagerDetails;
    user?: UserConnected | null

    noteTypes: NoteType[] = [];
    notes: Note[] = [];

    minDate: Date | null = null;
    maxDate: Date | null = null;

    constructor(
        private noteGateway: NoteGateway,
        private confirmationService: ConfirmationService,
        private toastService: ToastService,
        public dialogService: DialogService,
        private route: ActivatedRoute,
        private filterService: FilterService,
        private cdr: ChangeDetectorRef,
        private sanitizer: DomSanitizer,
        private usagerGateway: UsagerGateway,
        private breadcrumbService: BreadcrumbService,
        private readonly userService: UserService
    ) {
        this.user = this.userService.currentUser;
        const hebergeId = this.route.snapshot.paramMap.get('usagerId');
        if (hebergeId == null) {
            throw new Error('Heberge ID is missing');
        }

        this.usagerGateway
            .loadUsager(hebergeId)
            .pipe(
                filter((usagerDetails) => usagerDetails !== undefined),
                tap((usagerDetails) => {
                    this.usagerDetails = usagerDetails;
                    this.loadNoteTypes();
                    this.loadNotes();
                    this.breadcrumbService.setBreadcrumb([
                        {
                            label: 'Usagers',
                            route: '/home'
                        },
                        { label: this.usagerDetails.hb_cle },
                        {
                            label: 'Notes',
                            icon: 'pi pi-book',
                            route: '../notes',
                            currentRoute: true
                        }
                    ]);
                })
            )
            .subscribe();
    }

    sanitizeHtml(html: string): SafeHtml {
        return this.sanitizer.bypassSecurityTrustHtml(html);
    }

    loadNotes() {
        this.noteGateway
            .getNotesByUsager(this.usagerDetails.hb_referenceid)
            .pipe(
                tap((notes) => {
                    this.notes = notes;
                })
            )
            .subscribe();
    }

    loadNoteTypes() {
        this.noteGateway
            .getNotesType(this.usagerDetails.hb_referenceid)
            .pipe(
                tap((noteTypes) => {
                    this.noteTypes = noteTypes;
                })
            )
            .subscribe();
    }

    ngOnInit() {
        this.registerCustomFilters();
    }

    registerCustomFilters() {
        this.filterService.register('dateGte', (value: any, filter: Date): boolean => {
            if (!filter || !value) return true;
            const itemDate = new Date(value);
            const filterDate = new Date(filter);
            const itemDateOnly = new Date(itemDate.getFullYear(), itemDate.getMonth(), itemDate.getDate());
            const filterDateOnly = new Date(filterDate.getFullYear(), filterDate.getMonth(), filterDate.getDate());
            return itemDateOnly >= filterDateOnly;
        });

        this.filterService.register('dateLte', (value: any, filter: Date): boolean => {
            if (!filter || !value) return true;
            const itemDate = new Date(value);
            const filterDate = new Date(filter);
            const itemDateOnly = new Date(itemDate.getFullYear(), itemDate.getMonth(), itemDate.getDate());
            const filterDateOnly = new Date(filterDate.getFullYear(), filterDate.getMonth(), filterDate.getDate());
            return itemDateOnly <= filterDateOnly;
        });
    }

    applyDateFilters() {
        if (!this.table) return;

        if (this.minDate) {
            this.table.filter(this.minDate, 'date', 'dateGte');
        }
        if (this.maxDate) {
            this.table.filter(this.maxDate, 'date', 'dateLte');
        }
    }

    onMinDateChange(date: Date | null) {
        this.minDate = date;
        if (date === null) {
            this.clearMinDate();
        } else {
            this.applyDateFilters();
        }
    }

    onMaxDateChange(date: Date | null) {
        this.maxDate = date;
        if (date === null) {
            this.clearMaxDate();
        } else {
            this.applyDateFilters();
        }
    }

    clearMinDate() {
        this.minDate = null;

        if (this.table) {
            this.table.filter(undefined, 'date', 'dateGte');
            setTimeout(() => {
                this.table._filter();
                this.cdr.detectChanges();
            }, 0);
        }
    }

    clearMaxDate() {
        this.maxDate = null;

        if (this.table) {
            this.table.filter(null, 'date', 'dateLte');
            setTimeout(() => {
                this.table._filter();
                this.cdr.detectChanges();
            }, 0);
        }
    }

    onGlobalFilter(table: Table, event: Event) {
        table.filterGlobal((event.target as HTMLInputElement).value, 'contains');
    }

    onNewNote() {
        this.ref = this.dialogService.open(WriteNoteComponent, {
            focusOnShow: false,
            header: 'Créer une note',
            modal: true,
            width: '60vw',
            data: {
                hebergeId: this.usagerDetails.hb_referenceid,
                noteTypes: this.noteTypes
            }
        });

        this.ref.onClose.subscribe((result: any) => {
            this.handleMessageOnCloseDynamicDialog(result);
            this.loadNotes();
        });
    }

    editNote(note: Note) {
        this.ref = this.dialogService.open(WriteNoteComponent, {
            focusOnShow: false,
            header: 'Editer une note',
            modal: true,
            width: '60vw',
            data: {
                hebergeId: this.usagerDetails.hb_referenceid,
                noteTypes: this.noteTypes,
                note: note
            }
        });

        this.ref.onClose.subscribe((result: any) => {
            this.handleMessageOnCloseDynamicDialog(result);
            this.loadNotes();
        });
    }

    private handleMessageOnCloseDynamicDialog(result: any) {
        if (result) {
            if (result.success) {
                this.toastService.success(result.message);
            } else {
                this.toastService.warn(result.message);
            }
        }
        this.ref = undefined;
    }

    onConfirmDeleteNote(note: Note, event: Event) {
        const message = `Souhaitez-vous vraiment supprimer la note ${note.noteNumber} ?`;

        this.confirmationService.confirm({
            target: event.target as EventTarget,
            message: message,
            header: 'Supprimer une note',
            closable: true,
            closeOnEscape: true,
            icon: 'pi pi-exclamation-triangle',
            rejectButtonProps: {
                label: 'NON',
                severity: 'secondary',
                outlined: true
            },
            acceptButtonProps: {
                label: 'OUI'
            },
            accept: () => {
                this.deleteNote(note);
            },
            reject: () => {}
        });
    }

    deleteNote(note: Note) {
        this.noteGateway
            .deleteNote(this.usagerDetails.hb_referenceid, note)
            .pipe(
                tap((response) => {
                    this.toastService.success('Note supprimée avec succès');
                    this.loadNotes();
                }),
                catchError((error) => {
                    console.error('Erreur lors de la suppression:', error);
                    this.toastService.warn('Une erreur est survenue lors de la suppression de la note ' + note.noteNumber);
                    return of(null);
                })
            )
            .subscribe();
    }

    closePage() {
        window.close();
    }
}
