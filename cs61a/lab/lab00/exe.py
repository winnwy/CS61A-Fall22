def fib(n):
    """Compute the nth Fibonacci number, for n >= 2"""
    pred, curr = 0, 1
    k = 2
    while k < n:
        pred, curr = curr, pred + curr
        k = k + 1
    return curr

def fib_test():
    print("a")
    assert fib(2) == 10, 'The 2nd Fibonacci number should be 1'

fib_test()