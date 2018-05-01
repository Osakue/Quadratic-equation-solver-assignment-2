.data
buzz_1:.asciiz "\nenter any number for (A):"
buzz_2:.asciiz "\nenter any number for (B):"
buzz_3:.asciiz "\nenter any number for (C):"
buzz_error:.asciiz "\nComplex root, try again "
buzz_ans:.asciiz "\nYour answer is\n"
buzz_and:.asciiz " & "
buzz_question:.asciiz "\nWould you like to do another Quadratic Equation?!!\n press 1 to continue or any key to exit\n"
buzz_goodbye:.asciiz "\nThank you for using this app.Goodbye"
buzz_two: .float 2
buzz_four: .float 4
discriminant_checker:.float 0

.text
Starting_starting:
lwc1 $f1,buzz_two                   #$f1 they hold 2.0
lwc1 $f2,buzz_four                  #$f2 they hold 4.0
lwc1 $f3,discriminant_checker       #$f3 they hold 0.0 to check discriminant

la $a0,buzz_1                       #Tell user to enter any number as A
li $v0,4
syscall
li $v0,6
syscall
mov.s $f4,$f0                       #Na $f4 i take hold A

la $a0,buzz_2                       #Tell user make  enter any number as B
li $v0,4
syscall
li $v0,6
syscall
mov.s $f5,$f0                       #Na $f5 i take hold B

la $a0,buzz_3                       #Tell user make e enter any number as C
li $v0,4
syscall
li $v0,6
syscall
mov.s $f6,$f0                       #Na $f6 i take hold C

#The discriminant (d) can be calculated at this point using the formula ## d = b^2-4*a*c
#And my 4=$f2, a=$f4, b=$f5, c=$f6

mul.s $f7,$f5,$f5                  #$f7 = b^2
mul.s $f8,$f2,$f4                  
mul.s $f8,$f8,$f6                  #$f8 = 4*a*c
sub.s $f8,$f7,$f8                  #$f8 = d = b^2-4*a*c#$f9 = d = b^2-4*a*c
mfc1 $t1,$f8                       #i change $f8 to $t1 so as to be able to check if my discriminat is smaller than zero(0)

blez $t1,error_label               #Now to check if the discriminant is smaller than or equal to zero
sqrt.s $f10,$f8                    #$f10 holds the square root of the discriminant

#roots_solver                      #Nice work man. Now let us begin calculation which is ## -b+-sqrtd/2*a
neg.s $f9,$f5                      #Here i just change b to -b. like this $f9=-b
add.s $f23,$f9,$f10                #Here i did -b+sqrtd
sub.s $f25,$f9,$f10                #Here i did -b-sqrtd
mul.s $f1,$f1,$f4                  #2*a is written here
div.s $f24,$f23,$f1                #I divided -b+sqrtd by 2*a
div.s $f26,$f25,$f1                #I cdivide -b-sqrtd by 2*a
la $a0,buzz_ans
li $v0,4
syscall

mov.s $f12,$f24
li $v0,2
syscall

la $a0,buzz_and
li $v0,4
syscall

mov.s $f12,$f26
li $v0,2
syscall

la $a0,buzz_question
li $v0,4
syscall
li $v0,5
syscall
move $t4,$v0
li $t3,1
beq $t4,$t3,Starting_starting
b exit

error_label:
la $a0,buzz_error
li $v0,4
syscall

la $a0,buzz_question
li $v0,4
syscall
li $v0,5
syscall
move $t4,$v0
li $t3,1
beq $t4,$t3,Starting_starting

b exit
exit:
la $a0,buzz_goodbye
li $v0,4
syscall

li $v0,10
syscall
