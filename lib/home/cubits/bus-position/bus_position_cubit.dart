// lib/home/cubits/bus-position/bus_position_cubit.dart
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:tripiz_app/home/models/bus_position.dart';
import 'package:tripiz_app/home/cubits/bus-position/bus_position_state.dart';

class BusPositionCubit extends Cubit<BusPositionState> {
  late final StompClient _client;
  final List<BusPosition> _buses = [];

  BusPositionCubit() : super(BusPositionInitial()) {
    print("🚀 Initialisation BusPositionCubit");

    _client = StompClient(
      config: StompConfig(
        url: 'wss://tripiz-api-production.up.railway.app/ws',
        onConnect: _onConnect,
        onDisconnect: (frame) => print("❌ WebSocket déconnecté"),
        onWebSocketError: (e) {
          print("❌ Erreur WebSocket: $e");
          emit(BusPositionError(e.toString()));
        },
        onStompError: (frame) => print("❌ Erreur STOMP: ${frame.body}"),
        onDebugMessage: (message) => print('📡 STOMP Debug: $message'),
        reconnectDelay: const Duration(seconds: 5),
        heartbeatIncoming: const Duration(seconds: 20),
        heartbeatOutgoing: const Duration(seconds: 20),
      ),
    );

    print("🔄 Activation du client WebSocket...");
    _client.activate();
  }

  void _onConnect(StompFrame frame) {
    print('✅ WebSocket connecté avec succès !');
    print('📋 Frame de connexion: ${frame.headers}');

    print('🎯 Souscription à /topic/positions...');
    _client.subscribe(
      destination: '/topic/positions',
      callback: (StompFrame f) {
        print("🎉 UUUUUUUUUUUUUUUUUU - Message reçu sur /topic/positions !");
        print("📨 Headers: ${f.headers}");
        print("📄 Body brut: '${f.body}'");

        if (f.body == null || f.body!.isEmpty) {
          print("⚠️  Body vide, abandon");
          return;
        }

        try {
          print("🔍 Tentative de décodage JSON...");
          final data = jsonDecode(f.body!);
          print("✅ JSON décodé avec succès: $data");
          print("📊 Type de data: ${data.runtimeType}");

          // Vérification du contenu
          if (data is Map<String, dynamic>) {
            print("🗺️  Contenu de la Map:");
            data.forEach((key, value) {
              print("   $key: $value (${value.runtimeType})");
            });
          }

          print("🏗️  Création de BusPosition...");
          final BusPosition pos = BusPosition.fromJson(data);
          print(
            "✅ BusPosition créé: busId=${pos.busId}, lat=${pos.latitude}, lng=${pos.longitude}",
          );

          final idx = _buses.indexWhere((b) => b.busId == pos.busId);
          if (idx >= 0) {
            print("🔄 Mise à jour du bus existant à l'index $idx");
            _buses[idx] = pos;
          } else {
            print("➕ Ajout d'un nouveau bus");
            _buses.add(pos);
          }

          print("📊 Total buses: ${_buses.length}");
          for (var bus in _buses) {
            print("   🚌 ${bus.busId}: (${bus.latitude}, ${bus.longitude})");
          }

          print("🔄 Émission du nouvel état...");
          emit(BusPositionLoadSuccess(List.of(_buses)));
          print("✅ État émis avec succès !");
        } catch (e, stackTrace) {
          print("❌ Erreur lors du parsing: $e");
          print("📍 StackTrace: $stackTrace");
          emit(BusPositionError("Erreur parsing: $e"));
        }
      },
    );

    print("✅ Souscription terminée");
  }

  @override
  void onChange(Change<BusPositionState> change) {
    super.onChange(change);
    print(
      '🔀 État changé: ${change.currentState.runtimeType} → ${change.nextState.runtimeType}',
    );
    if (change.nextState is BusPositionLoadSuccess) {
      final state = change.nextState as BusPositionLoadSuccess;
      print('📍 Nouveau state avec ${state.buses.length} bus');
    }
  }

  @override
  Future<void> close() {
    print("🔚 Fermeture du BusPositionCubit");
    _client.deactivate();
    return super.close();
  }
}
