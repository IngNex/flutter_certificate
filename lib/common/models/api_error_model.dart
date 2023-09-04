class ApiErrorModel {
  int? statusCode;
  String? message;
  String? error;

  ApiErrorModel(this.error, this.message, this.statusCode);

  ApiErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    error = json['error'];
  }
}
