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

  Future<void> changeTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('app_theme', mode.name);

    if (!mounted) return;

    setState(() {
      _themeMode = mode;
    });
  }
@override
void initState() {
  super.initState();
  loadTheme();
}

Future<void> loadTheme() async {
  final prefs = await SharedPreferences.getInstance();

  final savedTheme = prefs.getString('app_theme');

  if (!mounted) return;

  setState(() {
    if (savedTheme == 'light') {
      _themeMode = ThemeMode.light;
    } else if (savedTheme == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }
  });
}
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

      home: HomeScreen(
  onThemeChanged: changeTheme,
),
    );
  }
}
class HomeScreen extends StatelessWidget {
  final ValueChanged<ThemeMode> onThemeChanged;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
  });

  final List<Map<String, dynamic>> moods = const [
    {'name': 'Calm', 'emoji': '😌', 'activities': ['Gratitude Moment', 'Mindful Walking', 'Positive Reflection']},
    {'name': 'Happy', 'emoji': '😊', 'activities': ['Happy Memories', 'Celebrate Yourself', 'Share Kindness']},
    {'name': 'Okay', 'emoji': '🙂', 'activities': ['Daily Reflection', 'Gentle Stretching', 'Mindful Breathing']},
    {'name': 'Anxious', 'emoji': '😟', 'activities': ['Breathing Exercise', '5 Senses Grounding', 'Calm Thoughts']},
    {'name': 'Low', 'emoji': '😔', 'activities': ['Small Positive Steps', 'Self Kindness', 'Reach Out to Someone']},
  ];

  @override
  Widget build(BuildContext context) {
    const cardColors = [
      Color(0xFFE8F0E8),
      Color(0xFFF1EEE3),
      Color(0xFFE9EFF0),
      Color(0xFFF2E9E5),
      Color(0xFFEDEAF2),
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            const SizedBox(height: 15),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Text(
      'StillSpace 🌿',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Color(0xFF526F5C),
      ),
    ),
    IconButton(
      icon: const Icon(
        Icons.settings,
        color: Color(0xFF526F5C),
        size: 28,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SettingsScreen(
              onThemeChanged: onThemeChanged,
            ),
          ),
        );
      },
    ),
  ],
),
            
            const SizedBox(height: 8),

            const Text(
              'A little space for yourself.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF68776B),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: const Color(0xFFE4EDE4),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Take a breath. You are here. 🌱',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF405D49),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'You deserve a moment of peace. '
                    'Take things one step at a time.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Color(0xFF526F5C),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'How are you feeling today?',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF354B3B),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Choose the feeling that best describes your day.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF68776B),
              ),
            ),

            const SizedBox(height: 18),

            ...moods.asMap().entries.map((entry) {
              final mood = entry.value;
              final cardColor =
                  cardColors[entry.key % cardColors.length];

              return Card(
                color: cardColor,
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  leading: Text(
                    mood['emoji'],
                    style: const TextStyle(fontSize: 32),
                  ),
                  title: Text(
                    mood['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF354B3B),
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 17,
                    color: Color(0xFF526F5C),
                  ),
                  onTap: () async {
                    final prefs =
                        await SharedPreferences.getInstance();

                    final history =
                        prefs.getStringList('mood_history') ?? [];

                    final now = DateTime.now();

                    final today =
                        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

                    final selectedMood =
                        mood['name'].toString();

                    history.removeWhere(
                      (entry) => entry.startsWith('$today|'),
                    );

                    history.add('$today|$selectedMood');

                    await prefs.setStringList(
                      'mood_history',
                      history,
                    );

                    if (!context.mounted) return;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ActivitiesScreen(
                          mood: selectedMood,
                          activities:
                              List<String>.from(mood['activities']),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                'One moment at a time. 💚',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF68776B),
                ),
              ),
            ),

            const SizedBox(height: 15),
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

class SettingsScreen extends StatelessWidget {
  final ValueChanged<ThemeMode> onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Appearance',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.light_mode),
                  title: const Text('Light mode'),
                  subtitle: const Text('Use a bright appearance'),
                  onTap: () => onThemeChanged(ThemeMode.light),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('Dark mode'),
                  subtitle: const Text('Use a darker appearance'),
                  onTap: () => onThemeChanged(ThemeMode.dark),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.settings_suggest),
                  title: const Text('System default'),
                  subtitle: const Text('Follow your phone settings'),
                  onTap: () => onThemeChanged(ThemeMode.system),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'About StillSpace',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Card(
            child: ListTile(
              leading: Icon(Icons.spa),
              title: Text('StillSpace'),
              subtitle: Text(
                'A little space for yourself. '
                'Take things one moment at a time.',
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Privacy',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),
Card(
  child: ListTile(
    leading: const Icon(Icons.calendar_month),
    title: const Text('Mood History'),
    subtitle: const Text(
      'View your recorded moods on a calendar.',
    ),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const MoodHistoryScreen(),
        ),
      );
    },
  ),
),
         
const SizedBox(height: 10),

Card(
  child: ListTile(
    leading: const Icon(Icons.insights),
    title: const Text('Mood Insights'),
    subtitle: const Text(
      'See patterns in your recorded moods.',
    ),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const MoodInsightsScreen(),
        ),
      );
    },
  ),
),
 
const SizedBox(height: 10),

Card(
  child: ListTile(
    leading: const Icon(Icons.privacy_tip_outlined),
    title: const Text('Privacy Policy'),
    subtitle: const Text(
      'Learn how StillSpace handles your information.',
    ),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const PrivacyPolicyScreen(),
        ),
      );
    },
  ),
),

        ],
      ),
    );
  }
}

class MoodHistoryScreen extends StatefulWidget {
  const MoodHistoryScreen({super.key});

  @override
  State<MoodHistoryScreen> createState() =>
      _MoodHistoryScreenState();
}

class _MoodHistoryScreenState extends State<MoodHistoryScreen> {
  DateTime selectedMonth = DateTime.now();

  Map<String, String> moodHistory = {};

  @override
  void initState() {
    super.initState();
    loadMoodHistory();
  }

  Future<void> loadMoodHistory() async {
    final prefs = await SharedPreferences.getInstance();

    final history = prefs.getStringList('mood_history') ?? [];

    final Map<String, String> loadedHistory = {};

    for (final entry in history) {
      final parts = entry.split('|');

      if (parts.length == 2) {
        loadedHistory[parts[0]] = parts[1];
      }
    }

    if (!mounted) return;

    setState(() {
      moodHistory = loadedHistory;
    });
  }

  String dateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  void changeMonth(int amount) {
    setState(() {
      selectedMonth = DateTime(
        selectedMonth.year,
        selectedMonth.month + amount,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(
      selectedMonth.year,
      selectedMonth.month,
      1,
    );

    final daysInMonth = DateTime(
      selectedMonth.year,
      selectedMonth.month + 1,
      0,
    ).day;

    final startingWeekday = firstDay.weekday - 1;

    const weekdays = [
      'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood History'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => changeMonth(-1),
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                '${_monthName(selectedMonth.month)} ${selectedMonth.year}',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => changeMonth(1),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),

          const SizedBox(height: 20),

          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: weekdays.map((day) {
              return Center(
                child: Text(
                  day,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 10),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: startingWeekday + daysInMonth,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              if (index < startingWeekday) {
                return const SizedBox();
              }

              final day = index - startingWeekday + 1;

              final date = DateTime(
                selectedMonth.year,
                selectedMonth.month,
                day,
              );

              final mood = moodHistory[dateKey(date)];

              final emojis = {
                'Calm': '😌',
                'Happy': '😊',
                'Okay': '🙂',
                'Anxious': '😟',
                'Low': '😔',
              };

              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Day $day'),
                      content: Text(
                        mood == null
                            ? 'No mood recorded on this day.'
                            : 'Recorded mood: $mood ${emojis[mood] ?? ''}',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: mood == null
                        ? const Color(0xFFF1F4EF)
                        : const Color(0xFFE0EBE0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$day',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (mood != null)
                        Text(
                          emojis[mood] ?? '•',
                          style: const TextStyle(fontSize: 17),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 25),

          const Text(
            'Your mood journey, one day at a time. 🌿',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December'
    ];

    return months[month - 1];
  }
}

class MoodInsightsScreen extends StatefulWidget {
  const MoodInsightsScreen({super.key});

  @override
  State<MoodInsightsScreen> createState() =>
      _MoodInsightsScreenState();
}

class _MoodInsightsScreenState
    extends State<MoodInsightsScreen> {
  DateTime selectedMonth = DateTime.now();

  List<String> moodHistory = [];

  @override
  void initState() {
    super.initState();
    loadMoodHistory();
  }

  Future<void> loadMoodHistory() async {
    final prefs = await SharedPreferences.getInstance();

    final history =
        prefs.getStringList('mood_history') ?? [];

    if (!mounted) return;

    setState(() {
      moodHistory = history;
    });
  }

  void changeMonth(int amount) {
    setState(() {
      selectedMonth = DateTime(
        selectedMonth.year,
        selectedMonth.month + amount,
      );
    });
  }

  String monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November',
      'December'
    ];

    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final monthKey =
        '${selectedMonth.year}-${selectedMonth.month.toString().padLeft(2, '0')}';

    final monthlyEntries = moodHistory.where((entry) {
      return entry.startsWith('$monthKey-');
    }).toList();

    final moodCounts = <String, int>{
      'Calm': 0,
      'Happy': 0,
      'Okay': 0,
      'Anxious': 0,
      'Low': 0,
    };

    for (final entry in monthlyEntries) {
      final parts = entry.split('|');

      if (parts.length == 2 &&
          moodCounts.containsKey(parts[1])) {
        moodCounts[parts[1]] =
            moodCounts[parts[1]]! + 1;
      }
    }

    String? mostCommonMood;
    int highestCount = 0;

    moodCounts.forEach((mood, count) {
      if (count > highestCount) {
        highestCount = count;
        mostCommonMood = mood;
      }
    });

    const emojis = {
      'Calm': '😌',
      'Happy': '😊',
      'Okay': '🙂',
      'Anxious': '😟',
      'Low': '😔',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Insights'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Your Mood Journey 🌿',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Explore the moods you have recorded '
            'this month.',
            style: TextStyle(fontSize: 15),
          ),

          const SizedBox(height: 25),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => changeMonth(-1),
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                '${monthName(selectedMonth.month)} '
                '${selectedMonth.year}',
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => changeMonth(1),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Days recorded'),
              subtitle: const Text(
                'Days with a saved mood this month',
              ),
              trailing: Text(
                '${monthlyEntries.length}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(Icons.star_outline),
              title: const Text('Most recorded mood'),
              subtitle: Text(
                mostCommonMood == null
                    ? 'No moods recorded yet'
                    : mostCommonMood!,
              ),
              trailing: Text(
                mostCommonMood == null
                    ? '—'
                    : emojis[mostCommonMood]!,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Mood Breakdown',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          if (monthlyEntries.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'No moods recorded this month yet. '
                  'Choose a mood on your home screen '
                  'to start building your history.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          ...moodCounts.entries.map((entry) {
            final count = entry.value;

            final progress = monthlyEntries.isEmpty
                ? 0.0
                : count / monthlyEntries.length;

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          emojis[entry.key]!,
                          style: const TextStyle(
                            fontSize: 23,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text('$count days'),
                      ],
                    ),

                    const SizedBox(height: 12),

                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
            );
          }),

          const SizedBox(height: 20),

          const Text(
            'Every feeling deserves attention. '
            'Your mood records are here to help '
            'you reflect, not to judge you. 🌿',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'StillSpace Privacy Policy 🌿',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Last updated: November 2026',
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 20),

          const Text(
            '1. Introduction',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Welcome to StillSpace. We respect your privacy '
            'and aim to protect your personal information. '
            'This policy explains how information is handled '
            'when you use the app.',
          ),

          const SizedBox(height: 20),

          const Text(
            '2. Information Stored',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'StillSpace stores your selected daily moods '
            'on your device using local app storage. '
            'Your mood history is used to display your '
            'Mood History calendar and Mood Insights.',
          ),

          const SizedBox(height: 20),

          const Text(
            '3. How Information Is Used',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Information stored by the app helps you '
            'review your mood entries and use the app '
            'features. StillSpace is designed to support '
            'personal reflection and general wellbeing.',
          ),

          const SizedBox(height: 20),

          const Text(
            '4. Sharing of Information',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'StillSpace does not currently provide a '
            'feature for sharing your mood history with '
            'other users. If advertising or other third-party '
            'services are added, this policy must be updated '
            'to explain what information those services '
            'may collect and how it is used.',
          ),

          const SizedBox(height: 20),

          const Text(
            '5. Data Security and Control',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Your mood history is stored locally on your '
            'device. Anyone with access to your unlocked '
            'device may be able to access information '
            'stored in the app. Uninstalling the app or '
            'clearing its data may remove locally stored '
            'mood records.',
          ),

          const SizedBox(height: 20),

          const Text(
            '6. Children and Young Users',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'StillSpace aims to provide a respectful and '
            'welcoming experience. The app should not '
            'replace guidance from a trusted adult or '
            'qualified professional when additional support '
            'is needed.',
          ),

          const SizedBox(height: 20),

          const Text(
            '7. Changes to This Policy',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'This policy may be updated when StillSpace '
            'features or services change. The latest version '
            'should be made available to app users.',
          ),

          const SizedBox(height: 20),

          const Text(
            '8. Contact',
            style: TextStyle(
              fontSize: 19, 
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'For privacy questions, please contact the '
            'StillSpace app developer using the official '
            'contact details provided with the app.',
          ),

          const SizedBox(height: 30),

          const Text(
            'StillSpace 🌿\n'
            'A little space for yourself. '
            'Take things one moment at a time.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}



