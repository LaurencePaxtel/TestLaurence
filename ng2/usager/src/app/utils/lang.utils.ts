export function absent(obj: unknown): obj is undefined | null {
    return obj === undefined || obj === null;
}

export function present<T>(obj: T | undefined | null): obj is T {
    return obj !== undefined && obj !== null;
}
