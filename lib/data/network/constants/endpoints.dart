class Endpoints {
  Endpoints._();
  static const environment =
      String.fromEnvironment('APP_VERSION', defaultValue: 'production') ==
              'production'
          ? 'http://13.125.200.185:3000'
          : 'http://13.125.200.185:3000';
  // : 'http://192.168.31.131:3000';

  static String serverEndpoint = environment;
  static String baseUrl = serverEndpoint + '/api';

  // receiveTimeout
  static int receiveTimeout = 40000;
  // connectTimeout
  static int connectionTimeout = 40000;

  static String auth = "https://id-cgz2k4uuaa-du.a.run.app";
  static String uploadProfileImage = "https://image-cgz2k4uuaa-du.a.run.app/";
  static String wiberSpace = "https://space-cgz2k4uuaa-du.a.run.app";
  static String category = "https://category-cgz2k4uuaa-du.a.run.app";
  static String bucket = "https://bucket-cgz2k4uuaa-du.a.run.app";
  static String notice = "https://notice-cgz2k4uuaa-du.a.run.app";
  static String faq = "https://faq-cgz2k4uuaa-du.a.run.app";
}
