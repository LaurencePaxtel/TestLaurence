import {Injectable} from "@angular/core";

@Injectable({
    providedIn: 'root',
})
export class TransmissionService {

    constructor() {
    }

    getPriorites() {
        return [
            {label: 'Urgent', value: 1},
            {label: 'Non urgent', value: 0},
        ];
    }

    getPrioritesFilters() {
        return [
            {label: 'Toutes', value: null},
            {label: 'Urgent', value: 1},
            {label: 'Non urgent', value: 0},
        ];
    }
}