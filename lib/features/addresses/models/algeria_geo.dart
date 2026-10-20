import '../../../core/models/localized_text.dart';

/// بلدية.
class Commune {
  const Commune({required this.id, required this.name});

  final String id;
  final LocalizedText name;
}

/// ولاية وبلدياتها.
class Wilaya {
  const Wilaya({
    required this.id,
    required this.name,
    required this.communes,
  });

  final String id;
  final LocalizedText name;
  final List<Commune> communes;
}