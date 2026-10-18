import 'package:flutter/material.dart';

void main() {
  runApp(const StillSpaceApp());
}

class StillSpaceApp extends StatelessWidget {
  const StillSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StillSpace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedMood;

  final Map<String, String> messages = {
    'Calm': 'Enjoy this peaceful moment. You deserve time to breathe.',
    'Happy': 'Let yourself enjoy this moment. Your happiness matters!',
    'Okay': 'It is okay to feel just okay. Take today one step at a time.',
    'Anxious': 'Take a slow breath. You do not have to solve everything right now.',
    'Low': 'Be gentle with yourself. Small steps are enough for today.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8F6),
      appBar: AppBar(
        title: const Text('StillSpace'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF2F8F6),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              const Text(
                'Take a breath.',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF24594F),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'How are you feeling today?',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 10,
                runSpacing: 12,
                children: messages.keys.map((mood) {
                  return ChoiceChip(
                    label: Text(mood),
                    selected: selectedMood == mood,
                    onSelected: (selected) {
                      setState(() {
                        selectedMood = selected ? mood : null;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              if (selectedMood != null)
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'A little reminder for you',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal.shade800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          messages[selectedMood]!,
                          style: const TextStyle(
                            fontSize: 17,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedMood = null;
                            });
                          },
                          child: const Text('Choose another mood'),
                        ),
                      ],
                    ),
                  ),
                ),
              const Spacer(),
              const Center(
                child: Text(
                  'Take things one breath at a time. 💚',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
