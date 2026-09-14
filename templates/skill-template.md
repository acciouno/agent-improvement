# Skill: <short-name>

> Copy this template into `skills/<short-name>.skill.md` and fill every section.
> A skill with an empty Provenance section is not trusted — it is a candidate
> for retirement.
>
> No manual version field: git is the version history. If you feel the need
> for a version number, the skill is probably doing too much — split it.

## Purpose

What this skill is for, in one or two sentences.

## Trigger conditions

When the agent should reach for this skill. Be specific: task types, signals,
keywords. If the trigger is vague, the skill will misfire.

## Procedure

The actual steps, commands, or decision rules. Concrete beats clever.

## Depends on / conflicts with

Other skills this one assumes, extends, or contradicts. When two skills
conflict, do not average them: state which one wins and why, and flag the
other for cleanup. "None known" is acceptable once, not forever.

## How to tell it's working

Observable signs this skill is helping (not just present). E.g. "date errors
caught before acting: count in experience log," or "regression check N passes."
The paper's structural-vs-effective distinction: a skill file existing is
structural; it changing outcomes is effective. Track the latter.

## Provenance

- **Created:** <YYYY-MM-DD> — <what evidence or experience motivated it>
- **Last validated:** <YYYY-MM-DD> — <how: regression run, spot-check, task outcome>
- **Rejected alternatives:** <what was tried and abandoned, and why>

## Changelog

- <YYYY-MM-DD>: <what changed> — <evidence: log entry date / eval result>

## Known limits

Where this skill is known to fail or not apply. Honesty here prevents
misuse more effectively than any trigger condition.
