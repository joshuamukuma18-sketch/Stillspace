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
          seedColor: const Color(0xFF789681),
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
  String? mood;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StillSpace')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Take a breath.',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text('How are you feeling today?'),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: ['Calm', 'Happy', 'Okay', 'Anxious', 'Low']
                .map(
                  (item) => ChoiceChip(
                    label: Text(item),
                    selected: mood == item,
                    onSelected: (selected) {
  if (selected) {
    setState(() {
      mood = item;
    });
  }
},
                  ),
                )
                .toList(),
          ),
          if (mood != null)
  Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mood == 'Calm'
                  ? 'Your calming moment'
                  : mood == 'Happy'
                      ? 'Keep your happiness growing'
                      : mood == 'Okay'
                          ? 'Take a mindful pause'
                          : mood == 'Anxious'
                              ? 'Let’s ease your worries'
                              : 'Be gentle with yourself',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              mood == 'Calm'
                  ? 'Breathe in gently for 4 seconds, then breathe out for 6 seconds. Repeat 5 times.'
                  : mood == 'Happy'
                      ? 'Take a moment to notice three good things about today.'
                      : mood == 'Okay'
                          ? 'Relax your shoulders and take three slow, comfortable breaths.'
                          : mood == 'Anxious'
                              ? 'Name 5 things you see, 4 things you feel, and 3 things you hear.'
                              : 'Take a small break, drink some water, and choose one kind thing to do for yourself.',
            ),
          ],
        ),
      ),
    ),
  ),
        
            
          const SizedBox(height: 24),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'A moment to reset\n\n'
                'Relax your shoulders and breathe gently. '
                'Take things one moment at a time.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
