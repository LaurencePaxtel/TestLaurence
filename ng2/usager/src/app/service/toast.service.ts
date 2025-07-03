// toast.service.ts
import { Injectable } from '@angular/core';
import { MessageService } from 'primeng/api';

@Injectable({
    providedIn: 'root'
})
export class ToastService {

    constructor(private messageService: MessageService) {}

    /**
     * Affiche un toast de succès
     */
    success(message: string, title: string = 'Succès', life: number = 3000) {
        this.messageService.add({
            severity: 'success',
            summary: title,
            detail: message,
            life: life
        });
    }

    /**
     * Affiche un toast d'erreur
     */
    error(message: string, title: string = 'Erreur', life: number = 5000) {
        this.messageService.add({
            severity: 'error',
            summary: title,
            detail: message,
            life: life
        });
    }

    /**
     * Affiche un toast d'information
     */
    info(message: string, title: string = 'Information', life: number = 3000) {
        this.messageService.add({
            severity: 'info',
            summary: title,
            detail: message,
            life: life
        });
    }

    /**
     * Affiche un toast d'avertissement
     */
    warn(message: string, title: string = 'Attention', life: number = 4000) {
        this.messageService.add({
            severity: 'warn',
            summary: title,
            detail: message,
            life: life
        });
    }

    /**
     * Affiche un toast personnalisé
     */
    custom(severity: 'success' | 'info' | 'warn' | 'error', message: string, title?: string, life: number = 3000) {
        this.messageService.add({
            severity: severity,
            summary: title,
            detail: message,
            life: life
        });
    }

    /**
     * Efface tous les toasts
     */
    clear() {
        this.messageService.clear();
    }

    /**
     * Efface un toast spécifique par sa clé
     */
    clearByKey(key: string) {
        this.messageService.clear(key);
    }
}
