.data
menu: .ascii "\n Choose the number operation:\n 1 - Addition\n 2 - Substraction\n 3 - Multiplication\n 4 - Divide\n Write in the following sequence:\n Operation\n Num A \n Num B \n"

# Imprimir texto
.text
li $v0,4
la $a0,menu
syscall 

# Accepting input from the user's keyboard
li $v0,5
syscall 
move $t0,$v0 #to contains the input of the user

# Operations
li $t1,1
li $t2,2
li $t3,3
li $t4,5 # for exponent

# Take numbers as input

# save num A
li $v0,5
syscall 
move $t5,$v0

# save num B
li $v0,5
syscall 
move $t6,$v0

beq $t0,$t4,exponent

# t5 - base
# t6 - exp

exponent:
    li $t7, 0 # index initial 0
    li $t8, 1 # result
    loop:
        mul $t8,$t8,$t5
        add $t7,$t7,1 # increment the index
        blt $t7,$t6,loop
    move $a0,$t8 # move to print register
    b print

print: 
li $v0,1
syscall

