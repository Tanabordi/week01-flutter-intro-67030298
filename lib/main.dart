import 'package:flutter/material.dart';
import 'widgets/weather_card.dart';
import 'pages/ai_chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile',
      // รองรับ ธีมสว่าง (Light Theme)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      // เพิ่มการรองรับ ธีมมืด (Dark Theme)
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system, // ดึงค่าการตั้งค่าจากระบบมือถือ (สว่าง/มืด)
      home: const ProfilePage(),
    );
  }
}

// เปลี่ยน ProfilePage เป็น StatefulWidget เพื่อให้รองรับ Animation และ State
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ตัวแปรเก็บสถานะว่าการ์ดถูกกดให้ขยายอยู่หรือไม่
  bool _isCardExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('โปรไฟล์ของฉัน'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // รูปโปรไฟล์
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.orange,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),

              const SizedBox(height: 16),

              const Text(
                'นายธนบดี บุญภมร',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                'รหัสนักศึกษา: 67030298',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 24),

              // ใช้ GestureDetector เพื่อจับ Event การแตะที่การ์ด
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isCardExpanded = !_isCardExpanded; // สลับสถานะเมื่อถูกกด
                  });
                },
                // ใช้ AnimatedContainer แทน Card เพื่อให้มีการขยับแบบ Smooth
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  // เมื่อกดขยาย จะลดขอบ margin ด้านข้างให้การ์ดดูกว้างขึ้น
                  margin: EdgeInsets.symmetric(horizontal: _isCardExpanded ? 0 : 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: _isCardExpanded ? 16 : 4,
                        spreadRadius: _isCardExpanded ? 4 : 1,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          Icons.school,
                          'คณะ',
                          'ครุศาสตร์อุตสาหกรรมและเทคโนโลยี',
                        ),
                        const Divider(),
                        _buildInfoRow(
                          Icons.business,
                          'มหาวิทยาลัย',
                          'สถานบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง',
                        ),
                        const Divider(),
                        _buildInfoRow(
                          Icons.code,
                          'วิชาที่ชอบ',
                          'Mobile Development',
                        ),
                        const Divider(),
                        _buildInfoRow(
                          Icons.star,
                          'เป้าหมาย',
                          'พัฒนาแอปให้ได้ 1 ตัว',
                        ),
                        const Divider(),
                        _buildInfoRow(
                          Icons.favorite,
                          'งานอดิเรก',
                          'เล่นเกมและดูการ์ตูน',
                        ),
                        // ถ้าการ์ดขยายอยู่ ให้โชว์แถวพิเศษขึ้นมา (Animation)
                        if (_isCardExpanded) ...[
                          const Divider(),
                          _buildInfoRow(
                            Icons.lightbulb,
                            'ความสามารถพิเศษ',
                            'เรียนรู้ไว และมีไฟในการเขียนโค้ด!',
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // เพิ่มปุ่ม Social Media Links
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.facebook, color: Colors.blue),
                    iconSize: 32,
                    onPressed: () {
                      // เพิ่มโค้ดไปเปิด Facebook
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.code), // ใช้ไอคอน Code แทน Github
                    iconSize: 32,
                    onPressed: () {
                      // เพิ่มโค้ดเปิด Github
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.email, color: Colors.redAccent),
                    iconSize: 32,
                    onPressed: () {
                      // เพิ่มโค้ดเปิด Email
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),
              // ตัวอย่างการนำไปใช้งานในหน้าจอ (Usage Example)
              const WeatherCard(
                city: 'Bangkok',
                temperature: 32.5,
                condition: 'sunny',
                humidity: 65,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AiChatPage()),
                  );
                },
                icon: const Icon(Icons.smart_toy),
                label: const Text('ทดลอง AI Chat'),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Method สร้างแถวข้อมูล
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange), // สีส้ม
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
