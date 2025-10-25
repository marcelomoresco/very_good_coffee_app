enum Status { initial, loading, success, error }

extension StatusExtension on Status {
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get hasError => this == Status.error;
}
