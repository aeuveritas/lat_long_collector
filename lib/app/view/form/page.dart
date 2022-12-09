import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_address_handler/kakao_address_handler.dart';

import '../../models/form_component.dart';
import 'bloc/bloc.dart';
import 'dynamic.dart';

class DashboardSearchPage extends StatelessWidget {
  const DashboardSearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(
        kakaoAddressHandler: context.read<KakaoAddressHandler>(),
        updateStreamController: StreamController<FormComponent>(),
      ),
      child: DashboardDynamic(TextEditingController()),
    );
  }
}
