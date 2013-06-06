# Fib.bf
$ Prints the first 13 fibonacci numbers

+++++++++++++               # number of repetitions
>++++++++++                 # put newline character in cell 1
>>+                         # initialize fibonacci series
<<<                         # move back to cell 1
[ >                         # infinite loop
  >>[>+>+<<-]>>[<<+>>-]<<   # copy cell 3 to cell 4
  <[>+<-]                   # add contents of cell 2 to cell 3
  >>[<<+>>-]                # move contents of cell 4 to cell 2
  <<:                       # print contents of cell 2
  <.                        # print a newline
  <-                        # decrement counter
]