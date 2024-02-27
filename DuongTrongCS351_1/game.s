.data
randInt:
	.word 0
getNum: 
	.asciz "%d"
userGuess:
	.word 0
newLine:
	.asciz "\n"
prompt:
	.asciz "Guess the number: "
highGuess: 
	.asciz "Too high. Guess again. "
lowGuess:
	.asciz "Too low. Guess again. " 
correctGuess:
	.asciz "You guessed correctly in %d tries!\n"
count: 
	.word 1

.text
.global main
main: 
str lr, [sp, #-4]!

ldr r0, =randInt
ldr r0, [r0]
bl time
bl srand			//rand returns random number to r0

bl rand
mov r1, r0		//move to r1, the value at r0
ldr r2, =randInt//load r2 with address of randInt
str r1, [r2]	//str to register 1, the value at register 2

//divide by 10
mov r4, #10
ldr r1, =randInt
ldr r2, [r1]
udiv r3, r2,r4 
mul r5, r3, r4 
sub r2, r2, r5
str r2, [r1] //str the final value back to r1, randInt

//print new line
ldr r0, =prompt
bl printf

loop:
ldr r0, =getNum
ldr r1, =userGuess
ldr r2, [r1]  
bl scanf 

//conditional
ldr r1, =userGuess	//reloading user guess into r2
ldr r3, =randInt	// reloading randomInt
ldr r5, =count		// loading count var

ldr r2, [r1]		//r2 contains user address	
ldr r4, [r3]		//r4 contains randInt
ldr r6, [r5]		//r6 contains count
cmp r2, r4			// userGuess == randomint?
bgt tooHigh
blt tooLow
beq justRight

tooHigh:
ldr r0, =highGuess
bl printf
// increment count
add r6, r6, #1
str r6, [r5]
b loop

tooLow:
ldr r0, =lowGuess
bl printf
//increment count
add r6, r6, #1
str r6, [r5]
b loop

justRight:
ldr r0, =correctGuess
ldr r1, =count
ldr r1, [r1]
bl printf

//end
ldr lr, [sp], #4
bx lr
.global printf
.global scanf
.global rand
.global time
.global srand
