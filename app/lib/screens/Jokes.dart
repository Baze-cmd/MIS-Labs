import 'package:app/services/api_services.dart';
import 'package:flutter/material.dart';
import '../models/Joke.dart';

class Jokes extends StatefulWidget
{
    final String? type;
    final Set<Joke>? jokes;
    final void Function(Joke)? onAddFavorite;
    final void Function(Joke)? onRemoveFavorite;

    Jokes({this.type, this.jokes, this.onAddFavorite, this.onRemoveFavorite});

    @override
    JokesState createState() => JokesState();
}

class JokesState extends State<Jokes>
{
    late List<Joke> jokes = [];

    @override
    void initState()
    {
        super.initState();
        if (widget.jokes != null)
        {
            jokes = widget.jokes!.toList();
        }
        else if (widget.type != null)
        {
            loadJokes();
        }
    }

    Future<void> loadJokes() async
    {
        try
        {
            JokesService jokesService = JokesService();
            List<Joke> fetchedJokes = await jokesService.getJokes(widget.type!);
            setState(()
                {
                    jokes = fetchedJokes;
                }
            );
        }
        catch (e)
        {
            print("Error fetching jokes: $e");
        }
    }

    void removeJoke(Joke joke)
    {
        if (widget.onRemoveFavorite != null)
        {
            widget.onRemoveFavorite!(joke); // Notify parent to remove joke
            setState(()
                {
                    jokes.remove(joke); // Update local state
                }
            );
        }
    }

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.type != null
                        ? '${widget.type} jokes'
                        : 'Favorites')
            ),
            body: jokes.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: jokes.length,
                    itemBuilder: (context, index)
                    {
                        final joke = jokes[index];
                        return Card(
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                                contentPadding: EdgeInsets.all(15),
                                title: Text(joke.setup, style: TextStyle(fontSize: 18)),
                                subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(joke.punchline, style: TextStyle(fontSize: 16)),
                                        SizedBox(height: 10),
                                        widget.type != null ?
                                            ElevatedButton(
                                                onPressed: ()
                                                {
                                                    widget.onAddFavorite!(joke);
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                            content: Text("Added to favorites!")
                                                        )
                                                    );
                                                },
                                                child: Text("Add to Favorites")
                                            ) : ElevatedButton(onPressed: ()
                                                {
                                                    removeJoke(joke);
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                            content: Text("Removed from favorites!")
                                                        )
                                                    );
                                                }, child: Text("Remove from favorites"))
                                    ]
                                )
                            )
                        );
                    }
                )
        );
    }
}
