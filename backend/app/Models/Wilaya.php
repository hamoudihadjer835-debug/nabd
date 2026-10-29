<?php

namespace App\Models;

use App\Models\Concerns\HasLocalized;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Wilaya extends Model
{
    use HasLocalized;

    protected $fillable = [
        'source_id',
        'name_ar',
        'name_fr',
        'yalidine_id',
    ];

    protected function casts(): array
    {
        return [
            'yalidine_id' => 'integer',
        ];
    }

    public function communes(): HasMany
    {
        return $this->hasMany(Commune::class);
    }
}
