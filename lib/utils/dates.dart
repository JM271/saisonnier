const monthsShort = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

const monthsLong = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

/// '5 Dec 2026 – 25 Apr 2027', or '6 Sep – 20 Sep 2027' within one year.
String formatDateRange(DateTime start, DateTime end) {
  final from = '${start.day} ${monthsShort[start.month - 1]}';
  final to = '${end.day} ${monthsShort[end.month - 1]} ${end.year}';
  return start.year == end.year ? '$from – $to' : '$from ${start.year} – $to';
}

/// Rough human duration: '12 days', '6 weeks', '5 months'.
String formatDuration(DateTime start, DateTime end) {
  final days = end.difference(start).inDays + 1;
  if (days < 14) return '$days days';
  final weeks = (days / 7).round();
  if (weeks <= 12) return '$weeks weeks';
  return '${(days / 30.4).round()} months';
}
