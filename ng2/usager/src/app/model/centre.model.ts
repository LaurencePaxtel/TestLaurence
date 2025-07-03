export class Centre {
    constructor(
        readonly id: number,
        readonly value: string,
        readonly categorie: string,
        readonly prestation: boolean
    ) {}

    static from(values: Partial<Centre>): Centre {
        const v = values as Centre;
        return new Centre(
            v.id,
            v.value,
            v.categorie,
            v.prestation
        );
    }
}
