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
	ldr r0, =prompt1
	bl printf	

	//scan
	ldr r0, =numberFormat
	ldr r1, =userNum
	bl scanf

	//getting [i]
	ldr r1, =i
	ldr r2, [r1]

	//get [user num]
	ldr r3, =userNum
	ldr r4, [r3]
	
	b outerLoopTest	

innerLoop: //execute loop
	ldr r0, =numberFormat //load format
	ldr r2, =j
	ldr r3, [r2]
	mov r1, r3		//get j not ldr, r3 already has value

	//push {r0-r3}
	bl printf 
	//pop {r0-r3}

	ldr r2, =j
	ldr r3, [r2]
	add r3, r3, #1 //j++
	str r3, [r2]

innerLoopTest:
	ldr r0, =i		//load address of i into r0
	ldr r1, [r0]	//load value of i into r1 

	ldr r2, =j		//load address of j from main memory into r2 
	ldr r3, [r2]	//load value of j from register 2 into r3

	cmp r3, r1		//comparing value of j against value of i

 	ble innerLoop   //branch if j less than equal i  

	ldr r1, =i		//else load adress of i into r1	
	ldr r2, [r1]	//load value of i into r2
	add r2, r2, #1  //add to r2, i + 1
	str r1, [r2]    //store to r2, the value of r1
	
	ldr r3, =j
	ldr r4, [r3]
	mov r5, #0
	str r4, [r5]

	ldr r0, =printNewLine//condition not met, printing new line
	bl printf

//compare i and userNum
outerLoopTest: 
	ldr r4, =i		//loading adress of i into r1
	ldr r5, [r4]	//loading value of i from r1  into r2

	ldr r6, =userNum //loading adress of userNum into r3
	ldr r7, [r6]	 //get user num r2 = usernum 

	cmp r5, r7  //i = r1 user num = r2  r1 - r2 

	ble innerLoopTest //branch in inner loop if r2 <= r4	

	
	
end:	
	ldr lr, [sp],#4
	bx lr

.global printf
.global scanf

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
