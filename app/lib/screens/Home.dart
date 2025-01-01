import 'package:flutter/material.dart';
import 'Jokes.dart';
import 'RandomJoke.dart';
import '../services/api_services.dart';
import '../models/Joke.dart';
import '../services/AuthService.dart';

class Home extends StatefulWidget
{
    @override
    HomeState createState() => HomeState();
}

class HomeState extends State<Home>
{
    final AuthService _authService = AuthService();
    final User = {};
    final String index = "216089";
    late List<String> types = [];
    Set<Joke> favorites = {};

    @override
    void initState()
    {
        super.initState();
        loadTypes();
    }

    void addFavorites(Joke joke)
    {
        setState(()
            {
                favorites.add(joke);
            }
        );
    }

    void removeFavorite(Joke joke)
    {
        setState(()
            {
                favorites.remove(joke);
            }
        );
    }

    Future<void> loadTypes() async
    {
        try
        {
            JokesService jokesService = new JokesService();
            List<String> fetchedTypes = await jokesService.getTypes();
            setState(()
                {
                    this.types = fetchedTypes;
                }
            );
        }
        catch (e)
        {
            print("Error fetching types: $e");
        }
    }

    void navigateToTypePage(String type)
    {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                Jokes(type: type, onAddFavorite: addFavorites, onRemoveFavorite: removeFavorite)
            )
        );
    }

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: SingleChildScrollView( // Allow horizontal scrolling
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: [
                            Text(this.index),
                            const SizedBox(width: 10),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ElevatedButton(
                                    onPressed: ()
                                    {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => RandomJoke())
                                        );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0)
                                    ),
                                    child: const Text("Get random joke", overflow: TextOverflow.ellipsis)
                                )
                            ),
                            const SizedBox(width: 5),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ElevatedButton(
                                    onPressed: ()
                                    {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Jokes(type: null, jokes: this.favorites, onAddFavorite: addFavorites, onRemoveFavorite: removeFavorite))
                                        );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0)
                                    ),
                                    child: const Text("Favorites", overflow: TextOverflow.ellipsis)
                                )
                            ),
                            const SizedBox(width: 5),
                            Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ElevatedButton(
                                    onPressed: () async
                                    {
                                        Navigator.pushReplacementNamed(context, '/');
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0)
                                    ),
                                    child: const Text("Logout", overflow: TextOverflow.ellipsis)
                                )
                            )
                        ]
                    )
                )
            ),
            body: Column(
                children: [
                    if (types.isEmpty)
                    Center(child: CircularProgressIndicator())
                    else
                    Expanded(
                        child: ListView.builder(
                            itemCount: types.length,
                            itemBuilder: (context, index)
                            {
                                return ListTile(
                                    title: Text('${this.types[index]} jokes'),
                                    onTap: () => navigateToTypePage(types[index])
                                );
                            }
                        )
                    )
                ]
            )
        );
    }
}
