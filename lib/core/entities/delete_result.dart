class DeleteResult {
  final bool isDeleted;
  final String? errorMessage;

  DeleteResult({
    required this.isDeleted,
    this.errorMessage,
  });
}
