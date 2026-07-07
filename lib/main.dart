import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'widgets/weather_card.dart';
import 'pages/ai_chat_page.dart';
import 'config/api_config.dart';

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
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system, 
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isCardExpanded = false;
  
  // ตัวแปรสำหรับ Challenge 3
  String? _aiIntro;
  bool _isGeneratingIntro = false;

  // ฟังก์ชันสำหรับให้ AI สร้างคำแนะนำตัว
  Future<void> _generateIntro() async {
    setState(() {
      _isGeneratingIntro = true;
      _aiIntro = null;
    });

    try {
      final model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: ApiConfig.geminiApiKey,
      );

      // สร้าง Prompt โดยดึงข้อมูล Profile ส่งไปให้ AI
      final prompt = '''
จงเขียนแนะนำตัวสั้นๆ ประมาณ 2-3 บรรทัด ให้น่าสนใจ ดูเป็นกันเอง และน่าตื่นเต้น จากข้อมูลของฉันต่อไปนี้:
ชื่อ: นายธนบดี บุญภมร
รหัสนักศึกษา: 67030298
คณะ: ครุศาสตร์อุตสาหกรรมและเทคโนโลยี
มหาวิทยาลัย: สถานบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง
วิชาที่ชอบ: Mobile Development
เป้าหมาย: พัฒนาแอปให้ได้ 1 ตัว
งานอดิเรก: เล่นเกมและดูการ์ตูน
ความสามารถพิเศษ: เรียนรู้ไว และมีไฟในการเขียนโค้ด!
''';

      final response = await model.generateContent([Content.text(prompt)]);
      
      setState(() {
        _aiIntro = response.text;
      });
    } catch (e) {
      setState(() {
        _aiIntro = 'เกิดข้อผิดพลาดในการเชื่อมต่อกับ AI: $e';
      });
    } finally {
      setState(() {
        _isGeneratingIntro = false;
      });
    }
  }

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

              GestureDetector(
                onTap: () {
                  setState(() {
                    _isCardExpanded = !_isCardExpanded;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.facebook, color: Colors.blue),
                    iconSize: 32,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.code), 
                    iconSize: 32,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.email, color: Colors.redAccent),
                    iconSize: 32,
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // --- ส่วนที่ทำ Challenge 3 ---
              ElevatedButton.icon(
                onPressed: _isGeneratingIntro ? null : _generateIntro,
                icon: const Icon(Icons.auto_awesome),
                label: const Text('ให้ AI ช่วยเขียนแนะนำตัว'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // แสดง Loading หรือ ข้อความที่ AI แต่งให้
              if (_isGeneratingIntro)
                const CircularProgressIndicator(color: Colors.orange)
              else if (_aiIntro != null)
                Card(
                  color: Theme.of(context).brightness == Brightness.dark 
                      ? Colors.orange.withOpacity(0.2) 
                      : Colors.orange.shade50,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.orange.withOpacity(0.5)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _aiIntro!,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              // --------------------------

              const SizedBox(height: 24),
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

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange),
          const SizedBox(width: 12),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
