import 'package:flutter/material.dart';

enum JobCategory {
  harvest('Harvest', Icons.agriculture),
  hospitality('Hospitality', Icons.restaurant),
  winter('Ski & winter', Icons.downhill_skiing),
  campsite('Campsites', Icons.holiday_village),
  farm('Farm & animals', Icons.pets),
  events('Events', Icons.festival),
  seafood('Fishing', Icons.set_meal);

  const JobCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}

enum Country {
  austria('Austria', '🇦🇹'),
  croatia('Croatia', '🇭🇷'),
  denmark('Denmark', '🇩🇰'),
  france('France', '🇫🇷'),
  germany('Germany', '🇩🇪'),
  greece('Greece', '🇬🇷'),
  italy('Italy', '🇮🇹'),
  netherlands('Netherlands', '🇳🇱'),
  norway('Norway', '🇳🇴'),
  portugal('Portugal', '🇵🇹'),
  spain('Spain', '🇪🇸'),
  switzerland('Switzerland', '🇨🇭'),
  uk('United Kingdom', '🇬🇧');

  const Country(this.label, this.flag);

  final String label;
  final String flag;

  /// Short, non-binding summary of who may take a seasonal job here.
  String get workRights => switch (this) {
    Country.norway =>
      'Norway is in the EEA: EU/EEA citizens can work here freely '
          '(register with the police if you stay longer than 3 months). '
          'Other nationalities need a seasonal work permit.',
    Country.switzerland =>
      'EU/EFTA citizens can work up to 3 months per year with an online '
          'notification filed by the employer; longer contracts need an '
          'L permit. Other nationalities need a work visa.',
    Country.uk =>
      'Since Brexit only UK and Irish citizens, or people with settled '
          'status, can work freely. Everyone else needs a visa, for example '
          'the Seasonal Worker visa.',
    _ =>
      'EU, EEA and Swiss citizens can work in $label without a permit. '
          'Other nationalities need a work visa before starting.',
  };
}

enum Housing {
  none('No housing provided'),
  free('Housing included'),
  paid('Housing available (paid)');

  const Housing(this.label);

  final String label;
}

enum PayUnit {
  hour('hour'),
  day('day'),
  month('month');

  const PayUnit(this.label);

  final String label;
}

class Pay {
  const Pay(this.amount, this.unit, {this.currency = '€', this.note});

  final double amount;
  final PayUnit unit;

  /// A symbol ('€', '£') or an ISO code ('CHF', 'NOK').
  final String currency;

  /// Qualifier such as 'net' or 'typical piece-rate earnings'.
  final String? note;

  String get label {
    final number = _formatAmount(amount);
    final money = currency.length == 1
        ? '$currency$number'
        : '$currency $number';
    return '$money / ${unit.label}';
  }

  static String _formatAmount(double value) {
    final isWhole = value == value.roundToDouble();
    final parts =
        (isWhole ? value.toStringAsFixed(0) : value.toStringAsFixed(2)).split(
          '.',
        );
    final digits = parts.first;
    final grouped = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) grouped.write(',');
      grouped.write(digits[i]);
    }
    return parts.length > 1 ? '$grouped.${parts[1]}' : grouped.toString();
  }
}

class Job {
  const Job({
    required this.id,
    required this.title,
    required this.employer,
    required this.place,
    required this.country,
    required this.category,
    required this.start,
    required this.end,
    required this.pay,
    required this.hoursPerWeek,
    required this.description,
    required this.tasks,
    required this.languages,
    required this.contactEmail,
    this.seasonId,
    this.housing = Housing.none,
    this.vanPitch = false,
    this.hookup = false,
    this.stayNote,
    this.englishOk = false,
    this.perks = const [],
  });

  final String id;
  final String title;
  final String employer;

  /// Town and region, without the country.
  final String place;
  final Country country;
  final JobCategory category;

  /// Links the job to an entry in the season calendar.
  final String? seasonId;

  final DateTime start;
  final DateTime end;
  final Pay pay;
  final int hoursPerWeek;

  final Housing housing;

  /// Whether you can live in your own van on or next to the workplace.
  final bool vanPitch;

  /// Electric hookup at the van pitch.
  final bool hookup;
  final String? stayNote;

  /// True when English alone is enough to do the job.
  final bool englishOk;
  final List<String> languages;

  final String description;
  final List<String> tasks;
  final List<String> perks;
  final String contactEmail;

  /// Calendar months (1-12) during which the job runs.
  Set<int> get activeMonths {
    final months = <int>{};
    var cursor = DateTime(start.year, start.month);
    while (!cursor.isAfter(end)) {
      months.add(cursor.month);
      cursor = DateTime(cursor.year, cursor.month + 1);
    }
    return months;
  }

  String get location => '$place, ${country.label}';
}
