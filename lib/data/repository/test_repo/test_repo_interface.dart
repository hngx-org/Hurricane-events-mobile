import 'package:tuple/tuple.dart';

abstract class TestRepoInterface {
  Future<Tuple2<List<Channels>?, String?>> getChannels();
}

class Channels {}
//Example class
