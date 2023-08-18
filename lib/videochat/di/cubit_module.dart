
import 'package:offline_maps/videochat/di/injector.dart';
import 'package:offline_maps/videochat/presentation/pages/webrtc/webrtc_cubit.dart';

void initCubitModule() {
  i.registerFactory<WebrtcCubit>(() => WebrtcCubit(i.get()));
}
