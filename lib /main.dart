import 'package:flutter/material.dart';
import 'dart:async': 
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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
  List<Map<String, String>> moodHistory = [];
  @override
void initState() {
  super.initState();
  loadMoodHistory();
}

Future<void> loadMoodHistory() async {
  final prefs = await SharedPreferences.getInstance();

  final savedData = prefs.getString('moodHistory');

  if (savedData != null) {
    final List<dynamic> decoded = jsonDecode(savedData);

    if (!mounted) return;

    setState(() {
      moodHistory = decoded.map((entry) {
        return Map<String, String>.from(entry);
      }).toList();
    });
  }
}
  Future<void> saveMoodHistory() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(
    'moodHistory',
    jsonEncode(moodHistory),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StillSpace')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
  child: ListTile(
    leading: const Icon(
      Icons.insights,
      color: Colors.deepPurple,
      size: 32,
    ),
    title: const Text(
      'Mood Progress',
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: const Text(
      'Explore your weekly mood history',
    ),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MoodProgressScreen(
            moodHistory: moodHistory,
          ),
        ),
      );
    },
  ),
),
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
  setState(() {
    mood = item;

    moodHistory.add({
      'mood': item,
      'date': DateTime.now().toString(),
    });
  });
        saveMoodHistory();
},

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActivitiesScreen(mood: item),
      ),
    );
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


class ActivitiesScreen extends StatelessWidget {
  final String mood;

  const ActivitiesScreen({super.key, required this.mood});

  @override
  Widget build(BuildContext context) {
    
final List<Map<String, dynamic>> activities = mood == 'Calm'
    ? [
        {
          'title': 'Nature Breathing',
          'description': 'Relax with a gentle breathing exercise.',
          'icon': Icons.air,
          'details': 'Breathe in for 4 seconds. Hold for 2 seconds. Breathe out slowly for 6 seconds. Repeat gently.'
        },
        {
          'title': 'Nature Meditation',
          'description': 'Enjoy a peaceful moment.',
          'icon': Icons.spa,
          'details': 'Find a comfortable position. Close your eyes if you wish. Imagine yourself somewhere peaceful.'
        },
        {
          'title': 'Gratitude Journal',
          'description': 'Remember the good things in life.',
          'icon': Icons.book,
          'details': 'Write down three things you are grateful for today.'
        },
      ]
    : mood == 'Happy'
        ? [
            {
              'title': 'Happy Moments',
              'description': 'Celebrate what makes you smile.',
              'icon': Icons.celebration,
              'details': 'Think of three things that made you smile today.'
            },
            {
              'title': 'Positive Affirmations',
              'description': 'Enjoy some encouraging words.',
              'icon': Icons.favorite,
              'details': 'I deserve happiness. I am growing. Good things can happen to me.'
            },
            {
              'title': 'Joyful Movement',
              'description': 'Enjoy a little movement.',
              'icon': Icons.directions_walk,
              'details': 'Put on your favourite music and enjoy a gentle dance or walk.'
            },
          ]
        : mood == 'Okay'
            ? [
                {
                  'title': 'Mindful Moment',
                  'description': 'Take a break and reconnect.',
                  'icon': Icons.self_improvement,
                  'details': 'Notice five things you can see, four things you can feel, and three things you can hear.'
                },
                {
                  'title': 'Mood Journal',
                  'description': 'Reflect on your feelings.',
                  'icon': Icons.book,
                  'details': 'Write about how your day is going and what you need right now.'
                },
                {
                  'title': 'Gentle Stretching',
                  'description': 'Give your body a little care.',
                  'icon': Icons.accessibility_new,
                  'details': 'Gently stretch your shoulders, arms and neck without forcing any movement.'
                },
              ]
            : mood == 'Anxious'
                ? [
                    {
                      'title': 'Guided Breathing',
                      'description': 'Slow down and breathe gently.',
                      'icon': Icons.air,
                      'details': 'Breathe in gently for 4 seconds and breathe out for 6 seconds. Repeat for one minute.'
                    },
                    {
                      'title': '5-4-3-2-1 Grounding',
                      'description': 'Reconnect with your surroundings.',
                      'icon': Icons.landscape,
                      'details': 'Notice 5 things you see, 4 things you feel, 3 things you hear, 2 things you smell and 1 thing you taste.'
                    },
                    {
                      'title': 'Calming Thoughts',
                      'description': 'Read reassuring reminders.',
                      'icon': Icons.favorite,
                      'details': 'I can take things one step at a time. I do not have to solve everything right now.'
                    },
                  ]
                : [
                    {
                      'title': 'Gentle Encouragement',
                      'description': 'Read a kind message.',
                      'icon': Icons.favorite,
                      'details': 'You matter. Your feelings matter. You do not have to be perfect. Take today one small step at a time.'
                    },
                    {
                      'title': 'Small Wins',
                      'description': 'Celebrate little achievements.',
                      'icon': Icons.star,
                      'details': 'Think of one small thing you managed to do today. Even getting through a difficult moment counts.'
                    },
                    {
                      'title': 'Self-Care Break',
                      'description': 'Give yourself a moment of kindness.',
                      'icon': Icons.spa,
                      'details': 'Drink some water, find a comfortable place and give yourself permission to rest.'
                    },
                  ];


    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose an Activity'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'You selected: $mood',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('What would you like to do today?'),
          const SizedBox(height: 20),
          ...activities.map((activity) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: Icon(
                  activity['icon'] as IconData,
                  size: 32,
                ),
                title: Text(activity['title'] as String),
                subtitle: Text(activity['description'] as String),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivityDetailScreen(
                        title: activity['title'] as String,
                        details: activity['details'] as String,
                      ),
                    ),
                  );
                },
              ),
            );
          }),
          const SizedBox(height: 16),

Card(
  child: ListTile(
    leading: const Icon(
      Icons.air,
      size: 32,
      color: Colors.deepPurple,
    ),
    title: const Text(
      'Interactive Breathing Coach',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: const Text(
      'Relax with a guided breathing exercise.',
    ),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const BreathingCoachScreen(),
        ),
      );
    },
  ),
),
        ],
      ),
    );
  }


class ActivityDetailScreen extends StatefulWidget {
  final String title;
  final String details;

  const ActivityDetailScreen({
    super.key,
    required this.title,
    required this.details,
  });

  @override
  State<ActivityDetailScreen> createState() =>
      _ActivityDetailScreenState();
}

class _ActivityDetailScreenState
    extends State<ActivityDetailScreen> {
  final TextEditingController _controller =
      TextEditingController();

  List<String> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('mood_journal_entries') ?? [];

    if (!mounted) return;

    setState(() {
      _entries = saved;
    });
  }

  Future<void> _saveEntry() async {
    final note = _controller.text.trim();

    if (note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write something first.'),
        ),
      );
      return;
    }

    final now = DateTime.now().toString().substring(0, 16);
    final entry = '$now|$note';

    final updatedEntries = [entry, ..._entries];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'mood_journal_entries',
      updatedEntries,
    );

    if (!mounted) return;

    setState(() {
      _entries = updatedEntries;
      _controller.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your journal entry has been saved!'),
      ),
    );
  }

  Future<void> _deleteEntry(int index) async {
    final updatedEntries = List<String>.from(_entries);
    updatedEntries.removeAt(index);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'mood_journal_entries',
      updatedEntries,
    );

    if (!mounted) return;

    setState(() {
      _entries = updatedEntries;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isJournal = widget.title == 'Mood Journal';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.details,
            style: const TextStyle(fontSize: 18),
          ),

          if (isJournal) ...[
            const SizedBox(height: 24),
            const Text(
              'How are you feeling today?',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write your thoughts here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                filled: true,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _saveEntry,
              icon: const Icon(Icons.save),
              label: const Text('Save Journal Entry'),
            ),
            const SizedBox(height: 28),
            const Text(
              'Previous Journal Entries',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            if (_entries.isEmpty)
              const Text(
                'Your saved entries will appear here.',
              ),

            ..._entries.asMap().entries.map((item) {
              final index = item.key;
              final entry = item.value;
              final separator = entry.indexOf('|');

              final date = separator >= 0
                  ? entry.substring(0, separator)
                  : '';
              final note = separator >= 0
                  ? entry.substring(separator + 1)
                  : entry;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(note),
                  subtitle: Text(date),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _deleteEntry(index),
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}
  


const ActivityDetailScreen({
    super.key,
    required this.title,
    required this.details,
  });

  @override
  State<ActivityDetailScreen> createState() =>
      _ActivityDetailScreenState();
}

class _ActivityDetailScreenState
    extends State<ActivityDetailScreen> {
  final TextEditingController _controller =
      TextEditingController();

  List<String> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('mood_journal_entries') ?? [];

    if (!mounted) return;

    setState(() {
      _entries = saved;
    });
  }

  Future<void> _saveEntry() async {
    final note = _controller.text.trim();

    if (note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write something first.'),
        ),
      );
      return;
    }

    final now = DateTime.now().toString().substring(0, 16);
    final entry = '$now|$note';

    final updatedEntries = [entry, ..._entries];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'mood_journal_entries',
      updatedEntries,
    );

    if (!mounted) return;

    setState(() {
      _entries = updatedEntries;
      _controller.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your journal entry has been saved!'),
      ),
    );
  }

  Future<void> _deleteEntry(int index) async {
    final updatedEntries = List<String>.from(_entries);
    updatedEntries.removeAt(index);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'mood_journal_entries',
      updatedEntries,
    );

    if (!mounted) return;

    setState(() {
      _entries = updatedEntries;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isJournal = widget.title == 'Mood Journal';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.details,
            style: const TextStyle(fontSize: 18),
          ),

          if (isJournal) ...[
            const SizedBox(height: 24),
            const Text(
              'How are you feeling today?',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write your thoughts here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                filled: true,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _saveEntry,
              icon: const Icon(Icons.save),
              label: const Text('Save Journal Entry'),
            ),
            const SizedBox(height: 28),
            const Text(
              'Previous Journal Entries',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            if (_entries.isEmpty)
              const Text(
                'Your saved entries will appear here.',
              ),

            ..._entries.asMap().entries.map((item) {
              final index = item.key;
              final entry = item.value;
              final separator = entry.indexOf('|');

              final date = separator >= 0
                  ? entry.substring(0, separator)
                  : '';
              final note = separator >= 0
                  ? entry.substring(separator + 1)
                  : entry;

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(note),
                  subtitle: Text(date),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _deleteEntry(index),
                  ),
                ),
              );
            }),
          ],
        ],
      ),
    );
  }
}


  const ActivityDetailScreen({
    super.key,
    required this.title,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              details,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            if (title == 'Mood Journal')
              const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your feelings here...',
                  border: OutlineInputBorder(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
class BreathingCoachScreen extends StatefulWidget {
  const BreathingCoachScreen({super.key});

  @override
  State<BreathingCoachScreen> createState() =>
      _BreathingCoachScreenState();
}

class _BreathingCoachScreenState
    extends State<BreathingCoachScreen> {
  Timer? _timer;

  bool _isRunning = false;
  bool _isInhaling = true;
  bool _isFinished = false;

  int _secondsLeft = 4;
  int _cyclesCompleted = 0;

  final int _targetCycles = 5;

  void _startBreathing() {
    if (_isFinished) {
      _resetBreathing();
    }

    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) return;

        setState(() {
          if (_secondsLeft > 1) {
            _secondsLeft--;
          } else {
            if (_isInhaling) {
              _isInhaling = false;
              _secondsLeft = 6;
            } else {
              _cyclesCompleted++;

              if (_cyclesCompleted >= _targetCycles) {
                _timer?.cancel();
                _isRunning = false;
                _isFinished = true;
              } else {
                _isInhaling = true;
                _secondsLeft = 4;
              }
            }
          }
        });
      },
    );
  }

  void _stopBreathing() {
    _timer?.cancel();

    setState(() {
      _isRunning = false;
    });
  }

  void _resetBreathing() {
    _timer?.cancel();

    setState(() {
      _isRunning = false;
      _isInhaling = true;
      _isFinished = false;
      _secondsLeft = 4;
      _cyclesCompleted = 0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                'Find Your Calm',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                _isFinished
                    ? 'Wonderful! You completed your exercise.'
                    : 'Follow the circle and breathe gently.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 40),

              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                width: _isInhaling ? 230 : 165,
                height: _isInhaling ? 230 : 165,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF8F9FE8),
                      Color(0xFFB9A5E8),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    _isFinished
                        ? 'Well done!'
                        : _isRunning
                            ? '${_isInhaling ? 'Breathe In' : 'Breathe Out'}\n$_secondsLeft'
                            : 'Ready?',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              Text(
                'Cycles completed: $_cyclesCompleted / $_targetCycles',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 25),

              if (!_isRunning && !_isFinished)
                ElevatedButton(
                  onPressed: _startBreathing,
                  child: const Text('Start Breathing'),
                ),

              if (_isRunning)
                ElevatedButton(
                  onPressed: _stopBreathing,
                  child: const Text('Pause Exercise'),
                ),

              if (_isFinished || !_isRunning)
                OutlinedButton(
                  onPressed: _resetBreathing,
                  child: const Text('Reset Exercise'),
                ),

              const SizedBox(height: 20),

              const Text(
                'Breathe comfortably. Never force your breathing. '
                'You can stop whenever you wish.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MoodProgressScreen extends StatelessWidget {
  final List<Map<String, String>> moodHistory;

  const MoodProgressScreen({
    super.key,
    required this.moodHistory,
  });

  @override
  Widget build(BuildContext context) {
    final recentMoods = moodHistory.where((entry) {
      final date = DateTime.tryParse(entry['date'] ?? '');
      if (date == null) return false;

      return DateTime.now().difference(date).inDays < 7;
    }).toList();

    final moodCounts = <String, int>{};

    for (final entry in recentMoods) {
      final name = entry['mood'] ?? 'Unknown';
      moodCounts[name] = (moodCounts[name] ?? 0) + 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Progress'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Your weekly mood journey',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'A gentle look at the moods you have recorded.',
          ),
          const SizedBox(height: 25),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Last 7 days',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '${recentMoods.length} mood check-ins recorded',
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Mood breakdown',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          if (moodCounts.isEmpty)
            const Text(
              'No mood records yet. Check in with yourself to begin!',
            ),

          ...moodCounts.entries.map((entry) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.favorite),
                title: Text(entry.key),
                trailing: Text(
                  '${entry.value} check-ins',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 20),

          const Text(
            'Recent mood history',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          if (moodHistory.isEmpty)
            const Text('Your mood history will appear here.'),

          ...moodHistory.map((entry) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(entry['mood'] ?? 'Unknown'),
                subtitle: Text(entry['date'] ?? ''),
              ),
            );
          }),
        ],
      ),
    );
  }
}

