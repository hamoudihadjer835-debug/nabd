/// اسم اللغة بلغتها الأصلية (هكذا يكتب في كل التطبيقات، باش كل واحد يلقى لغتو).
String nativeLanguageName(String languageCode) {
  switch (languageCode) {
    case 'ar':
      return 'العربية';
    case 'fr':
      return 'Français';
    default:
      return 'English';
  }
}