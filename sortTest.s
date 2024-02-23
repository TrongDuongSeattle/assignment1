.data
.balign 4
array: 
	.skip 40
i: 
	.word 0
j: 
	.word 0
randInt: 
	.word 0
getNum: 
	.asciz "%d\n"
unsorted:
	.asciz "Unsorted array: \n"
sorted:
	.asciz "Sorted array: \n"
testPrompt:
	.asciz "array[%d] =  %d\n"
.text
.global main
main:
str lr, [sp, #4]!
//generating time seed
ldr r0, =randInt
ldr r1, [r0]
bl time
bl srand			//rand returns random number to r0

//populate array with random values
ldr r1, =array
ldr r2, =i

b test

loop:
ldr r2, =i
ldr r3, [r2] //get value of i
add r4, r1, r3, LSL #2
//generate random num
bl randomNumberGenerator
continue:

ldr r5, =randInt
ldr r6, [r5]

str r6, [r4]
add r3, r3, #1
str r3, [r2]
/*
push {r0 - r3}
ldr r0, =testPrompt
ldr r1, =i
ldr r1, [r1]
ldr r2, =array
ldr r2, [r2]
//ldr r1, [r1] //putting this before shows offset
add r2, r2, r3, LSL #2
//ldr r1, [r1] //this shows value at
bl printf
pop {r0 - r3}
*/

test: 
ldr r2, =i
ldr r3, [r2]
cmp r3, #5
blt loop
mov r4, #0
b readloop


randomNumberGenerator: 
push {r0 - r5}

ldr r0, =randInt
ldr r1, [r0]
bl rand
mov r1, r0		//move to r1, the value at r0

ldr r2, =randInt//load r2 with address of randInt
str r1, [r2]	//str to register 1, the value at register 2

// % 99 = (n -  (n/m)*m)
mov r4, #99
ldr r1, =randInt
ldr r2, [r1]
udiv r3, r2,r4 
mul r5, r3, r4 
sub r2, r2, r5
str r2, [r1] //str the final value back to r1, randInt

pop {r0 - r5}
bl continue

readloop:
	cmp r4, #5
	beq end
	ldr r1, =array
	lsl r2, r4, #2
	add r2, r1, r2
	ldr r1, [r2]
	push {r0 - r2}
	ldr r0, =testPrompt
	mov r2, r1
	mov r1, r4
	bl printf
	pop {r0 - r2}
	add r4, r4, #1
	b readloop

end:
	ldr r0,=getNum
	bl scanf

ldr lr, [sp], #4

.global printf
.global rand
.global srand
.global time
.global scanf
