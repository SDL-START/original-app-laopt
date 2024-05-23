// ignore_for_file: constant_identifier_names

enum MapStatus{
  INITAL,
  LOADING,
  LOADED,
  FAILURE
}

class MapState {
	final MapStatus status;
	final String? error;
	  
	const MapState({
		this.status = MapStatus.INITAL,
		this.error,
	});
	  
	MapState copyWith({
		MapStatus? status,
		String? error,
	}) {
		return MapState(
			status: status ?? this.status,
			error: error ?? this.error,
		);
	}
}
