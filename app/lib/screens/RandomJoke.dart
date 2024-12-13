import 'package:app/services/api_services.dart';
import 'package:flutter/material.dart';
import '../models/Joke.dart';

class RandomJoke extends StatefulWidget
{
    @override
    RandomJokeState createState() => RandomJokeState();
}

class RandomJokeState extends State<RandomJoke>
{
    late Joke joke;

    @override
    void initState()
    {
        super.initState();
        this.joke = new Joke(setup: 'setup', punchline: 'punchline');
        loadJoke();
    }

    Future<void> loadJoke() async
    {
        try
        {
            JokesService jokesService = new JokesService();
            Joke fetchedJoke = await jokesService.getRandomJoke();
            setState(()
                {
                    this.joke = fetchedJoke;
                }
            );
        }
        catch(e)
        {
            print("Error fetching random joke: $e");
        }
    }

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Text('Random Joke')
            ),
            body: Center(
                child: this.joke.setup == 'setup' ? CircularProgressIndicator() :
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            if (this.joke.setup.isNotEmpty) Text(this.joke.setup, style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                            if (this.joke.punchline.isNotEmpty)
                            Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(this.joke.punchline, style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic), textAlign: TextAlign.center)
                            )
                        ]
                    )
            )
        );
    }
}
