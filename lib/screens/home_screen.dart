import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/game_provider.dart';
import '../widgets/background_pattern.dart';
import 'game_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundPattern(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Minimany Toys',
                  style: GoogleFonts.fredokaOne(
                    fontSize: 48,
                    color: const Color(0xFF433466),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Guess the Sound!',
                  style: GoogleFonts.fredokaOne(
                    fontSize: 24,
                    color: const Color(0xFF433466).withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 80),
                _buildStartButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final gameProvider = context.read<GameProvider>();
        gameProvider.resetGame();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GameScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFF9F29),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xFF433466),
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF433466).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          'Start Game',
          style: GoogleFonts.fredokaOne(
            fontSize: 32,
            color: const Color(0xFF433466),
          ),
        ),
      ),
    );
  }
}
