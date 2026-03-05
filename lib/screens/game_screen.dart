import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/background_pattern.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().playCurrentSound();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundPattern(
        child: SafeArea(
          child: Consumer<GameProvider>(
            builder: (context, gameProvider, child) {
              return Column(
                children: [
                  _buildTopBar(context),
                  const SizedBox(height: 40),
                  Expanded(
                    child: _buildMainArea(gameProvider),
                  ),
                  _buildControlButtons(gameProvider),
                  const SizedBox(height: 40),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF433466),
                  width: 3,
                ),
              ),
              child: const Icon(
                Icons.home,
                color: Color(0xFF433466),
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainArea(GameProvider gameProvider) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
          ),
          child: child,
        );
      },
      child: Container(
        key: ValueKey<bool>(gameProvider.isAnswerRevealed),
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xFF433466),
            width: 4,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF433466).withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: gameProvider.isAnswerRevealed
            ? _buildRevealedImage(gameProvider)
            : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Text(
        '?',
        style: GoogleFonts.fredokaOne(
          fontSize: 120,
          color: const Color(0xFF433466).withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildRevealedImage(GameProvider gameProvider) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Image.asset(
        gameProvider.currentItem.image,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Text(
              gameProvider.currentItem.id.toUpperCase(),
              style: GoogleFonts.fredokaOne(
                fontSize: 48,
                color: const Color(0xFF433466),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildControlButtons(GameProvider gameProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildRepeatButton(gameProvider),
          _buildActionButton(gameProvider),
        ],
      ),
    );
  }

  Widget _buildRepeatButton(GameProvider gameProvider) {
    return GestureDetector(
      onTap: () => gameProvider.playCurrentSound(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFE0F2FE),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: const Color(0xFF433466),
            width: 3,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.volume_up,
              color: Color(0xFF433466),
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              'Repeat',
              style: GoogleFonts.fredokaOne(
                fontSize: 20,
                color: const Color(0xFF433466),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(GameProvider gameProvider) {
    final isRevealed = gameProvider.isAnswerRevealed;
    
    return GestureDetector(
      onTap: () {
        if (isRevealed) {
          gameProvider.nextRound();
        } else {
          gameProvider.showAnswer();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFF9F29),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: const Color(0xFF433466),
            width: 3,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isRevealed ? Icons.arrow_forward : Icons.visibility,
              color: const Color(0xFF433466),
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              isRevealed ? 'Next' : 'Show Answer',
              style: GoogleFonts.fredokaOne(
                fontSize: 20,
                color: const Color(0xFF433466),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
