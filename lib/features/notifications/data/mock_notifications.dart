import '../../../core/models/localized_text.dart';
import '../models/app_notification.dart';

/// بيانات تجريبية من ملف المواصفات. نبدلوها ببيانات الـ Backend لاحقا.
/// \u2066 ... \u2069: علامتا اتجاه تحفظان ترتيب رقم الطلب داخل النص العربي.
const List<AppNotification> mockNotifications = [
  AppNotification(
    id: 'n1',
    type: NotificationType.shipped,
    title: LocalizedText(
      ar: 'تم شحن طلبك',
      en: 'Your order has shipped',
      fr: 'Votre commande a été expédiée',
    ),
    body: LocalizedText(
      ar: 'طلبك \u2066#NBD-10482\u2069 في الطريق إليك',
      en: 'Your order #NBD-10482 is on its way',
      fr: 'Votre commande #NBD-10482 est en route',
    ),
    timeLabel: LocalizedText(
      ar: 'منذ ساعة',
      en: '1 hour ago',
      fr: 'Il y a 1 heure',
    ),
  ),
  AppNotification(
    id: 'n2',
    type: NotificationType.preparing,
    title: LocalizedText(
      ar: 'قيد التحضير',
      en: 'Preparing your order',
      fr: 'Commande en préparation',
    ),
    body: LocalizedText(
      ar: 'طلبك \u2066#NBD-10483\u2069 قيد التحضير',
      en: 'Your order #NBD-10483 is being prepared',
      fr: 'Votre commande #NBD-10483 est en cours de préparation',
    ),
    timeLabel: LocalizedText(
      ar: 'منذ 3 ساعات',
      en: '3 hours ago',
      fr: 'Il y a 3 heures',
    ),
  ),
  AppNotification(
    id: 'n3',
    type: NotificationType.confirmed,
    isRead: true,
    title: LocalizedText(
      ar: 'تم تأكيد طلبك',
      en: 'Order confirmed',
      fr: 'Commande confirmée',
    ),
    body: LocalizedText(
      ar: 'طلبك \u2066#NBD-10485\u2069 تم تأكيده',
      en: 'Your order #NBD-10485 has been confirmed',
      fr: 'Votre commande #NBD-10485 a été confirmée',
    ),
    timeLabel: LocalizedText(ar: 'أمس', en: 'Yesterday', fr: 'Hier'),
  ),
  AppNotification(
    id: 'n4',
    type: NotificationType.backInStock,
    isRead: true,
    title: LocalizedText(
      ar: 'عاد للمخزون',
      en: 'Back in stock',
      fr: 'De retour en stock',
    ),
    body: LocalizedText(
      ar: 'جهاز قياس ضغط الدم الرقمي متوفر الآن',
      en: 'Digital blood pressure monitor is available again',
      fr: 'Le tensiomètre numérique est de nouveau disponible',
    ),
    timeLabel: LocalizedText(ar: 'أمس', en: 'Yesterday', fr: 'Hier'),
  ),
  AppNotification(
    id: 'n5',
    type: NotificationType.addressSaved,
    isRead: true,
    title: LocalizedText(
      ar: 'تم حفظ عنوانك',
      en: 'Address saved',
      fr: 'Adresse enregistrée',
    ),
    body: LocalizedText(
      ar: 'أُضيف العنوان «المنزل»',
      en: 'The address “Home” was added',
      fr: 'L’adresse « Domicile » a été ajoutée',
    ),
    timeLabel: LocalizedText(
      ar: 'قبل يومين',
      en: '2 days ago',
      fr: 'Il y a 2 jours',
    ),
  ),
  AppNotification(
    id: 'n6',
    type: NotificationType.welcome,
    isRead: true,
    title: LocalizedText(
      ar: 'مرحبًا بك في نبض',
      en: 'Welcome to Nabd',
      fr: 'Bienvenue sur Nabd',
    ),
    body: LocalizedText(
      ar: 'ابدأ بتصفح المنتجات الطبية',
      en: 'Start browsing medical supplies',
      fr: 'Commencez à parcourir les fournitures médicales',
    ),
    timeLabel: LocalizedText(
      ar: 'قبل 3 أيام',
      en: '3 days ago',
      fr: 'Il y a 3 jours',
    ),
  ),
];