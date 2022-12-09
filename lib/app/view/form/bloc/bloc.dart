import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:draccoon_logger/draccoon_logger.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kakao_address_handler/kakao_address_handler.dart';
import 'package:lat_long_collector/app/view/form/bloc/sub_bloc_manager.dart';

import '../../../consts/static.dart';
import '../../../models/form_component.dart';
import '../../block/barrel.dart';

part 'event.dart';
part 'state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> with MixInLogger {
  DashboardBloc({
    required this.updateStreamController,
    required this.kakaoAddressHandler,
  })  : blocManager = SubBlocManager(
          updateStreamController: updateStreamController,
          blocs: {
            "text": TextBoxBlockBloc(
                updateStreamController, FormComponent.dashboardTextBox, MIN_TEXT_LENGTH, MAX_TEXT_LENGTH, true),
            "candidate_list": CandidateListBlockBloc(
              updateStreamController: updateStreamController,
              component: FormComponent.dashboardCandidateList,
              kakaoAddressHandler: kakaoAddressHandler,
            ),
            "location_light": LocationLightBlockBloc(),
            "destination_list": DestinationListBlockBloc(
              updateStreamController: updateStreamController,
              component: FormComponent.dashboardDestinationList,
            ),
          },
        ),
        super(const DashboardState()) {
    on<DashboardInitiated>(_onDashboardInitiated);
    on<DashboardStateUpdated>(_onTextSearchStateUpdated);

    add(const DashboardInitiated());

    _updateStreamSubscription = updateStream.listen((FormComponent component) {
      if (component == FormComponent.dashboardTextBox) {
        return;
      }
      info("[listen] state update notified: $component");
      add(const DashboardStateUpdated());
    });
  }

  final SubBlocManager blocManager;

  final KakaoAddressHandler kakaoAddressHandler;

  final StreamController<FormComponent> updateStreamController;
  Stream<FormComponent> get updateStream async* {
    yield FormComponent.dashboardInit;
    yield* updateStreamController.stream;
  }

  late StreamSubscription<FormComponent> _updateStreamSubscription;

  @override
  Future<void> close() {
    blocManager.close();
    _updateStreamSubscription.cancel();
    updateStreamController.close();
    return super.close();
  }

  void _onDashboardInitiated(
    DashboardInitiated event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(
      status: FormzStatus.submissionSuccess,
    ));
  }

  void _onTextSearchStateUpdated(
    DashboardStateUpdated event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    await Future.delayed(const Duration(milliseconds: 100));

    emit(state.copyWith(status: FormzStatus.submissionSuccess));
  }
}
