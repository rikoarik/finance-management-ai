/// Exception thrown when API quota/limit is exceeded
class QuotaExceededException implements Exception {
  final String message;
  final String? originalError;

  QuotaExceededException({
    this.message = 'Quota limit exceeded. Please upgrade to continue using the service.',
    this.originalError,
  });

  @override
  String toString() {
    return message;
  }
}

