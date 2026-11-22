import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
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
    seedColor: const Color(0xFF78977F),
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: const Color(0xFF26352D),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF26352D),
    foregroundColor: Color(0xFFF6F8F4),
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
                
onTap: () async {
  final prefs = await SharedPreferences.getInstance();

  final history = prefs.getStringList('mood_history') ?? [];

  final now = DateTime.now();

  final today =
      '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

  final selectedMood = mood['name'].toString();

  // Keep only one mood entry per day.
  history.removeWhere((entry) => entry.startsWith('$today|'));

  history.add('$today|$selectedMood');

  await prefs.setStringList('mood_history', history);

  if (!context.mounted) return;
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
  final FlutterTts flutterTts = FlutterTts();

  Timer? breathingTimer;

  int phase = 0;
  int secondsRemaining = 4;
  int completedCycles = 0;

  bool voiceEnabled = true;
  bool isPaused = false;
  bool isFinished = false;

  final List<Map<String, dynamic>> phases = [
    {
      'name': 'Breathe In',
      'message': 'Breathe in gently.',
      'duration': 4,
      'size': 220.0,
    },
    {
      'name': 'Pause',
      'message': 'Pause gently.',
      'duration': 2,
      'size': 220.0,
    },
    {
      'name': 'Breathe Out',
      'message': 'Breathe out slowly.',
      'duration': 4,
      'size': 120.0,
    },
    {
      'name': 'Rest',
      'message': 'Relax for a moment.',
      'duration': 2,
      'size': 120.0,
    },
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

    if (mounted) {
      startExercise();
    }
  }

  Future<void> speakInstruction() async {
    if (!voiceEnabled) return;

    await flutterTts.stop();
    await flutterTts.speak(phases[phase]['message']);
  }

  void startExercise() {
    breathingTimer?.cancel();

    setState(() {
      phase = 0;
      secondsRemaining = 4;
      completedCycles = 0;
      isPaused = false;
      isFinished = false;
    });

    speakInstruction();

    breathingTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (secondsRemaining > 1) {
          setState(() {
            secondsRemaining--;
          });
        } else {
          moveToNextPhase();
        }
      },
    );
  }

  void moveToNextPhase() {
    if (phase == 3) {
      if (completedCycles + 1 >= 5) {
        breathingTimer?.cancel();

        setState(() {
          completedCycles = 5;
          isFinished = true;
        });

        flutterTts.stop();
        return;
      }

      completedCycles++;
    }

    setState(() {
      phase = (phase + 1) % phases.length;
      secondsRemaining = phases[phase]['duration'];
    });

    speakInstruction();
  }

  void pauseExercise() {
    breathingTimer?.cancel();
    flutterTts.stop();

    setState(() {
      isPaused = true;
    });
  }

  void resumeExercise() {
    if (isFinished) return;

    setState(() {
      isPaused = false;
    });

    speakInstruction();

    breathingTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (secondsRemaining > 1) {
          setState(() {
            secondsRemaining--;
          });
        } else {
          moveToNextPhase();
        }
      },
    );
  }

  Future<void> toggleVoice() async {
    setState(() {
      voiceEnabled = !voiceEnabled;
    });

    if (voiceEnabled && !isPaused && !isFinished) {
      await speakInstruction();
    } else {
      await flutterTts.stop();
    }
  }

  @override
  void dispose() {
    breathingTimer?.cancel();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPhase = phases[phase];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Coach'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Take a moment for yourself',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              AnimatedContainer(
                duration: Duration(
                  seconds: currentPhase['duration'],
                ),
                curve: Curves.easeInOut,
                width: currentPhase['size'],
                height: currentPhase['size'],
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.teal,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    isFinished
                        ? 'Done!'
                        : '$secondsRemaining',
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Text(
                isFinished
                    ? 'Well done! You completed your breathing session.'
                    : currentPhase['name'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Completed cycles: $completedCycles / 5',
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 25),

              OutlinedButton.icon(
                onPressed: toggleVoice,
                icon: Icon(
                  voiceEnabled
                      ? Icons.volume_up
                      : Icons.volume_off,
                ),
                label: Text(
                  voiceEnabled ? 'Voice ON' : 'Voice OFF',
                ),
              ),

              const SizedBox(height: 12),

              if (!isFinished)
                FilledButton.icon(
                  onPressed: isPaused
                      ? resumeExercise
                      : pauseExercise,
                  icon: Icon(
                    isPaused ? Icons.play_arrow : Icons.pause,
                  ),
                  label: Text(
                    isPaused ? 'Resume' : 'Pause',
                  ),
                ),

              const SizedBox(height: 12),

              OutlinedButton.icon(
                onPressed: startExercise,
                icon: const Icon(Icons.refresh),
                label: const Text('Restart Exercise'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

