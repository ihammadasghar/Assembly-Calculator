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


# choosing operation number
beq $t0,1,soma
beq $t0,2, subt
beq $t0,3, multi
beq $t0,4, divide
beq $t0,5, exponent
beq $t0,6, root
beq $t0,7, cos


# Operacoes
soma:
    # Take numbers as input
    # save num A
    li $v0,5
    syscall 
    move $t1,$v0

    # save num B
    li $v0,5
    syscall 
    move $t2,$v0

    add $a0,$t1,$t2  # add location, num1, num2
    b print

subt:
    # Take numbers as input
    # save num A
    li $v0,5
    syscall 
    move $t1,$v0

    # save num B
    li $v0,5
    syscall 
    move $t2,$v0

    sub $a0,$t1,$t2
    b print

divide:
    # Take numbers as input
    # save num A
    li $v0,5
    syscall 
    move $t1,$v0

    # save num B
    li $v0,5
    syscall 
    move $t2,$v0

    div $a0,$t1,$t2
    b print

multi:
    # Take numbers as input
    # save num A
    li $v0,5
    syscall 
    move $t1,$v0

    # save num B
    li $v0,5
    syscall 
    move $t2,$v0

    mul $a0,$t1,$t2
    b print

exponent:
    # Take numbers as input
    # save num A
    li $v0,5
    syscall 
    move $t1,$v0

    # save num B
    li $v0,5
    syscall 
    move $t2,$v0

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

root:
    # Take numbers as input
    # save num A
    li $v0,5
    syscall 
    move $t1,$v0

    # save num B
    li $v0,5
    syscall 
    move $t2,$v0

    # t1 - base
    # t2 - root power
    # t3 - index

    #base case
    li $a0,0
    beq $t1,0,print # if the base is zero

    li $t3,1
    rootloop:
        li $t4,0 # inner loop index
        li $t5,1 # temp variable
        rootloop2: # Multiply index by itself "root power" times
            mul $t5,$t5,$t3
            add $t4,$t4,1 # increment inner loop index
            blt $t4,$t2,rootloop2
        
        move $a0,$t3
        sub $a0,$a0,1
        bgt $t5,$t1,print # if index is greater than the base, index-1 was the approximation
        add $t3,$t3,1 # increment index
        b rootloop

cos:
    # Take input x
    li $v0,6
    syscall 

    # t1 - x
    # t6 - approximation level
    li $t6,10
    
    # HAVE TO CONVERT INT 1 TO FLOAT BECAUSE LI.S DOESNT WORK WITH MARS
    li $t4, 1
    mtc1 $t4, $f2
    cvt.s.w $f2, $f2 # final result variable

    li $t3,2 # loop index
    li $t0,1 # 1 - subtract series, 0 - add series
    cosloop:
        # HAVE TO CONVERT INT 1 TO FLOAT BECAUSE LI.S DOESNT WORK WITH MARS
        li $t4, 1
        mtc1 $t4, $f1
        cvt.s.w $f1, $f1
        
        li $t4, 0 # inner index
        cosloop2: # Multiply index by itself "root power" times
            mul.s $f1,$f1,$f0
            add $t4,$t4,1 # increment inner loop index
            blt $t4,$t3,cosloop2


        move $t4,$t3 # inner loop index
        li $t7,1 # result variable for factorial
        cosloop3: # get factorial of index
            mul $t7,$t7,$t4
            sub $t4,$t4,1 # decrement the inner index
            bgt $t4,1,cosloop3

        # Convert t7(factorial result) to float
        mtc1 $t7, $f8
        cvt.s.w $f8, $f8

        div.s $f4,$f1,$f8 # divide exponenet result by factorial result

        # if t8 is 1 subtract from result
        beq $t0,1,subtractFromRes
        # else
            add.s $f2,$f2,$f4
            li $t0,1
            b continue

        subtractFromRes:
            sub.s $f2,$f2,$f4 # subtract from the cos final result
            li $t0,0 

        continue:
        add $t3,$t3,2 # increment the index
        blt $t3,$t6,cosloop # check if the loop should end
    mov.s $f12,$f2
    b printfloat


print: 
li $v0,1
syscall


printfloat:
li $v0,2
syscall
