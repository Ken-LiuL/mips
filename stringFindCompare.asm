###############################################
	.data
input_string: .space 65   #storage for input string,set maximum length of input string  64
success_string: .asciiz "Success!!!Location:" 
fail_string: .asciiz "Fail!!\n"
newline: .asciiz "\n"

	.text
	#read the input string and store in the variable input_string
	li $v0,8
	la $a0,input_string
	la $a1,65
	syscall
	
loop:  #read  input character
       li $v0,12
       syscall
       move $t0,$v0
       #enter a newline
       la $a0,newline
       li $v0,4
       syscall
       
       la $t5,input_string #let register t5 hold the address of input string
       li $t6,0            #let register t6 be the index counter
       li $t1,63          #check whether the input character is ?
       bne $t1,$t0,find_position #if not,branch to the find_position
       li $v0,10 #otherwise, program exit
       syscall

find_position:
       lb $t2,($t5)
       beqz $t2,fail #if NULL, it means we can not find the character in the string, it should branch to fail
       beq $t2,$t0,success #if the input character is equal to the character that the pointer refer to, then it branch to success
       addiu $t6,$t6,1 #otherwise increment counter
       addiu $t5,$t5,1 #increment pointer
       j find_position #branch to find_position

success:#output  success_string
       la $a0,success_string
       li $v0,4
       syscall
       
       #output the position
       li $v0,1
       move $a0,$t6
       syscall
       
       #enter a newline
       la $a0,newline
       li $v0,4
       syscall 
       j loop #branch to loop

fail: #output  fail_string and branch to loop
      la $a0,fail_string
      li $v0,4
      syscall
      j loop