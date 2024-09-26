import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class BookStoreMap extends StatefulWidget {
  const BookStoreMap({super.key});

  @override
  State<BookStoreMap> createState() => _BookStoreMapState();
}

class _BookStoreMapState extends State<BookStoreMap> {
  LatLng? _currentLocation; // Store the user's current location
  final MapController _mapController = MapController();
  final TextEditingController _searchController =
      TextEditingController(); // Search controller
  final List<Marker> _markers = []; // Markers for the map
  bool _isSearching = true;

  String? _selectedPlaceType; // Selected place type from dropdown
  final List<DropdownItem> _placeTypes = [
    DropdownItem('Libraries', 'library'),
    DropdownItem('Restaurants', 'restaurant'),
    DropdownItem('Pharmacies', 'pharmacy'),
    DropdownItem('Schools', 'school'),
  ]; // Place options

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Fetch the location on app startup
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _isSearching = false;
      _markers.add(
        Marker(
          point: _currentLocation!,
          child: const Icon(Icons.my_location, color: Colors.blue, size: 40),
        ),
      );
    });
  }

  // Function to search for places using Overpass API
  Future<void> _searchPlaces(String query) async {
    if (_currentLocation == null) return;

    setState(() {
      _isSearching = true;
    });

    const String url = 'https://overpass-api.de/api/interpreter';
    final String overpassQuery = '''
    [out:json];
    node["name"~"$query", i](around:5000, ${_currentLocation!.latitude}, ${_currentLocation!.longitude});
    out;
    ''';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'data': overpassQuery},
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['elements'];

        // Clear previous markers
        _markers.clear();

        if (data.isNotEmpty) {
          setState(() {
            LatLng? centerPoint;

            for (var element in data) {
              if (element['tags'] != null && element['tags']['name'] != null) {
                LatLng targetLocation = LatLng(element['lat'], element['lon']);
                // Set the center to the first result
                centerPoint ??= targetLocation;
                _markers.add(
                  Marker(
                    point: targetLocation,
                    child: IconButton(
                      icon: const Icon(Icons.location_on,
                          color: Colors.red, size: 40),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 100,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      element['tags']['name'],
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      element['lat'],
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      element['lon'],
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              }
            }

            CameraFit.bounds(
              bounds: LatLngBounds.fromPoints(
                  _markers.map((m) => m.point).toList()),
              padding: const EdgeInsets.all(50),
            );
            _mapController.move(centerPoint!, 13.0);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No places found for "$query"')),
          );
        }
      } else {
        throw Exception('Failed to load places');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching places: $e')),
      );
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  // Function to search for bookstores or places by type using Overpass API
  Future<void> _searchByPlaceType() async {
    if (_currentLocation == null || _selectedPlaceType == null) return;

    setState(() {
      _isSearching = true;
    });

    const String url = 'https://overpass-api.de/api/interpreter';
    final String query = '''
    [out:json];
    node["amenity"="${_selectedPlaceType!.toLowerCase()}"](around:5000, ${_currentLocation!.latitude}, ${_currentLocation!.longitude});
    out;
    ''';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'data': query},
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body)['elements'];

        // Clear previous markers
        _markers.clear();

        if (data.isNotEmpty) {
          setState(() {
            LatLng? centerPoint;

            for (var element in data) {
              if (element['tags'] != null && element['tags']['name'] != null) {
                LatLng targetLocation = LatLng(element['lat'], element['lon']);
                centerPoint ??= targetLocation;
                _markers.add(
                  Marker(
                    point: targetLocation,
                    child: IconButton(
                      icon: const Icon(Icons.location_on,
                          color: Colors.red, size: 40),
                      onPressed: () {
                          print(element['lat']);
                          print(element['lon']);
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      element['tags']['name'],
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '${element['lat']}',
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '${element['lon']}',
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
                _markers.add(
                  Marker(
                    point: _currentLocation!,
                    child: const Icon(Icons.my_location, color: Colors.blue, size: 40),
                  ),
                );
              }
            }

            CameraFit.bounds(
              bounds: LatLngBounds.fromPoints(
                  _markers.map((m) => m.point).toList()),
              padding: const EdgeInsets.all(50),
            );
            _mapController.move(centerPoint!, 13.0);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('No places found for "$_selectedPlaceType"')),
          );
        }
      } else {
        throw Exception('Failed to load places');
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching places: $e')),
      );
    } finally {
      setState(() {
        _isSearching = false;
      });
    }
  }

  // Handle dropdown selection change
  void _onDropdownChanged(String? newValue) {
    setState(() {
      _selectedPlaceType = newValue;
      if (newValue != null) {
        _searchByPlaceType(); // Trigger search when a place type is selected
      }
    });
  }

  // Handle search bar input and trigger search
  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      _searchPlaces(query); // Trigger search based on user input
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Finder'),
        backgroundColor: const Color.fromARGB(255, 1, 44, 80),
        foregroundColor: Colors.white
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for a place',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _onSearchSubmitted(_searchController.text),
                ),
              ),
              onSubmitted: _onSearchSubmitted,
            ),
          ),

          // Dropdown for selecting place type
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              value: _selectedPlaceType,
              hint: const Text('Select place type'),
              items: _placeTypes.map((DropdownItem item) {
                return DropdownMenuItem<String>(
                  value: item.value,
                  child: Text(item.displayName),
                );
              }).toList(),
              onChanged: _onDropdownChanged,
            ),
          ),

          _isSearching == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter:
                          _currentLocation ?? const LatLng(9.031643, 38.761252),
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.place_finder',
                      ),
                      MarkerLayer(
                        markers:
                            _markers, // Use the dynamically updated markers
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class DropdownItem {
  final String displayName;
  final String value;

  DropdownItem(this.displayName, this.value);
}
