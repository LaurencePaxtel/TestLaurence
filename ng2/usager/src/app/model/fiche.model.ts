export class Fiche {
    constructor(
        readonly id: number | undefined,
        readonly date: Date | undefined,
        readonly prestation: string | undefined,
        readonly Sortie: string | undefined,
        readonly reservation: string | undefined,
        readonly c: string | undefined,
        readonly hg_hb_id: number | undefined,
        readonly plateforme: string | undefined,
        readonly autresolution: string | undefined,
        readonly edit: boolean | undefined,
        readonly checkbox: boolean | undefined
    ) {}

    static from(values: Partial<Fiche>): Fiche {
        const v = values as Fiche;
        return new Fiche(
            v.id,
            v.date,
            v.prestation,
            v.Sortie,
            v.reservation,
            v.c,
            v.hg_hb_id,
            v.plateforme,
            v.autresolution,
            v.edit,
            v.checkbox
        );
    }
}
