import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, Observable, firstValueFrom } from 'rxjs';
import { map } from 'rxjs/operators';
import {UserConnected} from "../model/user-connected.model";
import {environment} from "../../environments/environment";

@Injectable({
    providedIn: 'root'
})
export class UserService {
    private readonly http = inject(HttpClient);

    // BehaviorSubject pour stocker l'utilisateur courant
    private currentUserSubject = new BehaviorSubject<UserConnected | null>(null);

    // Observable public pour que les composants puissent s'abonner
    public readonly currentUser$ = this.currentUserSubject.asObservable();

    // Getter pour obtenir la valeur actuelle sans s'abonner
    get currentUser(): UserConnected | null {
        return this.currentUserSubject.value;
    }

    async loadUser(): Promise<void> {
        try {
            const user = await firstValueFrom(this.getIntervenant());
            console.log('~> Retrieve connected user', user);
            this.currentUserSubject.next(user);
        } catch (error) {
            console.error('An error occured during the retrieve of the connected user', error);
            this.currentUserSubject.next(null);
        }
    }

    public getIntervenant(): Observable<UserConnected> {
            return this.http.get(environment.apiUrl +'/session/intervenant').pipe(
                map((response: any) => {
                    return UserConnected.from(response);
                })
            );
        }

    hasPrivilege(privilegeName: string): boolean {
        return this.currentUser?.hasPrivilege(privilegeName) ?? false;
    }


    updateUser(user: UserConnected): void {
        this.currentUserSubject.next(user);
    }
}

