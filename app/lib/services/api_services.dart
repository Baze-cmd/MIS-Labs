import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Joke.dart';

class JokesService
{
    final String base = 'https://official-joke-api.appspot.com';

    Future<List<String>> getTypes() async
    {
        final response = await http.get(Uri.parse('${this.base}/types'));
        if (response.statusCode == 200)
        {
            return List<String>.from(jsonDecode(response.body));
        }
        else
        {
            throw Exception('Failed to get data: ${response.statusCode}');
        }
    }

    Future<List<Joke>> getJokes(String type) async
    {
        final response = await http.get(Uri.parse('${this.base}/jokes/$type/ten'));
        if (response.statusCode == 200)
        {
            List<dynamic> decodedResponse = jsonDecode(response.body);
            List<Joke> jokesList = decodedResponse.map((data) => Joke.fromJson(data as Map<String, dynamic>)).toList();
            return jokesList;
        }
        else
        {
            throw Exception('Failed to get jokes: ${response.statusCode}');
        }
    }

    Future<Joke> getRandomJoke() async
    {
        final response = await http.get(Uri.parse('${this.base}/random_joke'));
        if (response.statusCode == 200)
        {
            return Joke.fromJson(json.decode(response.body));
        }
        else
        {
            throw Exception('Failed to get random joke: ${response.statusCode}');
        }
    }

}
