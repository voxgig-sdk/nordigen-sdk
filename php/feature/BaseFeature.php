<?php
declare(strict_types=1);

// Nordigen SDK base feature

class NordigenBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    // Positions this feature when added via the client `extend` option:
    // "__before__" / "__after__" / "__replace__" name an already-added
    // feature (mirrors the ts feature `_options`). Declared so setting it
    // on an extension instance avoids the dynamic-property deprecation.
    public ?array $_options = null;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(NordigenContext $ctx, array $options): void {}
    public function PostConstruct(NordigenContext $ctx): void {}
    public function PostConstructEntity(NordigenContext $ctx): void {}
    public function SetData(NordigenContext $ctx): void {}
    public function GetData(NordigenContext $ctx): void {}
    public function GetMatch(NordigenContext $ctx): void {}
    public function SetMatch(NordigenContext $ctx): void {}
    public function PrePoint(NordigenContext $ctx): void {}
    public function PreSpec(NordigenContext $ctx): void {}
    public function PreRequest(NordigenContext $ctx): void {}
    public function PreResponse(NordigenContext $ctx): void {}
    public function PreResult(NordigenContext $ctx): void {}
    public function PreDone(NordigenContext $ctx): void {}
    public function PreUnexpected(NordigenContext $ctx): void {}
}
