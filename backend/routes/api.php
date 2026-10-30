<?php

use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/test', function () {
    return response()->json([
        'success' => true,
        'message' => 'Nabd API is working!',
    ]);
});

Route::get('/products', function () {
    return response()->json(['data' => Product::all()]);
});

// Temporary routes used only to exercise the error format.
Route::get('/me', fn (Request $request) => $request->user())->middleware('auth:sanctum');

Route::post('/test-validation', function (Request $request) {
    $request->validate(['email' => ['required', 'email']]);

    return response()->json(['data' => ['ok' => true]]);
});

Route::get('/test-error', fn () => throw new RuntimeException('boom'));
