# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
#
# Find the largest palindrome made from the product of two 3-digit numbers.

products = []

for x in range(100, 1000):
    for y in range(100, 1000):
        product = x * y
        if str(product) == str(product)[::-1]: # List Slicing
            products.append(product)

print(max(products))
