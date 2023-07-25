import 'package:nawytask/core/error/failures.dart';

class ErrorObject {
  const ErrorObject({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  /// Again, here I leverage the power of sealed_classes to write robust code and
  /// make sure to map evey and each failure with a specific message to show in
  /// the UI.
  static ErrorObject mapFailureToErrorObject({required Failure failure}) {
    return failure.when(
      serverFailure: () => ErrorObject(
          title: 'Error Code: INTERNAL_SERVER_FAILURE',
          message: (failure.cause == null || (failure.cause == ""))
              ? 'It seems that the server is not reachable at the moment, try '
                  'again later'
              : failure.cause!
          // , should the issue persist please reach out to the '
          // 'developer at a@b.com'
          ),
      dataParsingFailure: () => const ErrorObject(
        title: 'Error Code: JSON_PARSING_FAILURE',
        message: 'It seems that the app needs to be updated to reflect the , '
            'changed server data structure, if no update is '
            'available on the store please reach out to the developer at a@b.com',
      ),
      noConnectionFailure: () => const ErrorObject(
        title: 'Error Code: NO_CONNECTIVITY',
        message: 'It seems that your device is not connected to the network, '
            'please check your internet connectivity or try again later.',
      ),
      ambiguousFailure: () => ErrorObject(
        title: failure.cause ?? 'An Error Occurred',
        message: '!!',
      ),
    );
  }

  @override
  bool operator ==(covariant ErrorObject other) {
    if (identical(this, other)) {
      return true;
    }

    return other.title == title && other.message == message;
  }

  @override
  int get hashCode => title.hashCode ^ message.hashCode;
}
