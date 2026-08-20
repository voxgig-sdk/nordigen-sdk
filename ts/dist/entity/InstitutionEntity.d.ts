import { NordigenEntityBase } from '../NordigenEntityBase';
import type { NordigenSDK } from '../NordigenSDK';
import type { Control } from '../types';
import type { Institution, InstitutionLoadMatch, InstitutionListMatch } from '../NordigenTypes';
declare class InstitutionEntity extends NordigenEntityBase<Institution> {
    constructor(client: NordigenSDK, entopts: any);
    make(this: InstitutionEntity): InstitutionEntity;
    load(this: any, reqmatch?: InstitutionLoadMatch, ctrl?: Control): Promise<InstitutionEntity>;
    list(this: any, reqmatch?: InstitutionListMatch, ctrl?: Control): Promise<InstitutionEntity[]>;
}
export { InstitutionEntity };
