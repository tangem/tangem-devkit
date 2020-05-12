import 'u_of.dart';

//	< 0 	if [a] is smaller than [b],
//	= 0 	if [a] is equal to 		 [b],
//  > 0 	if [a] is greater than [b].
class Range<T> {
  final T start;
  final T stop;
  final Comparator<T> comparator;

  Range(this.start, this.stop, this.comparator);

  bool inRange(T value) {
    if (comparator(value, start) < 0 || comparator(value, stop) > 0) return false;

    return true;
  }

  static Comparator<int> get intComparator => (int a, int b) => a.compareTo(b);

  @override
  String toString() => "${stringOf(start)}-${stringOf(stop)}";
}
