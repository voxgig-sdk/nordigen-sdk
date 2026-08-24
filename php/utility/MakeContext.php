<?php
declare(strict_types=1);

// Nordigen SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class NordigenMakeContext
{
    public static function call(array $ctxmap, ?NordigenContext $basectx): NordigenContext
    {
        return new NordigenContext($ctxmap, $basectx);
    }
}
