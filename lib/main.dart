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
              child: Text('Thank you for checking in.'),
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
