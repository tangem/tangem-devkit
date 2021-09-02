extension OnInt on int {
  void foreach(void Function(int e) block) {
    if (this <= 0) return;
    for (var i = 0; i < this; i++) block(i);
  }
}
