<?php

namespace App\Models;

use App\Models\Concerns\HasLocalized;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Category extends Model
{
    use HasLocalized;

    protected $fillable = [
        'name_ar',
        'name_fr',
        'name_en',
        'icon',
    ];

    public function products(): HasMany
    {
        return $this->hasMany(Product::class);
    }
}
