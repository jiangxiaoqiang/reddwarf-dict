
enum LearnWordType {
  learn,
  remembered,
  all
}

extension ResponseStatusExtension on LearnWordType{
  static const menuValue = {
    LearnWordType.learn: 1,
    LearnWordType.remembered: 2,
    LearnWordType.all: 3,
  };

  int get value => menuValue[this]!;
}


