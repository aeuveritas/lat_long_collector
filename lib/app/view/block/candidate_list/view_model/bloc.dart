import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:draccoon_logger/draccoon_logger.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kakao_address_handler/kakao_address_handler.dart';

import '../../../../models/form_component.dart';
import '../../../template/models/barrel.dart';

part 'event.dart';
part 'state.dart';

class CandidateListBlockBloc extends Bloc<CandidateListBlockEvent, CandidateListBlockState> with MixInLogger {
  CandidateListBlockBloc({
    required this.updateStreamController,
    required this.component,
    required this.kakaoAddressHandler,
  }) : super(CandidateListBlockState()) {
    on<CandidateSearchFirstRequested>(_onTextSearchFirstRequested);
    on<CandidateSearchAdditionalRequested>(_onTextSearchAdditionalRequested);
    on<CandidateSearchSelected>(_onTextSearchSelected);
  }

  final StreamController<FormComponent> updateStreamController;
  final FormComponent component;
  final KakaoAddressHandler kakaoAddressHandler;

  void _onTextSearchFirstRequested(
    CandidateSearchFirstRequested event,
    Emitter<CandidateListBlockState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    try {
      final responseChunk = await kakaoAddressHandler.getCandidates(event.text, 1);

      if (responseChunk.tooEarly) {
        return;
      } else if (responseChunk.responseHashCode == 0) {
        emit(state.copyWith(
          status: FormzStatus.pure,
          addresses: [],
          hasMaxReached: false,
          nextPageCount: 1,
          responseHashCode: 0,
        ));
      } else {
        emit(state.copyWith(
          status: FormzStatus.valid,
          addresses: responseChunk.locationInfoList,
          hasMaxReached: false,
          nextPageCount: 2,
          responseHashCode: responseChunk.responseHashCode,
        ));
      }
    } on Exception catch (err) {
      exceptionHandle(err, "[_onTextSearchFirstRequested] Failed from request");
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    } on Error catch (err) {
      errorHandle(err, "[_onTextSearchFirstRequested] Failed from request");
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    }
  }

  void _onTextSearchAdditionalRequested(
    CandidateSearchAdditionalRequested event,
    Emitter<CandidateListBlockState> emit,
  ) async {
    if (state.hasMaxReached) {
      info("response is reached to max");
      return;
    }

    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    try {
      final responseChunk = await kakaoAddressHandler.getCandidates(event.text, state.nextPageCount);

      if (responseChunk.tooEarly) {
        return;
      } else if (responseChunk.responseHashCode == 0 || responseChunk.responseHashCode == state.responseHashCode) {
        emit(state.copyWith(
          status: FormzStatus.valid,
          hasMaxReached: true,
        ));
      } else {
        final updateAddresses = state.addresses + responseChunk.locationInfoList;
        emit(state.copyWith(
          status: FormzStatus.valid,
          addresses: updateAddresses,
          nextPageCount: state.nextPageCount + 1,
          responseHashCode: responseChunk.responseHashCode,
        ));
      }
    } catch (e) {
      final err = e as Error;
      errorHandle(err, "[_onTextSearchAdditionalRequested] Failed from request");
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    }
  }

  void _onTextSearchSelected(
    CandidateSearchSelected event,
    Emitter<CandidateListBlockState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));

    try {
      emit(state.copyWith(
        status: FormzStatus.valid,
      ));
    } on Error catch (e) {
      errorHandle(e, "[_onTextSearchSelected] Failed from request");
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
