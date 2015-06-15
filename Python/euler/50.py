from prime_generator import get_primes

# Had to guess and check 3. I assumed 0 would produce the longest sum, since it
# would include the lowest valued prime numbers. I was wrong.
index = 3

primes = get_primes(1000000)

current_sum = 0
largest_sum = 0
added = None
count = 0
string = "0"

while current_sum < 1000000:
    current_sum += primes[index]
    string += " + {0}".format(current_sum)
    count += 1
    if current_sum in primes:
        largest_sum = current_sum
        largest_count = count
        added = True
    else:
        added = False
    index += 1

if added:
    largest_sum     -= primes[index - 1]
    largest_count   -= 1

print(largest_sum)
print(largest_count)
print(string)
