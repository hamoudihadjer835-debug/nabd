<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->restrictOnDelete();
            $table->string('status', 30)->default('pending_confirmation');
            $table->json('shipping_address');
            $table->string('delivery_method', 30);
            $table->string('payment_method', 30)->nullable();
            $table->unsignedInteger('subtotal');
            $table->unsignedInteger('delivery_fee');
            $table->unsignedInteger('total');
            $table->timestamps();

            $table->index(['user_id', 'created_at']);
            $table->index('status');
        });

        if (in_array(DB::getDriverName(), ['mysql', 'mariadb'])) {
            DB::statement('ALTER TABLE orders AUTO_INCREMENT = 10486');
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
