<?php

namespace App\Models;

use App\Models\Concerns\HasLocalized;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class OrderItem extends Model
{
    use HasLocalized;

    // Snapshot of the product at purchase time, set only by the server.
    protected $fillable = [];

    protected function casts(): array
    {
        return [
            'unit_price' => 'integer',
            'quantity' => 'integer',
        ];
    }

    public function order(): BelongsTo
    {
        return $this->belongsTo(Order::class);
    }

    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class);
    }

    protected function lineTotal(): Attribute
    {
        return Attribute::get(fn (): int => $this->unit_price * $this->quantity);
    }
}
