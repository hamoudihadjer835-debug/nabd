<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class SetLocale
{
    private const SUPPORTED = ['ar', 'fr', 'en'];

    public function handle(Request $request, Closure $next): Response
    {
        if ($request->is('api/*')) {
            // Falls back to Arabic when Accept-Language is missing or unsupported.
            $locale = $request->getPreferredLanguage(self::SUPPORTED) ?? self::SUPPORTED[0];

            app()->setLocale($locale);
        }

        return $next($request);
    }
}
