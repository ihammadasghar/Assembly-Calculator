.data
res: .asciiz "result = "
menu: .asciiz "\n Choose the number operation:\n 1 - ADD,  2 - SUB,  3 - MUL,  4 - DIV\n  5 - EXP,  6 - ROOT,  7 - COS,  8 - SIN"
nextline: .asciiz "\n\nOperation number: "
addstr: .asciiz "ADD(a,b):\n"
substr: .asciiz "SUB(a,b):\n"
mulstr: .asciiz "MUL(a,b):\n"
divstr: .asciiz "DIV(a,b):\n"
expstr: .asciiz "EXP(base, power):\n"
rootstr: .asciiz "ROOT(base, power):\n"
cosstr: .asciiz "COS(X):\n"
sinstr: .asciiz "SIN(X):\n"


# Imprimir texto
.text
    #  Print message
    li $v0,4
    la $a0,menu

start:
    syscall 
    
    # Go to next line
    li $v0,4
    la $a0,nextline
    syscall

    # Get operation number
    li $v0,5
    syscall 
    move $t0,$v0


    # Calling operation
    beq $t0,1, sum
    beq $t0,2, subt
    beq $t0,3, multi
    beq $t0,4, divide
    beq $t0,5, exponent
    beq $t0,6, root
    beq $t0,7, cos
    beq $t0,8, sin

# Getting one input float from the user
oneinput:
    # save num A
    li $v0,6
    syscall 
    move $a1,$v0
    jr $ra

# Getting two inputs from the user
twoinputs:
    # save num A
    li $v0,5
    syscall 
    move $a1,$v0

    # save num B
    li $v0,5
    syscall 
    move $a2,$v0
    jr $ra

# Operations
sum:
    # print operation name
    la $a0,addstr
    jal printmessage
    
    jal twoinputs
    jal sumfunc
    b print

    sumfunc:
        add $v1,$a1,$a2  # add location, num1, num2
        jr $ra


subt:
    # print operation name
    la $a0,substr
    jal printmessage
    
    jal twoinputs
    jal subfunc
    b print

    subfunc:
        sub $v1,$a1,$a2
        jr $ra

divide:
    # print operation name
    la $a0,divstr
    jal printmessage
    
    jal twoinputs
    jal divfunc
    b print

    divfunc:
        div $v1,$a1,$a2
        jr $ra

multi:
    # print operation name
    la $a0,mulstr
    jal printmessage
    
    jal twoinputs
    jal multfunc
    b print

    multfunc:
        mul $v1,$a1,$a2
        jr $ra

exponent:
    # print operation name
    la $a0,expstr
    jal printmessage
    
    jal twoinputs
    jal expfunc
    b print

    expfunc:
        # a1 - base
        # a2 - power
        # t3 - loop index
        # t4 - result
        li $t3,0
        li $t4,1
        exploop:
            mul $t4,$t4,$a1 # multiply base by itself
            add $t3,$t3,1 # increment index by 1
            blt $t3,$a2,exploop # if index is less than the power, then repeat the loop
        move $v1,$t4 # move the result to print register
        jr $ra


root:
    # print operation name
    la $a0,rootstr
    jal printmessage
    
    jal twoinputs
    jal rootfunc

    rootfunc:
        # t1 - base
        # t2 - root power
        # t3 - index

        move $t1,$a1
        move $t2,$a2
        #base case
        li $t5,1
        beq $t1,0,endrootloop # if the base is zero

        rootloop:
            # get index to the power of "root power" in t6
            addi $a1,$t5,0
            addi $a2,$t2,0
            jal expfunc
            move $t6,$v1

            bgt $t6,$t1,endrootloop # if index is greater than the base, index-1 was the approximation
            add $t5,$t5,1 # increment index
            b rootloop

        endrootloop:
            move $v1,$t5
            sub $v1,$v1,1
            b print


cos:
    # print operation name
    la $a0,cosstr
    jal printmessage
   
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

sin:
    # print operation name
    la $a0,sinstr
    jal printmessage
    
    # Take input x
    li $v0,6
    syscall 

    # f0 - x
    # t6 - approximation level
    li $t6,10
    
    # HAVE TO CONVERT INT 1 TO FLOAT BECAUSE LI.S DOESNT WORK WITH MARS
    mov.s $f2,$f0 # final result variable

    li $t3,3 # loop index
    li $t0,1 # 1 - subtract series, 0 - add series
    sinloop:
        # HAVE TO CONVERT INT 1 TO FLOAT BECAUSE LI.S DOESNT WORK WITH MARS
        li $t4, 1
        mtc1 $t4, $f1
        cvt.s.w $f1, $f1
        
        li $t4, 0 # inner index
        sinloop2: # Multiply index by itself "root power" times
            mul.s $f1,$f1,$f0
            add $t4,$t4,1 # increment inner loop index
            blt $t4,$t3,sinloop2


        move $t4,$t3 # inner loop index
        li $t7,1 # result variable for factorial
        sinloop3: # get factorial of index
            mul $t7,$t7,$t4
            sub $t4,$t4,1 # decrement the inner index
            bgt $t4,1,sinloop3

        # Convert t7(factorial result) to float
        mtc1 $t7, $f8
        cvt.s.w $f8, $f8

        div.s $f4,$f1,$f8 # divide exponenet result by factorial result

        # if t8 is 1 subtract from result
        beq $t0,1,subtractFromRes2
        # else
            add.s $f2,$f2,$f4
            li $t0,1
            b continue2

        subtractFromRes2:
            sub.s $f2,$f2,$f4 # subtract from the cos final result
            li $t0,0 
            

        continue2:
        add $t3,$t3,2 # increment the index
        blt $t3,$t6,sinloop # check if the loop should end
    mov.s $f12,$f2
    
    b printfloat

printmessage:
    li $v0,4
    syscall
    jr $ra
    
printfloat:
    la $a0,res
    jal printmessage
    li $v0,2
    b start
    
print: 
    la $a0,res
    jal printmessage
    addi $a0,$v1,0
    li $v0,1
    b start