import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF241D4F),
        ), // สีน้ำเงิน
        useMaterial3: true,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFFED1C24), // สีแดง
        foregroundColor: Colors.white, // สีขาว
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // รูปโปรไฟล์
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFF241D4F), // สีน้ำเงิน
              child: Icon(Icons.person, size: 60, color: Colors.white), // สีขาว
            ),

            const SizedBox(height: 16),

            // ชื่อ — TODO: เปลี่ยนเป็นชื่อของคุณ
            const Text(
              'นายธนบดี บุญภมร',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // รหัสนักศึกษา — TODO: เปลี่ยนเป็นรหัสของคุณ
            const Text(
              'รหัสนักศึกษา: 67030298',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 24),

            // Card ข้อมูล
            Card(
              elevation: 4,
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
                  ],
                ),
              ),
            ),
          ],
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
          Icon(icon, color: const Color(0xFFED1C24)), // สีแดง
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
