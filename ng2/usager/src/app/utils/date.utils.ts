export function isValidDateFormat(dateString: string | undefined): boolean {
    if (!dateString) {
        return false;
    }
    const regex = /^\d{4}-\d{2}-\d{2}$/;

    if (!regex.test(dateString)) {
        return false;
    }

    const date = new Date(dateString);

    const year = date.getFullYear();
    const month = date.getMonth() + 1; // getMonth() retourne 0-11
    const day = date.getDate();

    const formattedDate = `${year}-${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}`;

    return formattedDate === dateString && !isNaN(date.getTime());
}

export function findDateRange(dates: Date[]): { oldest: string, newest: string } {
    if (dates.length === 0) {
        return { oldest: '', newest: '' };
    }

    const oldestDate = new Date(Math.min(...dates.map(date => date.getTime())));
    const newestDate = new Date(Math.max(...dates.map(date => date.getTime())));

    const formatDate = (date: Date): string => {
        const day = date.getDate().toString().padStart(2, '0');
        const month = (date.getMonth() + 1).toString().padStart(2, '0');
        const year = date.getFullYear();
        return `${day}/${month}/${year}`;
    };

    return {
        oldest: formatDate(oldestDate),
        newest: formatDate(newestDate)
    };
}

export function parseDate(dateString: string | null | undefined): Date | undefined {
    if (dateString == null) return undefined; // Gère null et undefined

    const regex = /^(\d{2})\/(\d{2})\/(\d{4})$/;
    const match = dateString.match(regex);

    if (!match) return undefined;

    const [, day, month, year] = match;
    const date = new Date(parseInt(year), parseInt(month) - 1, parseInt(day));

    // Vérifier que la date est valide
    if (date.getDate() !== parseInt(day) ||
        date.getMonth() !== parseInt(month) - 1 ||
        date.getFullYear() !== parseInt(year)) {
        return undefined;
    }

    return date;
}

function isValidDate(date: Date): boolean {
    return date instanceof Date && !isNaN(date.getTime());
}

export function isValidISODateString(dateString: string): boolean {
    if (!dateString || dateString.trim() === '') {
        return false;
    }

    // Vérifier le format invalide 0000-00-00T00:00:00.000Z
    if (dateString.startsWith('0000-00-00') || dateString.includes('0000-00-00')) {
        return false;
    }

    // Vérifier les autres formats invalides courants
    const invalidPatterns = [
        /^0000-/, // Année 0000
        /-00-00T/, // Mois et jour à 00
        /-00T/, // Jour à 00
        /T00:00:00\.000Z$/ // Peut être valide, mais on vérifie la date elle-même
    ];

    // Si c'est un pattern évidemment invalide
    if (dateString.startsWith('0000-') || dateString.includes('-00-00')) {
        return false;
    }

    try {
        const date = new Date(dateString);
        return isValidDate(date);
    } catch (error) {
        return false;
    }
}

export function formatDate(dateString: string): string {
    const date = new Date(dateString);
    const day = date.getDate().toString().padStart(2, '0');
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const year = date.getFullYear();
    return `${day}/${month}/${year}`;
}

export function isValidDateFormatAsDDMMYYYY(dateString: string): boolean {
    // Vérifier le format avec une regex
    const regex = /^(\d{2})\/(\d{2})\/(\d{4})$/;
    const match = dateString.match(regex);

    if (!match) {
        return false;
    }

    const day = parseInt(match[1], 10);
    const month = parseInt(match[2], 10);
    const year = parseInt(match[3], 10);

    // Créer une date et vérifier si elle est valide
    const date = new Date(year, month - 1, day); // month est 0-indexé

    return date.getFullYear() === year &&
        date.getMonth() === month - 1 &&
        date.getDate() === day;
}


export function createDateFromTime(timeString: string, baseDate?: Date): Date | undefined {
    if (!timeString || !timeString.includes(':')) {
        return undefined;
    }

    const parts = timeString.split(':');
    if (parts.length < 2 || parts.length > 3) {
        return undefined;
    }

    const hours = parseInt(parts[0], 10);
    const minutes = parseInt(parts[1], 10);
    const seconds = parts.length === 3 ? parseInt(parts[2], 10) : 0;

    if (isNaN(hours) || isNaN(minutes) || isNaN(seconds) ||
        hours < 0 || hours > 23 ||
        minutes < 0 || minutes > 59 ||
        seconds < 0 || seconds > 59) {
        return undefined;
    }

    const date = baseDate ? new Date(baseDate) : new Date();
    date.setHours(hours, minutes, seconds, 0);
    return date;
}
