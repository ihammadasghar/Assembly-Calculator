.data
empty: .space 16
res: .asciiz "result = "
menu: .asciiz "\n Choose the number operation:\n 1 - ADD,  2 - SUB,  3 - MUL,  4 - DIV\n 5 - EXP, 6 - LOG,  7 - ROOT,  8 - COS\n 9 - SIN, 10 - Dec to Bin,  11 - Dec to Hex 12 - Bin to Dec\n 13 - Bin to Hex, 14 - Hex to Dec,  15 - Hex to Bin"
nextline: .asciiz "\n\nOperation number: "
helpstr: .asciiz "help(operation number):\n"
helpErrorStr: .asciiz "No such operation number."
addstr: .asciiz "ADD(a,b):\n"
substr: .asciiz "SUB(a,b):\n"
mulstr: .asciiz "MUL(a,b):\n"
divstr: .asciiz "DIV(a,b):\n"
DecToBinStr: .asciiz "DecToBin(Decimal):\n"
DecToHexStr: .asciiz "DecToHex(Decimal):\n"
BinToDecStr: .asciiz "BinToDec(Binary):\n"
BinToHexStr: .asciiz "BinToHex(Binary):\n"
HexToDecStr: .asciiz "BinToDec(Hex):\n"
HexToBinStr: .asciiz "HexToBin(Hex):\n"
expstr: .asciiz "EXP(base, power):\n"
LogStr: .asciiz "LOG(base, X):\n"
LogErrorStr: .asciiz "Couldn't calculate log.\n"
rootstr: .asciiz "ROOT(X, root power):\n"
RootErrorStr: .asciiz "Couldn't calculate root."
cosstr: .asciiz "COS(X):\n"
sinstr: .asciiz "SIN(X):\n"

sumHelpFile: .asciiz "C:/help/sumHelpFile.txt"
subHelpFile: .asciiz "C:/help/subHelpFile.txt"
mulHelpFile: .asciiz "C:/help/mulHelpFile.txt"
divHelpFile: .asciiz "C:/help/divHelpFile.txt"
expHelpFile: .asciiz "C:/help/expHelpFile.txt"
cosHelpFile: .asciiz "C:/help/cosHelpFile.txt"
sinHelpFile: .asciiz "C:/help/sinHelpFile.txt"
logHelpFile: .asciiz "C:/help/logHelpFile.txt"
rootHelpFile: .asciiz "C:/help/rootHelpFile.txt"
DecToBinHelpFile: .asciiz "C:/help/DecToBinHelpFile.txt"
DecToHexHelpFile: .asciiz "C:/help/DecToHexHelpFile.txt"
BinToDecHelpFile: .asciiz "C:/help/BinToDecHelpFile.txt"
BinToHexHelpFile: .asciiz "C:/help/BinToHexHelpFile.txt"
HexToBinHelpFile: .asciiz "C:/help/HexToBinHelpFile.txt"
HexToDecHelpFile: .asciiz "C:/help/HexToDecHelpFile.txt"

fileWords: .space 1024


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
    beq $t0,0, help
    beq $t0,1, sum
    beq $t0,2, subt
    beq $t0,3, multi
    beq $t0,4, divide
    beq $t0,5, exponent
    beq $t0,6, log
    beq $t0,7, root
    beq $t0,8, cos
    beq $t0,9, sin
    beq $t0,10, decToBin
    beq $t0,11 decToHex
    beq $t0,12, binToDec
    beq $t0,13, binToHex

# Getting one input integer from the user
oneIntInput:
    # save num A
    li $v0,5
    syscall 
    move $a1,$v0
    jr $ra

# Getting one input float from the user
oneFloatInput:
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
    
help:
    	la $a0,helpstr
    	jal printmessage

	jal oneIntInput

    	beq $a1,1, helpForSum
    	beq $a1,2, helpForSub
    	beq $a1,3, helpForMul
    	beq $a1,4, helpForDiv
    	beq $a1,5, helpForExp
    	beq $a1,6, helpForLog
    	beq $a1,7, helpForRoot
    	beq $a1,8, helpForCos
    	beq $a1,9, helpForSin
    	beq $a1,10, helpForDecToBin
    	beq $a1,11, helpForDecToHex
    	beq $a1,12, helpForBinToDec
    	beq $a1,13, helpForBinToHex
    	
    	la $a0,helpErrorStr
    	li $v0,4
    	b start
	
	helpForSum:
		la $a0,sumHelpFile
		b printfile
	helpForSub:
		la $a0,subHelpFile
		b printfile
	helpForMul:
		la $a0,mulHelpFile
		b printfile
	helpForDiv:
		la $a0,divHelpFile
		b printfile
	helpForExp:
		la $a0,expHelpFile
		b printfile
	helpForLog:
		la $a0,logHelpFile
		b printfile
	helpForRoot:
		la $a0,rootHelpFile
		b printfile
	helpForCos:
		la $a0,cosHelpFile
		b printfile
	helpForSin:
		la $a0,sinHelpFile
		b printfile
	helpForDecToBin:
		la $a0,DecToBinHelpFile
		b printfile
	helpForDecToHex:
		la $a0,DecToHexHelpFile
		b printfile
	helpForBinToDec:
		la $a0,BinToDecHelpFile
		b printfile
	helpForBinToHex:
		la $a0,BinToHexHelpFile
		b printfile
	helpForHexToBin:
		la $a0,HexToBinHelpFile
		b printfile
 



printfile:
	li $v0,13           	# open_file syscall code = 13    	
	li $a1,0           	# file flag = read (0)
    	
    	
    	syscall
    	move $s0,$v0        	# save the file descriptor. $s0 = file
	
	#read the file
	li $v0, 14		# read_file syscall code = 14
	move $a0,$s0		# file descriptor
	la $a1,fileWords  	# The buffer that holds the string of the WHOLE file
	la $a2,1024		# hardcoded buffer length
	syscall
	
	# print whats in the file
	li $v0, 4		# read_string syscall code = 4
	la $a0,fileWords
	syscall
	
	#Close the file
    	li $v0, 16         		# close_file syscall code
    	move $a0,$s0      		# file descriptor to close
	b start
	
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

decToBin:
    # print operation name
    la $a0,DecToBinStr
    jal printmessage

    jal oneIntInput

    #  Print result message
    la $a0,res
    jal printmessage

    # save result and print
    li $v0, 35
    move $a0,$a1

    b start

decToHex:
    # print operation name
    la $a0,DecToHexStr
    jal printmessage

    jal oneIntInput

    #  Print result message
    la $a0,res
    jal printmessage

    # save result and print
    li $v0, 34
    move $a0,$a1

    b start


binToDec:
    # print operation name
    la $a0,BinToDecStr
    jal printmessage

    jal oneIntInput
    move $t5, $a1
    
    jal binToDecFunc
    b print
	
	binToDecFunc:
	li $t2,1 	# expo
	li $t3,10	# for mod 10 
	li $t9,0	# result
	bindecloop:
		div $t5,$t3     	#  digit = binary mod 10
		mfhi $t7  		# temporary hold result of mod
		div $t5,$t5,10		# binary = binary/10
		
		mul $t1,$t7,$t2		# digit * expo
		add $t9,$t9,$t1		# result += digit*expo
		mul $t2,$t2,2		# expo = expo*2
		
		bgt $t5,0,bindecloop		# binary > 0
		
	move $v1,$t9
	jr $ra
	
	


binToHex:
    # Print function string
    la $a0,BinToHexStr
    jal printmessage

    # Convert to binary to decimal first
    jal binToDecFunc

    #  Print result message
    la $a0,res
    jal printmessage

    # Use the mips print decimal as hex function
    li $v0, 34
    move $a0,$v1

    b start



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

log:
    # print operation name
    la $a0,LogStr
    jal printmessage

    jal twoinputs
    move $t1, $a1  # base
    move $t2, $a2  # x

    beq $t2,1,logbasecase
    
    li $t3,0 # index
    li $t4,1 # exponent
    logloop:
        mul $t4,$t4,$t1
        add $t3,$t3,1  #increment
        blt $t4,$t2,logloop

    beq $t4,$t2,logresult  #if x == exponent
    
    # print error message
    la $a0,LogErrorStr
    li $v0,4
    b start
	
    logbasecase:
    li $v1,0
    jal print
    
    logresult:
    move $v1, $t3
    jal print


  
root:
    # print operation name
    la $a0,rootstr
    jal printmessage
    
    jal twoinputs
    jal rootfunc

    rootfunc:
        move $t1,$a1  #x
        move $t2,$a2  #root power
        #base case
        beq $t2,0,rootbasecase # if the root power is zero

        li $t5,0 #index
        rootloop:
            add $t5,$t5,1 # increment index
            # get index to the power of "root power" in t6
            addi $a1,$t5,0
            addi $a2,$t2,0
            jal expfunc
            move $t6,$v1
            blt $t6,$t1,rootloop

        endrootloop:
            beq $t6,$t1,rootresult
            
            # print error message
    	    la $a0,RootErrorStr
            li $v0,4
            b start
	
            rootbasecase:
            li $v1,0
            jal print
            
            rootresult:
            move $v1,$t5
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
