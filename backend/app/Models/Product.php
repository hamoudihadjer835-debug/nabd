<?php

namespace App\Models;

use App\Models\Concerns\HasLocalized;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Product extends Model
{
    use HasLocalized;

    public const LOW_STOCK_THRESHOLD = 5;

    protected $fillable = [
        'category_id',
        'name_ar',
        'name_fr',
        'name_en',
        'sku',
        'price',
        'stock_quantity',
        'manufacturer',
        'intended_use_ar',
        'intended_use_fr',
        'intended_use_en',
        'certificate_number',
        'is_active',
    ];

    protected function casts(): array
    {
        return [
            'price' => 'integer',
            'stock_quantity' => 'integer',
            'is_active' => 'boolean',
        ];
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    public function images(): HasMany
    {
        return $this->hasMany(ProductImage::class)->orderBy('sort_order');
    }

    public function scopeActive(Builder $query): Builder
    {
        return $query->where('is_active', true);
    }

    protected function stockStatus(): Attribute
    {
        return Attribute::get(function (): string {
            if ($this->stock_quantity <= 0) {
                return 'outOfStock';
            }

            if ($this->stock_quantity <= self::LOW_STOCK_THRESHOLD) {
                return 'limited';
            }

            return 'available';
        });
    }
}
