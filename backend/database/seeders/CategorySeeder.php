<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Seeder;

class CategorySeeder extends Seeder
{
    public function run(): void
    {
        $now = now();

        $rows = array_map(
            fn (array $row) => $row + ['created_at' => $now, 'updated_at' => $now],
            [
                [
                    'id' => 1,
                    'name_ar' => 'أجهزة القياس',
                    'name_fr' => 'Appareils de mesure',
                    'name_en' => 'Measuring devices',
                    'icon' => 'monitor_heart_outlined',
                ],
                [
                    'id' => 2,
                    'name_ar' => 'معدات الفحص',
                    'name_fr' => 'Matériel d’examen',
                    'name_en' => 'Examination equipment',
                    'icon' => 'medical_services_outlined',
                ],
                [
                    'id' => 3,
                    'name_ar' => 'العناية بالجروح',
                    'name_fr' => 'Soins des plaies',
                    'name_en' => 'Wound care',
                    'icon' => 'healing_outlined',
                ],
                [
                    'id' => 4,
                    'name_ar' => 'المستلزمات الطبية',
                    'name_fr' => 'Fournitures médicales',
                    'name_en' => 'Medical supplies',
                    'icon' => 'inventory_2_outlined',
                ],
            ]
        );

        Category::upsert($rows, ['id'], ['name_ar', 'name_fr', 'name_en', 'icon', 'updated_at']);
    }
}
