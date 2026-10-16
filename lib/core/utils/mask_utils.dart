/// يخفي جزءا من البريد أو الهاتف: a•••@gmail.com أو 055••••••
String maskIdentifier(String value) {
  final v = value.trim();

  if (v.contains('@')) {
    final parts = v.split('@');
    final name = parts.first;
    final first = name.isEmpty ? '' : name[0];
    return '$first•••@${parts.sublist(1).join('@')}';
  }

  // هاتف: نظهرو أول 3 رموز ونخفيو الباقي
  if (v.length <= 3) return v;
  return '${v.substring(0, 3)}${'•' * (v.length - 3)}';
}