.data
menu: .ascii "\n Choose the number operation:\n 1 - Addition\n 2 - Substraction\n 3 - Multiplication"

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

# Numbers to use
li $t4,60
li $t5,9

# choosing operation number
beq $t0,$t1,soma
beq $t0,$t2, subt
beq $t0,$t3, multi

# Operacoes
soma:
add $a0,$t4,$t5  # add location, num1, num2
b print

subt:
sub $a0,$t4,$t5
b print

multi:
mul $a0,$t4,$t5
#  Nothing to skip, so we dont use "b print"

print: 
li $v0,1
syscall