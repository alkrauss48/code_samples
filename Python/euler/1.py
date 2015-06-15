# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

class Multiple:
    max_value = 1000

    def __init__(self, factor):
        self.factor     = factor
        self.multiples  = []

    def calculate_multiples(self):
        start = self.factor
        while(start < Multiple.max_value):
            self.multiples.append(start)
            start += self.factor
        return self.multiples

three_multiple  = Multiple(3)
five_multiple   = Multiple(5)

three_multiple.calculate_multiples()
five_multiple.calculate_multiples()

print(sum(set(three_multiple.multiples + five_multiple.multiples)))
