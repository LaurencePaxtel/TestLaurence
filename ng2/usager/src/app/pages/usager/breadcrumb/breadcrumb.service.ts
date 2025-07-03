import { Injectable, signal, computed } from '@angular/core';

export interface BreadcrumbItem {
    label?: string;
    route?: string;
    url?: string;
    icon?: string;
    currentRoute?: boolean
}

@Injectable({
    providedIn: 'root'
})
export class BreadcrumbService {
    private _items = signal<BreadcrumbItem[]>([]);

    public readonly items = this._items.asReadonly();

    public readonly isEmpty = computed(() => this._items().length === 0);

    public readonly currentPage = computed(() => {
        const items = this._items();
        return items.length > 0 ? items[items.length - 1] : null;
    });

    setBreadcrumb(items: BreadcrumbItem[]) {
        this._items.set(items);
    }

    addBreadcrumb(item: BreadcrumbItem) {
        this._items.update(current => [...current, item]);
    }

    removeLast() {
        this._items.update(current => current.slice(0, -1));
    }

    clear() {
        this._items.set([]);
    }

    buildFromRoute(segments: string[], labels: string[]) {
        const items: BreadcrumbItem[] = [];
        let route = '';

        segments.forEach((segment, index) => {
            route += `/${segment}`;
            items.push({
                label: labels[index] || segment,
                route: route,
                icon: index === 0 ? 'pi pi-home' : undefined
            });
        });

        this.setBreadcrumb(items);
    }
}
