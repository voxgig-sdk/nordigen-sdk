-- Typed models for the Nordigen SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Institution
---@field bic? string
---@field countries? table
---@field id? string
---@field logo? string
---@field name? string
---@field transaction_total_days? string

---@class InstitutionLoadMatch
---@field id string

---@class InstitutionListMatch
---@field bic? string
---@field countries? table
---@field id? string
---@field logo? string
---@field name? string
---@field transaction_total_days? string

local M = {}

return M
