class ApiResult {
  ApiResult({this.isSuccess = false, this.message = '', this.extra = const <String, dynamic>{}});

  final bool isSuccess;
  final String message;
  final Map<String, dynamic> extra;

  @override
  String toString() {
    return 'ApiResult{result: $isSuccess, message: $message, extra: $extra}';
  }
}
