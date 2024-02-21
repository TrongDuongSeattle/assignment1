/* simple for loop print out 0 - 9*/
.data
i: 
	.word 0
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

body:
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
	
test: 
	ldr r1, [r0]	//load into r1 value of i from r0
	cmp r1, #10		//cmp to 10
	blt body		// branch if less than to body
end:
	ldr lr, [sp],#4
	bx lr
.global printf
