import moment from "moment";

export type TransmissionAction = 'create' | 'update';

export interface TransmissionResult {
  totalRecords: number,
  data: Transmission[]
}

export class Transmission {

  constructor(public id: string,
              public date: Date | null,
              public intervenantId: number,
              public intervenantLogin: string,
              public service: string,
              public usagerId: number,
              public usagerCle: string,
              public priorite: number,
              public message: string) {
  }

  static fromJson(transmission: any): Transmission {
    let date = null;
    if (moment(transmission.date, "DD/MM/YYYY", true).isValid() && transmission.heure) {
      date = moment(transmission.date, "DD/MM/YYYY");
    }
    if (date && moment(transmission.heure, "HH:mm:ss", true).isValid()) {
      let hour = moment(transmission.heure, "HH:mm:ss");
      date = date.add(hour.hour(), 'hours').add(hour.minutes(), 'minutes');
    }

    let service = transmission.service;
    if (service === '115') {
      service = 'Tous'
    }

    return {
      id: transmission.id,
      date: date ? date.toDate() : null,
      intervenantId: transmission.intervenantID,
      intervenantLogin: transmission.intervenantLogin,
      service: service,
      usagerId: transmission.hebergeID,
      usagerCle: transmission.hebergeCle,
      priorite: transmission.priorite,
      message: transmission.message,
    }

  }
}

export interface Service {
  id: number;
  name: string;
}


export interface TransmissionForm {
  id?: string;
  date?: string;
  intervenantID?: number
  groupe?: string | null;
  priorite?: number;
  message?: string;
  usagerID?: number;
}

export interface TransmissionFilters {
  date?: string;
  keyword?: string;
  service?: string;
  priorite?: number;
}