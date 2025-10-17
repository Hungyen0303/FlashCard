enum ServerType {
  none,
  server;

  String get value {
    switch (this) {
      case ServerType.none:
        return 'none';
      case ServerType.server:
        return 'server';
    }
  }

  static ServerType fromValue(String? value) {
    switch (value) {
      case 'server':
        return ServerType.server;
      case 'none':
      default:
        return ServerType.none;
    }
  }
}
