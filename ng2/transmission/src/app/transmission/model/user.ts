export class User {
    constructor(public refStructure: string, public plateFormeServiceCode: string, public login: string, public id: number) {
    }

    public static new() {
        return new User('', '', '', 0);
    }
}