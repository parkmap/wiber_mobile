import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio => Dio();
}
