import { Component } from '@angular/core';
import {PrimeNGConfig} from "primeng/api";
import {TranslateService} from "@ngx-translate/core";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent {
  title = 'test';

  constructor(private config: PrimeNGConfig, private translateService: TranslateService) {
    // this language will be used as a fallback when a translation isn't found in the current language
    translateService.setDefaultLang('fr');
    // the lang to use, if the lang isn't available, it will use the current loader to get them
    translateService.use('fr');
    this.translateService.get('primeng').subscribe(res => this.config.setTranslation(res));
  }
}
