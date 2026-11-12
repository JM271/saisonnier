import 'package:flutter/material.dart';

/// A recurring window of seasonal work somewhere in Europe.
class Season {
  const Season({
    required this.id,
    required this.title,
    required this.regions,
    required this.blurb,
    required this.icon,
    required this.months,
  });

  final String id;
  final String title;
  final String regions;
  final String blurb;
  final IconData icon;

  /// Calendar months (1-12) in which the work typically happens.
  final Set<int> months;
}

const seasons = <Season>[
  Season(
    id: 'ski',
    title: 'Ski season',
    regions: 'Alps, Pyrenees, Scandinavia',
    blurb:
        'Lifts, rental shops, hotels and chalets hire for the whole winter. '
        'Most contracts are signed by October, but resorts refill gaps all '
        'season.',
    icon: Icons.downhill_skiing,
    months: {12, 1, 2, 3, 4},
  ),
  Season(
    id: 'olives',
    title: 'Olive harvest',
    regions: 'Andalusia, Puglia, Crete, Alentejo',
    blurb:
        'Mild winter work in the south. Crews net, rake and haul olives to '
        'the mill; small family groves often take helpers at short notice.',
    icon: Icons.eco_outlined,
    months: {10, 11, 12, 1},
  ),
  Season(
    id: 'citrus',
    title: 'Citrus harvest',
    regions: 'Valencia, Sicily, Algarve',
    blurb:
        'Oranges, mandarins and lemons are picked through the winter. Paid '
        'by the day or by the crate, with early starts and free afternoons.',
    icon: Icons.wb_sunny_outlined,
    months: {11, 12, 1, 2, 3, 4},
  ),
  Season(
    id: 'xmas',
    title: 'Christmas markets & trees',
    regions: 'Germany, Austria, Alsace, Denmark',
    blurb:
        'Four to six intense weeks: market stalls need sellers, and tree '
        'farms need people to cut, net and load.',
    icon: Icons.park_outlined,
    months: {11, 12},
  ),
  Season(
    id: 'skrei',
    title: 'Skrei cod season',
    regions: 'Lofoten and Northern Norway',
    blurb:
        'When the Arctic cod arrive, fish plants run long shifts. Cold, wet '
        'and well paid, with overtime on top.',
    icon: Icons.set_meal_outlined,
    months: {1, 2, 3, 4},
  ),
  Season(
    id: 'lambing',
    title: 'Lambing',
    regions: 'Wales, Scotland, Ireland',
    blurb:
        'Sheep farms take extra hands for a few weeks of round-the-clock '
        'care in the lambing sheds. Some livestock experience helps.',
    icon: Icons.pets_outlined,
    months: {3, 4},
  ),
  Season(
    id: 'asparagus',
    title: 'Asparagus',
    regions: 'Germany, Netherlands',
    blurb:
        'Cutting starts in April and traditionally ends on 24 June. '
        'Physical, early-morning field work with large international crews.',
    icon: Icons.grass,
    months: {4, 5, 6},
  ),
  Season(
    id: 'softfruit',
    title: 'Strawberries & soft fruit',
    regions: 'Denmark, Sweden, UK, Germany',
    blurb:
        'Strawberries first, then raspberries and blueberries. Usually paid '
        'by the kilo, and many farms run their own campsite for pickers.',
    icon: Icons.spa_outlined,
    months: {5, 6, 7, 8},
  ),
  Season(
    id: 'campsites',
    title: 'Campsites & summer coast',
    regions: 'France, Croatia, Italy, Spain, Portugal, Greece',
    blurb:
        'Reception, cleaning, maintenance, bars and kids clubs. Long '
        'contracts, often with a free pitch for your own van.',
    icon: Icons.holiday_village_outlined,
    months: {4, 5, 6, 7, 8, 9, 10},
  ),
  Season(
    id: 'alp',
    title: 'Alpine huts & mountain farms',
    regions: 'Switzerland, Austria, South Tyrol',
    blurb:
        'A summer on the Alp: serving hikers in mountain huts, or herding '
        'and milking on high pastures. Remote, simple and unforgettable.',
    icon: Icons.landscape_outlined,
    months: {6, 7, 8, 9},
  ),
  Season(
    id: 'festivals',
    title: 'Festivals',
    regions: 'All over Europe',
    blurb:
        'Site build, bars, stewarding and tear-down. Crews move from '
        'festival to festival, which suits life on wheels.',
    icon: Icons.festival_outlined,
    months: {6, 7, 8},
  ),
  Season(
    id: 'bulbs',
    title: 'Flower bulbs',
    regions: 'Netherlands',
    blurb:
        'After the tulip fields are lifted, sheds need people to peel, sort '
        'and pack bulbs. Indoor work with steady hours.',
    icon: Icons.local_florist_outlined,
    months: {6, 7, 8, 9},
  ),
  Season(
    id: 'hops',
    title: 'Hop harvest',
    regions: 'Hallertau, Bavaria',
    blurb:
        'Three to four weeks of long days bringing in the hop bines. Farms '
        'look for tractor drivers and people at the picking machine.',
    icon: Icons.sports_bar_outlined,
    months: {8, 9},
  ),
  Season(
    id: 'apples',
    title: 'Apples & pears',
    regions: 'South Tyrol, Lake Constance, Normandy, Kent',
    blurb:
        'Ladder and bin work from the early varieties in August to the late '
        'ones in October. Family farms often give you a room or a pitch.',
    icon: Icons.nature_outlined,
    months: {8, 9, 10},
  ),
  Season(
    id: 'grapes',
    title: 'Grape harvest',
    regions: 'France, Germany, Italy, Switzerland, Spain, Portugal',
    blurb:
        'The classic. One to six weeks of picking and carrying, usually '
        'with shared meals and a party at the end.',
    icon: Icons.wine_bar_outlined,
    months: {8, 9, 10},
  ),
];
