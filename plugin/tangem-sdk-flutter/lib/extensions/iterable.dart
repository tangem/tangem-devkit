extension OnIterableNullSafe<E> on Iterable<E> {
  E? firstWhereOrNull(bool test(E e)) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  E? firstOrNull() {
    return this.isEmpty ? null : this.first;
  }
}

extension OnIterable<E> on Iterable<E?>? {
  bool isNullOrEmpty() {
    if (this == null)
      return true;
    else
      return this!.isEmpty;
  }
}
