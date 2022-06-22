def ln(x):
    sum = 0
    for i in range(1, 1000, 2):
        nume = x - 1
        deno = x + 1
        res = ((nume/deno)**i)/i
        sum +=res
    
    result = 2*sum
    return result


def log(base, x):
    result = ln(x)/ln(base)
    return result


# Function to return a^n
def powerOptimised(a, n):
     
    # Stores final answer
    ans = 1
     
    while (n > 0):
        last_bit = (n & 1)
         
        # Check if current LSB
        # is set
        if (last_bit):
            ans = ans * a
        a = a * a
         
        # Right shift
        n = n >> 1
         
    return ans
 
# Driver code
if __name__ == '__main__':
     
    a = 2
    n = 5
     
    print(powerOptimised(a,n))