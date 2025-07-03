interface UserJSON {
    ID: number;
    Login: string;
    Email: string;
    Ref_Structure: string;
    Nom_Structure: string;
    Plateforme: string;
    Plateformes: string[];
    Privileges: Privilege[];
    cookie: string;
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
        readonly plateformes: string[] | undefined,
        readonly privileges: Privilege[] | undefined,
        readonly cookie: string | undefined
    ) {}

    static from(values: Partial<UserJSON>): UserConnected {
        return new UserConnected(
            values.ID,
            values.Login,
            values.Email,
            values.Ref_Structure,
            values.Nom_Structure,
            values.Plateforme,
            values.Plateformes,
            values.Privileges,
            values.cookie
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
