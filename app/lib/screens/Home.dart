import 'package:flutter/material.dart';
import 'Jokes.dart';
import 'RandomJoke.dart';
import '../services/api_services.dart';

class Home extends StatefulWidget
{
    @override
    HomeState createState() => HomeState();
}

class HomeState extends State<Home>
{
    final String index = "216089";
    late List<String> types = [];

    @override
    void initState()
    {
        super.initState();
        loadTypes();
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
        catch(e)
        {
            print("Error fetching types: $e");
        }
    }

    void navigateToTypePage(String type)
    {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Jokes(type: type)
            )
        );
    }

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Text(this.index),
                        const SizedBox(width: 10),
                        ElevatedButton(
                            onPressed: ()
                            {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => RandomJoke())
                                );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black
                            ),
                            child: const Text("Get random joke")
                        )
                    ]
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

