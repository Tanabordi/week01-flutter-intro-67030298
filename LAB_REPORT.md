## 📋 ส่วนที่ 3: แบบบันทึกผลการทดลอง (Lab Report)

### 3.1 ผลการติดตั้ง Flutter

flutter doctor output:
<img width="983" height="902" alt="image" src="https://github.com/user-attachments/assets/0275c547-7bcd-4813-93c9-ee1976136f3e" />

```
Flutter Version: 3.44.4
Dart Version: 3.12.2
Android SDK Version: 36.0.0
```

### 3.2 Screenshot ของ Flutter App

<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/47856617-2a5f-4b9d-bbb1-f22ffc3b6ae7" />
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/3dbf5350-f998-49a9-8a74-80b8d4c06454" />

**Widget Tree ที่วาด:**

```
MyApp
└── MaterialApp
    └── ProfilePage
        └── Scaffold
            ├── AppBar
            │   └── Text ('โปรไฟล์ของฉัน')
            └── SingleChildScrollView
                └── Padding
                    └── Column
                        ├── SizedBox
                        ├── CircleAvatar
                        │   └── Icon (Icons.person)
                        ├── SizedBox
                        ├── Text ('นายธนบดี บุญภมร')
                        ├── SizedBox
                        ├── Text ('รหัสนักศึกษา: 67030298')
                        ├── SizedBox
                        ├── Card
                        │   └── Padding
                        │       └── Column
                        │           ├── Row (ข้อมูล: คณะ)
                        │           ├── Divider
                        │           ├── Row (ข้อมูล: มหาวิทยาลัย)
                        │           ├── Divider
                        │           ├── Row (ข้อมูล: วิชาที่ชอบ)
                        │           ├── Divider
                        │           ├── Row (ข้อมูล: เป้าหมาย)
                        │           ├── Divider
                        │           └── Row (ข้อมูล: งานอดิเรก)
                        ├── SizedBox
                        ├── WeatherCard (การ์ดสภาพอากาศ)
                        ├── SizedBox
                        └── ElevatedButton.icon (ปุ่มกด)
                            ├── Icon (Icons.smart_toy)
                            └── Text ('ทดลอง AI Chat')
```

### 3.3 การเปรียบเทียบ Hot Reload vs Hot Restart

| รายการ | Hot Reload (r) | Hot Restart (R) |
|---|---|---|
| ความเร็ว | ทำงานได้อย่างรวดเร็วมากในระดับเสี้ยววินาที | ทำงานได้รวดเร็วแต่จะใช้เวลาโหลดนานกว่าแบบรัน Hot Reload |
| State ถูก Reset? | ค่า State จะไม่ถูกรีเซ็ตและยังคงค่าสถานะเดิมไว้ | ค่า State จะถูกรีเซ็ตทั้งหมดกลับไปเป็นค่าเริ่มต้น |
| ใช้เมื่อไหร่ | ใช้เมื่อมีการปรับแต่งหน้าตา UI หรือแก้ไขโค้ดทั่วไปที่ต้องการดูผลลัพธ์ทันที | ใช้เมื่อมีการเพิ่มไฟล์โครงสร้างใหม่ เปลี่ยนแปลงค่าตัวแปรหลักหรือแก้ไขโค้ดที่ต้องการให้ระบบเริ่มรันใหม่ตั้งแต่ต้น |

### 3.4 ผลการทดลอง Prompt Engineering

**Prompt แบบ Simple:**
```
แนะนำเมนูไข่หน่อย
```

**Prompt แบบ Detailed:**
```
ตอนนี้มีไข่ไก่ 2 ฟอง มาม่า 1 ห่อ และชีส 1 แผ่น แต่ไม่มีเตาแก๊ส (มีแค่ไมโครเวฟ) ช่วยคิดเมนูอาหารเย็นสไตล์เด็กหอที่ทำง่ายๆ ใช้เวลาไม่เกิน 5 นาที พร้อมบอกวิธีทำทีละขั้นตอนให้หน่อย
```

**ความแตกต่างของผลลัพธ์:**
```
ใช้ Prompt แบบ Simple AI จะสุ่มเมนูไข่ ซึ่งบางเมนูอาจจะทำไม่ได้เพราะอุปกรณ์หรือวัตถุดิบไม่ครบแต่พอใช้ Prompt แบบ Detailed ที่มีการระบุเงื่อนไขและข้อจำกัดชัดเจนจะทำให้ AI จะตอบโจทย์ได้ตรงจุดกว่า ซึ่งได้เมนูที่ทำในไมโครเวฟได้จริงและบอกวิธีทำที่เข้าใจง่ายตรงกับความต้องการ
```

### 3.5 Screenshot ของ AI Chat App

<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/9eac14df-e0cf-40aa-8c4c-87a25e4c4aba" />
<img width="1920" height="1020" alt="image" src="https://github.com/user-attachments/assets/a6f35f56-e471-4fcd-9a00-9c3ed320e7ec" />
