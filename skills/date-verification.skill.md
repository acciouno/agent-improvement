# Skill: date-verification

> Worked example — a real lesson, kept as the first skill so the format has
> something concrete to imitate.

## Purpose

Prevent acting on wrong date-sensitive claims (deadlines, start dates,
reminders). One wrong stored date once caused a same-day correction cascade.

## Trigger conditions

- Any task involving a calendar date, deadline, launch, or scheduled event.
- Any claim of the form "X happens on <date>" that will drive an action
  (reminder, booking, message, cron).

## Procedure

1. Do not work out the weekday from memory — run `date -d` for every relevant
   date first.
2. Cross-check the date against the most recent authoritative source in context
   (user correction beats stored memory; stored memory beats inference).
3. If the user has ever corrected this date before, treat the correction as
   guilty-until-proven-innocent: re-verify, don't re-assert.
4. Only then act or report.

## Depends on / conflicts with

- None known. If a scheduling/reminder skill is added later, this one constrains
  it: no date-driven action without verification first. This skill wins any
  conflict about whether a date is "probably fine."

## How to tell it's working

- Zero same-day date corrections in the experience log since adoption.
- Regression check 1 passes on every review.

## Provenance

- **Created:** 2026-09-14 — a wrongly stored work start date (Sun Sep 20) had
  to be corrected to Mon Sep 21 after the user flagged it; Pimsleur Day 1
  moved with it.
- **Last validated:** 2026-09-14 — applied during the RSI paper read (all
  date claims grounded via `date -d` before use).
- **Rejected alternatives:** "trust MEMORY.md silently" — rejected because a
  single stale entry propagated into multiple downstream artifacts.

## Changelog

- 2026-09-14: created from the Sep 13 correction incident.

## Known limits

- Only as good as the source it checks against; if the user misstates a date,
  this skill will faithfully verify the wrong date. Garbage in, verified garbage out.
