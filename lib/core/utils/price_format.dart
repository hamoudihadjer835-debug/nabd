import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../localization/l10n_extension.dart';

/// يكتب السعر بالشكل: 4,500 دج (الأرقام بالإنجليزية دايما، كما في Figma).
String formatPrice(BuildContext context, int value) {
  return '${NumberFormat.decimalPattern('en').format(value)} ${context.l10n.currency}';
}