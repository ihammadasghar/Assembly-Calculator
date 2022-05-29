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


# Take numbers as input
# save num A
li $v0,5
syscall 
move $t1,$v0

# save num B
li $v0,5
syscall 
move $t2,$v0


# choosing operation number
beq $t0,1,soma
beq $t0,2, subt
beq $t0,3, multi
beq $t0,4, divide
beq $t0,5, exponent


# Operacoes
soma:
add $a0,$t1,$t2  # add location, num1, num2
b print

subt:
sub $a0,$t1,$t2
b print

divide:
div $a0,$t1,$t2
b print

multi:
mul $a0,$t1,$t2
b print

exponent:
    # t1 - base
    # t2 - power
    # t3 - loop index
    # t4 - result
    li $t3,0
    li $t4, 1
    exploop:
        mul $t4,$t4,$t1 # multiply base by itself
        add $t3,$t3,1 # increment index by 1
        blt $t3,$t2,exploop # if index is less than the power, then repeat the loop
    move $a0, $t4 # move the result to print register
    b print

print: 
li $v0,1
syscall