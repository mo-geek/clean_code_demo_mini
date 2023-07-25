import 'error_object.dart';

abstract class Failure {
  String? cause;
  Failure([this.cause]);

  ErrorObject when({
    required ErrorObject Function() serverFailure,
    required ErrorObject Function() dataParsingFailure,
    required ErrorObject Function() noConnectionFailure,
    required ErrorObject Function() ambiguousFailure,
  }) {
    if (this.runtimeType == ServerFailure) {
      return serverFailure();
    } else if (this.runtimeType == ConnectionFailure) {
      return noConnectionFailure();
    } else if (this.runtimeType == DataParsingFailure) {
      return dataParsingFailure();
    } else {
      return ambiguousFailure();
    }
  }
}

// General failures
class ServerFailure extends Failure {
  String? cause;
  ServerFailure(this.cause) : super(cause);
}

class AmbiguousFailure extends Failure {
  String? cause;
  AmbiguousFailure(this.cause) : super(cause);
}

class ConnectionFailure extends Failure {}

class DataParsingFailure extends Failure {
  String? cause;
  DataParsingFailure(this.cause);
}
