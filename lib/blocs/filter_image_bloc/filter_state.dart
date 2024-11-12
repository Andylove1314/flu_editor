part of 'filter_bloc.dart';

abstract class FilterSourceImageState extends Equatable {
  final FilterDetail filterDetail;

  const FilterSourceImageState(this.filterDetail);

  @override
  List<Object?> get props => [filterDetail];
}

class FilterSourceImageInitial extends FilterSourceImageState {
  const FilterSourceImageInitial(super.filterDetail);

  @override
  List<Object?> get props => [...super.props];
}

class FilterSourceImageReady extends FilterSourceImageState {
  DataItem? filterData;

   FilterSourceImageReady(
    super.filterDetail,
    this.filterData,
  );

  @override
  List<Object?> get props => [...super.props, filterData];
}
