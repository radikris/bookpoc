import 'package:bookpoc/flip.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = GlobalKey<PageFlipWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageFlipWidget(
        key: _controller,
        backgroundColor: Colors.white,
        initialIndex: 0,
        // isRightSwipe: true,
        lastPage: Container(
            color: Colors.white,
            child: const Center(child: Text('Last Page!'))),
        children: <Widget>[
          for (var i = 0; i < 10; i++) DemoPage(page: i),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.looks_5_outlined),
        onPressed: () {
          _controller.currentState?.goToPage(5);
        },
      ),
    );
  }
}

class DemoPage extends StatefulWidget {
  final int page;

  const DemoPage({Key? key, required this.page}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0)
                    .copyWith(bottom: 64),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Part ${widget.page + 1}',
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                      onPressed: () {
                        //show snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Hello, World!')));
                      },
                      child: const Text('Interactive snackbar')),
                  ElevatedButton(
                      onPressed: () {
                        //show dialog
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Hello, World!'),
                                content:
                                    const Text('This is an interactive dialog'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'))
                                ],
                              );
                            });
                      },
                      child: const Text('Interactive dialog')),
                  const SizedBox(height: 32.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Expanded(
                          child: Text(
                        '''Elmer Elevator, when he was a kid. He and his mother Dela owned a candy shop in a small town, but were soon forced to close down and move away when the people of the town moved away. They move to a faraway city where they plan to open a new shop, but they eventually lose all the money they save up while getting by''',
                        style:
                            TextStyle(fontSize: 14, fontFamily: 'Droid Sans'),
                      )),
                      // GestureDetector(
                      //   onTap: () {
                      //     debugPrint('hello');
                      //   },
                      //   child: Container(
                      //     margin: const EdgeInsets.only(left: 12.0),
                      //     color: Colors.black26,
                      //     width: 160.0,
                      //     height: 240.0,
                      //     child: const Placeholder(),
                      //   ),
                      // ),
                      Switch(
                        onChanged: toggleSwitch,
                        value: isSwitched,
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.yellow,
                        inactiveThumbColor: Colors.redAccent,
                        inactiveTrackColor: Colors.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  ...List.generate(100, (index) => Text('Sor $index'))
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: Text(
              'Page ${widget.page + 1}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }
}
