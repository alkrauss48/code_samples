def calculate_fibonacci_sum_up_to(max_value):
    old     = 0
    current = 1
    sum     = 0
    while(current < max_value):
        old_current = current
        current     += old
        old         = old_current
        if(current % 2 == 0):
            sum += current
    return sum
