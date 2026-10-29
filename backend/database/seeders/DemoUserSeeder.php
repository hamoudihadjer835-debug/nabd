<?php

namespace Database\Seeders;

use App\Models\Commune;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\OrderStatusHistory;
use App\Models\Product;
use App\Models\User;
use App\Models\UserNotification;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

/**
 * Local development only: one demo user with related sample data.
 * The password below is public on purpose and must never exist in production.
 */
class DemoUserSeeder extends Seeder
{
    public function run(): void
    {
        DB::transaction(function () {
            $user = User::firstOrCreate(
                ['email' => 'demo@nabd.test'],
                [
                    'full_name' => 'مستخدم تجريبي',
                    'phone' => '0555000001',
                    'password' => 'Demo1234',
                    'locale' => 'ar',
                ]
            );

            if (! $user->wasRecentlyCreated) {
                return;
            }

            $algiers = Commune::with('wilaya')->where('source_id', 'c514')->firstOrFail();
            $annaba = Commune::with('wilaya')->where('source_id', 'c751')->firstOrFail();

            $home = $user->addresses()->create([
                'label' => 'المنزل',
                'wilaya_id' => $algiers->wilaya_id,
                'commune_id' => $algiers->id,
                'details' => 'عنوان تجريبي للتطوير فقط',
                'phone' => '0555000001',
                'is_default' => true,
            ]);

            $user->addresses()->create([
                'label' => 'العمل',
                'wilaya_id' => $annaba->wilaya_id,
                'commune_id' => $annaba->id,
                'details' => 'عنوان تجريبي ثان للتطوير فقط',
                'phone' => '0555000001',
                'is_default' => false,
            ]);

            $p1 = Product::where('sku', 'DEMO-NBD-0001')->firstOrFail();
            $p2 = Product::where('sku', 'DEMO-NBD-0002')->firstOrFail();
            $p4 = Product::where('sku', 'DEMO-NBD-0004')->firstOrFail();

            $user->favoriteProducts()->attach($p1->id);
            $user->cartItems()->create(['product_id' => $p2->id, 'quantity' => 1]);

            $lines = [[$p1, 1], [$p4, 2]];
            $subtotal = collect($lines)->sum(fn (array $line) => $line[0]->price * $line[1]);
            $deliveryFee = 600;
            $placedAt = now()->subDays(2);

            $order = new Order();
            $order->forceFill([
                'user_id' => $user->id,
                'status' => Order::STATUS_PREPARING,
                'shipping_address' => [
                    'label' => $home->label,
                    'recipient_name' => $user->full_name,
                    'phone' => $home->phone,
                    'wilaya_ar' => $algiers->wilaya->name_ar,
                    'wilaya_fr' => $algiers->wilaya->name_fr,
                    'commune_ar' => $algiers->name_ar,
                    'commune_fr' => $algiers->name_fr,
                    'details' => $home->details,
                ],
                'delivery_method' => 'home',
                'payment_method' => null,
                'subtotal' => $subtotal,
                'delivery_fee' => $deliveryFee,
                'total' => $subtotal + $deliveryFee,
                'created_at' => $placedAt,
                'updated_at' => $placedAt,
            ])->save();

            foreach ($lines as [$product, $quantity]) {
                (new OrderItem())->forceFill([
                    'order_id' => $order->id,
                    'product_id' => $product->id,
                    'product_name_ar' => $product->name_ar,
                    'product_name_fr' => $product->name_fr,
                    'product_name_en' => $product->name_en,
                    'sku' => $product->sku,
                    'unit_price' => $product->price,
                    'quantity' => $quantity,
                ])->save();
            }

            $timeline = [
                [Order::STATUS_PENDING_CONFIRMATION, $placedAt],
                [Order::STATUS_PREPARING, now()->subDay()],
            ];

            foreach ($timeline as [$status, $at]) {
                (new OrderStatusHistory())->forceFill([
                    'order_id' => $order->id,
                    'status' => $status,
                    'created_at' => $at,
                    'updated_at' => $at,
                ])->save();
            }

            (new UserNotification())->forceFill([
                'user_id' => $user->id,
                'type' => 'order_status',
                'title_ar' => 'طلبك قيد التحضير',
                'title_fr' => 'Votre commande est en préparation',
                'title_en' => 'Your order is being prepared',
                'body_ar' => 'نحضّر الآن طلبك ' . $order->number . '.',
                'body_fr' => 'Nous préparons votre commande ' . $order->number . '.',
                'body_en' => 'We are preparing your order ' . $order->number . '.',
            ])->save();
        });
    }
}
