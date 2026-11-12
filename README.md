# Saisonnier

Find short-term seasonal jobs across Europe: harvests, ski resorts, campsites,
mountain huts, festivals and fish plants. Built for vanlifers and anyone else
who follows the seasons, so every listing says whether you can park your van at
the workplace.

## Features

- **Jobs**: search by job, place or country; filter by category, the months you
  are free, country, van pitch, housing and "English is enough".
- **Job details**: dates, pay, hours, where you stay, tasks, languages, perks
  and a short note on who is allowed to work in that country.
- **Season calendar**: pick a month to see what is in season where, and jump to
  the matching jobs.
- **Saved**: bookmark jobs; they are stored on the device.

## Data

There is no backend yet. Listings come from `lib/data/sample_jobs.dart`:
places, seasons and pay levels are realistic, but the employers and contact
addresses are invented. The screens take a plain `List<Job>`, so a real source
can replace the sample list in `lib/main.dart`.

## Run

```sh
flutter run        # pick a device when asked
flutter test
```

## Layout

```
lib/
  main.dart            entry point
  app.dart             theme and bottom navigation
  models/              Job, Pay, Country, JobFilter
  data/                sample jobs and the season calendar
  state/               saved jobs (shared_preferences)
  screens/             jobs, job detail, seasons, saved
  widgets/             job card, filter sheet
```
