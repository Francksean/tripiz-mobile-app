import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripiz_app/home/cubits/bus-position/bus_position_state.dart';
import 'package:tripiz_app/home/models/bus_position.dart';
import 'package:web_socket_channel/io.dart';

class BusPositionCubit extends Cubit<BusPositionState> {
  late final IOWebSocketChannel _channel;
  final List<BusPosition> _buses = [];

  BusPositionCubit() : super(BusPositionInitial()) {
    // Remplace par ton URL
    _channel = IOWebSocketChannel.connect(
      'ws://tripiz-api-production.up.railway.app/',
    );
    _channel.stream.listen(_onData, onError: _onError, onDone: _onDone);
  }

  void _onData(dynamic raw) {
    final json = jsonDecode(raw as String) as Map<String, dynamic>;
    final busPos = BusPosition.fromJson(json);

    // mise à jour (remplace ou ajoute)
    final idx = _buses.indexWhere((b) => b.id == busPos.id);
    if (idx >= 0) {
      _buses[idx] = busPos;
    } else {
      _buses.add(busPos);
    }

    emit(BusPositionLoadSuccess(List.from(_buses)));
  }

  void _onError(error) {
    // tu peux émettre un état d’erreur ou logger
    print('WebSocket error: $error');
  }

  void _onDone() {
    // fermer ou tenter une reconnexion
    _channel.sink.close();
  }

  @override
  Future<void> close() {
    _channel.sink.close();
    return super.close();
  }
}
