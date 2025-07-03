import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { DynamicDialogConfig, DynamicDialogRef } from 'primeng/dynamicdialog';
import { Note, NoteType } from '../../../../model/note.model';
import { DatePicker } from 'primeng/datepicker';
import { Fluid } from 'primeng/fluid';
import { MultiSelectModule } from 'primeng/multiselect';
import { SelectModule } from 'primeng/select';
import { InputTextModule } from 'primeng/inputtext';
import { ButtonModule } from 'primeng/button';
import { TextareaModule } from 'primeng/textarea';
import { catchError, of, tap } from 'rxjs';
import { NoteGateway } from '../../../../gateway/note.gateway';

@Component({
    selector: 'app-write',
    imports: [DatePicker, Fluid, FormsModule, MultiSelectModule, ReactiveFormsModule, SelectModule, InputTextModule, ButtonModule, TextareaModule],
    templateUrl: './write.component.html',
    styleUrl: './write.component.scss'
})
export class WriteNoteComponent implements OnInit {
    form!: FormGroup;
    hebergeId!: string;
    noteTypes: NoteType[] = [];
    saveLoading = false;
    note: Note | undefined;

    constructor(
        public ref: DynamicDialogRef,
        public config: DynamicDialogConfig,
        private fb: FormBuilder,
        private noteGateway: NoteGateway
    ) {}

    ngOnInit(): void {
        this.hebergeId = this.config.data?.hebergeId;
        this.noteTypes = this.config.data?.noteTypes;
        this.note = this.config.data?.note;
        this.initForm(this.note);
    }

    initForm(note: Note | undefined) {
        const now = new Date();
        this.form = this.fb.group({
            date: [note ? note.date : now, [Validators.required]],
            hour: [note ? note.hour : now, [Validators.required]],
            type: [note?.type, [Validators.required]],
            content: [note ? this.cleanContentForTextarea(note.content) : null]
        });
    }

    cancel() {
        this.ref.close();
    }

    save() {
        if (!this.form.valid) {
            return;
        }
        this.saveLoading = true;
        if (this.note) {
            this.noteGateway
                .updateNote(this.hebergeId, this.note, this.form.getRawValue())
                .pipe(
                    tap((response) => {
                        this.ref.close({
                            success: true,
                            message: 'La note a été modifiée avec succès.'
                        });
                    }),
                    catchError((error) => {
                        this.ref.close({
                            success: false,
                            message: 'Une erreur est survenue lors de la création de la note'
                        });
                        return of(null);
                    })
                )
                .subscribe();
        } else {
            this.noteGateway
                .createNote(this.hebergeId, this.form.getRawValue())
                .pipe(
                    tap((response) => {
                        this.ref.close({
                            success: true,
                            message: 'Nouvelle note créee avec succès.'
                        });
                    }),
                    catchError((error) => {
                        this.ref.close({
                            success: false,
                            message: 'Une erreur est survenue lors de la modification de la note'
                        });
                        return of(null);
                    })
                )
                .subscribe();
        }
    }

    private cleanContentForTextarea(content: string): string {
        if (!content) return '';

        return content
            .replace(/<br\s*\/?>/gi, '\n')
            .replace(/\\r/g, '\n')
            .trim();
    }
}
