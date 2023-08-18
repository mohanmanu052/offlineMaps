import 'package:offline_maps/videochat/data/datasources/remote_datasource.dart';
import 'package:offline_maps/videochat/di/injector.dart';

void initDataSourceModule() {
  i.registerSingleton<RemoteDataSource>(
    RemoteDataSource(),
  );
}
