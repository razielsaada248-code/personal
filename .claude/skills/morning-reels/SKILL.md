---
name: morning-reels
description: >-
  Daily morning brief of Instagram reels and automation-bot messages from the user's
  Instagram DMs (saved messages + "click here for the guide" bots). Summarizes each reel;
  for AI-related reels finds the GitHub repos/skills mentioned, reviews them with
  skill-review, and asks the user whether to install. Use when the scheduled morning
  task fires or when the user asks for "סיכום רילסים", "סיכום בוקר של אינסטגרם",
  "מה שמרתי באינסטגרם".
---

# סיכום רילסים של הבוקר

כל התקשורת עם המשתמש בעברית.

## 0. הכנה

1. הרץ `sh scripts/setup-composio.sh`. אם נכשל (אין `COMPOSIO_API_KEY`) — עצור,
   וכתוב למשתמש בדיוק מה חסר.
2. ודא שאינסטגרם מחובר: `composio search "list instagram conversations"`.
   אם לא מחובר, השתמש בסקיל `composio:composio-connect` ותן למשתמש את קישור החיבור.

## 1. איסוף (24 השעות האחרונות)

הגדרות ב-`config/morning-reels.json` (`share_account` = החשבון שאליו המשתמש משתף רילסים).

1. `INSTAGRAM_LIST_ALL_CONVERSATIONS` עם `{"limit":100,"fields":"id,updated_time,participants"}`.
   קח רק שיחות עם `updated_time` מ-24 השעות האחרונות.
2. לכל שיחה: `INSTAGRAM_LIST_ALL_MESSAGES` עם
   `{"conversation_id":"...","limit":25,"fields":"id,from,message,created_time,attachments,shares"}`.
3. מיין:
   - **רילסים ששמרתי**: השיחה עם `share_account`. רילסים מגיעים ב-`shares`/`attachments`
     (קישור לרילס). אם `share_account` ריק — דלג וכתוב בדוח שצריך להגדיר אותו.
   - **בוטים של אוטומציה**: הודעות עם `attachments[].generic_template` (title + cta),
     לרוב ManyChat. כל שיחה כזאת נוצרה מרילס שהמשתמש הגיב עליו — זה הרילס לסכם.
   - הודעות רגילות מאנשים — התעלם (אל תקרא/תסכם שיחות פרטיות).

הודעות השמורות (שיחה עם עצמך) לא נגישות דרך ה-API — אל תנסה.

## 2. לכל רילס

1. שלוף כיתוב, יוצר, קישור. לבוטים: הטקסט של הבוט בדרך כלל מסביר מה היה בסרטון;
   השלם עם `WebFetch` על הקישור לרילס / לפרופיל היוצר אם צריך.
2. סווג: **AI** (כלים, סקילים, MCP, אוטומציות, Claude/GPT, ריפו בגיטהאב) או **אחר**.
3. **אחר**: סיכום של 2–3 שורות — מה קורה בסרטון ומה הנקודה.
4. **AI**:
   - זהה את הכלים/ריפויים/סקילים שהוזכרו. חפש ברשת את הריפו המדויק בגיטהאב
     (`WebSearch`, ואז `git clone --depth 1` לתיקייה ריקה ב-scratchpad).
   - הרץ את הסקיל `skill-review` על כל ריפו.
   - **אל תתקין שום דבר.** רק דווח.

## 3. לכל הודעת בוט עם מדריך

1. **כפתור postback** (`cta[].type == "postback"`, למשל "כן, תשלח", "תשלחי לי את המדריך"),
   ואין עדיין קישור אחריו: המשתמש אישר לשלוח בשמו **רק את טקסט הכפתור, מילה במילה**,
   עם `INSTAGRAM_SEND_TEXT_MESSAGE` באותה שיחה. שום טקסט אחר, אף פעם.
   אחרי שליחה — המתן ~30 שניות וקרא שוב את השיחה כדי לקבל את הקישור.
   אם השליחה נכשלה (חלון הודעות סגור, `2534022`) — אל תנסה שוב, דווח.
2. **כפתור web_url** או קישור בטקסט: פתח אותו (`curl -sSL` עוקב אחרי ההפניה של
   ManyChat, ואז WebFetch / Playwright).
3. אם יש טופס להרשמה למדריך — מלא אותו עם השם (Raziel Saada) והמייל של המשתמש
   (razielsaada248@gmail.com). **לעולם** אל תזין סיסמה, פרטי אשראי, או טופס שמבקש
   תשלום — דלג ודווח.
4. קרא את המדריך (דף / PDF / מייל שהגיע ל-Gmail אחרי ההרשמה — חפש ב-Gmail דרך Composio).
5. חזור עם אחד מהשניים:
   - **סקיל מוכן**: אם המדריך מתאר תהליך שאפשר להפוך לסקיל — כתוב טיוטת `SKILL.md`
     בתיקייה `drafts/skills/<name>/` והעבר אותה דרך `skill-review`.
   - **דרך פעולה מוכנה**: רשימת צעדים קצרה ומדויקת.
6. אם יש בו ריפו/כלי להתקנה — אותו טיפול כמו רילס AI (בדיקה עם `skill-review`).

## 4. הדוח

פתח בשורה אחת: כמה רילסים, כמה AI, כמה מדריכים.

```
## 🤖 רילסים על AI
### <שם היוצר> — <נושא>
- מה זה: ...
- ריפו: <קישור>
- פסק דין skill-review: להתקין / לא להתקין / להתקין אחרי תיקון X
- ❓ להתקין? (כן/לא)

## 📘 מדריכים מבוטים
### <נושא>
- מה מילאתי: ...
- תוצאה: סקיל מוכן ב-drafts/skills/<name> / דרך פעולה:
  1. ...

## 🎬 שאר הרילסים
- <יוצר>: סיכום 2–3 שורות
```

## 5. שאלת ההתקנה

אחרי הדוח, שאל את המשתמש עם `AskUserQuestion` (multiSelect) אילו פריטים
מהדוח להתקין — רק כאלה שקיבלו "להתקין". התקן רק מה שהמשתמש סימן במפורש,
ואחרי ההתקנה הרץ את שלב 4 (עדכונים) ושלב 5 (מבחן ההידלקות) של `skill-review`.
טיוטות סקילים — commit ו-push לענף של הסשן.
