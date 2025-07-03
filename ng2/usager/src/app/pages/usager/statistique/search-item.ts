export class SearchItem {
  constructor(
    readonly ID: number,
    readonly affichageNom: string,
    readonly Ref_Structure: string,
    readonly dataRetour: string[],
    readonly filtreRecherche: any,
    readonly statistiqueComptage: string,
    readonly statistiqueFicheEntree: boolean,
    readonly statistiqueFicheUnique: boolean,
    readonly statistiqueType: string,
    readonly typeGraph: string,
    readonly typeRecherche: string
  ) {
  }

  static fromValues(values: Partial<SearchItem>): Readonly<SearchItem> {
    const v = values as SearchItem;
    return Object.freeze(new SearchItem(v.ID,
        v.affichageNom,
        v.Ref_Structure,
        v.dataRetour,
        v.filtreRecherche,
        v.statistiqueComptage,
        v.statistiqueFicheEntree,
        v.statistiqueFicheUnique,
        v.statistiqueType,
        v.typeGraph,
        v.typeRecherche
      )
    )
  }
}
