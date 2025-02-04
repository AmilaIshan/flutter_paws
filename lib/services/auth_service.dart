class AuthService{
  String? _userName;

  void setUserName(String name) {
    _userName = name;
  }

  String userName() {
    return _userName ?? 'Guest';
  }
}