export class CentreHebergementPrestation {
  constructor(
    readonly id: number,
    readonly value: string,
    readonly categorie: string,
    readonly prestation: boolean,
  ) {
  }

  static fromValues(values: Partial<CentreHebergementPrestation>): Readonly<CentreHebergementPrestation> {
    const v = values as CentreHebergementPrestation;
    return Object.freeze(new CentreHebergementPrestation(v.id,
      v.value,
      v.categorie,
      v.prestation))
  }
}
