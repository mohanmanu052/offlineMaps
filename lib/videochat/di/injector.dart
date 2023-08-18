import 'package:get_it/get_it.dart';
import 'package:offline_maps/videochat/di/cubit_module.dart';
import 'package:offline_maps/videochat/di/data_source_module.dart';
import 'package:offline_maps/videochat/di/interactor_module.dart';
import 'package:offline_maps/videochat/di/repository_module.dart';

GetIt get i => GetIt.instance;

void initInjector() {
  initDataSourceModule();
  initRepositoryModule();
  initInteractorModule();
  initCubitModule();
}
