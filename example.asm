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
li $t4,4

# Take numbers as input

# save num A
li $v0,5
syscall 
move $t5,$v0

# save num B
li $v0,5
syscall 
move $t6,$v0


# choosing operation number
beq $t0,$t1,soma
beq $t0,$t2, subt
beq $t0,$t3, multi
beq $t0,$t4, divide

# Operacoes
soma:
add $a0,$t5,$t6  # add location, num1, num2
b print

subt:
sub $a0,$t5,$t6
b print

divide:
div $a0,$t5,$t6
b print

multi:
mul $a0,$t5,$t6
#  Nothing to skip, so we dont use "b print"

print: 
li $v0,1
syscall