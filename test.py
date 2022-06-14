from cmath import sin


# sin with taylor series


x = 1.57

def factorial(n):
    res = 1
    for i in range(n):
        res *= n
        n = n - 1
    return res

def sin(x):
    res = x
    sub = True
    for i in range(3,100,2):
        numenator = x**i
        denominator = factorial(i)
        div = numenator/denominator

        if sub:
            res -= div
            sub = False
        else:
            res += div
            sub = True
    return res

print("The answer is ", sin(x))