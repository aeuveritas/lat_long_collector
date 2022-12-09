part of 'bloc.dart';

abstract class CandidateListBlockEvent extends Equatable {
  const CandidateListBlockEvent();

  @override
  List<Object?> get props => [];
}

class CandidateSearchFirstRequested extends CandidateListBlockEvent {
  const CandidateSearchFirstRequested(this.text) : super();

  final String text;

  @override
  List<Object?> get props => [text];
}

class CandidateSearchAdditionalRequested extends CandidateListBlockEvent {
  const CandidateSearchAdditionalRequested(this.text) : super();

  final String text;

  @override
  List<Object?> get props => [text];
}

class CandidateSearchSelected extends CandidateListBlockEvent {
  const CandidateSearchSelected(this.selected, this.index);

  final LocationInfo selected;
  final int index;

  @override
  List<Object> get props => [selected, index];
}
