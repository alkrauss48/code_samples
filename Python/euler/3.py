# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?

from prime_generator import get_primes

primes = get_primes(10000)
number = 600851475143
factors = []
index = 0
final_prime = True

print(number % primes[index])

while (number not in primes):
    if (len(primes) == index + 1):
        final_prime = False
        break

    if(number % primes[index] == 0):
        factors.append(primes[index])
        number /= primes[index]
    else:
        index += 1

print(number)
print(factors)
print(final_prime)
