  int PARAM = 5;
  bool bob = true;

  int fact(int n, bool b, bool c) {
    if (n < 2) {
	return 1;
    } else {
      return n * fact(n + 1, -1, true);
    }
  }

  void main() {
    putchar(fact(PARAM, PARAM, bob));
  }
