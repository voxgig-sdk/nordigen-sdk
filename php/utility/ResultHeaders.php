<?php
declare(strict_types=1);

// Nordigen SDK utility: result_headers

class NordigenResultHeaders
{
    public static function call(NordigenContext $ctx): ?NordigenResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
