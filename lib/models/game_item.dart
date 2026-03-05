class GameItem {
  final String id;
  final String image;
  final String audio;

  const GameItem({
    required this.id,
    required this.image,
    required this.audio,
  });

  static const List<GameItem> items = [
    GameItem(id: 'car', image: 'assets/images/car.png', audio: 'assets/sounds/car.mp3'),
    GameItem(id: 'dog', image: 'assets/images/dog.png', audio: 'assets/sounds/dog.mp3'),
    GameItem(id: 'cat', image: 'assets/images/cat.png', audio: 'assets/sounds/cat.mp3'),
    GameItem(id: 'bird', image: 'assets/images/bird.png', audio: 'assets/sounds/bird.mp3'),
    GameItem(id: 'train', image: 'assets/images/train.png', audio: 'assets/sounds/train.mp3'),
    GameItem(id: 'drum', image: 'assets/images/drum.png', audio: 'assets/sounds/drum.mp3'),
    GameItem(id: 'phone', image: 'assets/images/phone.png', audio: 'assets/sounds/phone.mp3'),
    GameItem(id: 'bell', image: 'assets/images/bell.png', audio: 'assets/sounds/bell.mp3'),
  ];
}
