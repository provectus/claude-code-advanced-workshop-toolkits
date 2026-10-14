# Incident Response

## Severity levels

| Level | Definition | Response time |
|-------|------------|---------------|
| SEV1 | Full outage or data loss/leak affecting customers | Immediately, 24/7 |
| SEV2 | Major feature broken, no workaround | Within 30 minutes, 24/7 |
| SEV3 | Degraded feature, workaround exists | Next working day |
| SEV4 | Cosmetic or internal-only issue | Normal backlog |

## When you spot an incident

1. Declare it in `#incidents` with the severity, a one-line impact statement, and a link to evidence.
2. For SEV1/SEV2, page the on-call engineer and name an **Incident Commander (IC)**.
3. The IC opens a dedicated channel `#inc-<date>-<short-name>` and assigns a scribe.
4. Mitigate first (rollback, feature flag, scale up), find the root cause second.
5. Post status updates every 30 minutes for SEV1 and every 60 minutes for SEV2.

## After the incident

- A blameless postmortem is due within 5 working days for every SEV1 and SEV2.
- The postmortem covers: timeline, impact, root cause, what went well, and action items with owners and due dates.
- Action items are tracked as tickets labelled `postmortem`.
