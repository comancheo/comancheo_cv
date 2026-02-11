import 'package:comancheo_cv/models/weather_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState);

  void update(T value) => emit(value);
}

class BoolCubit extends Cubit<bool> {
  final bool initialState;
  BoolCubit(this.initialState) : super(initialState);
  void toggle() => emit(!state);
  void set(bool value) => emit(value);
}

class IntCubit extends Cubit<int> {
  final int initialState;
  IntCubit(this.initialState) : super(initialState);
  void set(int value) => emit(value);
}

class StringCubit extends Cubit<String> {
  final String initialState;
  StringCubit(this.initialState) : super(initialState);
  void set(String value) => emit(value);
}

class DoubleCubit extends Cubit<double> {
  final double initialState;
  DoubleCubit(this.initialState) : super(initialState);
  void set(double value) => emit(value);
}

class ListCubit<T> extends Cubit<List<T>> {
  final List<T> initialState;
  ListCubit(this.initialState) : super(initialState);
  void add(T value) => emit([...state, value]);
  void addAll(List<T> values) => emit([...state, ...values]);
  void addIf(T value, bool Function(T) condition) {
    if (condition(value)) {
      emit([...state, value]);
    }
  }

  void remove(T value) => emit(state.where((element) => element != value).toList());
  void removeAt(int index) => emit([...state]..removeAt(index));
  void clear() => emit([]);
}

class MapCubit<K, V> extends Cubit<Map<K, V>> {
  final Map<K, V> initialState;
  MapCubit(this.initialState) : super(initialState);
  void add(K key, V value) => emit({...state, key: value});
  void remove(K key) => emit({...state}..remove(key));
  void clear() => emit({});
}

class SetCubit<T> extends Cubit<Set<T>> {
  final Set<T> initialState;
  SetCubit(this.initialState) : super(initialState);
  void add(T value) => emit({...state}..add(value));
  void remove(T value) => emit({...state}..remove(value));
  void clear() => emit({});
}

class NullBoolCubit extends Cubit<bool?> {
  NullBoolCubit() : super(null);
  void toggle() => emit((state != null) ? !state! : null);
  void set(bool? value) => emit(value);
}

class NullForecastModelCubit extends Cubit<ForecastModel?> {
  NullForecastModelCubit() : super(null);
  void set(ForecastModel? value) => emit(value);
}

class NullIntCubit extends Cubit<int?> {
  NullIntCubit() : super(null);
  void set(int? value) => emit(value);
}

class NullStringCubit extends Cubit<String?> {
  NullStringCubit() : super(null);
  void set(String? value) => emit(value);
}

class NullDoubleCubit extends Cubit<double?> {
  NullDoubleCubit() : super(null);
  void set(double? value) => emit(value);
}

class NullListCubit<T> extends Cubit<List<T>?> {
  List<T>? initialState;
  NullListCubit(this.initialState) : super(initialState);
  void set(List<T>? value) => emit(value);
  void add(T value) => emit([...state!, value]);
  void remove(T value) => emit(state!.where((element) => element != value).toList());
  void clear() => emit([]);
}

class NullMapCubit<K, V> extends Cubit<Map<K, V>?> {
  NullMapCubit() : super(null);
  void add(K key, V value) => emit({...state!, key: value});
  void remove(K key) => emit({...state!}..remove(key));
  void clear() => emit({});
}

class NullSetCubit<T> extends Cubit<Set<T>?> {
  NullSetCubit() : super(null);
  void add(T value) => emit({...state!}..add(value));
  void remove(T value) => emit({...state!}..remove(value));
  void clear() => emit({});
}
