<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->foreignId('category_id')->constrained()->restrictOnDelete();
            $table->string('name_ar');
            $table->string('name_fr')->nullable();
            $table->string('name_en')->nullable();
            $table->string('sku', 64)->unique();
            $table->unsignedInteger('price');
            $table->unsignedInteger('stock_quantity')->default(0);
            $table->string('manufacturer')->nullable();
            $table->text('intended_use_ar')->nullable();
            $table->text('intended_use_fr')->nullable();
            $table->text('intended_use_en')->nullable();
            $table->string('certificate_number', 100)->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });
    
    }

    public function down(): void
    {
        Schema::dropIfExists('products');
    }
};
