.data
test1: 
	.asciz "outerloopTest1"
test2:
	.asciz "InnerLoopTest %d"
prompt1: 
	.asciz "Enter a number: "
numberFormat:
	.asciz "%d"  //using this to scan %d\n, assembler is trying to match a number and a whiteline or something. 
printNumber:
	.asciz "%d\n"
printNewLine: 
	.asciz "\n"
userNum: 
	.word 0
i: 
	.word 1
j: 
	.word 1
return:
	.word 0

.text
.global main
main:
	/* doing function this was trying to store 0 into the link register...
	program didn't work with this 
	ldr r1, =return  
	str lr, [r1]
	*/
	str lr, [sp, #-4]!	
	ldr r0, =prompt1
	bl printf	

	//scan
	ldr r0, =numberFormat
	ldr r1, =userNum
	bl scanf

	//getting [i]
	ldr r1, =i
	ldr r1, [r1]

	//get [user num]
	ldr r2, =userNum
	ldr r2, [r2]
	
	b outerLoopTest	

innerLoop: //execute loop
	ldr r0, =numberFormat //load format
	mov r1, r3		//get j not ldr, r3 already has value

	push {r0-r3}
	bl printf 
	pop {r0-r3}

	ldr r2, =j
	ldr r3, [r2]
	add r3, r3, #1 //j++
	str r3, [r2]
	

innerLoopTest:
	//getting j 
	ldr r3, =j		//get adress of j  
	ldr r3, [r3]		//get value of j
	cmp r3, r1		//compare r3 -  r1 j < i


 	ble innerLoop  
	ldr r1, =i	
	ldr r2, [r1]	
	add r2, r2, #1
	str r2, [r1]

	/*push {r0 - r3} //thanks nathaniel
	ldr r0, =test2
	mov r1, r1 	
	bl printf 
	ldr r0, =numberFormat
	ldr r1, =userNum
	bl scanf       */
outerLoopTest: 
/*
	push {r0 - r3} //thanks nathaniel
	ldr r0, =test1
	mov r1, r2 	
	bl printf 
	ldr r0, =numberFormat
	ldr r1, =userNum
	bl scanf
	pop {r0 - r3}
*/
	ldr r1, =i
	ldr r2, [r1]

	ldr r3, =userNum
	ldr r4, [r3] //get user num r2 = usernum 

	/*
	push {r0 - r3} //thanks nathaniel
	ldr r0, =printNumber
	mov r1, r2  //mov not ldr - because r2 already has value, just need to copy
	bl printf 
	ldr r0, =numberFormat
	bl scanf
	pop {r0 - r3} */

	cmp r2, r4   //i = r1 user num = r2  r1 - r2 
	
/*	push {r0 - r3} //thanks nathaniel
	ldr r0, =test1
	bl printf 
	ldr r0, =numberFormat
	bl scanf
    pop {r0 - r3} */

	ble innerLoopTest	
	//increment i, i = i + 1
	
	ldr r0, =printNewLine
	bl printf
end:	
	ldr lr, [sp],#4
	bx lr

/*
address_of_p1:.word prompt1		//i wonder if this increases or decrease speed rather than just calling with = 
address_of_number:.word number
adress_of_return:.word return
*/
.global printf
.global scanf
