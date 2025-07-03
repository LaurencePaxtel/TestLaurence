export class PrintDocumentType {
    constructor(
        readonly id: string,
        readonly value: string,
    ) {}

    static from(values: Partial<PrintDocumentType>): PrintDocumentType {
        const v = values as PrintDocumentType;
        return new PrintDocumentType(
            v.id,
            v.value,
        );
    }
}
