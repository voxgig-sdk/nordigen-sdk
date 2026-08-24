<?php
declare(strict_types=1);

// Nordigen SDK utility: result_body

class NordigenResultBody
{
    public static function call(NordigenContext $ctx): ?NordigenResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
