import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';

/// اختصار: context.l10n.loginTitle
extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}