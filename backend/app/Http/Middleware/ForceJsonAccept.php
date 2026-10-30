<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class ForceJsonAccept
{
    public function handle(Request $request, Closure $next): Response
    {
        // Every API route answers JSON, even when the client forgets the Accept header.
        if ($request->is('api/*')) {
            $request->headers->set('Accept', 'application/json');
        }

        return $next($request);
    }
}
