export class SearchUsagerCommand {
    constructor(
        public action?: string,
        public saction?: string,
        public nom?: string,
        public prenom?: string,
        public dateNaissance?: string,
        public lienFamille?: string,
        public telephone?: string,
        public filtre?: string
    ) {}

    static from(values: Partial<SearchUsagerCommand>): SearchUsagerCommand {
        const action = 'usager_list_json';
        const saction = 'get_heberges';
        return new SearchUsagerCommand(action, saction, values.nom, values.prenom, values.dateNaissance, values.lienFamille, values.telephone, values.filtre);
    }

    toHttpParams(): { [key: string]: string } {
        const params: { [key: string]: string } = {};

        if (this.action && this.action.trim() !== '') {
            params['action'] = this.action;
        }

        if (this.saction && this.saction.trim() !== '') {
            params['saction'] = this.saction;
        }

        if (this.nom && this.nom.trim() !== '') {
            params['nom'] = this.nom;
        }

        if (this.prenom && this.prenom.trim() !== '') {
            params['prenom'] = this.prenom;
        }

        if (this.dateNaissance && this.dateNaissance.trim() !== '') {
            params['date_naissance'] = this.dateNaissance;
        }

        if (this.lienFamille && this.lienFamille.trim() !== '') {
            params['lien_famille'] = this.lienFamille;
        }

        if (this.telephone && this.telephone.trim() !== '') {
            params['telephone'] = this.telephone;
        }

        if (this.filtre && this.filtre.trim() !== '') {
            params['filtre'] = this.filtre;
        }

        return params;
    }
}
