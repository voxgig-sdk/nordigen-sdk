<?php
declare(strict_types=1);

// Typed models for the Nordigen SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Institution entity data model. */
class Institution
{
    public ?string $bic = null;
    public ?array $countries = null;
    public ?string $id = null;
    public ?string $logo = null;
    public ?string $name = null;
    public ?string $transaction_total_days = null;
}

/** Request payload for Institution#load. */
class InstitutionLoadMatch
{
    public string $id;
}

/** Request payload for Institution#list. */
class InstitutionListMatch
{
    public ?string $bic = null;
    public ?array $countries = null;
    public ?string $id = null;
    public ?string $logo = null;
    public ?string $name = null;
    public ?string $transaction_total_days = null;
}

