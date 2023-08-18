import 'package:offline_maps/videochat/di/injector.dart';
import 'package:offline_maps/videochat/domain/interactors/webrtc_interactor.dart';

void initInteractorModule() {
  i.registerFactory<WebrtcInteractor>(() => WebrtcInteractor(i.get()));
}
