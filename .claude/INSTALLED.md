# סקילים ומודים שהותקנו אחרי skill-review

כלל: מעדכנים כשהמשתמש רוצה, לא כשהסקיל רוצה. עדכון = להוריד מחדש, להריץ שוב את שלב 1
של skill-review על ההפרש מול הגרסה כאן, ורק אז להחליף.

| פריט | מקור | גרסה שנבדקה | תאריך בדיקה | הערות |
|---|---|---|---|---|
| video-analysis | eilon.co/wp-content/uploads/2026/08/video-analysis-skill.zip?v=3 | v1.0.0 (zip v=3) | 2026-11-04 | אין עדכון אוטומטי |
| video-download | eilon.co/wp-content/uploads/2026/08/video-download-skill.zip?v=3 | zip v=3 | 2026-11-04 | yt-dlp מתעדכן רק כשמבקשים |
| verification-before-completion | github.com/obra/superpowers | 22f0b463e7a5e579904dd6211a520321035526f7 | 2026-11-04 | רק SKILL.md; בלי ה-hook ושאר החבילה |
| leitstand (mod) | github.com/dominikmartn/leitstand | c240234c29793e999c8bf1622a02851652f9665e (v0.2.2) | 2026-11-04 | עותק מקומי, נעול |
| plan-progress (mod) | github.com/zycck/claude-mods | b77335ee560c609d67ae85c7321f886719361426 (v1.0.0) | 2026-11-04 | עותק מקומי; בדיקת עדכונים כבויה (register.tsx:3056, local patch); בלי tests/ |

טביעות אצבע (sha256 של כל הקבצים, ממוין):
- `.claude/skills/video-analysis`: `d1e1cdea8c34b9e4`
- `.claude/skills/video-download`: `2a8801a7557898ba`
- `.claude/skills/verification-before-completion`: `e59685359ca7cb10`
- `plugins/leitstand`: `6355724c77634df4`
- `plugins/plan-progress`: `77709bfe2d8387dd`
