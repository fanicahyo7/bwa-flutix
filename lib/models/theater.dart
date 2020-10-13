part of 'models.dart';

class Theater extends Equatable {
  final String name;

  Theater(this.name);

  @override
  List<Object> get props => [name];
}

List<Theater> dummysTheater = [
  Theater("Dieng 21"),
  Theater("Transmart MX Mall XXI"),
  Theater("Movimax Dinoyo"),
  Theater("Cinépolis Malang Town Square")
  ];
