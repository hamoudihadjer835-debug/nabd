<?php

namespace App\Exceptions;

use Illuminate\Auth\AuthenticationException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Symfony\Component\HttpKernel\Exception\HttpExceptionInterface;
use Throwable;

class ApiExceptionRenderer
{
    public static function render(Throwable $e, Request $request): ?JsonResponse
    {
        if (! $request->is('api/*')) {
            return null;
        }

        $headers = [];
        $errors = null;

        if ($e instanceof ValidationException) {
            $status = $e->status;
            $code = 'validation_failed';
            $errors = $e->errors();
        } elseif ($e instanceof AuthenticationException) {
            $status = 401;
            $code = 'unauthenticated';
        } elseif ($e instanceof HttpExceptionInterface) {
            $status = $e->getStatusCode();
            $headers = $e->getHeaders();
            $code = match ($status) {
                401 => 'unauthenticated',
                403 => 'forbidden',
                404 => 'not_found',
                405 => 'method_not_allowed',
                429 => 'too_many_requests',
                default => 'http_error',
            };
        } else {
            $status = 500;
            $code = 'server_error';
        }

        $body = [
            'message' => __('api.' . $code),
            'code' => $code,
        ];

        if ($errors !== null) {
            $body['errors'] = $errors;
        }

        // Internal details are exposed only when APP_DEBUG is true (local).
        if ($status >= 500 && config('app.debug')) {
            $body['debug'] = [
                'exception' => $e::class,
                'detail' => $e->getMessage(),
            ];
        }

        return response()->json($body, $status, $headers);
    }
}
