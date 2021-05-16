import 'dart:async';

import 'package:rxdart/rxdart.dart';

abstract class Typed<T> {
  T getType();
}

abstract class SubTyped<T> {
  T getSubType();
}

abstract class AtoB<A, B> {
  B invoke(A incoming);
}

abstract class IBuilder<A, B> {
  B build(A from);
}

abstract class ModelBuilder<F, T> implements IBuilder<F, T> {
  bool canBuild(F from);
}

abstract class TypedHolder<T, K> {
  register(T type, K clazz);

  K? get(T type);
}

class BaseHolder<T, K> implements TypedHolder<T, K> {
  Map<T, K> holderData = {};

  @override
  register(T type, K value) {
    holderData[type] = value;
  }

  @override
  K? get(T type) => holderData[type];
}

class Pair<A, B> {
  final A a;
  final B b;

  Pair(this.a, this.b);
}

class Triple<A, B, C> {
  final A a;
  final B b;
  final C c;

  Triple(this.a, this.b, this.c);
}

abstract class Disposable {
  dispose();
}

class StatedBehaviorSubject<T> extends Disposable {
  final BehaviorSubject<T> _subject;
  late StreamSubscription _subscription;
  T? _state;

  StatedBehaviorSubject([T? initialState])
      : this._subject = initialState == null ? BehaviorSubject<T>() : BehaviorSubject<T>.seeded(initialState),
        this._state = initialState {
    _subscription = _subject.stream.listen((event) => _state = event);
  }

  Stream<T> get stream => _subject.stream;

  Sink<T> get sink => _subject.sink;

  T? get state => _state;

  @override
  dispose() {
    _subscription.cancel();
  }
}
