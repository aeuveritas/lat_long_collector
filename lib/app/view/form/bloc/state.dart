part of 'bloc.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.status = FormzStatus.pure,
  });

  final FormzStatus status;

  @override
  String toString() {
    return '{ status: $status }';
  }

  DashboardState copyWith({
    FormzStatus? status,
    bool? saved,
  }) {
    return DashboardState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
      ];
}
