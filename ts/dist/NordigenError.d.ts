import { Context } from './Context';
declare class NordigenError extends Error {
    isNordigenError: boolean;
    sdk: string;
    code: string;
    ctx: Context;
    status: number;
    get notFound(): boolean;
    constructor(code: string, msg: string, ctx: Context);
}
export { NordigenError };
