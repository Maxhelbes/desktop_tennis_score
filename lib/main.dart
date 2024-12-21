import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScorePage(),
    );
  }
}

class ScorePage extends StatelessWidget {
  const ScorePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Сейчас подает: Игрок №1',
            style: TextStyle(color: Colors.white, fontSize: 40),
          ),
          backgroundColor: Colors.black87,
          leading: const Icon(Icons.airline_stops_sharp),
        ),
        body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            ScoreTile(color: Colors.red),
            ScoreTile(color: Colors.green),
          ],
        ));
  }
}

class ScoreTile extends StatefulWidget {
  const ScoreTile({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  State<ScoreTile> createState() => _ScoreTileState();
}

class _ScoreTileState extends State<ScoreTile> {
  int _score = 0;

  void _incrementCounter() {
    setState(() {
      _score++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _score--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _incrementCounter,
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 500) {
          _decrementCounter();
        }
        ;
      },
      // onVerticalDragEnd: _decrementCounter,
      child: Container(
        color: widget.color,
        child: Center(
          child: Text(
            _score.toString(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 200,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}

class GridBuilder extends StatelessWidget {
  const GridBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: null,
          child: Container(
            color: (index == 0) ? (Colors.red) : (Colors.green),
            child: Center(
              child: Text('0'),
            ),
          ),
        );
      },
    );
  }
}
