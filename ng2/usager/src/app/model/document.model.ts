export interface LegacyApiResponse {
    total_rows: number;
    headers: string[];
    rows: any[];
}

export interface CleanDocument {
    id: string;
    titre: string;
    type: string;
    dateCreation: string;
    format: string;
    selected?: boolean;
}

export class DocumentTypeValue {
    constructor(
        readonly label: string,
        readonly value: string,
    ) {}

    static from(values: Partial<DocumentTypeValue>): DocumentTypeValue {
        const v = values as DocumentTypeValue;
        return new DocumentTypeValue(
            v.label,
            v.value,
        );
    }
}

export class DocumentData {
    constructor(
        readonly id: number,
        readonly refStructure: string,
        readonly type: string,
        readonly origineId: number,
        readonly tableNo: number,
        readonly name: string,
        readonly date: Date | undefined,
        readonly title: string,
        readonly notes: string,
        readonly version: number,
        readonly document: any | null,
        readonly extension: string,
        readonly immeubleId: number,
        readonly bienId: number,
        readonly namePrevious: string,
    ) {}

    static from(values: Partial<DocumentData>): DocumentData {
        const v = values as DocumentData;
        return new DocumentData(
            v.id,
            v.refStructure,
            v.type,
            v.origineId,
            v.tableNo,
            v.name,
            v.date,
            v.title,
            v.notes,
            v.version,
            v.document,
            v.extension,
            v.immeubleId,
            v.bienId,
            v.namePrevious,
        );
    }
}
