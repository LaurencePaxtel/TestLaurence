import { AbstractControl, ValidatorFn } from '@angular/forms';

export function atLeastOneFieldFilledValidator(): ValidatorFn {
    return (formGroup: AbstractControl): { [key: string]: any } | null => {
        const controls = formGroup.value;

        // Vérifier si au moins un champ a une valeur non vide
        const isValid = Object.keys(controls).some(key => {
            const value = controls[key];
            return value !== null && value !== undefined && value !== '';
        });

        // Si aucun champ n'est rempli, retourner une erreur
        return isValid ? null : { 'requiredAtLeastOne': true };
    };
}
