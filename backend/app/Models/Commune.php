<?php

namespace App\Models;

use App\Models\Concerns\HasLocalized;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Commune extends Model
{
    use HasLocalized;

    protected $fillable = [
        'wilaya_id',
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

    public function wilaya(): BelongsTo
    {
        return $this->belongsTo(Wilaya::class);
    }
}
