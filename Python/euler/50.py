# The prime 41, can be written as the sum of six consecutive primes:
#
# 41 = 2 + 3 + 5 + 7 + 11 + 13
# This is the longest sum of consecutive primes that adds to a prime below one-hundred.
#
# The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.
#
# Which prime, below one-million, can be written as the sum of the most consecutive primes?

from prime_generator import get_primes

class LongestSum:
    primes      = get_primes(1000000)
    max_value   = 1000000

    def __init__(self, index):
        self.index          = index
        self.current_sum    = 0
        self.largest_sum    = 0
        self.count          = 0
        self.largest_counts = []

    def determine_sum(self):
        added = None
        while self.current_sum < 1000000:
            self.current_sum += LongestSum.primes[self.index]
            self.count += 1
            if self.current_sum in LongestSum.primes:
                self.largest_sum = self.current_sum
                self.largest_counts.append(self.count)
                added = True
            else:
                added = False
            self.index += 1

        # Because python doesn't support a do-while loop, this loop will run 1
        # loop over the maximum value. If during that last loop, the resulting
        # current_sum is in fact a prime number, we need to remove it because
        # it's an invalid answer.
        if added: _remove_last_entries(self)

    def largest_count(self):
        return max(self.largest_counts)

    # Trying to signify a private method
    def _remove_last_entries(self):
        self.largest_sum -= LongestSum.primes[self.index - 1]
        self.largest_count.pop()


# index is the starting index in the array of all primes number that you want to
# add up
# Had to guess and check 3. I assumed 0 would produce the longest sum, since it
# would include the lowest valued prime numbers. I was wrong.
index = 3
l = LongestSum(index)
l.determine_sum()

print(l.largest_sum)
print(l.largest_count())
