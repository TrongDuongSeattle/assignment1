.data
randInt:
	.word 0
getNum: 
	.asciz "%d"
newLine:
	.asciz "\n"
prompt:
	.asciz "Guess the number: "

.text
.global main
main: 
str lr, [sp, #-4]!

push {r0}

bl rand			//rand returns random number to r0
mov r1, r0		//move to r1, the value at r0
ldr r2, =randInt//load r2 with address of randInt
str r1, [r2]	//str to register 1, the value at register 2

//print number
ldr r0, =getNum
ldr r2, = randInt
ldr r1, [r2]
bl printf

//print new line
ldr r0, =newLine
bl printf

//divide by 10
mov r4, #10
ldr r1, =randInt
ldr r2, [r1]
udiv r3, r2,r4 
mul r5, r3, r4 
sub r2, r2, r5
str r2, [r1]

ldr r0, =getNum
ldr r1, =randInt
ldr r1, [r1]
bl printf
pop {r0}

end:
ldr lr, [sp], #4
bx lr
.global printf
.global scanf
.global rand
