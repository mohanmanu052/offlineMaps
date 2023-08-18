import 'package:offline_maps/videochat/data/repositories/auth_repository.dart';
import 'package:offline_maps/videochat/data/repositories/room_repository.dart';
import 'package:offline_maps/videochat/di/injector.dart';
import 'package:offline_maps/videochat/domain/repositories/auth_repository.dart';
import 'package:offline_maps/videochat/domain/repositories/room_repository.dart';

void initRepositoryModule() {
  i.registerSingleton<RoomRepositoryInt>(RoomRepository(i.get()));
  i.registerSingleton<AuthRepositoryInt>(AuthRepository(i.get()));
}
