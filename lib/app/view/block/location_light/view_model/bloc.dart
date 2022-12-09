import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kakao_address_handler/kakao_address_handler.dart';

import '../../../template/models/abstract_bloc_state.dart';

part 'event.dart';
part 'state.dart';

class LocationLightBlockBloc extends Bloc<LocationLightBlockEvent, LocationLightBlockState> {
  LocationLightBlockBloc() : super(LocationLightBlockState()) {
    on<LocationLightUpdated>(_onLocationLightUpdated);
  }

  void _onLocationLightUpdated(
    LocationLightUpdated event,
    Emitter<LocationLightBlockState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    emit(
      state.copyWith(
        locationInfo: event.locationInfo,
        status: FormzStatus.submissionSuccess,
      ),
    );
  }
}
