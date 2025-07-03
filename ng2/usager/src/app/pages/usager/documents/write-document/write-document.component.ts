import { Component, OnInit, ViewChild } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { DatePickerModule } from 'primeng/datepicker';
import { FluidModule } from 'primeng/fluid';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { SelectModule } from 'primeng/select';
import { TextareaModule } from 'primeng/textarea';
import { DynamicDialogConfig, DynamicDialogRef } from 'primeng/dynamicdialog';
import { of, switchMap, tap } from 'rxjs';
import { DocumentData, DocumentTypeValue } from '../../../../model/document.model';
import { DocumentGateway } from '../../../../gateway/document.gateway';
import { InputTextModule } from 'primeng/inputtext';
import { FileUpload, FileUploadModule } from 'primeng/fileupload';

@Component({
    selector: 'app-write-document',
    imports: [FormsModule, ReactiveFormsModule, FileUploadModule, FluidModule, SelectModule, InputTextModule, DatePickerModule, ButtonModule, TextareaModule],
    templateUrl: './write-document.component.html',
    styleUrl: './write-document.component.scss'
})
export class WriteDocumentComponent implements OnInit {
    form!: FormGroup;
    usagerId!: string;
    documentTypes: DocumentTypeValue[] = [];
    saveLoading = false;
    document: DocumentData | undefined;
    shouldUpload = false;

    @ViewChild('fileUpload') fileUpload!: FileUpload;
    selectedFile: File | null = null;
    uploadedFiles: File[] = [];

    constructor(
        public ref: DynamicDialogRef,
        public config: DynamicDialogConfig,
        private fb: FormBuilder,
        private documentGateway: DocumentGateway
    ) {}

    ngOnInit(): void {
        this.usagerId = this.config.data?.usagerId;
        this.documentTypes = this.config.data?.documentTypes;
        this.document = this.config.data?.document;
        this.initForm(this.document);
    }

    initForm(document: DocumentData | undefined) {
        const now = new Date();
        this.form = this.fb.group({
            title: [document ? document.title : undefined, [Validators.required]],
            name: [document ? document.name : undefined, [Validators.required]],
            type: [document ? document.type : undefined, [Validators.required]],
            version: [document ? document.version : undefined],
            extension: [document ? document.extension : undefined],
            notes: [document ? document.notes : undefined],
            date: [document ? document.date : now]
        });

        this.form.get('name')?.disable();
        this.form.get('extension')?.disable();
        this.form.get('date')?.disable();

        if (this.document) {
            const fakeFile = new File([''], this.document.name, { type: 'application/octet-stream' });
            this.uploadedFiles = [fakeFile];
            this.selectedFile = fakeFile;
        }
    }

    onFileSelect(event: any) {
        this.shouldUpload = true;
        this.selectedFile = event.files[0];
        if (this.selectedFile) {
            const fullFileName = this.selectedFile.name;
            const lastDotIndex = fullFileName.lastIndexOf('.');

            let fileExtension: string;

            if (lastDotIndex > 0) {
                fileExtension = fullFileName.substring(lastDotIndex);
            } else {
                fileExtension = '';
            }

            this.form.patchValue({
                name: fullFileName,
                extension: fileExtension
            });
        }
    }

    cancel() {
        this.ref.close();
    }

    save() {
        if (!this.form.valid) {
            return;
        }

        if (!this.selectedFile) {
            return;
        }

        if (this.document) {
            this.updateDocument();
        } else {
            this.createDocument();
        }

        this.saveLoading = true;
    }

    createDocument() {
        this.documentGateway
            .createDocument(this.usagerId, this.form.getRawValue())
            .pipe(
                tap((response) => {
                    console.log('document created', response);
                }),
                switchMap((response) => {
                    if (response.success && response.id && this.selectedFile) {
                        const formData = new FormData();
                        formData.append(response.id.toString(), this.selectedFile, this.selectedFile.name);
                        return this.documentGateway.uploadDocument(this.usagerId, formData);
                    } else {
                        return of(response); // Retourner la réponse originale
                    }
                })
            )
            .subscribe({
                next: (finalResponse) => {
                    this.ref.close({
                        success: true,
                        message: 'Document crée avec succès.'
                    });
                    this.saveLoading = false;
                },
                error: (error) => {
                    this.ref.close({
                        success: false,
                        message: 'Une erreur est survenue lors de la creation du document'
                    });
                    this.saveLoading = false;
                }
            });
    }

    updateDocument() {
        if (!this.document) {
            return;
        }

        this.documentGateway
            .updateDocument(this.usagerId, this.document.id, this.form.getRawValue())
            .pipe(
                tap((response) => {
                    console.log('Document updated', response);
                }),
                switchMap((response) => {
                    // Vérifier si selectedFile existe et si le nom a changé
                    if (this.selectedFile && this.document && this.shouldUpload) {
                        const formData = new FormData();
                        formData.append(this.usagerId, this.selectedFile, this.selectedFile.name);
                        return this.documentGateway.updateUploadDocument(this.usagerId, this.document.name, formData);
                    } else {
                        // Si pas de fichier à uploader, retourner la réponse originale
                        return of(response);
                    }
                })
            )
            .subscribe({
                next: (finalResponse) => {
                    this.ref.close({
                        success: true,
                        message: 'Document modifié avec succès.'
                    });
                    this.saveLoading = false;
                },
                error: (error) => {
                    this.ref.close({
                        success: false,
                        message: 'Une erreur est survenue lors de la modification du document'
                    });
                    this.saveLoading = false;
                }
            });
    }
}
