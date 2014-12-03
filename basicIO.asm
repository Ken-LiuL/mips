#############################
         .data
newline: .asciiz "\n"  
others:  .asciiz "*"   #for other case
alphabet: .word 0:26   #storage for alphabet conversion
numbers: .word 0:10    #storage for number conversion

#initialization of every conversion rule  
A: .asciiz "Alpha"
B:  .asciiz "Bravo"
C: .asciiz "Charlie"
D: .asciiz "Delta"
E: .asciiz "Echo"
F: .asciiz "Foxtrot"
G: .asciiz "Golf"
H: .asciiz "Hotel"
I: .asciiz "India"
J: .asciiz "Juliet"
K: .asciiz "Kilo"
L: .asciiz "Lima"
M: .asciiz "Mike"
N: .asciiz "November"
O: .asciiz "Oscar"
P: .asciiz "Papa"
Q: .asciiz "Quebec"
R: .asciiz "Romeo"
S: .asciiz "Sierra"
T: .asciiz "Tango"
U: .asciiz "Uniform"
V: .asciiz "Victor"
W: .asciiz "Whiskey"
X: .asciiz "X-ray"
Y: .asciiz "Yankee"
Z: .asciiz "Zulu"
One: .asciiz "one"
Two: .asciiz "two"
Three: .asciiz "three"
Four: .asciiz "four"
Five: .asciiz "five"
Six: .asciiz "six"
Seven: .asciiz "seven"
Eight: .asciiz "eight"
Nine: .asciiz "nine"
Zero: .asciiz "zero"
   
   .text
   #store every alphabet conversion string in the array according to alphabetic order
   la $t0,alphabet
   la $t1,A
   sw $t1,0($t0)
   la $t1,B
   sw $t1,4($t0) 
   la $t1,C
   sw $t1,8($t0) 
   la $t1,D
   sw $t1,12($t0)
   la $t1,E
   sw $t1,16($t0)
   la $t1,F
   sw $t1,20($t0)
   la $t1,G
   sw $t1,24($t0)
   la $t1,H
   sw $t1,28($t0)
   la $t1,I
   sw $t1,32($t0)
   la $t1,J
   sw $t1,36($t0)
   la $t1,K
   sw $t1,40($t0)
   la $t1,L
   sw $t1,44($t0)
   la $t1,M
   sw $t1,48($t0)
   la $t1,N
   sw $t1,52($t0)
   la $t1,O
   sw $t1,56($t0)
   la $t1,P
   sw $t1,60($t0)
   la $t1,Q
   sw $t1,64($t0)
   la $t1,R
   sw $t1,68($t0)
   la $t1,S
   sw $t1,72($t0)
   la $t1,T
   sw $t1,76($t0)
   la $t1,U
   sw $t1,80($t0)
   la $t1,V
   sw $t1,84($t0)
   la $t1,W
   sw $t1,88($t0)
   la $t1,X
   sw $t1,92($t0)
   la $t1,Y
   sw $t1,96($t0)
   la $t1,Z	
   sw $t1,100($t0)
   
   #store the number conversion string  in the array according to 0~9 order
   la $t0,numbers
   la $t1,Zero
   sw $t1,0($t0)
   la $t1,One
   sw $t1,4($t0)		
   la $t1,Two
   sw $t1,8($t0)
   la $t1,Three
   sw $t1,12($t0)
   la $t1,Four
   sw $t1,16($t0)
   la $t1,Five
   sw $t1,20($t0)
   la $t1,Six
   sw $t1,24($t0)
   la $t1,Seven
   sw $t1,28($t0)
   la $t1,Eight
   sw $t1,32($t0)
   la $t1,Nine
   sw $t1,36($t0)	
   
loop:	 li $v0,12   #read character 
    	 syscall  
   	 move $t0,$v0
  	 la $a0,newline #enter a newline
  	 li $v0,4
  	 syscall   
  	 sle $t1,$t0,57 #if the character is equal or smaller than 9, then branch to deal_number
  	 beq $t1,$1,deal_number
   
   	 sle $t2,$t0,90 #if the character is equal or smaller than Z, then branch to deal_upper_case
  	 beq $t2,$1,deal_upper_case
   
   	 sle $t3,$t0,122
	 beq $t3,$1,deal_lower_case #if the character is equal or smaller than z, then branch to lower_case
   
   	j other_case #otherwise, let it branch to other_case


deal_number:
	sge $t1,$t0,48
	beq $t1,$1,output_number #if the character is also equal or larger than 0, then it is a number then branch to output_number
        j other_case #otherwise let it branch to other_case
  
deal_upper_case: 
	sge $t2,$t0,65 #if the character is also equal or larger than A,then it is a upper letter then branch to output_alphabet
 	beq $t2,$1,output_alphabet
	j other_case #otherwise,let it branch to other_case
 
deal_lower_case:
	 sge $t3,$t0,97 #if the character is als equal or larger than a, then it is a lower letter
 	addi $t0,$t0,-32 # we let it become a upper letter, because A-a = -32, B- b =-32...Z-z=-32
	 beq $t3,$1,output_alphabet #then branch to output_alphabet
 	j other_case #otherwise branch to othercase

other_case:
	li $t4,63  #if the character is equal to ? , then let the program branch to the end
  	beq $t4,$t0,end
  
 	la $a0,others #otherwise, we output * and enter a newline
  	li $v0,4
  	syscall
 	la $a0,newline
 	li $v0,4
  	syscall
  	j loop # and branch to loop
    
output_number:
	addiu $t0,$t0,-48 #let X-'0' to convert the character to a number
  	li $t1,4  
  	mul $t0,$t0,$t1 #get address of  corresponding element in the array
  	lw $a0,numbers($t0) #get address of the conversion string
  	li $v0,4
  	syscall      #output the correponding string
  	la $a0,newline #enter a new line
   	li $v0,4
 	syscall
    	j loop #branch to loop
    	
output_alphabet:
   	addiu $t0,$t0,-65 #let X-'A' to get index of the corresponding element in the array
   	li $t1,4
   	mul $t0,$t0,$t1 #get address of the corresponding element in the array
   	lw $a0,alphabet($t0)#get address of the conversion string in the stack
   	li $v0,4
  	syscall  #output the string
  	la $a0,newline #enter a newline
  	li $v0,4
  	syscall 
   	j loop #branch to loop

end:
  	li $v0,10 
        syscall #exit this program