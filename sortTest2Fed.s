//sort 2
.data
.balign 4
array: 
	.skip 40
arrayJ:
	.word 0
i: 
.word 0
j: 
.word 0
randInt: 
.word 0
getNum: 
.asciz "getNum: %d\n"
unsorted:
.asciz "Unsorted array: \n"
/*
sorted:
.asciz "Sorted array: \n"
testPrompt:
	.asciz "array[%d] =  %d\n"
testI:
	.asciz "IN i LOOP %d \n"
testJ:
	.asciz "in j loop "

testSelSort:
	.ascii "in selectionSort\n"
testRand:
	.ascii "before bl randomGenerator\n"
testInRand:
	.ascii "\tinside of randomGenerator\n"
testAfterStore:
	.ascii "after store\n"
testAfterRand:
	.ascii "\t\tAfter rand, rand number is: %d\n"

printValue:
	.asciz "printValue: %d\n"
*/

.text
.global main
main:
str lr, [sp, #4]!
//generating time seed
mov r0, #0
bl time
bl srand			//rand returns random number to r0

//print "unsorted array"
push {r0}
ldr r0, =unsorted
bl printf
pop {r0}		

//populate array with random values
ldr r4, =array		//loading adress of array, r1 contains address of array
//begin for loop
mov r5, #0			//using r5 as i, i = 0
b test				//begin outer loop, i

loop:
add r6, r4, r5, lsl #2 //r6 = &array[j] 

					/*testprint
					push {r0}
					ldr r0, =testRand
					bl printf
					pop {r0}		
					*/
ldr r7, =arrayJ
str r6, [r7]
bl randomNumberGenerator	//r0 contains random integer

ldr r8, =randInt
str r0, [r8]
str r0, [r6]
					//testprint
					push {r0 - r1}
					ldr r1, =randInt
					ldr r1, [r1]
					ldr r0, =getNum
					bl printf
					pop {r0 - r1}		


add r5, r5, #1			//i++

test: 
cmp r5, #5		//i < 5?	
blt loop		//do thing
b end

randomNumberGenerator: 
				/*testprint
				push {r0}
				ldr r0, =testInRand
				bl printf
				pop {r0}
				*/


bl rand			//rand returns value to r0
				//r0 now contains random value	
// % 99 = (n -  (n/m)*m)
mov r1, #99
udiv r2, r0, r1		//r2 = r0/r1 
mul r3, r2, r1		//r3 = r2 * r1 
sub r0, r0, r3		//r0 = r3 - r0
// todo: add 1 here
				/*testprint
				push {r0 - r1}
				mov r1, r0
				ldr r0, =getNum
				bl printf
				pop {r0 - r1} 
				*/
//r0 should have randome number
bx lr

end:
ldr lr, [sp], #4
bx lr

.global printf
.global rand
.global srand
.global time
.global scanf

