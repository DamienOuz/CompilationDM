  int PARAM = 5;
  bool bob = true;

  int fact(int n, bool b, bool c) {
    if (n < 2) {
	for(int i = 0; i < n; i++){
      		PARAM = PARAM + 2;
	}
    } else {
      return n * fact(n + 1, -1, true);
    }
  }

  void main() {
    putchar(fact(PARAM, PARAM, bob));
  }
