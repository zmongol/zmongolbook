class LoginResult {
  final bool success;
  String? accessToken;
  String? errorMessage;

  LoginResult(this.success, {this.accessToken, this.errorMessage});
}
