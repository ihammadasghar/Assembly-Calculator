#######################################################################################################################
# PROJETO DE ARQUITETURA DE COMPUTADORES 2021/2022 - UAL
# TEMA: Calculadora Científica 
# GRUPO:
# 30008767 - Syed Hammad Ur Rehman Asghar
# 30009658 - Duarte Miguel dos Santos Rodrigues
# Ahmet add your name here
# Jorge add your name here
#
# NOTE: The "Help" folder should be in path "c:\" for the help function to work. 
#######################################################################################################################

.data
empty: .space 16
menu: .asciiz "\n ------- Welcome! ------- \n Operations table:\n 0 - Help,  16 - Exit\n 1 - ADD,  2 - SUB,  3 - MUL\n 4 - DIV,  5 - POW,  6 - LOG\n 7 - ROOT,  8 - COS,  9 - SIN\n 10 - DecToBin,  11 - DecToHex\n 12 - BinToDec,  13 - BinToHex\n 14 - HexToDec,  15 - HexToBin"
oneFloatConstant: .float 1.000000

#  Operation prompts and errors
nextline: .asciiz "\n\nChoose Operation: "
input1Str: .asciiz "\nArg 1: "
input2Str: .asciiz "Arg 2: "
res: .asciiz " Ans = "
new_line: .asciiz "\n"
helpstr: .asciiz "-> Help(operation number): "
helpErrorStr: .asciiz "Error: No such operation number."
addstr: .asciiz "-> ADD(a,b): "
substr: .asciiz "-> SUB(a,b): "
mulstr: .asciiz "-> MUL(a,b): "
divstr: .asciiz "-> DIV(a,b): "
DecToBinStr: .asciiz "-> DecToBin(Decimal): "
DecToHexStr: .asciiz "-> DecToHex(Decimal): "
BinToDecStr: .asciiz "-> BinToDec(Binary): "
BinToHexStr: .asciiz "-> BinToHex(Binary): "
HexToDecStr: .asciiz "-> HexToDec(Hex): "
HexToBinStr: .asciiz "-> HexToBin(Hex): "
HexToDecErrorStr: .asciiz "Error: You have entered in an incorrect form, make sure everything is inbetween 0 to 9 and a to f (small letters).\n"
expstr: .asciiz "-> Power(base, power): "
LogStr: .asciiz "-> LOG(base, X): "
LogErrorStr: .asciiz "Error: Couldn't calculate log. "
rootstr: .asciiz "-> ROOT(X, root power): "
RootErrorStr: .asciiz "Error: Couldn't calculate root."
cosstr: .asciiz "-> COS(X): "
sinstr: .asciiz "-> SIN(X): "

#  Help file addresses
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

hexa: .space 1024
fileWords: .space 1024


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
    beq $t0,14, hexToDec
    beq $t0,15, hexToBin
    beq $t0,16, exit


# Getting one input string from the user
strInput:
    li $v0,8
    syscall 
    jr $ra


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
    la $a0, input1Str
    li $v0,4
    syscall
    
    # save num A
    li $v0,5
    syscall 
    move $a1,$v0

    la $a0, input2Str
    li $v0,4
    syscall
    
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
    beq $a1,14, helpForHexToDec
    beq $a1,15, helpForHexToBin
    
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

    helpForHexToDec:
		la $a0,HexToDecHelpFile
		b printfile

	helpForHexToBin:
		la $a0,HexToBinHelpFile
		b printfile
 

printfile:
	li $v0,13  # open_file syscall code = 13    	
	li $a1,0  # file flag = read (0)
    	
    syscall
    move $s0,$v0  # save the file descriptor. $s0 = file
	
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
    b printfloat
    
    divfunc:
        mtc1 $a1, $f1
    	cvt.s.w $f1, $f1 
    	mtc1 $a2, $f2
    	cvt.s.w $f2, $f2 
        div.s $f12,$f1,$f2
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
    
    # Ask for input
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
    
    
    # Ask for input
    jal oneIntInput
    move $t5, $a1
    
    # Convert to binary to decimal first
    jal binToDecFunc

    #  Print result message
    la $a0,res
    jal printmessage

    # Use the mips print decimal as hex function
    li $v0, 34
    move $a0,$v1

    b start


hexToDec:
    # Print function string
    la $a0,HexToDecStr
    jal printmessage

	la $a0, hexa
	li $a1, 1024
	li $v0, 8
	syscall

    jal hexToDecFunc

    #  Print result message
    la $a0,res
    jal printmessage

    move $a0, $v1
    li 	$v0, 1
    b start

    hexToDecFunc:
        la $t8, hexa
        la $t0, hexa
        lb $t1, ($t0)
        li $t6, 1
        li $t7, 0
        b find_end
        find_end:
            beq $t1, 10, end_found
            addu $t0, $t0, 1
            lb $t1, ($t0)
            b find_end
        end_found:		
            subu $t0, $t0, 1
            lb $t1, ($t0)
            sge $t2, $t1, '0'
            sle $t3, $t1, '9'
            sge $t4, $t1, 'a'
            sle $t5, $t1, 'f'
            beq $t2, 1, zero_to_nine_check
            b hexToDecError
        loop:
            beq 	$t0, $t8, exitHexToDec	
            subu 	$t0, $t0, 1
            lb 		$t1, ($t0)
            mul 	$t6, $t6, 16
            sge 	$t2, $t1, '0'
            sle 	$t3, $t1, '9'
            sge 	$t4, $t1, 'a'
            sle 	$t5, $t1, 'f'
            beq 	$t2, 1, zero_to_nine_check
            b 		hexToDecError	
        zero_to_nine_check:
            beq 	$t3, 1, is_between_zero_to_nine	
            beq 	$t5, 1, a_to_f_check
            b 		hexToDecError	
        is_between_zero_to_nine:
            sub 	$t1, $t1, '0'
            mul 	$t1, $t1, $t6
            add 	$t7, $t7, $t1
            b 		loop
        a_to_f_check:
            beq 	$t4, 1, is_a_to_f
            b 		hexToDecError
        is_a_to_f:
            beq 	$t1, 'a', is_a
            beq 	$t1, 'b', is_b
            beq 	$t1, 'c', is_c
            beq 	$t1, 'd', is_d
            beq 	$t1, 'e', is_e
            beq 	$t1, 'f', is_f
            b 		hexToDecError
        is_a:
            li 		$t1, 10
            mul 	$t1, $t1, $t6
            add 	$t7, $t7, $t1
            b 		loop
        is_b:
            li 		$t1, 11
            mul 	$t1, $t1, $t6
            add 	$t7, $t7, $t1
            b 		loop
        is_c:
            li 		$t1, 12
            mul 	$t1, $t1, $t6
            add 	$t7, $t7, $t1
            b 		loop
        is_d:
            li 		$t1, 13
            mul 	$t1, $t1, $t6
            add 	$t7, $t7, $t1
            b 		loop
        is_e:
            li 		$t1, 14
            mul 	$t1, $t1, $t6
            add 	$t7, $t7, $t1
            b 		loop
        is_f:
            li 		$t1, 15
            mul 	$t1, $t1, $t6
            add 	$t7, $t7, $t1
            b 		loop					
        hexToDecError:
            la 		$a0, HexToDecErrorStr
            li 		$v0, 4
            b start

        exitHexToDec:
            move $v1,$t7
            jr $ra


hexToBin:
    # Print function string
    la $a0,HexToBinStr
    jal printmessage

    la $a0, hexa
	li $a1, 1024
	li $v0, 8
	syscall

    # Convert to Decimal first
    jal hexToDecFunc

    #  Print result message
    la $a0,res
    jal printmessage

    # Use the mips print decimal as binary function
    move $a0,$v1
    li $v0, 35
    
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

    # f0 - x
    l.s $f1,oneFloatConstant # x1
    mov.s $f12,$f1 # cosx

    li $t1,1 #index
    cosloop:
        # HAVE TO CONVERT INT 1 TO FLOAT BECAUSE LI.S DOESNT WORK WITH MARS
        mtc1 $t1, $f4
        cvt.s.w $f4, $f4 # final result variable
            
        l.s $f2,oneFloatConstant # 1
        add.s $f5,$f2,$f2 # 2
        mul.s $f3,$f5,$f4 # (2 x i)
        sub.s $f3,$f3,$f2 # (2 x i) - 1
        mul.s $f3,$f3,$f4 # i * ((2 x i) - 1)
        mul.s $f3,$f3,$f5 # 2 * i * ((2 x i) - 1) denominator

        mul.s $f1,$f1,$f0 # x1*n
        mul.s $f1,$f1,$f0 # x1*n*n
        div.s $f1,$f1,$f3 # x1*n*n/denominator
        neg.s $f1,$f1 # -x1*n*n/denominator

        add.s $f12,$f12,$f1 # cosx = cosx + 1

        addi $t1,$t1,1 # increment

        blt $t1,10,cosloop

    b printfloat


sin:
    # print operation name
    la $a0,sinstr
    jal printmessage
    
    # Take input x
    li $v0,6
    syscall 

    # f0 - x

    mov.s $f1,$f0 # x1
    mov.s $f12,$f0 # sinx

    li $t1,1 #index
    sinloop:
        # HAVE TO CONVERT INT 1 TO FLOAT BECAUSE LI.S DOESNT WORK WITH MARS
        mtc1 $t1, $f4
        cvt.s.w $f4, $f4 # final result variable
            
        l.s $f2,oneFloatConstant # 1
        add.s $f5,$f2,$f2 # 2
        mul.s $f3,$f5,$f4 # (2 x i)
        add.s $f3,$f3,$f2 # (2 x i) + 1
        mul.s $f3,$f3,$f4 # i * ((2 x i) + 1)
        mul.s $f3,$f3,$f5 # 2 * i * ((2 x i) + 1) denominator

        mul.s $f1,$f1,$f0 # x1*n
        mul.s $f1,$f1,$f0 # x1*n*n
        div.s $f1,$f1,$f3 # x1*n*n/denominator
        neg.s $f1,$f1 # -x1*n*n/denominator

        add.s $f12,$f12,$f1 # sinx = sinx + 1

        addi $t1,$t1,1 # increment

        blt $t1,10,sinloop
    
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


exit:
    li $v0, 10
    syscall
