import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  runApp(MemorhythmApp());
}

class MemorhythmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memorhythm',
      theme: ThemeData(
        primaryColor: Color(0xFFE6E6FA),
        scaffoldBackgroundColor: Color(0xFFE6E6FA), // Light-purple color for the background
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFE6E6FA)!),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
        ),
      ),
      home: MusicScreen(),
    );
  }
}

class MusicScreen extends StatefulWidget {
  @override
  _MusicScreenState createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  String? userInput;
  String? singerName = 'unknown artist';
  List<String> responses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFE6E6FA), // Light-purple color code
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.music_note, size: 50, color: Colors.black.withOpacity(0.1)),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.music_note, size: 40, color: Colors.black.withOpacity(0.1)),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.music_note, size: 50, color: Colors.black.withOpacity(0.1)),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.music_note, size: 40, color: Colors.black.withOpacity(0.1)),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.music_note, size: 40, color: Colors.black.withOpacity(0.1)),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.music_note, size: 50, color: Colors.black.withOpacity(0.1)),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.music_note, size: 40, color: Colors.black.withOpacity(0.1)),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.music_note, size: 50, color: Colors.black.withOpacity(0.1)),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 300,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Positioned(
                    top: 150, // Adjust this value to move the app name closer or further from the white box
                    left: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Memorhythm',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                      padding: EdgeInsets.all(8.0),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter words or phrases from the song',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        userInput = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter singer\'s name (optional)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        singerName = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      final model = GenerativeModel(model: 'gemini-pro', apiKey: 'AIzaSyDqDJY3wqxa1NZz3aLEoQIVt5ptP-JKPVg');
                      final content = [Content.text("You are searching for songs based on user inputs. "
                          "The $userInput field represents the words or phrases the song must contain, "
                          "while the $singerName field, if provided, specifies the name of the artist of the song. "
                          "Please provide a list of songs (up to 5 songs) that match the given criteria, "
                          "including both the song titles and the corresponding artist names, if available. "
                          "Make response in the following format:"
                          "Searching for songs with user input: '$userInput' by $singerName.\n"
                          "\nA list of possible song(s) is: \n"
                          "\n'Song name' by Artist name"
                          "\n'Song name' by Artist name")];
                      final response = await model.generateContent(content);
                      print(response.text);
                      setState(() {
                        responses = []; // Clear previous responses
                        responses.add(response.text!); // Add new response
                      });
                    },
                    child: Text('Search'),
                  ),
                  SizedBox(height: 16.0),
                  Column(
                    children: responses.map((response) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(response),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
