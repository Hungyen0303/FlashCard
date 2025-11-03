// lib/utils/icon_mapper.dart
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class IconMapper {
  // Bắt đầu từ 10000 → tránh trùng với codePoint gốc
  static const int _base = 10000;

  // Map: mã tùy chỉnh → IconData (const)
  static const Map<int, IconData> _codeToIcon = {
    _base + 0: Icons.book,
    _base + 1: Icons.book_outlined,
    _base + 2: Icons.menu_book,
    _base + 3: Icons.auto_stories,
    _base + 4: Icons.library_books,
    _base + 5: Icons.import_contacts,
    _base + 6: Icons.chrome_reader_mode,
    _base + 7: Icons.edit,
    _base + 8: Icons.create,
    _base + 9: Icons.draw,
    _base + 10: Icons.border_color,
    _base + 11: Icons.note_alt,
    _base + 12: Icons.sticky_note_2,
    _base + 13: Icons.abc,
    _base + 14: Icons.spellcheck,
    _base + 15: Icons.translate,
    _base + 16: Icons.language,
    _base + 17: Icons.record_voice_over,
    _base + 18: Icons.mic,
    _base + 19: Icons.volume_up,
    _base + 20: Icons.school,
    _base + 21: LineIcons.gripLines,
    _base + 22: LineIcons.graduationCap,
    _base + 23: Icons.class_,
    _base + 24: Icons.people,
    _base + 25: Icons.group,
    _base + 26: Icons.diversity_3,
    _base + 27: Icons.dashboard,
    _base + 28: Icons.table_chart,
    _base + 29: Icons.format_list_bulleted,
    _base + 30: Icons.checklist,
    _base + 31: Icons.task_alt,
    _base + 32: Icons.lightbulb,
    _base + 33: Icons.lightbulb_outline,
    _base + 34: Icons.psychology,
    _base + 35: Icons.insights,
    _base + 36: Icons.trending_up,
    _base + 37: Icons.bar_chart,
    _base + 38: Icons.laptop,
    _base + 39: Icons.computer,
    _base + 40: Icons.tablet_mac,
    _base + 41: Icons.smartphone,
    _base + 42: Icons.wifi,
    _base + 43: Icons.cloud,
    _base + 44: Icons.cast_for_education,
    _base + 45: Icons.credit_card,
    _base + 46: Icons.style,
    _base + 47: Icons.flip_to_front,
    _base + 48: Icons.quiz,
    _base + 49: Icons.check_circle,
    _base + 50: Icons.star,
    _base + 51: Icons.star_border,
    _base + 52: Icons.star_half,
    _base + 53: LineIcons.star,
    _base + 54: Icons.schedule,
    _base + 55: Icons.access_time,
    _base + 56: Icons.timer,
    _base + 57: Icons.alarm,
    _base + 58: LineIcons.book,
    _base + 59: LineIcons.chalkboardTeacher,
    _base + 60: LineIcons.microphone,
    _base + 61: LineIcons.headphones,
    _base + 62: LineIcons.globe,
    _base + 63: LineIcons.flag,
    _base + 64: LineIcons.commentDots,
    _base + 65: LineIcons.search,
    _base + 66: LineIcons.filter,
  };

  static IconData fromCode(int code) {
    return _codeToIcon[code] ?? Icons.help_outline;
  }

  static int toCode(IconData iconData) {
    return _codeToIcon.entries
            .firstWhere(
              (entry) => entry.value == iconData,
              orElse: () => const MapEntry(-1, Icons.help_outline),
            )
            .key ??
        -1;
  }

  /// Danh sách tất cả mã (dùng để random hoặc chọn)
  static List<int> get allCodes => _codeToIcon.keys.toList();

  static List<IconData> get educationIcons => _codeToIcon.values.toList();
}
