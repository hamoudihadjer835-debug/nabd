import 'package:flutter/material.dart';

import '../../core/localization/l10n_extension.dart';
import '../shop/models/product.dart';
import 'cart_controller.dart';

/// يضيف منتجا للسلة ويعرض رسالة قصيرة بالنتيجة.
void addToCart(BuildContext context, Product product) {
  final l10n = context.l10n;

  final String message;
  if (product.status == ProductStatus.outOfStock) {
    message = l10n.statusOutOfStock;
  } else if (cartController.add(product)) {
    message = l10n.addedToCart;
  } else {
    message = l10n.maxQuantityReached;
  }

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}