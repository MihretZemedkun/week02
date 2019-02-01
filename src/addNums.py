# Add a list of numbers. NB: the addition operator dispatches on the type
# tags of numbers appearing as operands.
#
def addNums(ns):
  sum = 0
  for i in ns:
    sum = sum + i 
  return sum

ns = [1, 2.3, 3, 4.5]
