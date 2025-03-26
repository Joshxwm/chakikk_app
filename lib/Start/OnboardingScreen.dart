import 'package:chakikk_app/UI/Account/loginScreen.dart';
import 'package:chakikk_app/UI/Account/regScreen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  late VideoPlayerController _videoController;
  late PageController _pageController;

  final List<Map<String, String>> _pages = [
    {
      "video": "assets/video/rain.mp4",
      "text": "Acceso directo a mapas de huracanes en tiempo real",
    },
    {
      "video": "assets/video/rain.mp4",
      "text":
          "Fomenta información más segura para el resguardo en épocas de huracanes, tormentas y más",
    },
    {
      "video": "assets/video/rain.mp4",
      "text": "Solicita ayuda y accede a refugios en casos de emergencia",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeVideo();
  }

  void _initializeVideo() {
    _videoController = VideoPlayerController.asset(_pages[0]["video"]!)
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
        _videoController.setLooping(true);
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });

    if (_videoController.value.isInitialized) {
      _videoController.seekTo(Duration.zero);
      _videoController.play();
    }
  }

  void _goToRegister() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RegScreen()),
    );
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child:
                _videoController.value.isInitialized
                    ? AspectRatio(
                      aspectRatio: _videoController.value.aspectRatio,
                      child: VideoPlayer(_videoController),
                    )
                    : const Center(child: CircularProgressIndicator()),
          ),

          // Contenido del PageView
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20), // Espacio donde estaba el logo
                    const Text(
                      "Chak iik’ App",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 100),
                    Text(
                      _pages[index]["text"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Indicadores de página y botón de registro
          Positioned(
            left: 16,
            right: 16,
            bottom: 100,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentPage == index ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _goToRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Para comenzar",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Texto "Iniciar sesión"
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: _goToLogin,
              child: const Text(
                "¿Ya tienes una cuenta?  Iniciar sesión",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
