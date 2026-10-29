<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call([
            GeographySeeder::class,
            CategorySeeder::class,
        ]);

        // Sample data is never loaded outside the local environment.
        if (app()->environment('local')) {
            $this->call([
                DemoProductSeeder::class,
                DemoUserSeeder::class,
            ]);
        }
    }
}
