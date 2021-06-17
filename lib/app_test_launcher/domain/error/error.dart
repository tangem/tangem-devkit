abstract class TestFrameworkError {
  String get errorMessage;
}

class CustomError implements TestFrameworkError {
  final String _customError;

  CustomError(this._customError);

  @override
  String get errorMessage => _customError;
}
