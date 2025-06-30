export class Usager {

  constructor(public id: number, public referenceId: number, public key: string, public refStructure: string) {
  }

  public static new(): Usager {
    return new Usager(0, 0, '', '');
  }
}
