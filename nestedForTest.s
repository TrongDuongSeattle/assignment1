/* nested for loop print out 0 - 9*/
.data
i: 
	.word 1 
j: 
	.word 1
testJ:
	.asciz "j = %d"
testI:
	.asciz "i = %d\n"
numberFormat:
	.asciz "%d"
newLine:
	.asciz "\n"
.text
.global main
main:
	str lr, [sp, #-4]!
	ldr r0, =i  //load into r0, the adress of i from main memory  i is already initialized to 0
	
	b test // branch to test

innerbody:
	push {r0 - r3}
	ldr r0, =numberFormat
	ldr r1, [r2]
	bl printf
	pop {r0 - r3}	
	
	//incrementing j		
	add r3, r3, #1
	str r3, [r2] //store to r1, the value at r1

//	ldr r0, =i
//	ldr r1, [r0]	//loading to r1, the value at [r0]


	cmp r3, r1		//compare i and j, 
	ble innerbody 
body:
	ldr r2, =j		//load to r2, the adress of j
	ldr r3, [r2]	//load to r3, the value at r2 from main memory
	
	cmp r3, r1		//compare i and j, 
	ble innerbody 

	push {r0 - r3} 
	ldr r0, =newLine
	//r1 should still be available
	bl printf
	pop {r0 - r3}

	ldr r1, [r0]	//loading to r1, the value at [r0] 
	add r1, r1, #1	// incrementing i
	str r1, [r0]	//store to r1, the value at r0
	
	ldr r2, =j 
	ldr r3, [r2]
	mov r3, #1
	str r3, [r2]
	

	

/*
	//print function
	push {r0 - r3} 
	ldr r0, =numberFormat
	ldr r1, =i
	ldr r1, [r1] 	
	bl printf
	pop {r0 - r3}
	
	//increment i
	ldr r1, [r0]  //loading to r1, the value at [r0]
	add r1, r1, #1
	str r1, [r0]  //store to r1, the value at r0

	//print newline
	push {r0 - r3} 
	ldr r0, =newLine
	bl printf
	pop {r0 - r3}
*/	
test: 
	ldr r1, [r0]	//load into r1 value of i from r0
	cmp r1, #5		//cmp to 10
	ble body		// branch if less than to body
end:
	ldr lr, [sp],#4
	bx lr
.global printf
