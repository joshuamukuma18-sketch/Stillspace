import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const StillSpaceApp());
}


class StillSpaceApp extends StatefulWidget {
  const StillSpaceApp({super.key});

  @override
  State<StillSpaceApp> createState() => _StillSpaceAppState();
}

class _StillSpaceAppState extends State<StillSpaceApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StillSpace',
      debugShowCheckedModeBanner: false,

      themeMode: _themeMode,

      // LIGHT MODE
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF91A995),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF2EDE2),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF2EDE2),
          foregroundColor: Color(0xFF30363D),
          elevation: 0,
        ),
      ),

      // DARK MODE
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF91A995),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF30363D),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF30363D),
          foregroundColor: Color(0xFFF2EDE2),
          elevation: 0,
        ),
      ),

      home: const HomeScreen(),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> moods = const [
    {'name': 'Calm', 'emoji': '😌', 'activities': ['Gratitude Moment', 'Mindful Walking', 'Positive Reflection']},
    {'name': 'Happy', 'emoji': '😊', 'activities': ['Happy Memories', 'Celebrate Yourself', 'Share Kindness']},
    {'name': 'Okay', 'emoji': '🙂', 'activities': ['Daily Reflection', 'Gentle Stretching', 'Mindful Breathing']},
    {'name': 'Anxious', 'emoji': '😟', 'activities': ['Breathing Exercise', '5 Senses Grounding', 'Calm Thoughts']},
    {'name': 'Low', 'emoji': '😔', 'activities': ['Small Positive Steps', 'Self Kindness', 'Reach Out to Someone']},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            const SizedBox(height: 20),
            const Text(
              'StillSpace 🌿',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF526F5C)),
            ),
            const SizedBox(height: 10),
            const Text('Take a breath. You are here.', style: TextStyle(fontSize: 17)),
            const SizedBox(height: 30),
            const Text(
              'How are you feeling today?',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 18),
            ...moods.map((mood) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(14),
                leading: Text(mood['emoji'], style: const TextStyle(fontSize: 30)),
                title: Text(mood['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ActivitiesScreen(
                        mood: mood['name'],
                        activities: List<String>.from(mood['activities']),
                      ),
                    ),
                  );
                },
              ),
            )),
            const SizedBox(height: 12),
            Card(
              child: ListTile( 
                leading: const Icon(Icons.air, size: 32),
                title: const Text('Breathing Coach'),
                subtitle: const Text('Take a peaceful moment.'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BreathingScreen()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivitiesScreen extends StatelessWidget {
  final String mood;
  final List<String> activities;

  const ActivitiesScreen({
    super.key,
    required this.mood,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$mood Activities')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Activities for when you feel $mood.',
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          ...activities.map((activity) => Card(
            child: ListTile(
              leading: const Icon(Icons.spa),
              title: Text(activity),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ActivityDetailScreen(title: activity),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

class ActivityDetailScreen extends StatelessWidget {
  final String title;

  const ActivityDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text(
              'Take your time with this activity. There is no pressure to get everything right. Go at a comfortable pace.',
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Finish Activity'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() =>
      _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> {
  int step = 0;
  bool voiceEnabled = true;

  final FlutterTts flutterTts = FlutterTts();

  final List<String> instructions = const [
    'Breathe in gently.',
    'Pause for a moment.',
    'Breathe out slowly.',
    'Relax and begin again.',
  ];

  @override
  void initState() {
    super.initState();
    setupVoice();
  }

  Future<void> setupVoice() async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    if (mounted && voiceEnabled) {
      await speakInstruction();
    }
  }

  Future<void> speakInstruction() async {
    if (!voiceEnabled) return;

    await flutterTts.stop();
    await flutterTts.speak(instructions[step]);
  }

  Future<void> nextStep() async {
    setState(() {
      step = (step + 1) % instructions.length;
    });

    await speakInstruction();
  }

  Future<void> toggleVoice() async {
    setState(() {
      voiceEnabled = !voiceEnabled;
    });

    if (voiceEnabled) {
      await speakInstruction();
    } else {
      await flutterTts.stop();
    }
  }

  Future<void> replayVoice() async {
    await speakInstruction();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Coach'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.air,
                size: 80,
                color: Colors.teal,
              ),
              const SizedBox(height: 25),
              const Text(
                'Take a moment for yourself',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 20),
              Text(
                instructions[step],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              FilledButton(
                onPressed: nextStep,
                child: const Text('Next Step'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: toggleVoice,
                icon: Icon(
                  voiceEnabled ? Icons.volume_up : Icons.volume_off,
                ),
                label: Text(
                  voiceEnabled ? 'Voice ON' : 'Voice OFF',
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: voiceEnabled ? replayVoice : null,
                icon: const Icon(Icons.replay),
                label: const Text('Replay Instruction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
