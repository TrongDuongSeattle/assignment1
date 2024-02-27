//sort 2
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
//strings must end in Z because C will read until it finds a null character. C strings
//are null terminated
numFormat: 
.asciz "getNum: %d\n"
unsorted:
.asciz "Unsorted array: \n"
sorted:
.asciz "Sorted array: \n"
testPrompt:
	.asciz "array[%d] =  %d\n"
testI:
	.asciz "IN i LOOP i is:  %d \n"
testJ:
	.asciz "\t\tIn j loop j is: %d\n "
testSelSort:
	.asciz "in selectionSort\n"
testRand:
	.asciz "before bl randomGenerator\n"
testInRand:
	.asciz "\tinside of randomGenerator\n"
testAfterStore:
	.asciz "after store\n"
testAfterRand:
	.asciz "\t\tAfter rand, rand number is: %d\n"
testSwap:
	.asciz "swapping %d with %d\n"
testMin:
	.asciz "minimum is: %d\n"
printValue:
	.asciz "array[%d] =  %d\n"

finishloop:
	.asciz "loop done loopin \n"
compare:
 .asciz "comparing array[j] \< array [minimum]: %d < %d \n"
minimum:
	.asciz "minimum = %d"

.text
.global main
main:
	push {lr}
	//generating time seed
	mov r0, #0
	bl time
	bl srand			//rand returns random number to r0

	ldr r0, =unsorted
	bl printf
	ldr r4, =array		//loading adress of array, r1 contains address of array
	//begin for loop
	mov r5, #0			//using r5 as i, i = 0
	b test				//begin outer loop, i

loop:
	add r6, r4, r5, lsl #2		//r6 = &array[i] 
	bl randomNumberGenerator	//after call r0 contains random integer
	str r0, [r6]				// *array[i] = r0
	add r5, r5, #1				//i++

test: 
	cmp r5, #5		//i < 5?	
	blt loop		//do thing
	 
	bl printArray
		
	bl selectionSort
	bl printArray
	b end

selectionSort:  
//i, j, minimum
//this calls another function remember to save lr
push {r1 - r8, lr}
mov r10, #0			//r3 = minimum = 0;
mov r1, #0			//r1 = i
mov r2, #0			//r2 = j 
ldr r4, =array		//r4 = &array[0] 

//r1 = i
//r2 = j 
//r3 = minimum = 0;
//r4 = &array[0]
b test2

loop2:
mov r10, r1		//minimum = i
add r2, r1, #1  //j = i + 1
	//test print
	push {r0 - r10}
	ldr r0, =testMin
	mov r1, r10
	bl printf
	pop {r0 - r10}
b nestedLoopTest

nestedLoopBody:
	add r5, r4, r2, lsl #2		//r5 = &array[j]	
	ldr r6, [r5]				//r6 = *array[j]
	
	add r7, r4, r10, lsl #2		//r7 = &array[minimum]
	ldr r8, [r7]				//r8 = *array[minimum]
	
	//test print " comparing array[j] < array [minimum]
	push {r0 - r2}
	ldr r0, =compare
	mov r1, r6		//r1 = *array[j]
	mov r2, r8		//r2 = *array[min}
	bl printf
	pop {r0 -  r2}
	
	push {r0 - r2}
	ldr r0, =testJ
	mov r1, r2		//r1 = *array[j]
	bl printf
	pop {r0 - r2}

	cmp r6, r8		// array[j] < array[minimum}
	movlt r10, r2    // r10 = minimum = j = r2 	

	push {r0 - r10}
	ldr r0, =testMin
	mov r1, r10
	bl printf
	pop {r0 - r10}
	
	//increment j
	add r2, r2, #1

nestedLoopTest:
cmp r2, #5		// j < 5?
blt nestedLoopBody

push {lr}
bl swap
pop {lr}
add r1, r1, #1	// i++

mov r2, #0		//set j back to 0
test2:
//r1 = i = 0
cmp r1, #5		//i < 5?	
blt loop2
pop {r1 - r8, lr}
bx lr

swap: 
push {r1 - r5, lr}

//r1 = i
//r2 = j  over written to &array[i]
//r3 = minimum = 0;
//r4 = &array[0]
//r7 = &array[minimum]
//r8 = array[minimum]
add r0, r4, r1, lsl #2	//r2 =  &array[i]
add r1, r4, r10, lsl #2	//r2 =  &array[minimum]
			push {r0 - r5}
			ldr r2, [r1]
			ldr r1, [r0]
			ldr r0, =testSwap
			bl printf
			pop {r0 - r5}
//mov r10, r3				//r10 contains copy of array [i]
ldr	r2, [r0]			// r2 = temp = *array[i]
ldr r5, [r1]			// r5 = *array[minimum]
str r2, [r1]			// 
str r5, [r0]
bl printArray
pop {r1 - r5, lr}
bx lr

printArray:
	push {lr}
		mov r0, #0
		printArrayLoop:
			cmp r0, #5		//using r5 as incrementor
			beq end			//branch if equal to size of array
			ldr r1, =array	//r1 contains address of array
			lsl r2, r0, #2	//calculating offset
			add r2, r1, r2	//r2 now contains memory address of array[i]
			ldr r1, [r2]	//r1 contains VALUE off array[i], r1 = array[i] 
			
			push {r0 - r2}		
			mov r2, r1 
			mov r1, r0 
			ldr r0, =printValue 
			bl printf
			pop {r0 - r2}
			
			add r0, r0, #1
			b printArrayLoop
	pop {lr}
	bx lr
randomNumberGenerator: 
	push {lr}		//saving path back to bl randomNumber generator
					// because we're callinga function within here
	bl rand			//rand returns value to r0
					//r0 now contains random value	
	// % 99 = (n -  (n/m)*m)
	mov r1, #99
	udiv r2, r0, r1		//r2 = r0 / r1 
	mul r3, r2, r1		//r3 = r2 * r1 
	sub r0, r0, r3		//r0 = r0 - r3
					
	//r0 should have randome number
	pop {lr}
	bx lr

end:
	pop {lr}
	bx lr

.global printf
.global rand
.global srand
.global time
.global scanf
