<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Seeder;

/**
 * Sample products for development only (SKU prefixed with DEMO-).
 * Manufacturer and certificate are intentionally empty: they must come
 * from verified manufacturer data before launch.
 */
class DemoProductSeeder extends Seeder
{
    public function run(): void
    {
        $now = now();

        $rows = array_map(
            fn (array $row) => $row + [
                'manufacturer' => null,
                'certificate_number' => null,
                'is_active' => true,
                'created_at' => $now,
                'updated_at' => $now,
            ],
            [
                [
                    'category_id' => 1,
                    'name_ar' => 'جهاز قياس ضغط الدم الرقمي',
                    'name_fr' => 'Tensiomètre numérique',
                    'name_en' => 'Digital blood pressure monitor',
                    'sku' => 'DEMO-NBD-0001',
                    'price' => 4500,
                    'stock_quantity' => 12,
                    'intended_use_ar' => 'قياس ضغط الدم المنزلي',
                    'intended_use_fr' => 'Mesure de la tension artérielle à domicile',
                    'intended_use_en' => 'Home blood pressure measurement',
                ],
                [
                    'category_id' => 1,
                    'name_ar' => 'جهاز قياس ضغط الدم المعصم',
                    'name_fr' => 'Tensiomètre de poignet',
                    'name_en' => 'Wrist blood pressure monitor',
                    'sku' => 'DEMO-NBD-0002',
                    'price' => 3900,
                    'stock_quantity' => 3,
                    'intended_use_ar' => 'قياس ضغط الدم عند المعصم',
                    'intended_use_fr' => 'Mesure de la tension artérielle au poignet',
                    'intended_use_en' => 'Wrist blood pressure measurement',
                ],
                [
                    'category_id' => 1,
                    'name_ar' => 'جهاز قياس ضغط الدم الناطق',
                    'name_fr' => 'Tensiomètre parlant',
                    'name_en' => 'Talking blood pressure monitor',
                    'sku' => 'DEMO-NBD-0003',
                    'price' => 6800,
                    'stock_quantity' => 0,
                    'intended_use_ar' => 'قياس ضغط الدم المنزلي',
                    'intended_use_fr' => 'Mesure de la tension artérielle à domicile',
                    'intended_use_en' => 'Home blood pressure measurement',
                ],
                [
                    'category_id' => 1,
                    'name_ar' => 'جهاز قياس ضغط الدم المنزلي',
                    'name_fr' => 'Tensiomètre domestique',
                    'name_en' => 'Home blood pressure monitor',
                    'sku' => 'DEMO-NBD-0004',
                    'price' => 5200,
                    'stock_quantity' => 20,
                    'intended_use_ar' => 'قياس ضغط الدم المنزلي',
                    'intended_use_fr' => 'Mesure de la tension artérielle à domicile',
                    'intended_use_en' => 'Home blood pressure measurement',
                ],
            ]
        );

        Product::upsert($rows, ['sku'], [
            'category_id',
            'name_ar',
            'name_fr',
            'name_en',
            'price',
            'stock_quantity',
            'manufacturer',
            'intended_use_ar',
            'intended_use_fr',
            'intended_use_en',
            'certificate_number',
            'is_active',
            'updated_at',
        ]);
    }
}
