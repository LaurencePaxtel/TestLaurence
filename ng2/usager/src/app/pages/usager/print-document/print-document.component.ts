import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { DynamicDialogConfig, DynamicDialogRef } from 'primeng/dynamicdialog';
import { ConfirmationService } from 'primeng/api';
import { Usager } from '../../../model/usager.model';
import { PrintDocumentType } from '../../../model/document-type.model';
import { SelectModule } from 'primeng/select';
import { ButtonModule } from 'primeng/button';
import { FluidModule } from 'primeng/fluid';
import { filter } from 'rxjs/operators';
import { ScrollPanelModule } from 'primeng/scrollpanel';
import {DomSanitizer, SafeHtml, SafeResourceUrl} from '@angular/platform-browser';
import { DocumentGateway } from '../../../gateway/document.gateway';

@Component({
    selector: 'app-print-document',
    imports: [FormsModule, ReactiveFormsModule, SelectModule, ButtonModule, FluidModule, ScrollPanelModule],
    providers: [ConfirmationService],
    templateUrl: './print-document.component.html',
    styleUrl: './print-document.component.scss'
})
export class PrintDocumentComponent implements OnInit {
    form!: FormGroup;
    usager!: Usager;
    printDocumentTypes: PrintDocumentType[] = [];

    sanitizedHtmlContent: SafeHtml | undefined;
    htmlContent: string = '';

    safeUrl: SafeResourceUrl | undefined;
    documentUrl: SafeResourceUrl | undefined;
    constructor(
        public ref: DynamicDialogRef,
        public config: DynamicDialogConfig,
        private fb: FormBuilder,
        private documentGateway: DocumentGateway,
        private sanitizer: DomSanitizer
    ) {
        this.initForm();
    }

    ngOnInit(): void {
        this.usager = this.config.data?.usager;
        this.printDocumentTypes = this.config.data?.printDocumentTypes;
    }

    initForm() {
        this.form = this.fb.group({
            documentType: [null, [Validators.required]]
        });
    }

    onDocumentSelectionChange(event: any) {
        this.documentGateway
            .loadDocumentTemplatePath(this.usager.hb_referenceid, event)
            .pipe(
                filter((documentUrl) => documentUrl != undefined)
            )
            .subscribe({
                next: (documentUrl) => {
                    if (documentUrl) {
                        // Directement utiliser l'URL sans charger le contenu
                        this.documentUrl = this.sanitizer.bypassSecurityTrustResourceUrl(documentUrl);
                    }
                },
                error: (error) => {
                    console.error('Erreur lors du chargement du document:', error);
                }
            });

    }

    cancel() {
        this.ref.close();
    }

    print(): void {
        if (!this.documentUrl) {
            console.warn('Aucune URL de document disponible');
            return;
        }

        try {
            const iframe = document.querySelector('iframe') as HTMLIFrameElement;

            if (!iframe || !iframe.contentDocument) {
                console.error('Iframe non trouvée ou contenu non accessible');
                return;
            }

            const iframeDocument = iframe.contentDocument;
            const iframeWindow = iframe.contentWindow;

            if (!iframeWindow) {
                console.error('Fenêtre de l\'iframe non accessible');
                return;
            }

            // Sauvegarder les contenus
            const breakPageElement = iframeDocument.querySelector('.breakPage');
            const breakPageContent = breakPageElement?.innerHTML;

            const section1FirstFooterElement = iframeDocument.querySelector('.section1FirstFooter');
            const section1FirstFooterContent = section1FirstFooterElement?.innerHTML;

            // Fonction pour restaurer le contenu
            const restoreContent = () => {
                if (breakPageContent !== undefined) {
                    const breakPageElements = iframeDocument.querySelectorAll('.breakPage');
                    breakPageElements.forEach(element => {
                        element.innerHTML = breakPageContent;
                    });
                }

                if (section1FirstFooterContent !== undefined) {
                    const section1FirstFooterElements = iframeDocument.querySelectorAll('.section1FirstFooter');
                    section1FirstFooterElements.forEach(element => {
                        element.innerHTML = section1FirstFooterContent || '';
                    });
                }
            };

            // Nettoyer les éléments pour l'impression
            if (breakPageContent !== undefined) {
                const breakPageElements = iframeDocument.querySelectorAll('.breakPage');
                breakPageElements.forEach(element => {
                    element.innerHTML = '';
                });
            }

            if (section1FirstFooterContent !== undefined) {
                const section1FirstFooterElements = iframeDocument.querySelectorAll('.section1FirstFooter');
                section1FirstFooterElements.forEach(element => {
                    element.innerHTML = '';
                });
            }

            // Écouter la fin de l'impression
            const afterPrintHandler = () => {
                restoreContent();
                iframeWindow.removeEventListener('afterprint', afterPrintHandler);
            };

            iframeWindow.addEventListener('afterprint', afterPrintHandler);

            // Sécurité : restaurer après 5 secondes même si l'événement n'est pas déclenché
            setTimeout(() => {
                restoreContent();
                iframeWindow.removeEventListener('afterprint', afterPrintHandler);
            }, 5000);

            // Lancer l'impression
            iframeWindow.print();

        } catch (error) {
            console.error('Erreur lors de l\'impression:', error);

            // Fallback simple
            const iframe = document.querySelector('iframe') as HTMLIFrameElement;
            if (iframe && iframe.contentWindow) {
                iframe.contentWindow.print();
            }
        }
    }
}
