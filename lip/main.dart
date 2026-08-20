import 'dart:convert';

class EventItem {
  final String id;
  final String title;
  final DateTime date;
  final bool isFavorite;
  final bool isPinned; // خاصية التثبيت الجديدة
  final bool isAnnualRepeat;
  final int notificationMinutes;

  EventItem({
    required this.id,
    required this.title,
    required this.date,
    this.isFavorite = false,
    this.isPinned = false, // القيمة الافتراضية غير مثبت
    this.isAnnualRepeat = false,
    this.notificationMinutes = 0,
  });

  EventItem copyWith({
    String? title,
    DateTime? date,
    bool? isFavorite,
    bool? isPinned,
    bool? isAnnualRepeat,
    int? notificationMinutes,
  }) {
    return EventItem(
      id: id,
      title: title ?? this.title,
      date: date ?? this.date,
      isFavorite: isFavorite ?? this.isFavorite,
      isPinned: isPinned ?? this.isPinned,
      isAnnualRepeat: isAnnualRepeat ?? this.isAnnualRepeat,
      notificationMinutes: notificationMinutes ?? this.notificationMinutes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'isFavorite': isFavorite ? 1 : 0,
      'isPinned': isPinned ? 1 : 0, // حفظ التثبيت في الذاكرة
      'isAnnualRepeat': isAnnualRepeat ? 1 : 0,
      'notificationMinutes': notificationMinutes,
    };
  }

  factory EventItem.fromMap(Map<String, dynamic> map) {
    return EventItem(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      isFavorite: map['isFavorite'] == 1,
      isPinned: map['isPinned'] == 1, // قراءة حالة التثبيت
      isAnnualRepeat: map['isAnnualRepeat'] == 1,
      notificationMinutes: map['notificationMinutes'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());
  factory EventItem.fromJson(String source) => EventItem.fromMap(json.decode(source));
}
