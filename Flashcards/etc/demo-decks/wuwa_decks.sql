-- Adds decks Wuwa 3.1 / 3.6 / 3.7 (161 Cards, new, Due today). Skips a deck name or Front that already exists.
BEGIN;
INSERT INTO decks(name,created_at) SELECT 'Wuwa 3.1', CAST(strftime('%s','now') AS INTEGER)*1000 WHERE NOT EXISTS (SELECT 1 FROM decks WHERE name = 'Wuwa 3.1' COLLATE NOCASE);
INSERT INTO decks(name,created_at) SELECT 'Wuwa 3.6', CAST(strftime('%s','now') AS INTEGER)*1000 WHERE NOT EXISTS (SELECT 1 FROM decks WHERE name = 'Wuwa 3.6' COLLATE NOCASE);
INSERT INTO decks(name,created_at) SELECT 'Wuwa 3.7', CAST(strftime('%s','now') AS INTEGER)*1000 WHERE NOT EXISTS (SELECT 1 FROM decks WHERE name = 'Wuwa 3.7' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Fierce','Meaning: Very strong, aggressive, or determined | ดุร้าย, รุนแรง, มุ่งมั่นอย่างแรงกล้า
Word (POS): Fierce (adj.)
Frequency: Common — strong emotions, intense competition, aggressive behaviour
Feeling: Intense, powerful — ให้ความรู้สึกรุนแรง ทรงพลัง ไม่ยอมใคร
Example: The two teams faced fierce competition.',CAST(strftime('%s','now') AS INTEGER)*1000+1,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Fierce' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Brink','Meaning: The edge of a situation, just before something happens | จุดใกล้ถึง, ขอบเหว
Word (POS): Brink (n.)
Frequency: Common — something big or dangerous is about to happen (on the brink of)
Feeling: Tense, on edge — ให้ความรู้สึกตึงเครียด เหมือนยืนอยู่ริมขอบ
Example: The company was on the brink of bankruptcy.',CAST(strftime('%s','now') AS INTEGER)*1000+2,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Brink' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Synchronist','Meaning: Someone who makes events or actions happen at the same time | ผู้ทำให้เหตุการณ์หรือการกระทำเกิดขึ้นพร้อมกัน
Word (POS): Synchronist (n.)
Frequency: Rare — specialised or fantasy/sci-fi contexts
Feeling: Mysterious, technical — ให้ความรู้สึกลึกลับ เป็นศัพท์เฉพาะทาง
Example: As a synchronist, she could link her mind with the machine.',CAST(strftime('%s','now') AS INTEGER)*1000+3,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Synchronist' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Issue','Meaning: A problem or topic being discussed; to officially give out something | ปัญหา, ประเด็น; ออกหรือประกาศอย่างเป็นทางการ
Word (POS): Issue (n./v.)
Frequency: Very common — daily conversation, work and technology
Feeling: Neutral, practical — เป็นคำกลาง ๆ ใช้ได้ทั่วไป
Example: We need to fix this issue before the deadline.',CAST(strftime('%s','now') AS INTEGER)*1000+4,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Issue' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Intrigued','Meaning: Very interested and curious to know more | สนใจ, อยากรู้อยากเห็น
Word (POS): Intrigued (adj.)
Frequency: Common — reacting to something new or mysterious
Feeling: Curious, drawn in — ให้ความรู้สึกอยากรู้ ถูกดึงดูดความสนใจ
Example: I was intrigued by the strange signal.',CAST(strftime('%s','now') AS INTEGER)*1000+5,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Intrigued' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Presumed','Meaning: Believed to be true without proof | สันนิษฐาน, ถูกเชื่อว่า
Word (POS): Presumed (v./adj.)
Frequency: Common — news, reports and formal statements (presumed dead)
Feeling: Uncertain, formal — ให้ความรู้สึกไม่แน่ชัด เป็นทางการ
Example: The pilot was presumed dead after the crash.',CAST(strftime('%s','now') AS INTEGER)*1000+6,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Presumed' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Figment','Meaning: Something that seems real but exists only in the mind | สิ่งที่จินตนาการขึ้นเอง
Word (POS): Figment (n.)
Frequency: Less common — almost always "a figment of your imagination"
Feeling: Dreamy, doubtful — ให้ความรู้สึกเหมือนภาพลวง ไม่มีอยู่จริง
Example: Maybe the voice was just a figment of my imagination.',CAST(strftime('%s','now') AS INTEGER)*1000+7,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Figment' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Turned it inside out','Meaning: Searched a place very thoroughly | ค้นจนทั่ว, รื้อจนพรุน
Word (POS): Turned it inside out (idiom)
Frequency: Common — looking for something lost
Feeling: Frantic, thorough — ให้ความรู้สึกรีบร้อน ค้นทุกซอกทุกมุม
Example: I turned my room inside out looking for my keys.',CAST(strftime('%s','now') AS INTEGER)*1000+8,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Turned it inside out' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'On the fritz','Meaning: (of a machine) not working properly | เสีย, ทำงานผิดปกติ
Word (POS): On the fritz (idiom)
Frequency: Less common — informal talk about devices
Feeling: Casual, annoyed — ให้ความรู้สึกเป็นกันเอง ปนรำคาญ
Example: The radio is on the fritz again.',CAST(strftime('%s','now') AS INTEGER)*1000+9,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='On the fritz' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Unorthodox','Meaning: Different from what is usual or traditional | นอกแบบแผน, ไม่ธรรมดา
Word (POS): Unorthodox (adj.)
Frequency: Common — methods, ideas and styles
Feeling: Bold, unusual — ให้ความรู้สึกแหวกแนว กล้าแตกต่าง
Example: Her unorthodox methods actually worked.',CAST(strftime('%s','now') AS INTEGER)*1000+10,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Unorthodox' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Averted','Meaning: Prevented something bad from happening; turned your eyes away | หลีกเลี่ยงได้, ป้องกันไว้ได้; เบือนหน้าหนี
Word (POS): Averted (v.)
Frequency: Common — disasters avoided; avoiding eye contact
Feeling: Relieved; shy or guilty — รอดหวุดหวิดอย่างโล่งใจ หรือเขินอาย/รู้สึกผิดเมื่อเบือนหน้า
Example: A disaster was narrowly averted.',CAST(strftime('%s','now') AS INTEGER)*1000+11,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Averted' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Tethered','Meaning: Tied so it cannot move far; closely linked to something | ถูกผูกไว้, ถูกล่ามไว้
Word (POS): Tethered (adj./v.)
Frequency: Less common — ropes and animals; emotional or digital connections
Feeling: Bound, restricted — ให้ความรู้สึกถูกผูกมัด ไปไหนไม่ได้ไกล
Example: The boat was tethered to the dock.',CAST(strftime('%s','now') AS INTEGER)*1000+12,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Tethered' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Wrench','Meaning: A tool for turning nuts; to pull or twist suddenly and hard | ประแจ; บิด, กระชาก
Word (POS): Wrench (n./v.)
Frequency: Common — tools; sudden violent movement; emotional pain
Feeling: Forceful, painful — ให้ความรู้สึกรุนแรง ฉับพลัน เจ็บปวด
Example: He wrenched the door open.',CAST(strftime('%s','now') AS INTEGER)*1000+13,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Wrench' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Wrecked','Meaning: Badly damaged or destroyed; (informal) very tired | พังยับเยิน; เหนื่อยหมดแรง
Word (POS): Wrecked (adj.)
Frequency: Common — accidents; feeling exhausted
Feeling: Broken, drained — ให้ความรู้สึกพังทลาย หมดสภาพ
Example: After the long trip, I was completely wrecked.',CAST(strftime('%s','now') AS INTEGER)*1000+14,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Wrecked' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Glossed','Meaning: Dealt with something only briefly to avoid it (gloss over) | มองข้าม, พูดผ่าน ๆ
Word (POS): Glossed (v.)
Frequency: Less common — avoiding uncomfortable details
Feeling: Evasive — ให้ความรู้สึกเลี่ยง ไม่อยากพูดตรง ๆ
Example: He glossed over the real reason he left.',CAST(strftime('%s','now') AS INTEGER)*1000+15,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Glossed' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Prying','Meaning: Too interested in other people''s private affairs; forcing open | สอดรู้สอดเห็น; งัด
Word (POS): Prying (adj./v.)
Frequency: Common — nosy people; opening something with force
Feeling: Intrusive, nosy — ให้ความรู้สึกน่ารำคาญ ล้ำเส้นความเป็นส่วนตัว
Example: Keep your secrets away from prying eyes.',CAST(strftime('%s','now') AS INTEGER)*1000+16,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Prying' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Possession','Meaning: Owning something; something owned; being controlled by a spirit | การครอบครอง, ทรัพย์สิน; การถูกสิง
Word (POS): Possession (n.)
Frequency: Common — property and law; horror stories
Feeling: Neutral; eerie in supernatural sense — ปกติเป็นกลาง แต่ถ้าหมายถึงการถูกสิงจะให้ความรู้สึกน่าขนลุก
Example: The letter is still in my possession.',CAST(strftime('%s','now') AS INTEGER)*1000+17,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Possession' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Interrogated','Meaning: Questioned closely and aggressively, often by police | ถูกสอบสวน, ถูกซักถาม
Word (POS): Interrogated (v.)
Frequency: Common — police, military and crime stories
Feeling: Tense, pressured — ให้ความรู้สึกกดดัน ถูกบีบคั้น
Example: The suspect was interrogated for hours.',CAST(strftime('%s','now') AS INTEGER)*1000+18,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Interrogated' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Over a tapped line','Meaning: Through a phone line someone is secretly listening to | ทางสายโทรศัพท์ที่ถูกดักฟัง
Word (POS): Over a tapped line (phrase)
Frequency: Rare — spy and crime stories
Feeling: Secretive, risky — ให้ความรู้สึกระแวง ต้องระวังคำพูด
Example: We can''t talk about it over a tapped line.',CAST(strftime('%s','now') AS INTEGER)*1000+19,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Over a tapped line' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Auditorium','Meaning: A large room or building where an audience sits | หอประชุม
Word (POS): Auditorium (n.)
Frequency: Common — schools, concerts and events
Feeling: Neutral, formal — เป็นคำกลาง ๆ บรรยากาศงานพิธี
Example: The ceremony was held in the school auditorium.',CAST(strftime('%s','now') AS INTEGER)*1000+20,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Auditorium' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Alias','Meaning: A false or alternative name | ชื่อแฝง, นามแฝง
Word (POS): Alias (n.)
Frequency: Common — spies, criminals, online names
Feeling: Secretive — ให้ความรู้สึกลึกลับ ปกปิดตัวตน
Example: He travelled under an alias.',CAST(strftime('%s','now') AS INTEGER)*1000+21,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Alias' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Epitaph','Meaning: Words written on a gravestone about the dead person | คำจารึกบนหลุมศพ
Word (POS): Epitaph (n.)
Frequency: Less common — graves, memorials, literature
Feeling: Solemn, sad — ให้ความรู้สึกเศร้า สงบ ระลึกถึง
Example: Her epitaph read: "She lived to help others."',CAST(strftime('%s','now') AS INTEGER)*1000+22,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Epitaph' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Student rep','Meaning: A student chosen to speak for other students | ตัวแทนนักเรียน
Word (POS): Student rep (n.)
Frequency: Common — school and university life
Feeling: Friendly, everyday — ให้ความรู้สึกเป็นกันเอง ชีวิตในโรงเรียน
Example: She was elected student rep for our class.',CAST(strftime('%s','now') AS INTEGER)*1000+23,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Student rep' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Extracurriculars','Meaning: School activities outside normal lessons, like clubs and sports | กิจกรรมนอกหลักสูตร
Word (POS): Extracurriculars (n.)
Frequency: Common — school, university applications
Feeling: Busy, positive — ให้ความรู้สึกกระตือรือร้น ชีวิตนักเรียนที่ยุ่ง
Example: Between classes and extracurriculars, I have no free time.',CAST(strftime('%s','now') AS INTEGER)*1000+24,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Extracurriculars' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Dabbler','Meaning: Someone who tries an activity casually, not seriously | คนที่ลองทำหลายอย่างแบบผิวเผิน
Word (POS): Dabbler (n.)
Frequency: Less common — hobbies and skills
Feeling: Light, slightly dismissive — ให้ความรู้สึกไม่จริงจัง บางทีก็แฝงการดูแคลน
Example: I''m just a dabbler in painting.',CAST(strftime('%s','now') AS INTEGER)*1000+25,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Dabbler' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Bluntly','Meaning: In a direct way, without trying to be polite | อย่างตรงไปตรงมา, พูดไม่อ้อมค้อม
Word (POS): Bluntly (adv.)
Frequency: Common — honest opinions (to put it bluntly)
Feeling: Direct, harsh — ให้ความรู้สึกตรงแรง อาจทำให้เจ็บ
Example: To put it bluntly, your plan won''t work.',CAST(strftime('%s','now') AS INTEGER)*1000+26,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Bluntly' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Hid','Meaning: Past tense of hide: put or kept out of sight | ซ่อน (อดีตของ hide)
Word (POS): Hid (v.)
Frequency: Very common — everyday stories
Feeling: Secretive, nervous — ให้ความรู้สึกปกปิด กลัวถูกพบ
Example: She hid the letter under her pillow.',CAST(strftime('%s','now') AS INTEGER)*1000+27,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Hid' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'White-knuckling','Meaning: Getting through something scary or hard by pure willpower | กัดฟันอดทน, เกร็งสู้
Word (POS): White-knuckling (v.)
Frequency: Less common — fear, stress, holding on tightly
Feeling: Tense, strained — ให้ความรู้สึกเกร็ง กลัว แต่ฝืนทน
Example: I spent the whole flight white-knuckling the armrest.',CAST(strftime('%s','now') AS INTEGER)*1000+28,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='White-knuckling' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Lush','Meaning: (of plants) growing thick and healthy; rich and comfortable | เขียวชอุ่ม, อุดมสมบูรณ์; หรูหรา
Word (POS): Lush (adj.)
Frequency: Common — nature, gardens, luxury
Feeling: Fresh, rich — ให้ความรู้สึกสดชื่น อุดมสมบูรณ์
Example: The valley was lush and green after the rain.',CAST(strftime('%s','now') AS INTEGER)*1000+29,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Lush' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Cataclysm','Meaning: A sudden violent event that causes great change or destruction | มหันตภัย, หายนะครั้งใหญ่
Word (POS): Cataclysm (n.)
Frequency: Less common — disasters, history, fantasy worlds
Feeling: Dramatic, terrifying — ให้ความรู้สึกยิ่งใหญ่ น่ากลัว เปลี่ยนโลก
Example: The cataclysm wiped out most of the city.',CAST(strftime('%s','now') AS INTEGER)*1000+30,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Cataclysm' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Glean','Meaning: To collect information slowly, in small amounts | รวบรวม (ข้อมูล) ทีละเล็กทีละน้อย
Word (POS): Glean (v.)
Frequency: Less common — research and investigation
Feeling: Careful, patient — ให้ความรู้สึกค่อย ๆ เก็บเล็กผสมน้อย
Example: We gleaned a few clues from the old records.',CAST(strftime('%s','now') AS INTEGER)*1000+31,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Glean' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Debris','Meaning: Broken pieces left after something is destroyed | เศษซาก, เศษหักพัง
Word (POS): Debris (n.)
Frequency: Common — accidents, storms, explosions
Feeling: Messy, ruined — ให้ความรู้สึกเละเทะ หลังเกิดเหตุร้าย
Example: Debris was scattered across the road.',CAST(strftime('%s','now') AS INTEGER)*1000+32,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Debris' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Wreckage','Meaning: The remains of something badly damaged | ซากปรักหักพัง
Word (POS): Wreckage (n.)
Frequency: Common — crashes and disasters
Feeling: Grim, heavy — ให้ความรู้สึกหดหู่ สูญเสีย
Example: Rescuers searched the wreckage for survivors.',CAST(strftime('%s','now') AS INTEGER)*1000+33,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Wreckage' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Containment','Meaning: Keeping something harmful under control or within limits | การควบคุมไม่ให้แพร่กระจาย, การกักกัน
Word (POS): Containment (n.)
Frequency: Less common — disasters, disease, science fiction
Feeling: Serious, urgent — ให้ความรู้สึกจริงจัง ต้องควบคุมสถานการณ์
Example: The team worked on containment of the leak.',CAST(strftime('%s','now') AS INTEGER)*1000+34,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Containment' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Glimpsed','Meaning: Saw something for a very short time or only partly | เห็นแวบ ๆ
Word (POS): Glimpsed (v.)
Frequency: Common — brief sightings
Feeling: Fleeting, curious — ให้ความรู้สึกแวบเดียว อยากเห็นอีก
Example: I glimpsed a figure in the window.',CAST(strftime('%s','now') AS INTEGER)*1000+35,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Glimpsed' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Obstacles','Meaning: Things that block the way or make progress hard | อุปสรรค, สิ่งกีดขวาง
Word (POS): Obstacles (n.)
Frequency: Very common — challenges in life, work or a path
Feeling: Challenging — ให้ความรู้สึกท้าทาย ต้องฝ่าฟัน
Example: We overcame many obstacles to finish the project.',CAST(strftime('%s','now') AS INTEGER)*1000+36,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Obstacles' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Competing','Meaning: Trying to win against others; (of needs) not all able to be met | แข่งขัน; ขัดแย้งกัน
Word (POS): Competing (v./adj.)
Frequency: Common — sports, business, priorities
Feeling: Pressured, torn — ให้ความรู้สึกกดดัน ต้องเลือก
Example: She had to balance competing demands.',CAST(strftime('%s','now') AS INTEGER)*1000+37,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Competing' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Discretion','Meaning: Freedom to decide; care not to reveal private information | ดุลยพินิจ; ความรอบคอบ, การเก็บความลับ
Word (POS): Discretion (n.)
Frequency: Common — work rules, privacy (at your discretion)
Feeling: Careful, trustworthy — ให้ความรู้สึกสุขุม ไว้ใจได้
Example: Please handle this matter with discretion.',CAST(strftime('%s','now') AS INTEGER)*1000+38,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Discretion' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Confidants','Meaning: People you trust and tell your secrets to | คนสนิทที่ไว้ใจได้
Word (POS): Confidants (n.)
Frequency: Less common — close friendships
Feeling: Warm, trusting — ให้ความรู้สึกอบอุ่น ไว้เนื้อเชื่อใจ
Example: She was one of his closest confidants.',CAST(strftime('%s','now') AS INTEGER)*1000+39,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Confidants' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Composed','Meaning: Calm and in control of your feelings; made up of parts | สงบนิ่ง, ใจเย็น; ประกอบด้วย
Word (POS): Composed (adj./v.)
Frequency: Common — staying calm under pressure; describing parts
Feeling: Calm, steady — ให้ความรู้สึกนิ่ง มั่นคง
Example: She stayed composed during the interview.',CAST(strftime('%s','now') AS INTEGER)*1000+40,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Composed' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Probe','Meaning: To investigate something thoroughly; a device sent to explore | สืบสวน, ตรวจค้น; ยานสำรวจ
Word (POS): Probe (v./n.)
Frequency: Common — investigations, science, space
Feeling: Searching, serious — ให้ความรู้สึกค้นลึก จริงจัง
Example: Scientists sent a probe to study the planet.',CAST(strftime('%s','now') AS INTEGER)*1000+41,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Probe' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Hence','Meaning: For this reason; therefore | ดังนั้น, ด้วยเหตุนี้
Word (POS): Hence (adv.)
Frequency: Common — formal writing and explanations
Feeling: Formal, logical — ให้ความรู้สึกเป็นทางการ มีเหตุผล
Example: The road was closed, hence the delay.',CAST(strftime('%s','now') AS INTEGER)*1000+42,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Hence' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Dissolution','Meaning: The ending or breaking up of something, like a group | การสลายตัว, การยุบ
Word (POS): Dissolution (n.)
Frequency: Less common — organisations, marriages, parliament
Feeling: Final, sad — ให้ความรู้สึกจบสิ้น แตกสลาย
Example: The scandal led to the dissolution of the council.',CAST(strftime('%s','now') AS INTEGER)*1000+43,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Dissolution' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Sliver','Meaning: A small, thin piece; a very small amount | ชิ้นเล็ก ๆ บาง ๆ, เสี้ยว
Word (POS): Sliver (n.)
Frequency: Common — food, light, hope (a sliver of hope)
Feeling: Small, fragile — ให้ความรู้สึกเล็กน้อย เปราะบาง
Example: A sliver of light came through the door.',CAST(strftime('%s','now') AS INTEGER)*1000+44,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Sliver' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Chronic','Meaning: Lasting a long time or keeps coming back | เรื้อรัง
Word (POS): Chronic (adj.)
Frequency: Common — illness, pain, long-term problems
Feeling: Heavy, wearing — ให้ความรู้สึกหนักใจ เป็นมานาน
Example: He suffers from chronic back pain.',CAST(strftime('%s','now') AS INTEGER)*1000+45,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Chronic' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Envelope','Meaning: A paper cover for a letter; the limits of what is possible | ซองจดหมาย; ขอบเขต
Word (POS): Envelope (n.)
Frequency: Very common — letters; "push the envelope"
Feeling: Neutral; daring (idiom) — ปกติเป็นกลาง แต่สำนวน push the envelope ให้ความรู้สึกท้าทายขีดจำกัด
Example: She slid the note into an envelope.',CAST(strftime('%s','now') AS INTEGER)*1000+46,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Envelope' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Scatter','Meaning: To spread things over an area; to run in different directions | กระจาย, โปรย, แตกฮือ
Word (POS): Scatter (v.)
Frequency: Common — objects, crowds, animals
Feeling: Chaotic, sudden — ให้ความรู้สึกวุ่นวาย กระจัดกระจาย
Example: The birds scattered when the dog ran in.',CAST(strftime('%s','now') AS INTEGER)*1000+47,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Scatter' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Crawl over','Meaning: To move slowly across on hands and knees; to examine every detail | คลานข้าม, ไต่ไปทั่ว
Word (POS): Crawl over (phr. v.)
Frequency: Less common — climbing; checking carefully
Feeling: Slow, creepy — ให้ความรู้สึกช้า ๆ บางทีน่าขนลุก
Example: Ants crawled over the leftover food.',CAST(strftime('%s','now') AS INTEGER)*1000+48,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Crawl over' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Nose-dive','Meaning: A sudden steep fall | ดิ่งลงอย่างรวดเร็ว
Word (POS): Nose-dive (n./v.)
Frequency: Common — planes, prices, mood
Feeling: Dramatic, alarming — ให้ความรู้สึกตกฮวบ น่าตกใจ
Example: The company''s shares took a nose-dive.',CAST(strftime('%s','now') AS INTEGER)*1000+49,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Nose-dive' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Stumbled around','Meaning: Walked around unsteadily; did things without clear direction | เดินโซซัดโซเซไปมา; งมไปเรื่อย
Word (POS): Stumbled around (phr. v.)
Frequency: Common — darkness, tiredness, confusion
Feeling: Clumsy, lost — ให้ความรู้สึกงุ่มง่าม หลงทาง
Example: I stumbled around in the dark looking for the switch.',CAST(strftime('%s','now') AS INTEGER)*1000+50,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Stumbled around' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Scoop me up','Meaning: Pick me up quickly in your arms | ช้อนตัวฉันขึ้นมา, อุ้มฉันขึ้น
Word (POS): Scoop me up (phrase)
Frequency: Common — affectionate or rescue moments
Feeling: Warm, protective — ให้ความรู้สึกอบอุ่น ได้รับการปกป้อง
Example: If I fall, will you scoop me up?',CAST(strftime('%s','now') AS INTEGER)*1000+51,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Scoop me up' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Apprentice','Meaning: Someone learning a skill by working for an expert | ลูกมือฝึกงาน, ศิษย์
Word (POS): Apprentice (n.)
Frequency: Common — trades, crafts, master and student
Feeling: Humble, eager — ให้ความรู้สึกถ่อมตน ตั้งใจเรียนรู้
Example: He worked as an apprentice to the blacksmith.',CAST(strftime('%s','now') AS INTEGER)*1000+52,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Apprentice' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Steep','Meaning: Rising or falling sharply; (price) too high; to soak in liquid | ชัน; แพงเกินไป; แช่
Word (POS): Steep (adj./v.)
Frequency: Common — hills, prices, tea
Feeling: Difficult, demanding — ให้ความรู้สึกยาก หนัก ต้องใช้แรง
Example: The path up the mountain was steep.',CAST(strftime('%s','now') AS INTEGER)*1000+53,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Steep' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Drifting between','Meaning: Moving slowly and without purpose from one state to another | ล่องลอยไปมาระหว่าง
Word (POS): Drifting between (phrase)
Frequency: Less common — sleep, dreams, worlds, moods
Feeling: Dreamy, lost — ให้ความรู้สึกเลื่อนลอย ไม่ยึดติดที่ใด
Example: She was drifting between sleep and waking.',CAST(strftime('%s','now') AS INTEGER)*1000+54,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Drifting between' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Cuddling','Meaning: Holding someone closely and lovingly | กอด, กอดรัดอย่างอ่อนโยน
Word (POS): Cuddling (v.)
Frequency: Common — family, couples, pets
Feeling: Warm, tender — ให้ความรู้สึกอบอุ่น อ่อนโยน
Example: The kids were cuddling the puppy.',CAST(strftime('%s','now') AS INTEGER)*1000+55,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Cuddling' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Precedent','Meaning: An earlier event used as an example or rule for later ones | แบบอย่าง, บรรทัดฐาน
Word (POS): Precedent (n.)
Frequency: Less common — law, politics, decisions (set a precedent)
Feeling: Formal, serious — ให้ความรู้สึกเป็นทางการ มีผลระยะยาว
Example: This decision could set a dangerous precedent.',CAST(strftime('%s','now') AS INTEGER)*1000+56,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Precedent' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Hand over','Meaning: To give something or someone to another person | ส่งมอบ
Word (POS): Hand over (phr. v.)
Frequency: Very common — giving items, responsibility, control
Feeling: Neutral; sometimes forced — ปกติเป็นกลาง บางครั้งแฝงการถูกบังคับให้ยอม
Example: Hand over the key, please.',CAST(strftime('%s','now') AS INTEGER)*1000+57,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Hand over' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Splurging','Meaning: Spending a lot of money on something you enjoy | ใช้จ่ายฟุ่มเฟือย, ทุ่มเงิน
Word (POS): Splurging (v.)
Frequency: Common — shopping, treats, holidays
Feeling: Fun, guilty pleasure — ให้ความรู้สึกสนุก แต่แอบรู้สึกผิด
Example: I''m splurging on a nice dinner tonight.',CAST(strftime('%s','now') AS INTEGER)*1000+58,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Splurging' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Creased','Meaning: Having folds or lines in it | ยับ, มีรอยพับ
Word (POS): Creased (adj.)
Frequency: Common — clothes, paper, faces
Feeling: Worn, untidy — ให้ความรู้สึกไม่เรียบร้อย ผ่านการใช้มา
Example: He handed me a creased old photo.',CAST(strftime('%s','now') AS INTEGER)*1000+59,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Creased' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Worn','Meaning: Damaged by long use; looking tired | สึกหรอ, เก่า; อ่อนล้า
Word (POS): Worn (adj.)
Frequency: Very common — clothes, objects, people
Feeling: Old, weary — ให้ความรู้สึกเก่า ผ่านกาลเวลา เหนื่อยล้า
Example: She wore a worn leather jacket.',CAST(strftime('%s','now') AS INTEGER)*1000+60,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Worn' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Crammed','Meaning: Filled too full; pushed into a small space | อัดแน่น, ยัดเยียด
Word (POS): Crammed (adj./v.)
Frequency: Common — rooms, bags, studying (cram for exams)
Feeling: Crowded, stressful — ให้ความรู้สึกแออัด อึดอัด
Example: The train was crammed with commuters.',CAST(strftime('%s','now') AS INTEGER)*1000+61,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Crammed' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Misery','Meaning: Great unhappiness or suffering | ความทุกข์ยาก, ความทรมาน
Word (POS): Misery (n.)
Frequency: Common — hardship, pain, bad situations
Feeling: Heavy, sad — ให้ความรู้สึกหดหู่ ทุกข์ทรมาน
Example: The war brought misery to millions.',CAST(strftime('%s','now') AS INTEGER)*1000+62,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Misery' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Roving','Meaning: Travelling or moving around from place to place | ร่อนเร่, ตระเวน
Word (POS): Roving (adj.)
Frequency: Less common — reporters, patrols, eyes (a roving eye)
Feeling: Restless, free — ให้ความรู้สึกไม่อยู่นิ่ง เคลื่อนที่ตลอด
Example: A roving patrol checked the area every hour.',CAST(strftime('%s','now') AS INTEGER)*1000+63,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Roving' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Absurdly','Meaning: In a way that is ridiculous; extremely | อย่างไร้สาระ, อย่างน่าขัน
Word (POS): Absurdly (adv.)
Frequency: Common — exaggeration, humour (absurdly expensive)
Feeling: Amused, disbelieving — ให้ความรู้สึกขำปนไม่อยากเชื่อ
Example: The tickets were absurdly expensive.',CAST(strftime('%s','now') AS INTEGER)*1000+64,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Absurdly' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'My head''s been loud','Meaning: My mind has been full of noisy, racing thoughts | ในหัวมันวุ่นวาย คิดไม่หยุด
Word (POS): My head''s been loud (phrase)
Frequency: Less common — stress, anxiety, emotional talk
Feeling: Anxious, overwhelmed — ให้ความรู้สึกฟุ้งซ่าน กังวล ล้นหัว
Example: Sorry I''ve been quiet; my head''s been loud lately.',CAST(strftime('%s','now') AS INTEGER)*1000+65,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='My head''s been loud' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Piled','Meaning: Put things on top of each other in a heap | กองสุมกัน
Word (POS): Piled (adj./v.)
Frequency: Common — dishes, work, clothes (piled up)
Feeling: Messy, overwhelming — ให้ความรู้สึกรก ล้นมือ
Example: Dirty dishes were piled in the sink.',CAST(strftime('%s','now') AS INTEGER)*1000+66,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Piled' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Carefree','Meaning: Having no worries or responsibilities | ไร้กังวล
Word (POS): Carefree (adj.)
Frequency: Common — childhood, holidays, happy times
Feeling: Light, happy — ให้ความรู้สึกสบายใจ อิสระ
Example: We spent a carefree summer by the sea.',CAST(strftime('%s','now') AS INTEGER)*1000+67,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Carefree' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Trekked','Meaning: Walked a long and difficult way | เดินทางไกลอย่างยากลำบาก
Word (POS): Trekked (v.)
Frequency: Common — hiking, long journeys
Feeling: Tiring, adventurous — ให้ความรู้สึกเหนื่อย แต่เป็นการผจญภัย
Example: We trekked through the forest for three days.',CAST(strftime('%s','now') AS INTEGER)*1000+68,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Trekked' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Festered','Meaning: (wound) became infected; (bad feeling) grew worse over time | (แผล) เน่าเปื่อย; (ความรู้สึก) คุกรุ่นสะสม
Word (POS): Festered (v.)
Frequency: Less common — wounds; anger or resentment
Feeling: Dark, toxic — ให้ความรู้สึกหมักหมม เป็นพิษ
Example: His anger festered for years.',CAST(strftime('%s','now') AS INTEGER)*1000+69,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Festered' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Coherent','Meaning: Logical and clear; able to speak clearly | สอดคล้อง, เป็นเหตุเป็นผล; พูดรู้เรื่อง
Word (POS): Coherent (adj.)
Frequency: Common — arguments, plans, speech
Feeling: Clear, organised — ให้ความรู้สึกชัดเจน เป็นระบบ
Example: She gave a clear and coherent explanation.',CAST(strftime('%s','now') AS INTEGER)*1000+70,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Coherent' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Ragged','Meaning: Torn and old; (breathing) uneven | ขาดรุ่งริ่ง; หอบ, ไม่สม่ำเสมอ
Word (POS): Ragged (adj.)
Frequency: Common — clothes; breathing after effort
Feeling: Worn out, rough — ให้ความรู้สึกทรุดโทรม เหนื่อยหอบ
Example: He took a ragged breath after the race.',CAST(strftime('%s','now') AS INTEGER)*1000+71,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Ragged' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Swooning','Meaning: Being overwhelmed with love or excitement; fainting | เคลิบเคลิ้ม, ใจละลาย; เป็นลม
Word (POS): Swooning (v.)
Frequency: Less common — romance, fans, old stories
Feeling: Dreamy, dazzled — ให้ความรู้สึกหลงใหล ใจละลาย
Example: Fans were swooning over the singer.',CAST(strftime('%s','now') AS INTEGER)*1000+72,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Swooning' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Desperate','Meaning: Feeling there is little hope and ready to do anything | สิ้นหวัง; ต้องการอย่างมาก
Word (POS): Desperate (adj.)
Frequency: Very common — crises, strong needs
Feeling: Urgent, hopeless — ให้ความรู้สึกร้อนรน หมดหนทาง
Example: He was desperate to find his sister.',CAST(strftime('%s','now') AS INTEGER)*1000+73,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Desperate' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Occupied','Meaning: Busy or in use; (place) controlled by an enemy | ไม่ว่าง, ถูกใช้อยู่; ถูกยึดครอง
Word (POS): Occupied (adj.)
Frequency: Common — toilets, seats, busy people; war
Feeling: Neutral; tense in war sense — ปกติเป็นกลาง แต่ในบริบทสงครามให้ความรู้สึกตึงเครียด
Example: Sorry, this seat is occupied.',CAST(strftime('%s','now') AS INTEGER)*1000+74,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.1' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Occupied' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Counseling','Meaning: Professional advice to help someone with personal problems | การให้คำปรึกษา
Word (POS): Counseling (n.)
Frequency: Common — schools, mental health, therapy
Feeling: Supportive, caring — ให้ความรู้สึกได้รับการดูแล เห็นอกเห็นใจ
Example: She went to counseling after the accident.',CAST(strftime('%s','now') AS INTEGER)*1000+75,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Counseling' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Perceptive','Meaning: Quick to notice and understand things | ช่างสังเกต, เข้าใจลึกซึ้ง
Word (POS): Perceptive (adj.)
Frequency: Common — describing smart, observant people
Feeling: Admiring — ให้ความรู้สึกชื่นชม ความฉลาดหลักแหลม
Example: That''s a very perceptive question.',CAST(strftime('%s','now') AS INTEGER)*1000+76,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Perceptive' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Candidly','Meaning: Honestly and openly | อย่างเปิดอก, อย่างจริงใจ
Word (POS): Candidly (adv.)
Frequency: Less common — interviews, honest talks (speaking candidly)
Feeling: Honest, open — ให้ความรู้สึกจริงใจ ไม่ปิดบัง
Example: Candidly, I don''t think we''re ready.',CAST(strftime('%s','now') AS INTEGER)*1000+77,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Candidly' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Fort','Meaning: A strong building used to defend a place | ป้อม
Word (POS): Fort (n.)
Frequency: Common — history, war, kids'' games
Feeling: Solid, protective — ให้ความรู้สึกมั่นคง แข็งแรง
Example: The soldiers retreated to the fort.',CAST(strftime('%s','now') AS INTEGER)*1000+78,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Fort' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Holding down the fort','Meaning: Taking care of things while someone is away | เฝ้าที่มั่นไว้, ดูแลแทนชั่วคราว
Word (POS): Holding down the fort (idiom)
Frequency: Common — work, home, teams
Feeling: Responsible, reliable — ให้ความรู้สึกรับผิดชอบ พึ่งพาได้
Example: Thanks for holding down the fort while I was away.',CAST(strftime('%s','now') AS INTEGER)*1000+79,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Holding down the fort' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Emit','Meaning: To send out light, heat, sound or gas | ปล่อย, แผ่ (แสง เสียง ความร้อน)
Word (POS): Emit (v.)
Frequency: Common — science, machines, devices
Feeling: Technical, neutral — ให้ความรู้สึกเป็นวิทยาศาสตร์ เป็นกลาง
Example: The device emits a faint blue light.',CAST(strftime('%s','now') AS INTEGER)*1000+80,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Emit' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Excruciating','Meaning: Extremely painful; very embarrassing or boring | เจ็บปวดแสนสาหัส
Word (POS): Excruciating (adj.)
Frequency: Common — pain; awkward moments
Feeling: Agonising — ให้ความรู้สึกทรมานสุด ๆ
Example: The pain in my leg was excruciating.',CAST(strftime('%s','now') AS INTEGER)*1000+81,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Excruciating' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Mundane','Meaning: Ordinary and not interesting | ธรรมดา, จืดชืด
Word (POS): Mundane (adj.)
Frequency: Common — daily routines and tasks
Feeling: Dull, plain — ให้ความรู้สึกน่าเบื่อ ซ้ำซาก
Example: I spent the day on mundane chores.',CAST(strftime('%s','now') AS INTEGER)*1000+82,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Mundane' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Grave','Meaning: A place where a dead person is buried; very serious | หลุมศพ; ร้ายแรง, เคร่งขรึม
Word (POS): Grave (n./adj.)
Frequency: Common — death; serious situations (grave danger)
Feeling: Solemn, serious — ให้ความรู้สึกหนักแน่น เคร่งเครียด
Example: She spoke in a grave voice.',CAST(strftime('%s','now') AS INTEGER)*1000+83,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Grave' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Exhumed','Meaning: Dug a dead body out of the ground | ขุดศพขึ้นมา
Word (POS): Exhumed (v.)
Frequency: Rare — investigations, history, horror
Feeling: Eerie, grim — ให้ความรู้สึกน่าขนลุก มืดหม่น
Example: The body was exhumed for further tests.',CAST(strftime('%s','now') AS INTEGER)*1000+84,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Exhumed' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Smithereens','Meaning: Small broken pieces (blown to smithereens) | เศษเล็กเศษน้อย, แหลกละเอียด
Word (POS): Smithereens (n.)
Frequency: Less common — explosions, informal exaggeration
Feeling: Dramatic, playful — ให้ความรู้สึกรุนแรงแต่ฟังดูขำ ๆ
Example: The vase was smashed to smithereens.',CAST(strftime('%s','now') AS INTEGER)*1000+85,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Smithereens' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Recipient','Meaning: A person who receives something | ผู้รับ
Word (POS): Recipient (n.)
Frequency: Common — awards, letters, donations
Feeling: Formal, neutral — ให้ความรู้สึกเป็นทางการ
Example: She was the recipient of a national award.',CAST(strftime('%s','now') AS INTEGER)*1000+86,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Recipient' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Loosely','Meaning: Not tightly; not exactly | อย่างหลวม ๆ, คร่าว ๆ
Word (POS): Loosely (adv.)
Frequency: Common — clothes; "loosely based on"
Feeling: Relaxed, inexact — ให้ความรู้สึกไม่เคร่ง ไม่ตรงเป๊ะ
Example: The film is loosely based on a true story.',CAST(strftime('%s','now') AS INTEGER)*1000+87,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Loosely' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Tandem','Meaning: Two things working together (in tandem) | ควบคู่กัน, ไปพร้อมกัน
Word (POS): Tandem (n.)
Frequency: Less common — teamwork, systems, bicycles
Feeling: Cooperative — ให้ความรู้สึกร่วมมือกัน ไปด้วยกัน
Example: The two teams worked in tandem.',CAST(strftime('%s','now') AS INTEGER)*1000+88,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Tandem' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Echelons','Meaning: Levels of power or authority (the upper echelons) | ระดับชั้น (ในองค์กร)
Word (POS): Echelons (n.)
Frequency: Rare — organisations, military, society
Feeling: Formal, elite — ให้ความรู้สึกเป็นทางการ ห่างไกลระดับสูง
Example: The order came from the highest echelons.',CAST(strftime('%s','now') AS INTEGER)*1000+89,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Echelons' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Impunity','Meaning: Freedom from punishment (with impunity) | การรอดพ้นจากการลงโทษ
Word (POS): Impunity (n.)
Frequency: Less common — crime, injustice, politics
Feeling: Unfair, outrageous — ให้ความรู้สึกไม่ยุติธรรม น่าโกรธ
Example: They broke the rules with impunity.',CAST(strftime('%s','now') AS INTEGER)*1000+90,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Impunity' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Immense','Meaning: Extremely large or great | มหาศาล, ใหญ่โตมาก
Word (POS): Immense (adj.)
Frequency: Common — size, power, feelings
Feeling: Awe-inspiring — ให้ความรู้สึกยิ่งใหญ่ น่าทึ่ง
Example: She felt immense relief.',CAST(strftime('%s','now') AS INTEGER)*1000+91,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Immense' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Donor','Meaning: A person who gives money, blood or an organ | ผู้บริจาค
Word (POS): Donor (n.)
Frequency: Common — charity, medicine
Feeling: Generous, kind — ให้ความรู้สึกเสียสละ ใจดี
Example: An anonymous donor paid for the new library.',CAST(strftime('%s','now') AS INTEGER)*1000+92,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Donor' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Infiltrated','Meaning: Secretly entered a group or place to get information or cause harm | แทรกซึม
Word (POS): Infiltrated (v.)
Frequency: Less common — spies, security, crime
Feeling: Sneaky, threatening — ให้ความรู้สึกลับ ๆ ล่อ ๆ อันตราย
Example: A spy had infiltrated the organisation.',CAST(strftime('%s','now') AS INTEGER)*1000+93,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Infiltrated' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Leisurely','Meaning: Relaxed and without hurry | อย่างสบาย ๆ ไม่เร่งรีบ
Word (POS): Leisurely (adj./adv.)
Frequency: Common — walks, meals, holidays
Feeling: Calm, pleasant — ให้ความรู้สึกผ่อนคลาย สบายใจ
Example: We took a leisurely walk by the river.',CAST(strftime('%s','now') AS INTEGER)*1000+94,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Leisurely' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Sabotage','Meaning: To deliberately damage or block something | การก่อวินาศกรรม, การบ่อนทำลาย
Word (POS): Sabotage (n./v.)
Frequency: Common — war, work rivalry, plans
Feeling: Hostile, sneaky — ให้ความรู้สึกมุ่งร้าย ทรยศ
Example: Someone tried to sabotage the launch.',CAST(strftime('%s','now') AS INTEGER)*1000+95,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Sabotage' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Preamble','Meaning: An introduction before the main part of a speech or document | อารัมภบท, คำนำ
Word (POS): Preamble (n.)
Frequency: Less common — formal documents, long speeches (without preamble)
Feeling: Formal, slow — ให้ความรู้สึกเป็นทางการ เกริ่นยาว
Example: Without any preamble, she told us the news.',CAST(strftime('%s','now') AS INTEGER)*1000+96,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Preamble' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Delirious','Meaning: Confused and talking nonsense, often from fever; extremely happy | เพ้อคลั่ง; ดีใจสุดขีด
Word (POS): Delirious (adj.)
Frequency: Less common — illness; extreme joy
Feeling: Feverish, wild — ให้ความรู้สึกสับสนเพ้อ หรือดีใจจนเกินควบคุม
Example: He was delirious with fever all night.',CAST(strftime('%s','now') AS INTEGER)*1000+97,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Delirious' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Cynical','Meaning: Believing people act only for themselves | มองโลกในแง่ร้าย, ไม่เชื่อในความดีของคน
Word (POS): Cynical (adj.)
Frequency: Common — attitudes about people, politics
Feeling: Bitter, distrustful — ให้ความรู้สึกขมขื่น ไม่ไว้ใจใคร
Example: Years in politics made him cynical.',CAST(strftime('%s','now') AS INTEGER)*1000+98,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Cynical' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Perimeter','Meaning: The outer edge of an area | แนวขอบเขต, เส้นรอบรูป
Word (POS): Perimeter (n.)
Frequency: Common — security, maths, military
Feeling: Guarded, alert — ให้ความรู้สึกเฝ้าระวัง เป็นแนวป้องกัน
Example: Guards patrolled the perimeter.',CAST(strftime('%s','now') AS INTEGER)*1000+99,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Perimeter' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Frantic','Meaning: Wild with fear or worry; hurried and disorganised | ร้อนรน, ลนลาน
Word (POS): Frantic (adj.)
Frequency: Common — emergencies, rushing
Feeling: Panicked — ให้ความรู้สึกตื่นตระหนก รีบร้อน
Example: There was a frantic search for the missing child.',CAST(strftime('%s','now') AS INTEGER)*1000+100,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Frantic' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Feigned','Meaning: Pretended (feigned surprise) | แสร้ง, เสแสร้ง
Word (POS): Feigned (adj./v.)
Frequency: Less common — hiding real feelings
Feeling: Fake, sly — ให้ความรู้สึกไม่จริงใจ เจ้าเล่ห์
Example: She feigned surprise at the party.',CAST(strftime('%s','now') AS INTEGER)*1000+101,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Feigned' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Alley','Meaning: A narrow path between buildings | ตรอก, ซอย
Word (POS): Alley (n.)
Frequency: Common — cities, crime stories
Feeling: Narrow, shadowy — ให้ความรู้สึกแคบ มืด อาจน่ากลัว
Example: The cat disappeared down a dark alley.',CAST(strftime('%s','now') AS INTEGER)*1000+102,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Alley' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Apprehend','Meaning: To catch and arrest; (formal) to understand | จับกุม; เข้าใจ
Word (POS): Apprehend (v.)
Frequency: Less common — police and law
Feeling: Official, serious — ให้ความรู้สึกเป็นทางการ จริงจัง
Example: Police apprehended the thief at the station.',CAST(strftime('%s','now') AS INTEGER)*1000+103,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Apprehend' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Whim','Meaning: A sudden wish to do something, without a reason | ความต้องการชั่ววูบ, อารมณ์ชั่วแล่น
Word (POS): Whim (n.)
Frequency: Common — spontaneous choices (on a whim)
Feeling: Playful, impulsive — ให้ความรู้สึกเอาแต่ใจ ไม่ได้คิดมาก่อน
Example: We bought the tickets on a whim.',CAST(strftime('%s','now') AS INTEGER)*1000+104,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Whim' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Diverge','Meaning: To separate and go in different directions | แยกออกจากกัน, แตกต่าง
Word (POS): Diverge (v.)
Frequency: Less common — paths, opinions, data
Feeling: Parting, distant — ให้ความรู้สึกแยกทาง ห่างกันออกไป
Example: Our opinions diverge on this issue.',CAST(strftime('%s','now') AS INTEGER)*1000+105,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Diverge' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Barring','Meaning: Except if; unless something happens | เว้นแต่, ยกเว้น
Word (POS): Barring (prep.)
Frequency: Less common — plans and forecasts (barring accidents)
Feeling: Formal, cautious — ให้ความรู้สึกเป็นทางการ เผื่อเหตุไม่คาดฝัน
Example: Barring delays, we''ll arrive at noon.',CAST(strftime('%s','now') AS INTEGER)*1000+106,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Barring' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Cope','Meaning: To deal successfully with something difficult | รับมือ, จัดการได้
Word (POS): Cope (v.)
Frequency: Very common — stress, loss, hard situations
Feeling: Resilient — ให้ความรู้สึกพยายามยืนหยัด อดทน
Example: She''s learning to cope with the loss.',CAST(strftime('%s','now') AS INTEGER)*1000+107,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Cope' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Keep the numbness at bay','Meaning: To stop a feeling of emptiness from taking over | กันความรู้สึกด้านชาไม่ให้เข้ามา
Word (POS): Keep the numbness at bay (phrase)
Frequency: Rare — emotional, literary writing
Feeling: Melancholic, fragile — ให้ความรู้สึกเศร้า เปราะบาง พยายามประคองใจ
Example: He kept busy to keep the numbness at bay.',CAST(strftime('%s','now') AS INTEGER)*1000+108,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Keep the numbness at bay' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Riddle','Meaning: A puzzling question; (riddled with) full of holes or problems | ปริศนา; เต็มไปด้วย (รู, ปัญหา)
Word (POS): Riddle (n./v.)
Frequency: Common — puzzles; "riddled with errors"
Feeling: Mysterious, playful — ให้ความรู้สึกลึกลับ ชวนขบคิด
Example: The old man spoke in riddles.',CAST(strftime('%s','now') AS INTEGER)*1000+109,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Riddle' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Inseparable','Meaning: Always together; impossible to separate | แยกกันไม่ออก
Word (POS): Inseparable (adj.)
Frequency: Common — close friends, linked ideas
Feeling: Close, loyal — ให้ความรู้สึกผูกพัน สนิทสนม
Example: The two sisters were inseparable.',CAST(strftime('%s','now') AS INTEGER)*1000+110,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Inseparable' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Confine','Meaning: To keep within limits or in a closed space | กักขัง, จำกัด
Word (POS): Confine (v.)
Frequency: Common — rules, rooms, illness (confined to bed)
Feeling: Restrictive — ให้ความรู้สึกถูกจำกัด อึดอัด
Example: Please confine your answers to the question.',CAST(strftime('%s','now') AS INTEGER)*1000+111,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Confine' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Deteriorating','Meaning: Becoming worse | ทรุดลง, เสื่อมลง
Word (POS): Deteriorating (v./adj.)
Frequency: Common — health, buildings, relationships
Feeling: Worrying — ให้ความรู้สึกน่ากังวล แย่ลงเรื่อย ๆ
Example: His health is deteriorating quickly.',CAST(strftime('%s','now') AS INTEGER)*1000+112,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Deteriorating' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Reimbursement','Meaning: Repayment of money someone has spent or lost | การชดใช้เงินคืน
Word (POS): Reimbursement (n.)
Frequency: Less common — work expenses, insurance
Feeling: Formal, practical — ให้ความรู้สึกเป็นทางการ เรื่องเงิน
Example: Submit your receipts for reimbursement.',CAST(strftime('%s','now') AS INTEGER)*1000+113,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Reimbursement' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Excessive','Meaning: More than is necessary or normal | มากเกินไป
Word (POS): Excessive (adj.)
Frequency: Common — amounts, force, behaviour
Feeling: Disapproving — ให้ความรู้สึกเกินพอดี ไม่เห็นด้วย
Example: It would already be excessive.',CAST(strftime('%s','now') AS INTEGER)*1000+114,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Excessive' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Frowns','Meaning: Brings the eyebrows together to show anger, worry or thought | ขมวดคิ้ว, หน้านิ่ว
Word (POS): Frowns (v./n.)
Frequency: Common — facial expressions
Feeling: Displeased, thoughtful — ให้ความรู้สึกไม่พอใจ หรือกำลังครุ่นคิด
Example: She frowns whenever she reads bad news.',CAST(strftime('%s','now') AS INTEGER)*1000+115,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Frowns' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Pensive','Meaning: Thinking deeply, often about something sad | ครุ่นคิด, เหม่อลอย
Word (POS): Pensive (adj.)
Frequency: Less common — quiet, reflective moments
Feeling: Quiet, wistful — ให้ความรู้สึกเงียบ ๆ ครุ่นคิด ปนเศร้า
Example: He looked pensive as he watched the rain.',CAST(strftime('%s','now') AS INTEGER)*1000+116,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Pensive' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Shone','Meaning: Past tense of shine: gave out bright light | ส่องแสง (อดีตของ shine)
Word (POS): Shone (v.)
Frequency: Common — light, eyes, stories
Feeling: Bright, hopeful — ให้ความรู้สึกสว่าง มีความหวัง
Example: The moon shone over the lake.',CAST(strftime('%s','now') AS INTEGER)*1000+117,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Shone' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Confiscating','Meaning: Officially taking something away from someone | ยึด, ริบ
Word (POS): Confiscating (v.)
Frequency: Less common — school rules, police, customs
Feeling: Strict, authoritative — ให้ความรู้สึกเข้มงวด ใช้อำนาจ
Example: The teacher is confiscating phones during the exam.',CAST(strftime('%s','now') AS INTEGER)*1000+118,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.6' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Confiscating' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Trivial','Meaning: Of little value or importance | เล็กน้อย, ไม่สำคัญ
Word (POS): Trivial (adj.)
Frequency: Common — small problems, trivia
Feeling: Minor, dismissive — ให้ความรู้สึกไม่ใช่เรื่องใหญ่
Example: Don''t worry about such trivial details.',CAST(strftime('%s','now') AS INTEGER)*1000+119,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Trivial' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Intermittent','Meaning: Stopping and starting again, not continuous | เป็นพัก ๆ, ไม่ต่อเนื่อง
Word (POS): Intermittent (adj.)
Frequency: Less common — weather, signals, pain
Feeling: Unstable — ให้ความรู้สึกไม่แน่นอน ขาด ๆ หาย ๆ
Example: We had intermittent rain all day.',CAST(strftime('%s','now') AS INTEGER)*1000+120,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Intermittent' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Amnesia','Meaning: Loss of memory | ภาวะความจำเสื่อม
Word (POS): Amnesia (n.)
Frequency: Less common — medicine, mystery stories
Feeling: Lost, uneasy — ให้ความรู้สึกว่างเปล่า สับสน
Example: After the accident, he suffered from amnesia.',CAST(strftime('%s','now') AS INTEGER)*1000+121,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Amnesia' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Candidly','Meaning: Honestly and openly | อย่างเปิดอก, อย่างจริงใจ
Word (POS): Candidly (adv.)
Frequency: Less common — interviews, honest talks (speaking candidly)
Feeling: Honest, open — ให้ความรู้สึกจริงใจ ไม่ปิดบัง
Example: She spoke candidly about her past.',CAST(strftime('%s','now') AS INTEGER)*1000+122,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Candidly' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Botched','Meaning: Done badly or clumsily | ทำพลาด, ทำเละ
Word (POS): Botched (adj./v.)
Frequency: Less common — failed jobs, plans, operations
Feeling: Embarrassing, messy — ให้ความรู้สึกพัง น่าอาย
Example: It was a botched rescue attempt.',CAST(strftime('%s','now') AS INTEGER)*1000+123,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Botched' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Skeptical','Meaning: Doubting that something is true | ไม่เชื่อ, สงสัย
Word (POS): Skeptical (adj.)
Frequency: Common — claims, promises, new ideas
Feeling: Doubtful — ให้ความรู้สึกไม่ค่อยเชื่อ ระแวง
Example: I''m skeptical about his story.',CAST(strftime('%s','now') AS INTEGER)*1000+124,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Skeptical' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Confined','Meaning: Kept in a small or closed space; limited | ถูกจำกัด, ถูกกักไว้
Word (POS): Confined (adj.)
Frequency: Common — rooms, illness, rules
Feeling: Trapped — ให้ความรู้สึกอึดอัด ถูกขัง
Example: He was confined to his room for a week.',CAST(strftime('%s','now') AS INTEGER)*1000+125,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Confined' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Contingency','Meaning: A possible future event you plan for | เหตุการณ์ที่อาจเกิดขึ้น, เหตุฉุกเฉิน
Word (POS): Contingency (n.)
Frequency: Less common — planning (contingency plan)
Feeling: Prepared, cautious — ให้ความรู้สึกเตรียมพร้อม รอบคอบ
Example: We need a contingency plan in case it fails.',CAST(strftime('%s','now') AS INTEGER)*1000+126,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Contingency' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Astronomical','Meaning: Extremely large (cost or number); related to astronomy | มหาศาล; เกี่ยวกับดาราศาสตร์
Word (POS): Astronomical (adj.)
Frequency: Common — prices, numbers, space science
Feeling: Shocking — ให้ความรู้สึกตกใจกับความมากมาย
Example: The repair bill was astronomical.',CAST(strftime('%s','now') AS INTEGER)*1000+127,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Astronomical' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Funnel','Meaning: A cone-shaped tube; to direct things to one place | กรวย; ส่งผ่าน, ทุ่มไปที่
Word (POS): Funnel (n./v.)
Frequency: Common — kitchens; money or resources
Feeling: Focused, directed — ให้ความรู้สึกรวมศูนย์ ไหลไปทางเดียว
Example: They funneled all their money into the project.',CAST(strftime('%s','now') AS INTEGER)*1000+128,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Funnel' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Conscience','Meaning: The inner sense of right and wrong | มโนธรรม, สำนึกผิดชอบ
Word (POS): Conscience (n.)
Frequency: Common — moral choices (guilty conscience)
Feeling: Moral, heavy — ให้ความรู้สึกสำนึก ชั่งใจ
Example: My conscience wouldn''t let me lie.',CAST(strftime('%s','now') AS INTEGER)*1000+129,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Conscience' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Chronic','Meaning: Lasting a long time or keeps coming back | เรื้อรัง
Word (POS): Chronic (adj.)
Frequency: Common — illness, pain, long-term problems
Feeling: Heavy, wearing — ให้ความรู้สึกหนักใจ เป็นมานาน
Example: The city has a chronic shortage of water.',CAST(strftime('%s','now') AS INTEGER)*1000+130,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Chronic' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Liability','Meaning: Legal responsibility; someone or something that causes problems | ภาระ, ความรับผิดชอบทางกฎหมาย
Word (POS): Liability (n.)
Frequency: Common — law, business, teams
Feeling: Burdensome — ให้ความรู้สึกเป็นภาระ ตัวถ่วง
Example: He became a liability to the team.',CAST(strftime('%s','now') AS INTEGER)*1000+131,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Liability' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Resentment','Meaning: A feeling of anger at being treated unfairly | ความขุ่นเคือง, ความแค้นใจ
Word (POS): Resentment (n.)
Frequency: Common — relationships, injustice
Feeling: Bitter — ให้ความรู้สึกขุ่นข้องใจ เก็บกด
Example: She couldn''t hide her resentment.',CAST(strftime('%s','now') AS INTEGER)*1000+132,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Resentment' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Plaque','Meaning: A flat sign with writing on it; a deposit on teeth | แผ่นป้ายจารึก; คราบหินปูน
Word (POS): Plaque (n.)
Frequency: Common — memorials, awards; dentists
Feeling: Commemorative — ให้ความรู้สึกเป็นอนุสรณ์ ระลึกถึง
Example: A plaque marks the house where she was born.',CAST(strftime('%s','now') AS INTEGER)*1000+133,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Plaque' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Revulsion','Meaning: A strong feeling of disgust | ความรู้สึกขยะแขยง
Word (POS): Revulsion (n.)
Frequency: Less common — horror, strong moral reactions
Feeling: Disgusted — ให้ความรู้สึกรังเกียจ อยากถอยหนี
Example: She stepped back in revulsion.',CAST(strftime('%s','now') AS INTEGER)*1000+134,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Revulsion' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Keener','Meaning: More eager; sharper (comparative of keen) | กระตือรือร้นกว่า; แหลมคมกว่า
Word (POS): Keener (adj.)
Frequency: Common — interest, senses (a keener eye)
Feeling: Eager, sharp — ให้ความรู้สึกตั้งใจ เฉียบคม
Example: Nobody was keener to help than him.',CAST(strftime('%s','now') AS INTEGER)*1000+135,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Keener' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Assimilation','Meaning: The process of absorbing something or becoming part of a group | การกลืนกลาย, การซึมซับ
Word (POS): Assimilation (n.)
Frequency: Less common — culture, learning, biology
Feeling: Absorbing, losing identity — ให้ความรู้สึกถูกกลืนเข้าไปเป็นส่วนหนึ่ง
Example: Assimilation into a new culture takes time.',CAST(strftime('%s','now') AS INTEGER)*1000+136,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Assimilation' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Effusive','Meaning: Showing strong feelings in a very open, enthusiastic way | แสดงออกอย่างล้นหลาม
Word (POS): Effusive (adj.)
Frequency: Less common — praise, thanks, greetings
Feeling: Warm, overflowing — ให้ความรู้สึกอบอุ่น ล้นเหลือ
Example: She was effusive in her thanks.',CAST(strftime('%s','now') AS INTEGER)*1000+137,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Effusive' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Ravings','Meaning: Wild, crazy talk that makes no sense | คำพูดเพ้อเจ้อ
Word (POS): Ravings (n.)
Frequency: Rare — madness, fever, villains
Feeling: Unhinged — ให้ความรู้สึกบ้าคลั่ง ไร้เหตุผล
Example: No one listened to the ravings of the old man.',CAST(strftime('%s','now') AS INTEGER)*1000+138,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Ravings' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Tempting','Meaning: Attractive, making you want to do or have it | น่าดึงดูดใจ, ยั่วยวน
Word (POS): Tempting (adj.)
Frequency: Common — offers, food, choices
Feeling: Alluring — ให้ความรู้สึกอยากได้ อดใจยาก
Example: The offer is very tempting.',CAST(strftime('%s','now') AS INTEGER)*1000+139,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Tempting' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Retribution','Meaning: Punishment for something wrong that was done | การแก้แค้น, การลงโทษอย่างสาสม
Word (POS): Retribution (n.)
Frequency: Less common — revenge, justice, stories
Feeling: Vengeful, grim — ให้ความรู้สึกแค้น ต้องชดใช้
Example: They feared retribution from the gang.',CAST(strftime('%s','now') AS INTEGER)*1000+140,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Retribution' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Ephemeral','Meaning: Lasting a very short time | ชั่วคราว, ประเดี๋ยวประด๋าว
Word (POS): Ephemeral (adj.)
Frequency: Less common — beauty, fame, moments
Feeling: Fleeting, poetic — ให้ความรู้สึกงดงามแต่ไม่จีรัง
Example: Fame on the internet is ephemeral.',CAST(strftime('%s','now') AS INTEGER)*1000+141,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Ephemeral' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Imminent','Meaning: About to happen very soon | ใกล้จะเกิดขึ้น
Word (POS): Imminent (adj.)
Frequency: Common — danger, storms, decisions
Feeling: Urgent, tense — ให้ความรู้สึกเร่งด่วน ใกล้ตัว
Example: A storm warning said danger was imminent.',CAST(strftime('%s','now') AS INTEGER)*1000+142,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Imminent' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Unobstructed','Meaning: Clear, with nothing blocking it | ไม่มีสิ่งกีดขวาง, โล่ง
Word (POS): Unobstructed (adj.)
Frequency: Less common — views, paths
Feeling: Open, free — ให้ความรู้สึกโล่ง โปร่ง
Example: The room has an unobstructed view of the sea.',CAST(strftime('%s','now') AS INTEGER)*1000+143,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Unobstructed' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Hindrance','Meaning: Something that makes progress difficult | สิ่งขัดขวาง, ตัวถ่วง
Word (POS): Hindrance (n.)
Frequency: Less common — plans, work, help vs. hindrance
Feeling: Frustrating — ให้ความรู้สึกติดขัด น่าหงุดหงิด
Example: The heavy bag was more of a hindrance than a help.',CAST(strftime('%s','now') AS INTEGER)*1000+144,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Hindrance' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Viable','Meaning: Able to work successfully | เป็นไปได้, ใช้การได้
Word (POS): Viable (adj.)
Frequency: Common — plans, business, options
Feeling: Practical, hopeful — ให้ความรู้สึกมีทางเป็นไปได้
Example: Is this a viable solution?',CAST(strftime('%s','now') AS INTEGER)*1000+145,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Viable' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Content','Meaning: What is inside something; satisfied and happy | เนื้อหา; พอใจ
Word (POS): Content (n./adj.)
Frequency: Very common — media and documents; feelings
Feeling: Peaceful (adj.) — ในความหมายพอใจ ให้ความรู้สึกสงบ อิ่มใจ
Example: She seemed content with her quiet life.',CAST(strftime('%s','now') AS INTEGER)*1000+146,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Content' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Deteriorating','Meaning: Becoming worse | ทรุดลง, เสื่อมลง
Word (POS): Deteriorating (v./adj.)
Frequency: Common — health, buildings, relationships
Feeling: Worrying — ให้ความรู้สึกน่ากังวล แย่ลงเรื่อย ๆ
Example: The weather is deteriorating fast.',CAST(strftime('%s','now') AS INTEGER)*1000+147,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Deteriorating' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Ground zero','Meaning: The exact place where an explosion or disaster happened | จุดศูนย์กลางเหตุ (ระเบิด/หายนะ)
Word (POS): Ground zero (n.)
Frequency: Less common — disasters, news; the starting point of something
Feeling: Grim, intense — ให้ความรู้สึกหนัก เป็นศูนย์กลางความเสียหาย
Example: The lab was ground zero for the outbreak.',CAST(strftime('%s','now') AS INTEGER)*1000+148,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Ground zero' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Unconventional','Meaning: Different from what is usual | นอกกรอบ, ไม่ธรรมดา
Word (POS): Unconventional (adj.)
Frequency: Common — ideas, styles, methods
Feeling: Creative, bold — ให้ความรู้สึกสร้างสรรค์ แหวกแนว
Example: He took an unconventional path to success.',CAST(strftime('%s','now') AS INTEGER)*1000+149,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Unconventional' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Lackadaisical','Meaning: Lazy, showing little effort or interest | เฉื่อยชา, ไม่กระตือรือร้น
Word (POS): Lackadaisical (adj.)
Frequency: Rare — work attitude, criticism
Feeling: Lazy, careless — ให้ความรู้สึกเรื่อยเปื่อย ไม่ใส่ใจ
Example: His lackadaisical attitude annoyed the coach.',CAST(strftime('%s','now') AS INTEGER)*1000+150,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Lackadaisical' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Readily','Meaning: Easily; quickly and willingly | อย่างง่ายดาย; อย่างเต็มใจ
Word (POS): Readily (adv.)
Frequency: Common — availability, agreement
Feeling: Willing, easy — ให้ความรู้สึกสะดวก เต็มใจ
Example: The information is readily available online.',CAST(strftime('%s','now') AS INTEGER)*1000+151,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Readily' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Composure','Meaning: The state of being calm and in control | ความสงบ, ความเยือกเย็น
Word (POS): Composure (n.)
Frequency: Less common — pressure, emotions (lose/regain composure)
Feeling: Calm, dignified — ให้ความรู้สึกสุขุม มีสติ
Example: She quickly regained her composure.',CAST(strftime('%s','now') AS INTEGER)*1000+152,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Composure' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Rewinding','Meaning: Going back to an earlier point in a recording or in time | กรอกลับ, ย้อนกลับ
Word (POS): Rewinding (v.)
Frequency: Common — videos, memories, time travel
Feeling: Nostalgic — ให้ความรู้สึกย้อนวันวาน
Example: I kept rewinding the scene to watch it again.',CAST(strftime('%s','now') AS INTEGER)*1000+153,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Rewinding' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Spherical','Meaning: Shaped like a ball | เป็นทรงกลม
Word (POS): Spherical (adj.)
Frequency: Less common — science, shapes, objects
Feeling: Technical, neutral — ให้ความรู้สึกเป็นวิทยาศาสตร์ เป็นกลาง
Example: The device was small and spherical.',CAST(strftime('%s','now') AS INTEGER)*1000+154,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Spherical' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Compelling','Meaning: Very interesting or convincing | น่าเชื่อถือ, น่าสนใจมาก
Word (POS): Compelling (adj.)
Frequency: Common — stories, arguments, evidence
Feeling: Gripping, persuasive — ให้ความรู้สึกดึงดูด น่าเชื่อ
Example: She made a compelling argument.',CAST(strftime('%s','now') AS INTEGER)*1000+155,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Compelling' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Justifies','Meaning: Shows or proves something is right or reasonable | ให้เหตุผลสนับสนุน, ทำให้ชอบธรรม
Word (POS): Justifies (v.)
Frequency: Common — decisions, actions (the end justifies the means)
Feeling: Defensive, reasoning — ให้ความรู้สึกหาเหตุผลมารองรับ
Example: Nothing justifies that kind of cruelty.',CAST(strftime('%s','now') AS INTEGER)*1000+156,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Justifies' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Wrought','Meaning: Caused (wrought havoc); shaped by hammering (wrought iron) | ก่อให้เกิด; ซึ่งตีขึ้นรูป
Word (POS): Wrought (v./adj.)
Frequency: Rare — literary writing; metalwork
Feeling: Old-fashioned, dramatic — ให้ความรู้สึกโบราณ ขลัง
Example: The storm wrought havoc on the coast.',CAST(strftime('%s','now') AS INTEGER)*1000+157,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Wrought' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Perilous','Meaning: Full of danger | อันตรายมาก
Word (POS): Perilous (adj.)
Frequency: Less common — journeys, situations
Feeling: Threatening — ให้ความรู้สึกเสี่ยงอันตราย
Example: They began a perilous journey across the ice.',CAST(strftime('%s','now') AS INTEGER)*1000+158,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Perilous' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Steep','Meaning: Rising or falling sharply; (price) too high; to soak in liquid | ชัน; แพงเกินไป; แช่
Word (POS): Steep (adj./v.)
Frequency: Common — hills, prices, tea
Feeling: Difficult, demanding — ให้ความรู้สึกยาก หนัก ต้องใช้แรง
Example: The price was too steep for me.',CAST(strftime('%s','now') AS INTEGER)*1000+159,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Steep' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Futility','Meaning: The fact of having no useful result | ความไร้ประโยชน์, ความสูญเปล่า
Word (POS): Futility (n.)
Frequency: Less common — hopeless efforts, war
Feeling: Hopeless — ให้ความรู้สึกสิ้นหวัง ทำไปก็เปล่าประโยชน์
Example: He realised the futility of arguing.',CAST(strftime('%s','now') AS INTEGER)*1000+160,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Futility' COLLATE NOCASE);
INSERT INTO cards(deck_id,front,back,created_at,ease_factor,interval_days,repetitions,due_day) SELECT d._id,'Enviably','Meaning: In a way that others would like to have | อย่างน่าอิจฉา
Word (POS): Enviably (adv.)
Frequency: Rare — describing luck, skill or calm
Feeling: Admiring — ให้ความรู้สึกชื่นชมปนอิจฉา
Example: She remained enviably calm.',CAST(strftime('%s','now') AS INTEGER)*1000+161,2.5,0,0,CAST(julianday('now','localtime','start of day') - 2440587.5 AS INTEGER) FROM decks d WHERE d.name='Wuwa 3.7' AND NOT EXISTS (SELECT 1 FROM cards c WHERE c.deck_id=d._id AND c.front='Enviably' COLLATE NOCASE);
COMMIT;
