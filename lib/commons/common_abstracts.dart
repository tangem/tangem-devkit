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

  K get(T type);
}

class BaseHolder<T, K> implements TypedHolder<T, K> {
  Map<T, K> holderData = {};

  @override
  register(T type, K value) {
    holderData[type] = value;
  }

  @override
  K get(T type) => holderData[type];
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
