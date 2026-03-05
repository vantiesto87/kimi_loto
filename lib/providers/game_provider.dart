import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/game_item.dart';

class GameProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentIndex = 0;
  bool _isAnswerRevealed = false;
  final List<GameItem> _shuffledItems = [];

  GameProvider() {
    _shuffleItems();
  }

  void _shuffleItems() {
    _shuffledItems.addAll(GameItem.items);
    _shuffledItems.shuffle(Random());
  }

  GameItem get currentItem => _shuffledItems.isNotEmpty 
      ? _shuffledItems[_currentIndex] 
      : GameItem.items[0];
  
  bool get isAnswerRevealed => _isAnswerRevealed;

  void playCurrentSound() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(currentItem.audio.replaceFirst('assets/', '')));
  }

  void showAnswer() {
    _isAnswerRevealed = true;
    notifyListeners();
  }

  void nextRound() {
    _isAnswerRevealed = false;
    _currentIndex = (_currentIndex + 1) % _shuffledItems.length;
    notifyListeners();
    playCurrentSound();
  }

  void resetGame() {
    _currentIndex = 0;
    _isAnswerRevealed = false;
    _shuffledItems.shuffle(Random());
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
