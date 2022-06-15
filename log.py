def ln(x):
    sum = 0
    for i in range(1, 150, 2):
        nume = x - 1
        deno = x + 1
        res = ((nume/deno)**i)/i
        sum +=res
    
    result = 2*sum
    return result


def log(base, x):
    result = ln(x)/ln(base)
    return result


print(log(10, 100))