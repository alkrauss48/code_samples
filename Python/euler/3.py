# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?

from prime_generator import get_primes

class LargestPrime:
    number = 600851475143

    def __init__(self, count):
        self.primes         = get_primes(count)
        self.factors        = []
        self.index          = 0
        self.final_prime    = True
        self.number         = LargestPrime.number

    def build_factors(self):
        while (self.number not in self.primes):
            if (len(self.primes) == self.index + 1):
                self.final_prime = False
                break

            if(self.number % self.__current_prime() == 0):
                self.factors.append(self.__current_prime())
                self.number /= self.__current_prime()
            else:
                self.index += 1

    def max_factor(self):
        if self.final_prime:
            return self.number
        else:
            return max(self.factors)

    def __current_prime(self):
        return self.primes[self.index]

l = LargestPrime(10000)
l.build_factors()
print(l.max_factor())
print("Absolute Max Factor? {0}".format(l.final_prime))
