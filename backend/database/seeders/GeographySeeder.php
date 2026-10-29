<?php

namespace Database\Seeders;

use App\Models\Commune;
use App\Models\Wilaya;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class GeographySeeder extends Seeder
{
    public function run(): void
    {
        $path = database_path('data/algeria_geo.json');
        $data = json_decode(file_get_contents($path), true, 512, JSON_THROW_ON_ERROR);
        $now = now();

        DB::transaction(function () use ($data, $now) {
            $wilayaRows = [];
            foreach ($data['wilayas'] as $wilaya) {
                $wilayaRows[] = [
                    'source_id' => $wilaya['id'],
                    'name_ar' => $this->clean($wilaya['ar']),
                    'name_fr' => $this->clean($wilaya['fr']),
                    'created_at' => $now,
                    'updated_at' => $now,
                ];
            }

            Wilaya::upsert($wilayaRows, ['source_id'], ['name_ar', 'name_fr', 'updated_at']);

            $wilayaIds = Wilaya::pluck('id', 'source_id');

            $communeRows = [];
            foreach ($data['wilayas'] as $wilaya) {
                foreach ($wilaya['communes'] as $commune) {
                    $communeRows[] = [
                        'wilaya_id' => $wilayaIds[$wilaya['id']],
                        'source_id' => $commune['id'],
                        'name_ar' => $this->clean($commune['ar']),
                        'name_fr' => $this->clean($commune['fr']),
                        'created_at' => $now,
                        'updated_at' => $now,
                    ];
                }
            }

            foreach (array_chunk($communeRows, 500) as $chunk) {
                Commune::upsert($chunk, ['source_id'], ['wilaya_id', 'name_ar', 'name_fr', 'updated_at']);
            }
        });
    }

    private function clean(string $value): string
    {
        $value = str_replace("\u{0640}", '', $value);
        $value = preg_replace('/\s+/u', ' ', $value);

        return trim($value);
    }
}
