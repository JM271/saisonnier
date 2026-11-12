import '../models/job.dart';

/// Placeholder listings until a real backend exists. Employers and contact
/// addresses are invented; places, seasons and pay levels are realistic.
final sampleJobs = <Job>[
  Job(
    id: 'olives-jaen',
    title: 'Olive harvest crew',
    employer: 'Finca Los Almendros',
    place: 'Úbeda, Andalusia',
    country: Country.spain,
    category: JobCategory.harvest,
    seasonId: 'olives',
    start: DateTime(2026, 11, 16),
    end: DateTime(2027, 1, 15),
    pay: const Pay(64, PayUnit.day),
    hoursPerWeek: 39,
    vanPitch: true,
    stayNote:
        'Park between the olive trees behind the farmhouse. Drinking water '
        'and an outdoor shower, no electricity.',
    englishOk: true,
    languages: ['English or Spanish'],
    description:
        'A family grove of 9,000 trees needs eight extra people for the '
        'harvest. You work in a crew of four with a tree shaker, nets and '
        'rakes. No work on rainy days.',
    tasks: [
      'Spread and gather harvest nets',
      'Rake olives from the lower branches',
      'Load crates onto the trailer',
    ],
    perks: ['Olive oil to take home', 'Sundays off', 'Crew lunch on Fridays'],
    contactEmail: 'cosecha@fincalosalmendros.example',
  ),
  Job(
    id: 'xmas-trees-jutland',
    title: 'Christmas tree harvest',
    employer: 'Hedegaard Juletræer',
    place: 'Silkeborg, Jutland',
    country: Country.denmark,
    category: JobCategory.harvest,
    seasonId: 'xmas',
    start: DateTime(2026, 11, 16),
    end: DateTime(2026, 12, 20),
    pay: const Pay(150, PayUnit.hour, currency: 'DKK'),
    hoursPerWeek: 45,
    vanPitch: true,
    hookup: true,
    stayNote:
        'Gravel yard next to the machine hall with electricity, heated '
        'shower room and a shared kitchen.',
    englishOk: true,
    languages: ['English'],
    description:
        'Five weeks of cutting, netting and palletising Nordmann firs for '
        'export. Outdoor work in all weather; waterproofs and safety boots '
        'are provided.',
    tasks: [
      'Carry and net cut trees',
      'Sort by size and quality label',
      'Stack pallets and load lorries',
    ],
    perks: ['Overtime paid at 150%', 'Work clothing provided'],
    contactEmail: 'job@hedegaard-juletraeer.example',
  ),
  Job(
    id: 'olives-crete',
    title: 'Olive harvest & mill helper',
    employer: 'Kolymvari Growers Cooperative',
    place: 'Kolymvari, Crete',
    country: Country.greece,
    category: JobCategory.harvest,
    seasonId: 'olives',
    start: DateTime(2026, 11, 20),
    end: DateTime(2026, 12, 23),
    pay: const Pay(52, PayUnit.day),
    hoursPerWeek: 40,
    vanPitch: true,
    stayNote:
        'Flat parking by the cooperative mill, five minutes from the beach. '
        'Toilets and water on site.',
    englishOk: true,
    languages: ['English'],
    description:
        'Help small growers bring in their Koroneiki olives, and take '
        'evening shifts receiving sacks at the cooperative mill.',
    tasks: [
      'Harvest with electric combs',
      'Sack and weigh olives',
      'Keep the mill floor clean',
    ],
    perks: ['Lunch in the grove', 'Five litres of new oil'],
    contactEmail: 'harvest@kolymvari-coop.example',
  ),
  Job(
    id: 'xmas-market-nuremberg',
    title: 'Christmas market stall seller',
    employer: 'Lebkuchen Hofmann',
    place: 'Nuremberg, Bavaria',
    country: Country.germany,
    category: JobCategory.events,
    seasonId: 'xmas',
    start: DateTime(2026, 11, 27),
    end: DateTime(2026, 12, 24),
    pay: const Pay(14.5, PayUnit.hour),
    hoursPerWeek: 38,
    stayNote:
        'No parking at the market. The nearest all-year motorhome site is '
        '20 minutes away by tram.',
    languages: ['German (conversational)', 'English'],
    description:
        'Sell gingerbread and mulled wine from a wooden stall on the main '
        'market square. Busy, friendly and cold: you stand outside for the '
        'whole shift.',
    tasks: [
      'Serve customers and handle the till',
      'Restock and decorate the stall',
      'Open or close the stall',
    ],
    perks: ['Tips', 'Hot drinks during the shift'],
    contactEmail: 'markt@lebkuchen-hofmann.example',
  ),
  Job(
    id: 'oranges-valencia',
    title: 'Orange picker',
    employer: 'Cítricos Ribera Alta',
    place: 'Carcaixent, Valencia',
    country: Country.spain,
    category: JobCategory.harvest,
    seasonId: 'citrus',
    start: DateTime(2026, 12, 1),
    end: DateTime(2027, 3, 31),
    pay: const Pay(68, PayUnit.day),
    hoursPerWeek: 36,
    stayNote:
        'No pitch at the farm. Crews are collected each morning from the '
        'town square.',
    languages: ['Spanish (basic)'],
    description:
        'Pick navel oranges and clementines for the fresh market. Work '
        'starts at sunrise and usually finishes by early afternoon.',
    tasks: [
      'Clip fruit by hand',
      'Fill and carry 20 kg crates',
      'Light pruning at the end of the season',
    ],
    perks: ['Free afternoons', 'Transport from town'],
    contactEmail: 'personal@citricosriberaalta.example',
  ),
  Job(
    id: 'lifts-val-thorens',
    title: 'Ski lift operator',
    employer: 'Remontées des Trois Cimes',
    place: 'Val Thorens, Savoie',
    country: Country.france,
    category: JobCategory.winter,
    seasonId: 'ski',
    start: DateTime(2026, 12, 5),
    end: DateTime(2027, 4, 25),
    pay: const Pay(12.4, PayUnit.hour),
    hoursPerWeek: 35,
    housing: Housing.paid,
    stayNote:
        'Shared staff studio for €260 a month. Sleeping in vehicles is not '
        'allowed in the resort.',
    languages: ['French (conversational)', 'English'],
    description:
        'Run chairlifts and drag lifts at 2,300 m. You welcome skiers, '
        'watch the loading area and keep the station clear of snow.',
    tasks: [
      'Open and close the lift',
      'Help guests load safely',
      'Shovel and groom the station',
    ],
    perks: ['Season lift pass', 'Staff canteen', 'Uniform provided'],
    contactEmail: 'recrutement@troiscimes.example',
  ),
  Job(
    id: 'kitchen-st-anton',
    title: 'Kitchen porter',
    employer: 'Hotel Alpenrose',
    place: 'St. Anton am Arlberg, Tyrol',
    country: Country.austria,
    category: JobCategory.hospitality,
    seasonId: 'ski',
    start: DateTime(2026, 12, 10),
    end: DateTime(2027, 4, 11),
    pay: const Pay(2050, PayUnit.month, note: 'net'),
    hoursPerWeek: 48,
    housing: Housing.free,
    vanPitch: true,
    hookup: true,
    stayNote:
        'Take a single room in the staff house, or keep your van on the '
        'winter pitch behind it with electricity.',
    englishOk: true,
    languages: ['English', 'German is a plus'],
    description:
        'Keep a 120-cover hotel kitchen running through the winter. Six '
        'days a week in split shifts, with the middle of the day free for '
        'skiing.',
    tasks: [
      'Run the dishwashing station',
      'Basic vegetable prep',
      'Clean down after service',
    ],
    perks: ['Full board', 'Discounted lift pass', 'Tips shared weekly'],
    contactEmail: 'jobs@alpenrose-stanton.example',
  ),
  Job(
    id: 'rental-laax',
    title: 'Ski rental technician',
    employer: 'Crap Sport',
    place: 'Laax, Graubünden',
    country: Country.switzerland,
    category: JobCategory.winter,
    seasonId: 'ski',
    start: DateTime(2026, 12, 12),
    end: DateTime(2027, 4, 18),
    pay: const Pay(24, PayUnit.hour, currency: 'CHF'),
    hoursPerWeek: 42,
    housing: Housing.paid,
    stayNote:
        'Room in a shared staff flat for CHF 650 a month. Overnight parking '
        'in the village is not permitted in winter.',
    englishOk: true,
    languages: ['English', 'German is a plus'],
    description:
        'Fit boots, set bindings and tune skis and snowboards in a busy '
        'rental shop at the base station.',
    tasks: [
      'Fit guests with boots and boards',
      'Wax and edge rental gear',
      'Handle returns at the end of the day',
    ],
    perks: ['Season pass', 'Test the newest gear'],
    contactEmail: 'team@crapsport.example',
  ),
  Job(
    id: 'skrei-lofoten',
    title: 'Fish processing worker',
    employer: 'Vestfjord Sjømat',
    place: 'Henningsvær, Lofoten',
    country: Country.norway,
    category: JobCategory.seafood,
    seasonId: 'skrei',
    start: DateTime(2027, 1, 18),
    end: DateTime(2027, 4, 16),
    pay: const Pay(228, PayUnit.hour, currency: 'NOK'),
    hoursPerWeek: 45,
    housing: Housing.paid,
    vanPitch: true,
    hookup: true,
    stayNote:
        'Bed in a shared fisherman\'s cabin for NOK 3,500 a month, or park '
        'on the quay with electricity and use the staff showers.',
    englishOk: true,
    languages: ['English'],
    description:
        'Process the winter cod catch: gutting, sorting, and hanging fish '
        'on the drying racks. Cold, wet and physical, with plenty of '
        'overtime.',
    tasks: [
      'Gut and head cod on the line',
      'Sort roe, liver and tongues',
      'Hang fish on outdoor racks',
    ],
    perks: ['Overtime supplements', 'Northern lights', 'Free fish'],
    contactEmail: 'sesong@vestfjord-sjomat.example',
  ),
  Job(
    id: 'lambing-powys',
    title: 'Lambing assistant',
    employer: 'Bryn Glas Farm',
    place: 'Llanidloes, Powys',
    country: Country.uk,
    category: JobCategory.farm,
    seasonId: 'lambing',
    start: DateTime(2027, 3, 8),
    end: DateTime(2027, 4, 18),
    pay: const Pay(12.75, PayUnit.hour, currency: '£'),
    hoursPerWeek: 50,
    vanPitch: true,
    hookup: true,
    stayNote:
        'Hardstanding in the farmyard with hookup, and use of the farmhouse '
        'bathroom and washing machine.',
    englishOk: true,
    languages: ['English'],
    description:
        'Help lamb 900 ewes indoors. Shifts rotate between days and nights. '
        'Previous livestock experience is expected.',
    tasks: [
      'Check ewes and assist births',
      'Bottle-feed weak lambs',
      'Bed pens and move ewes to pasture',
    ],
    perks: ['Farmhouse dinners', 'Dogs welcome'],
    contactEmail: 'lambing@brynglasfarm.example',
  ),
  Job(
    id: 'campsite-vendee',
    title: 'Campsite receptionist',
    employer: 'Camping Les Dunes Vertes',
    place: 'Saint-Jean-de-Monts, Vendée',
    country: Country.france,
    category: JobCategory.campsite,
    seasonId: 'campsites',
    start: DateTime(2027, 4, 1),
    end: DateTime(2027, 9, 30),
    pay: const Pay(1850, PayUnit.month, note: 'gross'),
    hoursPerWeek: 35,
    housing: Housing.free,
    vanPitch: true,
    hookup: true,
    stayNote:
        'Choose a staff mobile home or a full-service pitch for your own '
        'van, both free of charge.',
    languages: ['French', 'English', 'German or Dutch is a plus'],
    description:
        'Be the first face guests see at a 300-pitch family campsite, '
        '400 m from the Atlantic.',
    tasks: [
      'Check guests in and out',
      'Answer booking emails and calls',
      'Sell bike hire and excursion tickets',
    ],
    perks: ['Two days off a week', 'Free use of pool and bikes'],
    contactEmail: 'emploi@dunesvertes.example',
  ),
  Job(
    id: 'asparagus-beelitz',
    title: 'Asparagus harvest worker',
    employer: 'Spargelhof Märkische Heide',
    place: 'Beelitz, Brandenburg',
    country: Country.germany,
    category: JobCategory.harvest,
    seasonId: 'asparagus',
    start: DateTime(2027, 4, 12),
    end: DateTime(2027, 6, 24),
    pay: const Pay(14.6, PayUnit.hour),
    hoursPerWeek: 48,
    housing: Housing.paid,
    vanPitch: true,
    stayNote:
        'Container rooms for €10 a day, or park for free on the meadow by '
        'the packing hall with access to showers.',
    englishOk: true,
    languages: ['English, German, Polish or Romanian'],
    description:
        'Cut white asparagus by hand in a crew of 60. Work starts at 5:30 '
        'and is hard on the back for the first week.',
    tasks: [
      'Cut and lay out spears',
      'Re-cover the ridges with foil',
      'Wash and grade in the packing hall',
    ],
    perks: ['Bonus above 12 kg per hour', 'Asparagus to take home'],
    contactEmail: 'ernte@spargelhof-mh.example',
  ),
  Job(
    id: 'campsite-rovinj',
    title: 'Campsite maintenance all-rounder',
    employer: 'Kamp Borik',
    place: 'Rovinj, Istria',
    country: Country.croatia,
    category: JobCategory.campsite,
    seasonId: 'campsites',
    start: DateTime(2027, 4, 15),
    end: DateTime(2027, 9, 30),
    pay: const Pay(1300, PayUnit.month, note: 'net'),
    hoursPerWeek: 40,
    vanPitch: true,
    hookup: true,
    stayNote:
        'Shaded staff pitch among the pines with electricity, water and '
        'the campsite\'s wash houses.',
    englishOk: true,
    languages: ['English', 'German or Italian is a plus'],
    description:
        'Keep a seaside campsite in good shape: small repairs, gardening '
        'and helping guests onto their pitches.',
    tasks: [
      'Fix taps, lights and fences',
      'Mow and water the grounds',
      'Guide motorhomes to their pitches',
    ],
    perks: ['Staff lunch', 'Free pitch for the whole season'],
    contactEmail: 'posao@kampborik.example',
  ),
  Job(
    id: 'beach-bar-naxos',
    title: 'Beach bar staff',
    employer: 'Meltemi Beach Bar',
    place: 'Plaka, Naxos',
    country: Country.greece,
    category: JobCategory.hospitality,
    seasonId: 'campsites',
    start: DateTime(2027, 5, 1),
    end: DateTime(2027, 10, 10),
    pay: const Pay(1100, PayUnit.month, note: 'net, plus tips'),
    hoursPerWeek: 48,
    housing: Housing.free,
    stayNote: 'Shared twin room in the staff house, ten minutes\' walk away.',
    englishOk: true,
    languages: ['English'],
    description:
        'Serve drinks and snacks to sunbeds and tables at a relaxed beach '
        'bar. Six days a week through the whole summer.',
    tasks: [
      'Take orders on the beach',
      'Mix simple drinks',
      'Set up and stack sunbeds',
    ],
    perks: ['Two meals a day', 'Tips'],
    contactEmail: 'crew@meltemi-naxos.example',
  ),
  Job(
    id: 'surfcamp-peniche',
    title: 'Surf camp host',
    employer: 'Baleal Tides Surf Camp',
    place: 'Peniche, Oeste',
    country: Country.portugal,
    category: JobCategory.hospitality,
    seasonId: 'campsites',
    start: DateTime(2027, 5, 1),
    end: DateTime(2027, 10, 15),
    pay: const Pay(900, PayUnit.month, note: 'net'),
    hoursPerWeek: 35,
    housing: Housing.free,
    vanPitch: true,
    stayNote:
        'Bed in the staff dorm, or park in the camp garden and use the '
        'kitchen and showers.',
    englishOk: true,
    languages: ['English'],
    description:
        'Look after 30 guests a week: breakfast, check-ins, airport runs '
        'and the Thursday barbecue.',
    tasks: [
      'Prepare breakfast and clean rooms',
      'Welcome new guests',
      'Drive the camp van to the surf spots',
    ],
    perks: ['Free board hire and lessons', 'All meals included'],
    contactEmail: 'aloha@balealtides.example',
  ),
  Job(
    id: 'strawberries-funen',
    title: 'Strawberry picker',
    employer: 'Lundsgaard Bær',
    place: 'Faaborg, Funen',
    country: Country.denmark,
    category: JobCategory.harvest,
    seasonId: 'softfruit',
    start: DateTime(2027, 5, 24),
    end: DateTime(2027, 7, 31),
    pay: const Pay(
      140,
      PayUnit.hour,
      currency: 'DKK',
      note: 'typical piece-rate earnings',
    ),
    hoursPerWeek: 40,
    vanPitch: true,
    hookup: true,
    stayNote:
        'Pickers\' campsite on the farm for DKK 40 a night with hookup, '
        'kitchen tent, showers and Wi-Fi.',
    englishOk: true,
    languages: ['English'],
    description:
        'Pick strawberries in tunnels and open fields. You are paid by the '
        'kilo, so earnings rise quickly after the first week.',
    tasks: [
      'Pick and grade berries into punnets',
      'Weed and lay straw early in the season',
    ],
    perks: ['Weekly pay', 'Shop within cycling distance'],
    contactEmail: 'pick@lundsgaard-baer.example',
  ),
  Job(
    id: 'alp-bernese-oberland',
    title: 'Alp dairy assistant',
    employer: 'Alpgenossenschaft Bussalp',
    place: 'Grindelwald, Bernese Oberland',
    country: Country.switzerland,
    category: JobCategory.farm,
    seasonId: 'alp',
    start: DateTime(2027, 6, 5),
    end: DateTime(2027, 9, 18),
    pay: const Pay(140, PayUnit.day, currency: 'CHF'),
    hoursPerWeek: 60,
    housing: Housing.free,
    stayNote:
        'Simple room in the alp hut at 1,800 m. Your van stays in the '
        'valley for the summer.',
    languages: ['German (conversational)'],
    description:
        'Spend the summer with 70 cows on a high pasture, helping the '
        'cheesemaker every day. Long days, no days off in bad weather, and '
        'a view of the Eiger.',
    tasks: [
      'Milk twice a day',
      'Turn and wash cheeses in the cellar',
      'Fence pastures and drive the herd',
    ],
    perks: ['Full board', 'A wheel of alp cheese at the end'],
    contactEmail: 'alp@bussalp.example',
  ),
  Job(
    id: 'hut-zillertal',
    title: 'Mountain hut helper',
    employer: 'Rastkogelhütte',
    place: 'Zillertal, Tyrol',
    country: Country.austria,
    category: JobCategory.hospitality,
    seasonId: 'alp',
    start: DateTime(2027, 6, 12),
    end: DateTime(2027, 9, 26),
    pay: const Pay(2100, PayUnit.month, note: 'net'),
    hoursPerWeek: 54,
    housing: Housing.free,
    stayNote:
        'Bunk room in the hut, which is a 90-minute walk from the nearest '
        'road. Free parking for your van at the valley station.',
    languages: ['German (basic)', 'English'],
    description:
        'Serve hikers and overnight guests in an 80-bed alpine hut. '
        'Everyone does everything: kitchen, terrace and dormitories.',
    tasks: [
      'Serve food and drinks on the terrace',
      'Prepare dormitories',
      'Help in the kitchen',
    ],
    perks: ['Full board', 'Tips', 'One long weekend off a month'],
    contactEmail: 'team@rastkogelhuette.example',
  ),
  Job(
    id: 'festival-crew-utrecht',
    title: 'Festival site crew',
    employer: 'Stagehands Collective',
    place: 'Utrecht region',
    country: Country.netherlands,
    category: JobCategory.events,
    seasonId: 'festivals',
    start: DateTime(2027, 6, 14),
    end: DateTime(2027, 8, 22),
    pay: const Pay(15.2, PayUnit.hour),
    hoursPerWeek: 44,
    vanPitch: true,
    stayNote:
        'Crew camping at every site with showers and catering. No hookup, '
        'so solar helps.',
    englishOk: true,
    languages: ['English'],
    description:
        'Travel with a crew of 25 between six summer festivals, building '
        'and taking down fences, tents and stages.',
    tasks: [
      'Lay trackway and build fencing',
      'Put up tents and bars',
      'Tear down and load trucks',
    ],
    perks: ['Crew catering', 'Festival access after your shift'],
    contactEmail: 'crew@stagehands-collective.example',
  ),
  Job(
    id: 'bulbs-hillegom',
    title: 'Flower bulb peeler and packer',
    employer: 'Van der Meer Bloembollen',
    place: 'Hillegom, South Holland',
    country: Country.netherlands,
    category: JobCategory.harvest,
    seasonId: 'bulbs',
    start: DateTime(2027, 6, 21),
    end: DateTime(2027, 9, 3),
    pay: const Pay(14.8, PayUnit.hour),
    hoursPerWeek: 40,
    vanPitch: true,
    hookup: true,
    stayNote:
        'Small farm campsite behind the bulb shed for €8 a night, with '
        'hookup and showers.',
    englishOk: true,
    languages: ['English'],
    description:
        'Peel, sort and pack tulip and daffodil bulbs in the shed. Seated '
        'or standing indoor work with regular hours.',
    tasks: [
      'Peel and clean bulbs',
      'Sort by size on the grading line',
      'Count and pack for export',
    ],
    perks: ['Weekends off', 'Beach 15 minutes away by bike'],
    contactEmail: 'werk@vandermeer-bollen.example',
  ),
  Job(
    id: 'apples-south-tyrol',
    title: 'Apple picker',
    employer: 'Obsthof Unterweger',
    place: 'Lana, South Tyrol',
    country: Country.italy,
    category: JobCategory.harvest,
    seasonId: 'apples',
    start: DateTime(2027, 8, 23),
    end: DateTime(2027, 10, 23),
    pay: const Pay(9.6, PayUnit.hour),
    hoursPerWeek: 48,
    housing: Housing.free,
    vanPitch: true,
    stayNote:
        'Room on the farm, or park under the pergola by the barn with '
        'water and a bathroom. No electricity at the pitch.',
    languages: ['German or Italian (basic)'],
    description:
        'Pick Gala, Golden Delicious and Pink Lady on a family farm with '
        'harvest platforms. No ladders, and careful hands matter more than '
        'speed.',
    tasks: [
      'Pick by colour in several passes',
      'Fill bins from the harvest platform',
      'Sort out windfalls',
    ],
    perks: ['Lunch with the family', 'Saturday afternoons and Sundays off'],
    contactEmail: 'ernte@obsthof-unterweger.example',
  ),
  Job(
    id: 'hops-hallertau',
    title: 'Hop harvest helper',
    employer: 'Hopfenhof Lindner',
    place: 'Wolnzach, Bavaria',
    country: Country.germany,
    category: JobCategory.harvest,
    seasonId: 'hops',
    start: DateTime(2027, 8, 25),
    end: DateTime(2027, 9, 20),
    pay: const Pay(14.6, PayUnit.hour),
    hoursPerWeek: 60,
    vanPitch: true,
    hookup: true,
    stayNote:
        'Pitch in the farmyard with electricity. Shower and washing machine '
        'in the farmhouse.',
    englishOk: true,
    languages: ['English', 'German is a plus'],
    description:
        'Four intense weeks with no days off. You hang hop bines into the '
        'picking machine or drive the tractor between the garden and the '
        'yard.',
    tasks: [
      'Hang bines into the picker',
      'Drive tractor and trailer (licence needed)',
      'Fill and move drying sacks',
    ],
    perks: ['Three meals a day', 'Harvest party'],
    contactEmail: 'hopfen@hof-lindner.example',
  ),
  Job(
    id: 'grapes-champagne',
    title: 'Grape picker',
    employer: 'Champagne Veuve Marchal',
    place: 'Épernay, Champagne',
    country: Country.france,
    category: JobCategory.harvest,
    seasonId: 'grapes',
    start: DateTime(2027, 9, 6),
    end: DateTime(2027, 9, 17),
    pay: const Pay(12.3, PayUnit.hour),
    hoursPerWeek: 48,
    vanPitch: true,
    stayNote:
        'Park on the meadow beside the press house. Toilets, showers and '
        'water on site, no electricity.',
    englishOk: true,
    languages: ['English or French'],
    description:
        'Twelve days of hand-picking Pinot Noir and Chardonnay in a crew of '
        '40. Everything in Champagne is picked by hand, and the meals are '
        'famous.',
    tasks: ['Cut bunches with secateurs', 'Carry crates to the row end'],
    perks: ['Three meals a day', 'Champagne at the closing dinner'],
    contactEmail: 'vendanges@veuve-marchal.example',
  ),
  Job(
    id: 'grapes-mosel',
    title: 'Grape harvest & cellar hand',
    employer: 'Weingut Schieferberg',
    place: 'Bernkastel-Kues, Mosel',
    country: Country.germany,
    category: JobCategory.harvest,
    seasonId: 'grapes',
    start: DateTime(2027, 9, 13),
    end: DateTime(2027, 10, 25),
    pay: const Pay(14.6, PayUnit.hour),
    hoursPerWeek: 45,
    vanPitch: true,
    hookup: true,
    stayNote:
        'Riverside pitch in the winery yard with hookup, water and a '
        'bathroom in the press house.',
    englishOk: true,
    languages: ['English', 'German is a plus'],
    description:
        'Pick Riesling on steep slate slopes and help in the cellar on '
        'rainy days. Sure feet and a head for heights are essential.',
    tasks: [
      'Pick and select grapes on the slope',
      'Carry harvest tubs to the monorail',
      'Clean presses and tanks',
    ],
    perks: ['Harvest lunch', 'Six bottles to take home'],
    contactEmail: 'lese@weingut-schieferberg.example',
  ),
  Job(
    id: 'grapes-lavaux',
    title: 'Grape picker',
    employer: 'Domaine des Terrasses',
    place: 'Epesses, Lavaux',
    country: Country.switzerland,
    category: JobCategory.harvest,
    seasonId: 'grapes',
    start: DateTime(2027, 9, 20),
    end: DateTime(2027, 10, 8),
    pay: const Pay(16.5, PayUnit.hour, currency: 'CHF'),
    hoursPerWeek: 45,
    housing: Housing.free,
    stayNote:
        'Dormitory above the cellar. The village lanes are too narrow for '
        'vans; there is a car park in Cully.',
    languages: ['French (basic)'],
    description:
        'Harvest Chasselas on terraced vineyards above Lake Geneva. Steep, '
        'beautiful, and all carried out on your back.',
    tasks: ['Pick into small crates', 'Carry the brante down the terraces'],
    perks: ['All meals included', 'Lake view all day'],
    contactEmail: 'vendanges@domainedesterrasses.example',
  ),
];
