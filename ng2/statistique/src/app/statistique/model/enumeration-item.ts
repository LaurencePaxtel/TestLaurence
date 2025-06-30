export class EnumerationItem {
  constructor(
    readonly nom: string,
    readonly item: string[],
    readonly champNumero: number,
    readonly champNom: string,
    readonly libelle: string,
  ) {
  }

  static fromValues(values: Partial<EnumerationItem>): Readonly<EnumerationItem> {
    const v = values as EnumerationItem;
    return Object.freeze(new EnumerationItem(v.nom,
      v.item,
      v.champNumero,
      v.champNom,
      v.libelle))
  }
}

export interface TableColumn {
  libelle: string | undefined;
  value: string;
  defaultDisplay: boolean;
}

