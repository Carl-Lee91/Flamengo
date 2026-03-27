import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flamengo/features/footprint/domain/entities/footprint.dart';

part 'footprint_state.freezed.dart';

@freezed
abstract class FootprintState with _$FootprintState {
  const factory FootprintState.initial() = _Initial;
  const factory FootprintState.loading() = _Loading;
  const factory FootprintState.loaded(FootprintData data) = _Loaded;
  const factory FootprintState.error(String message) = _Error;
}
