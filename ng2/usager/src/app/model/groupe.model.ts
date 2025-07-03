export class Groupe {
    constructor(
        readonly id: string | undefined,
        readonly value: string | undefined,
    ) {}

    static from(values: Partial<Groupe>): Groupe {
        const v = values as Groupe;
        return new Groupe(
            v.id,
            v.value,
        );
    }
}
