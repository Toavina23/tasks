class UnknowException implements Exception {
  final String message;
  const UnknowException(this.message);
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);
}
