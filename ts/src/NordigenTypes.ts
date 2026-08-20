// Typed models for the Nordigen SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Institution {
  bic?: string
  countries?: any[]
  id?: string
  logo?: string
  name?: string
  transaction_total_days?: string
}

export interface InstitutionLoadMatch {
  id: string
}

export interface InstitutionListMatch {
  bic?: string
  countries?: any[]
  id?: string
  logo?: string
  name?: string
  transaction_total_days?: string
}

