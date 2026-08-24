<?php
declare(strict_types=1);

// Nordigen SDK utility: prepare_body

class NordigenPrepareBody
{
    public static function call(NordigenContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
