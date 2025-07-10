export class Usager {
    constructor(
        readonly id: number,
        readonly hb_cle: string | undefined,
        readonly clefamille: string | undefined,
        readonly hb_referenceid: number,
        readonly count_fiches: number | undefined,
        readonly noteSP: boolean | undefined,
        readonly isFamChief: boolean | undefined,
        readonly hg_genre: boolean | undefined,
    ) {}

    static from(values: Partial<Usager>): Usager {
        const v = values as Usager;
        return new Usager(v.id, v.hb_cle, v.clefamille, v.hb_referenceid, v.count_fiches, v.noteSP, v.isFamChief, v.hg_genre);
    }
}


interface SituationBudgetaire {
    dateSitBudget: string;
    nbPersonneMenage: number;
    commentaire: string;
    budget: {
        salaire: number;
        loyer: number;
        apl: number;
        charge: any[];
        ressource: any[];
    };
    dette: {
        detail: any[];
    };
}

export class UsagerDetails {
    constructor(
        readonly id: number,
        readonly hb_referenceid: number,
        readonly hb_cle: string | undefined,
        readonly hb_nom: string | undefined,
        readonly hb_prenom: string | undefined,
        readonly hb_datenele: Date | undefined,
        readonly notes: string | undefined,
        readonly hb_cas1: boolean,
        readonly hb_cas2: boolean,
        readonly hb_cas3: boolean,
        readonly hb_cas4: boolean,
        readonly hb_cas5: boolean,
        readonly hb_cas6: boolean,
        readonly hb_cas7: boolean,
        readonly hb_cas8: boolean,
        readonly hb_cas9: boolean,
        readonly hb_cas10: boolean,
        readonly hb_commentaire: string | undefined,
        readonly hb_status: boolean,
        readonly hb_casdt1: Date | undefined,
        readonly hb_casdt2: Date | undefined,
        readonly hb_casdt3: Date | undefined,
        readonly hb_casdt4: Date | undefined,
        readonly hb_casdt5: Date | undefined,
        readonly hb_casdt6: Date | undefined,
        readonly hb_casdt7: Date | undefined,
        readonly hb_casdt8: Date | undefined,
        readonly hb_casdt9: Date | undefined,
        readonly hb_casdt10: Date | undefined,
        readonly hb_caslib1: string | undefined,
        readonly hb_caslib2: string | undefined,
        readonly hb_caslib3: string | undefined,
        readonly hb_caslib4: string | undefined,
        readonly hb_caslib5: string | undefined,
        readonly hb_caslib6: string | undefined,
        readonly hb_caslib7: string | undefined,
        readonly hb_caslib8: string | undefined,
        readonly hb_caslib9: string | undefined,
        readonly hb_caslib10: string | undefined,
        readonly hg_genre: boolean,
        readonly hg_actions: string | undefined,
        readonly hb_maraude: string | undefined,
        readonly hb_social: string | undefined,
        readonly hb_infirmier: string | undefined,
        readonly hb_psycho: string | undefined,
        readonly hb_medical: string | undefined,
        readonly hb_fichecreeele: string,
        readonly hb_clefam: string | undefined,
        readonly hb_sante: string | undefined,
        readonly hb_actionsf: string | undefined,
        readonly hb_notes2: string | undefined,
        readonly hb_maraude2: string | undefined,
        readonly hb_social2: string | undefined,
        readonly hb_notestrans: string | undefined,
        readonly hb_notes3: string | undefined,
        readonly hb_trans_referenceid: number,
        readonly hb_trans_clefam: string | undefined,
        readonly hb_pieceneou: string | undefined,
        readonly hb_piecenationalite: string | undefined,
        readonly hb_piececni: string | undefined,
        readonly hb_piecepasseport: string | undefined,
        readonly hb_clecodee_etat: boolean,
        readonly hb_clecodee: string | undefined,
        readonly hb_photo: string | undefined,
        readonly hb_notes4: string | undefined,
        readonly hb_telephone: string | undefined,
        readonly ref_structure: string,
        readonly hb_email: string | undefined,
        readonly hb_note_fvv: string | undefined,
        readonly hb_type_locataire: string | undefined,
        readonly hb_locataire: boolean,
        readonly hb_fac_destation: string | undefined,
        readonly hb_compte_comptable: string | undefined,
        readonly import_tmp: string | undefined,
        readonly hb_note_comptable: string | undefined,
        readonly hb_adresse_facturation: string | undefined,
        readonly hb_mode_reglement: string | undefined,
        readonly hb_fac_envoie_courrier: boolean,
        readonly hb_fac_envoie_mail: boolean,
        readonly hb_fac_mode_facturation: string | undefined,
        readonly notesarchive: string | undefined,
        readonly hb_notes2archive: string | undefined,
        readonly hb_noteextract: boolean,
        readonly hb_alertedirection: any | null,
        readonly situationbudgetaire: SituationBudgetaire | undefined,
        readonly hb_timestamp: number,
        readonly importapplicationmobile: boolean,
        readonly hb_fac_dette_initiale: number,
        readonly adresse1: string | undefined,
        readonly adresse2: string | undefined,
        readonly adresse3: string | undefined,
        readonly codePostal: string | undefined,
        readonly ville: string | undefined
    ) {
    }

    static from(values: Partial<UsagerDetails>): UsagerDetails {
        const v = values as any;
        return new UsagerDetails(
            v.id,
            v.hb_referenceid,
            v.hb_cle,
            v.hb_nom,
            v.hb_prenom,
            v.hb_datenele,
            v.notes,
            v.hb_cas1 || false,
            v.hb_cas2 || false,
            v.hb_cas3 || false,
            v.hb_cas4 || false,
            v.hb_cas5 || false,
            v.hb_cas6 || false,
            v.hb_cas7 || false,
            v.hb_cas8 || false,
            v.hb_cas9 || false,
            v.hb_cas10 || false,
            v.hb_commentaire,
            v.hb_status || false,
            v.hb_casdt1 ,
            v.hb_casdt2 ,
            v.hb_casdt3 ,
            v.hb_casdt4 ,
            v.hb_casdt5 ,
            v.hb_casdt6 ,
            v.hb_casdt7 ,
            v.hb_casdt8 ,
            v.hb_casdt9 ,
            v.hb_casdt10,
            v.hb_caslib1,
            v.hb_caslib2,
            v.hb_caslib3,
            v.hb_caslib4,
            v.hb_caslib5,
            v.hb_caslib6,
            v.hb_caslib7,
            v.hb_caslib8,
            v.hb_caslib9,
            v.hb_caslib10,
            v.hg_genre || false,
            v.hg_actions,
            v.hb_maraude,
            v.hb_social,
            v.hb_infirmier,
            v.hb_psycho,
            v.hb_medical,
            v.hb_fichecreeele,
            v.hb_clefam,
            v.hb_sante,
            v.hb_actionsf,
            v.hb_notes2,
            v.hb_maraude2,
            v.hb_social2,
            v.hb_notestrans,
            v.hb_notes3,
            v.hb_trans_referenceid || 0,
            v.hb_trans_clefam,
            v.hb_pieceneou,
            v.hb_piecenationalite,
            v.hb_piececni,
            v.hb_piecepasseport,
            v.hb_clecodee_etat || false,
            v.hb_clecodee,
            v.hb_photo,
            v.hb_notes4,
            v.hb_telephone,
            v.ref_structure,
            v.hb_email,
            v.hb_note_fvv,
            v.hb_type_locataire,
            v.hb_locataire || false,
            v.hb_fac_destation,
            v.hb_compte_comptable,
            v.import_tmp,
            v.hb_note_comptable,
            v.hb_adresse_facturation,
            v.hb_mode_reglement,
            v.hb_fac_envoie_courrier || false,
            v.hb_fac_envoie_mail || false,
            v.hb_fac_mode_facturation,
            v.notesarchive,
            v.hb_notes2archive,
            v.hb_noteextract || false,
            v.hb_alertedirection,
            v.situationbudgetaire,
            v.hb_timestamp || 0,
            v.importapplicationmobile || false,
            v.hb_fac_dette_initiale || 0,
            v.adresse1,
            v.adresse2,
            v.adresse3,
            v.codePostal,
            v.ville
        );
    }
}

export class UnknownUsager {
    constructor(
        readonly nom: number,
        readonly prenom: string | undefined,
        readonly dateNaissance: Date | undefined,
    ) {}

    static from(values: Partial<UnknownUsager>): UnknownUsager {
        const v = values as UnknownUsager;
        return new UnknownUsager(v.nom, v.prenom, v.dateNaissance);
    }
}
