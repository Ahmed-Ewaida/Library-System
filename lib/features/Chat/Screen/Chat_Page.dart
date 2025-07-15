import 'package:flutter/material.dart';
import '../Widget/Chat_Bubble.dart';
import '../Widget/Message_Input.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static String id = "/ChatPage";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> messages = [
    {
      'text': 'السلام عليكم ورحمة الله وبركاته',
      'isMe': true,
      'time': '11:31 AM',
      'date': '16/2/2025'
    },
    {
      'text': 'هل يمكنني استعارة كتاب من المكتبة؟',
      'isMe': true,
      'time': '11:31 AM'
    },
    {
      'text': 'السلام عليكم ورحمة الله وبركاته',
      'isMe': false,
      'time': '11:35 AM'
    },
    {
      'text': 'يمكنك الاستعارة بعد تقديم الأوراق المطلوبة',
      'isMe': false,
      'time': '11:35 AM'
    },
    {
      'text': 'وهل يمكنني استعارة أكثر من كتاب في نفس الوقت؟',
      'isMe': true,
      'time': '11:36 AM'
    },
    {
      'text': 'لا، يمكنك استعارة كتاب واحد فقط كل مرة',
      'isMe': false,
      'time': '11:45 AM'
    },
    {
      'text': 'حسنًا شكرًا جزيلًا على المساعدة',
      'isMe': true,
      'time': '11:52 PM'
    },
    {
      'text': 'على الرحب والسعة، استمتع بالقراءة',
      'isMe': false,
      'time': '11:46 AM'
    },
  ];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      messages.add({
        'text': text,
        'isMe': true,
        'time': TimeOfDay.now().format(context),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أمينة المكتبة'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        // leading: const BackArrow(),
      ),
      body: Column(
        children: [
          if (messages.isNotEmpty && messages.first.containsKey('date'))
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  messages.first['date'],
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatBubble(
                  text: message['text'],
                  isMe: message['isMe'],
                  time: message['time'],
                );
              },
            ),
          ),
          MessageInput(onSend: sendMessage),
        ],
      ),
    );
  }
}
