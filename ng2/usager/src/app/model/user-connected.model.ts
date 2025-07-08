interface UserJSON {
    ID: number;
    Login: string;
    Email: string;
    Ref_Structure: string;
    Nom_Structure: string;
    Plateforme: string;
    Privileges: Privilege[];
    cookie: string;
    Nom_PieceChamp1: string;
    Nom_PieceChamp2: string;
    Nom_PieceChamp3: string;
    Nom_PieceChamp4: string;
    Plateformes: string[];
}

interface Privilege {
    nom: string;
}

export class UserConnected {
    constructor(
        readonly id: number | undefined,
        readonly login: string | undefined,
        readonly email: string | undefined,
        readonly refStructure: string | undefined,
        readonly nomStructure: string | undefined,
        readonly plateforme: string | undefined,
        readonly privileges: Privilege[] | undefined,
        readonly cookie: string | undefined,
        readonly pieceChamps1: string | undefined,
        readonly pieceChamps2: string | undefined,
        readonly pieceChamps3: string | undefined,
        readonly pieceChamps4: string | undefined,
        readonly plateformes: string[] | undefined,
    ) {}

    static from(values: Partial<UserJSON>): UserConnected {
        return new UserConnected(
            values.ID,
            values.Login,
            values.Email,
            values.Ref_Structure,
            values.Nom_Structure,
            values.Plateforme,
            values.Privileges,
            values.cookie,
            values.Nom_PieceChamp1,
            values.Nom_PieceChamp2,
            values.Nom_PieceChamp3,
            values.Nom_PieceChamp4,
            values.Plateformes
        );
    }

    // Méthode utilitaire pour vérifier si l'utilisateur a un privilège spécifique
    hasPrivilege(privilegeName: string): boolean {
        if (!this.privileges) return false;
        return this.privileges.some(p => p.nom === privilegeName);
    }

    // Méthode pour obtenir tous les noms de privilèges
    getPrivilegeNames(): string[] {
        if (!this.privileges) return [];
        return this.privileges.map(p => p.nom);
    }

}
