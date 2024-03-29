//sort 2
.data
.balign 4
array: 
	.skip 40
numFormat: 
	.asciz "%d "
newLine:
	.asciz "\n"
unsorted:
	.asciz "Unsorted array: \n"
sorted:
	.asciz "Sorted array: \n"

.text
.global main
main:
	push {lr}
	//generating time seed
	mov r0, #0
	bl time
	bl srand			//rand returns random number to r0

	ldr r0, =unsorted	//print "unsorted array"
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
	cmp r5, #10		//i < 10?	
	blt loop	
	 
	bl printArray			//print unsorted array
	ldr r0, =newLine		//print newLine
	bl printf
	bl selectionSort		//call to selectionSort
	ldr r0, =sorted
	bl printf				//print "sorted array"
	bl printArray			//print sorted array	
	ldr r0, =newLine		//print newLine
	bl printf
	b end

selectionSort:  
	push {r1 - r8, lr}
	mov r10, #0			//r3 = minimum = 0;
	mov r1, #0			//r1 = i
	mov r2, #0			//r2 = j 
	ldr r4, =array		//r4 = &array[0] 

	b test2

loop2:
	mov r10, r1		//minimum = i
	add r2, r1, #1  //j = i + 1
	b nestedLoopTest

	nestedLoopBody:
		add r5, r4, r2, lsl #2		//r5 = &array[j]	
		ldr r6, [r5]				//r6 = *array[j]
		add r7, r4, r10, lsl #2		//r7 = &array[minimum]
		ldr r8, [r7]				//r8 = *array[minimum]
		cmp r6, r8		//array[j] < array[minimum}
		movlt r10, r2   //r10 = minimum = j = r2 	
		add r2, r2, #1	//increment j

	nestedLoopTest:
		cmp r2, #10		// j < 10?
		blt nestedLoopBody
		bl swap			//inner loop has finished executing
		add r1, r1, #1	// i++
		mov r2, #0		//set j back to 0

test2:
	cmp r1, #10		//i < 10? r1 = i = 0	
	blt loop2
	pop {r1 - r8, lr}
	bx lr

swap: 
	push {r1 - r5, lr}
	add r0, r4, r1, lsl #2	//r0 =  &array[i]
	add r1, r4, r10, lsl #2	//r1 =  &array[minimum]
	ldr	r2, [r0]			// r2 = temp = *array[i]
	ldr r5, [r1]			// r5 = *array[minimum]
	str r2, [r1]			// *r1 = temp 
	str r5, [r0]			// *array[minimum] = *array[i]
	pop {r1 - r5, lr}
	bx lr

printArray:
	push {lr}
	mov r0, #0
	printArrayLoop:
			cmp r0, #10		//using r5 as incrementor
			beq end			//branch if equal to size of array
			ldr r1, =array	//r1 contains address of array
			lsl r2, r0, #2	//calculating offset
			add r2, r1, r2	//r2 now contains memory address of array[i]
			ldr r1, [r2]	//r1 contains VALUE off array[i], r1 = array[i] 
			push {r0 - r2}		
			ldr r0, =numFormat
			bl printf
			pop {r0 - r2}
			add r0, r0, #1
			b printArrayLoop
	pop {lr}
	bx lr
randomNumberGenerator: 
	push {lr}		//saving path back to bl randomNumber generator
	bl rand			//rand returns value to r0,
	// % 99 = (n -  (n/m)*m)
	mov r1, #99
	udiv r2, r0, r1		//r2 = r0 / r1 
	mul r3, r2, r1		//r3 = r2 * r1 
	sub r0, r0, r3		//r0 = r0 - r3
	pop {lr}
	bx lr

end:
	pop {lr}
	bx lr

.global printf
.global rand
.global srand
.global time
