export class NoteType {
    constructor(
        readonly label: string,
        readonly value: string,
    ) {}

    static from(values: Partial<NoteType>): NoteType {
        const v = values as NoteType;
        return new NoteType(
            v.label,
            v.value,
        );
    }
}

export class Note {
    constructor(
        readonly noteNumber: string,
        readonly type: string,
        readonly date: Date | undefined,
        readonly content: string,
        readonly userName: string,
        readonly uuid: string,
        readonly hour: Date | undefined,
        readonly editable: boolean,
    ) {}

    static from(values: Partial<Note>): Note {
        const v = values as Note;
        return new Note(
            v.noteNumber,
            v.type,
            v.date,
            v.content,
            v.userName,
            v.uuid,
            v.hour,
            v.editable,
        );
    }
}
