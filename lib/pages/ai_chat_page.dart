import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/api_config.dart';

class AiChatPage extends StatefulWidget {
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  late final GenerativeModel _model;
  
  // เพิ่มตัวแปร ChatSession สำหรับเก็บประวัติการสนทนา (Chat History)
  late ChatSession _chat; 

  @override
  void initState() {
    super.initState();
    // เริ่มต้น Gemini Model พร้อมกำหนด System Prompt (กำหนดบุคลิก)
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: ApiConfig.geminiApiKey,
      // กำหนดบุคลิกของ AI ด้วย systemInstruction
      systemInstruction: Content.system(
          'คุณคือ AI ผู้ช่วยนักพัฒนา Flutter ชื่อน้อง "ฟลัตตี้" (Flutty) ให้ตอบคำถามด้วยความกระตือรือร้น เป็นกันเอง ใช้ภาษาไทยที่เข้าใจง่าย และเชี่ยวชาญการเขียนโค้ด Flutter มากๆ (ใช้ Emoji ประกอบการตอบด้วยเสมอ)'),
    );
    
    // เริ่มต้น Chat Session เพื่อให้มันจำประวัติการคุยแทนการถามตอบแบบครั้งเดียวจบ
    _chat = _model.startChat();
  }

  // ส่งข้อความไปยัง Gemini API
  Future<void> _sendMessage() async {
    final userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': userMessage});
      _isLoading = true;
    });
    _controller.clear();

    try {
      // ใช้ _chat.sendMessage แทน เพื่อให้ระบบจัดการและส่ง History ไปด้วยอัตโนมัติ
      final response = await _chat.sendMessage(Content.text(userMessage));
      
      setState(() {
        _messages.add({
          'role': 'assistant',
          'text': response.text ?? 'ไม่ได้รับการตอบกลับ'
        });
      });
    } catch (e) {
      setState(() {
        _messages.add({
          'role': 'assistant',
          'text': 'เกิดข้อผิดพลาด: ${e.toString()}'
        });
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // ฟังก์ชันล้างแชท (Clear Chat)
  void _clearChat() {
    setState(() {
      _messages.clear(); // ล้างหน้าจอข้อความเก่า
      _chat = _model.startChat(); // รีเซ็ต Session ใหม่เพื่อลบความจำเดิมทั้งหมด
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini AI Chat'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          // ปุ่ม Clear Chat ตรงมุมขวาบน
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'ล้างประวัติแชท',
            onPressed: _clearChat,
          ),
        ],
      ),
      body: Column(
        children: [
          // รายการข้อความ
          Expanded(
            child: _messages.isEmpty
                ? const Center(
                    child: Text(
                      '👋 ทักทายน้อง ฟลัตตี้!\nผู้ช่วย Flutter ของคุณ\nลองพิมพ์ข้อความด้านล่าง',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isUser = message['role'] == 'user';
                      
                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.blue : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            message['text']!,
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          
          // Loading Indicator
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          
          // Input Box
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'พิมพ์ข้อความ...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                    textInputAction: TextInputAction.send,
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton.small(
                  onPressed: _isLoading ? null : _sendMessage,
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
