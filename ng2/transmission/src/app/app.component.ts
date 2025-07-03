import {Component, OnInit} from '@angular/core';
import {PrimeNGConfig} from "primeng/api";
import {TranslateService} from "@ngx-translate/core";
import {ActivatedRoute} from "@angular/router";
import {skip, tap} from "rxjs";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent implements OnInit{
  title = 'transmission';

  constructor(private config: PrimeNGConfig, private translateService: TranslateService, private route: ActivatedRoute) {
    // this language will be used as a fallback when a translation isn't found in the current language
    translateService.setDefaultLang('fr');
    // the lang to use, if the lang isn't available, it will use the current loader to get them
    translateService.use('fr');
    this.translateService.get('primeng').subscribe(res => this.config.setTranslation(res));
  }

  ngOnInit(): void {
        this.route.queryParams
            .pipe(
                skip(1),
                tap(params => {
                  const login: boolean = params['login'];
                  if (login) {
                    window.open('/home', '_blank');
                  }
                })
            )
            .subscribe()
    }
}
