import 'package:ed_tech_aap/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';

class RegionScreen extends StatefulWidget {
  const RegionScreen({super.key});

  @override
  State<RegionScreen> createState() => _RegionScreenState();
}

class _RegionScreenState extends State<RegionScreen>
    with SingleTickerProviderStateMixin {
  final Flutter3DController _controller = Flutter3DController();
  bool _isLoading = true;
  String country = "";

  // AnimationController to manage the zoom animation
  late AnimationController _animationController;

  // Animation that interpolates between 1.0 and 1.5 for zoom effect
  late Animation<double> _zoomAnimation;

  // Visibility flags for pins
  bool _showKarachi = false;
  bool _showIslamabad = false;
  bool _showLahore = false;

  @override
  void initState() {
    super.initState();
    _initializeModel();

    // Initialize the animation controller with a 2-second duration
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Define a zoom animation with an ease-in curve
    _zoomAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));

    // Start the zoom animation immediately
    _animationController.forward();
  }

  @override
  void dispose() {
    // Dispose the animation controller to free up resources
    _animationController.dispose();
    super.dispose();
  }

  // Initialize the 3D model and set initial camera position
  Future<void> _initializeModel() async {
    await Future.delayed(const Duration(seconds: 1));
    _controller.setCameraOrbit(0, 0, 0); // Set initial camera orbit
    setState(() {
      _isLoading = false; // Update loading state
    });
  }

  // Method to set the model's camera position based on given coordinates
  Future<void> setModel(double x, double y, double z) async {
    // Note: Correct the real dimensional values of x, y, z for better accuracy.
    // These values are placeholders and should be fine-tuned for a better user experience.

    _animationController.forward(from: 0); // Restart the animation
    await Future.delayed(
        const Duration(milliseconds: 300)); // Delay for animation
    _controller.setCameraOrbit(x * _zoomAnimation.value,
        y * _zoomAnimation.value, z); // Apply zoom effect
    print('Position: $x, $y, $z'); // Debug print for coordinates
  }

  // Show a dialog for city selection based on the selected country
  Future<void> showCitySelectionDialog(String country) async {
    List<Map<String, dynamic>> cities;
    await Future.delayed(const Duration(seconds: 1)); // Simulate loading delay

    // Define city coordinates for different countries
    // Note: The 3D model should use high-quality design for better visualization.
    switch (country) {
      case 'Pakistan':
        cities = [
          {
            'name': 'Lahore',
            'coords': [-110, 60, -10] // Placeholder values, adjust accordingly
          },
          {
            'name': 'Karachi',
            'coords': [-110, 60, -10] // Placeholder values, adjust accordingly
          },
          {
            'name': 'Islamabad',
            'coords': [-110, -60, -10] // Placeholder values, adjust accordingly
          },
        ];

        break;
      case 'USA':
        cities = [
          {
            'name': 'New York',
            'coords': [-100, -50, 0] // Placeholder values, adjust accordingly
          },
          {
            'name': 'Los Angeles',
            'coords': [-90, -40, 0] // Placeholder values, adjust accordingly
          },
          {
            'name': 'Chicago',
            'coords': [-110, -60, 0] // Placeholder values, adjust accordingly
          },
        ];

        break;
      case 'China':
        cities = [
          {
            'name': 'Beijing',
            'coords': [-120, -30, 0] // Placeholder values, adjust accordingly
          },
          {
            'name': 'Shanghai',
            'coords': [-130, -35, 0] // Placeholder values, adjust accordingly
          },
          {
            'name': 'Guangzhou',
            'coords': [-140, -25, 0] // Placeholder values, adjust accordingly
          },
        ];

        break;
      case 'Brazil':
        cities = [
          {
            'name': 'Rio de Janeiro',
            'coords': [-50, -10, 0] // Placeholder values, adjust accordingly
          },
          {
            'name': 'São Paulo',
            'coords': [-60, -15, 0] // Placeholder values, adjust accordingly
          },
          {
            'name': 'Brasília',
            'coords': [-70, -5, 0] // Placeholder values, adjust accordingly
          },
        ];

        break;
      case 'France':
        cities = [
          {
            'name': 'Paris',
            'coords': [-10, -50, 0] // Placeholder values, adjust accordingly
          },
          {
            'name': 'Lyon',
            'coords': [-20, -55, 0] // Placeholder values, adjust accordingly
          },
          {
            'name': 'Marseille',
            'coords': [-15, -45, 0] // Placeholder values, adjust accordingly
          },
        ];

        break;
      default:
        cities = []; // No cities available for the default case
    }

    if (cities.isNotEmpty) {
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Select City in $country',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: cities.map(
                  (city) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          city['name'],
                          style: TextStyle(
                            color: Colors.blue.shade800,
                            fontSize: 16,
                          ),
                        ),
                        trailing:
                            const Icon(Icons.location_city, color: Colors.blue),
                        onTap: () async {
                          print(
                              'Selected city: ${city['name']}'); // Debug print for selected city
                          Navigator.of(context).pop(); // Close dialog
                          setState(() {
                            // Update visibility flags based on selected city
                            _showKarachi = city['name'] == 'Karachi';
                            _showLahore = city['name'] == 'Lahore';
                            _showIslamabad = city['name'] == 'Islamabad';
                          });
                          await setModel(
                            city['coords'][0],
                            city['coords'][1],
                            city['coords'][2],
                          );
                        },
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          );
        },
      );
    } else {
      // Show an error dialog if no cities are available for the selected country
      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Error!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
            content: Text(
              'Select region first',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red.shade800,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.red.shade900),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            key: const ValueKey('floatingActionButton'),
            backgroundColor: Colors.blue.shade800,
            onPressed: () {
              showCitySelectionDialog(country);
            },
            child: const Icon(
              Icons.location_city,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NextScreen()),
              );
            },
            backgroundColor: Colors.blue.shade800,
            child: const Icon(
              Icons.navigate_next,
              color: Colors.white,
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          const Text(
            'Select your region',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.location_on, color: Colors.white),
            onSelected: (value) async {
              switch (value) {
                case 0:
                  country = 'Pakistan';

                  print(
                      'Selected country: $country'); // Debug print for selected country
                  await setModel(-110, 60,
                      0); // Adjust these coordinates for better accuracy
                  setState(() {
                    _showKarachi = true;
                    _showIslamabad = true;
                    _showLahore = true;
                  });
                  break;
                case 1:
                  country = 'USA';
                  setState(() {
                    _showKarachi = false;
                    _showIslamabad = false;
                    _showLahore = false;
                  });
                  print(
                      'Selected country: $country'); // Debug print for selected country
                  await setModel(-100, 50,
                      0); // Adjust these coordinates for better accuracy
                  break;
                case 2:
                  country = 'China';
                  setState(() {
                    _showKarachi = false;
                    _showIslamabad = false;
                    _showLahore = false;
                  });
                  print(
                      'Selected country: $country'); // Debug print for selected country
                  await setModel(120, 30,
                      0); // Adjust these coordinates for better accuracy
                  break;
                case 3:
                  country = 'Brazil';
                  setState(() {
                    _showKarachi = false;
                    _showIslamabad = false;
                    _showLahore = false;
                  });
                  print(
                      'Selected country: $country'); // Debug print for selected country
                  await setModel(-50, -10,
                      0); // Adjust these coordinates for better accuracy
                  break;
                case 4:
                  country = 'France';
                  setState(() {
                    _showKarachi = false;
                    _showIslamabad = false;
                    _showLahore = false;
                  });
                  print(
                      'Selected country: $country'); // Debug print for selected country
                  await setModel(10, 50,
                      0); // Adjust these coordinates for better accuracy
                  break;
                default:
                  country = '';
              }

              showCitySelectionDialog(
                  country); // Show city selection dialog based on selected country
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text(
                  'Pakistan',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text(
                  'USA',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text(
                  'China',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Text(
                  'Brazil',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
              PopupMenuItem<int>(
                value: 4,
                child: Text(
                  'France',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  )
                : AnimatedBuilder(
                    animation: _zoomAnimation,
                    builder: (context, child) {
                      return Flutter3DViewer(
                        progressBarColor: Colors.blue.shade900,
                        src:
                            'assets/Earth_3d_model.glb', // Ensure this is a high-quality model for better experience
                        controller: _controller,
                      );
                    },
                  ),
          ),
          _showKarachi == false
              ? const SizedBox()
              : Positioned(
                  top: 335,
                  left: 160,
                  child: GestureDetector(
                    onTap: () {
                      print('Karachi');
                    },
                    child: const Text(
                      '📍',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
          _showIslamabad == false
              ? const SizedBox()
              : Positioned(
                  top: 260,
                  left: 198,
                  child: GestureDetector(
                    onTap: () {
                      print('Islamabad');
                    },
                    child: const Text(
                      '📍',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
          _showLahore == false
              ? const SizedBox()
              : Positioned(
                  top: 275,
                  left: 215,
                  child: GestureDetector(
                    onTap: () {
                      print('Lahore');
                    },
                    child: const Text(
                      '📍',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
