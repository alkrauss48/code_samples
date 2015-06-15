# The sum of the squares of the first ten natural numbers is,
#
# 12 + 22 + ... + 102 = 385
# The square of the sum of the first ten natural numbers is,
#
# (1 + 2 + ... + 10)2 = 552 = 3025
# Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
#
# Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

# List comprehensions for the win!
squares = [x**2 for x in range(1, 101)]
sum_of_squares = sum(squares)

squared_sum = sum(range(1, 101)) ** 2

print(squared_sum - sum_of_squares)
