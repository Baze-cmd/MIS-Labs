import 'package:app/services/api_services.dart';
import 'package:flutter/material.dart';
import '../models/Joke.dart';

class Jokes extends StatefulWidget
{
    final String type;

    Jokes({required this.type});

    @override
    JokesState createState() => JokesState(type: this.type);
}

class JokesState extends State<Jokes>
{
    final String type;
    late List<Joke> jokes = [];

    JokesState({required this.type});

    @override
    void initState()
    {
        super.initState();
        loadJokes();
    }

    Future<void> loadJokes() async
    {
        try
        {
            JokesService jokesService = new JokesService();
            List<Joke> fetchedJokes = await jokesService.getJokes(this.type);
            setState(()
                {
                    this.jokes = fetchedJokes;
                }
            );
        }
        catch(e)
        {
            print("Error fetching jokes: $e");
        }
    }

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(title: Text('${widget.type} jokes')),
            body: jokes.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 2.0
                    ),
                    itemCount: jokes.length,
                    itemBuilder: (context, index)
                    {
                        final joke = jokes[index];
                        return Card(
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                                contentPadding: EdgeInsets.all(15),
                                title: Text(joke.setup, style: TextStyle(fontSize: 18)),
                                subtitle: Text(joke.punchline, style: TextStyle(fontSize: 16))
                            )
                        );
                    }
                )
        );
    }
}
