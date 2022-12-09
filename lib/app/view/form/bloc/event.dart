part of 'bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardInitiated extends DashboardEvent {
  const DashboardInitiated() : super();
}

class DashboardStateUpdated extends DashboardEvent {
  const DashboardStateUpdated();
}
