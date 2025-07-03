import { Component, inject } from '@angular/core';
import { RouterModule } from '@angular/router';
import { BreadcrumbModule } from 'primeng/breadcrumb';
import { CommonModule } from '@angular/common';
import { BreadcrumbService } from './breadcrumb.service';

@Component({
    selector: 'app-breadcrumb',
    standalone: true,
    imports: [CommonModule, RouterModule, BreadcrumbModule],
    template: `
        <p-breadcrumb *ngIf="!breadcrumbService.isEmpty()" class="max-w-full" [model]="breadcrumbService.items()">
            <ng-template #item let-item>
                <ng-container *ngIf="item.route; else elseBlock">
                    <a [routerLink]="item.route" class="p-breadcrumb-item-link">
                        <span *ngIf="item.icon" [ngClass]="item.icon" class="text-color"></span>
                        <span class="text-black font-semibold">{{ item.label }}</span>
                    </a>
                </ng-container>
                <ng-template #elseBlock>
                    <a [href]="item.url" target="_blank" rel="noopener noreferrer">
                        <span class="text-color">{{ item.label }}</span>
                    </a>
                </ng-template>
            </ng-template>
        </p-breadcrumb>
    `
})
export class BreadcrumbComponent {
    breadcrumbService = inject(BreadcrumbService);
}
