import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/GeolocatorService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapScreen extends StatefulWidget
{
    final String location;
    const MapScreen({super.key, required this.location});

    @override
    MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen>
{
    LatLng? userLocation;
    GoogleMapController? mapController;
    Set<Marker> markers = {};
    Set<Polyline> polylines = {};
    List<LatLng> polylineCoordinates = [];

    @override
    void initState()
    {
        super.initState();
        loadenv();
        getCurrentLocation();
        addMarkers();
        getPolyline();
        String a = "F";
    }

    void loadenv() async
    {
        await dotenv.load();
    }

    void getCurrentLocation() async
    {
        try
        {
            Position position = await GeolocatorService.getCurrentLocation();
            setState(()
                {
                    userLocation = LatLng(position.latitude, position.longitude);
                }
            );
        }
        catch (e)
        {
            print("Error getting location: $e");
        }
    }

    void addMarkers()
    {
        if (userLocation == null) return;

        LatLng destination = parseLocationString(widget.location);

        setState(()
            {
                markers.add(
                    Marker(
                        markerId: const MarkerId('userLocation'),
                        position: userLocation!,
                        infoWindow: const InfoWindow(title: 'Your Location')
                    )
                );

                markers.add(
                    Marker(
                        markerId: const MarkerId('destination'),
                        position: destination,
                        infoWindow: const InfoWindow(title: 'Destination')
                    )
                );
            }
        );
    }

    LatLng parseLocationString(String location)
    {
        List<String> coordinates = location.split(',');
        double lat = double.parse(coordinates[0].trim());
        double lng = double.parse(coordinates[1].trim());
        return LatLng(lat, lng);
    }

    void getPolyline() async
    {
        if (userLocation == null) return;
        LatLng destination = parseLocationString(widget.location);
        final String apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';

        List<LatLng> route = await getRoute(userLocation!, destination);
        setState(()
            {
                this.polylines.add(Polyline(
                        polylineId: PolylineId('routeTo${destination.latitude},${destination.longitude}'),
                        points: route,
                        color: Colors.blue,
                        width: 5
                    ));
            }
        );
    }

    Future<List<LatLng>> getRoute(LatLng origin, LatLng destination) async
    {
        final originString = '${origin.latitude},${origin.longitude}';
        final destinationString = '${destination.latitude},${destination.longitude}';
        final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];

        final url = Uri.parse(
            'https://maps.googleapis.com/maps/api/directions/json?origin=$originString&destination=$destinationString&key=$apiKey'
        );

        final response = await http.get(url);

        if (response.statusCode == 200)
        {
            final data = json.decode(response.body);
            List<LatLng> route = [];

            if (data['routes'].isNotEmpty)
            {
                final points = data['routes'][0]['legs'][0]['steps'];
                for (var point in points)
                {
                    final lat = point['end_location']['lat'];
                    final lng = point['end_location']['lng'];
                    route.add(LatLng(lat, lng));
                }
            }

            return route;
        }
        else
        {
            throw Exception('Failed to load directions');
        }
    }

    void _decodePolyline(dynamic data)
    {
        try
        {
            String points = data['routes'][0]['overview_polyline']['points'];
            List<PointLatLng> decodedPoints = PolylinePoints().decodePolyline(points);

            if (decodedPoints.isEmpty)
            {
                print('No points decoded from polyline');
                return;
            }

            List<LatLng> polylineCoordinates = decodedPoints
                .map((point) => LatLng(point.latitude, point.longitude))
                .toList();

            setState(()
                {
                    polylines.add(Polyline(
                            polylineId: const PolylineId('route'),
                            color: Colors.blue,
                            points: polylineCoordinates,
                            width: 5
                        ));
                }
            );
        }
        catch (e)
        {
            print('Error decoding polyline: $e');
        }
    }

    @override
    Widget build(BuildContext context)
    {
        if (userLocation == null)
        {
            return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
            appBar: AppBar(title: const Text('Route Map')),
            body: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: userLocation!,
                    zoom: 12
                ),
                markers: markers,
                polylines: polylines,
                onMapCreated: (GoogleMapController controller)
                {
                    mapController = controller;
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true
            )
        );
    }
}
