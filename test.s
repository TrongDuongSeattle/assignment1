.data
a: 
	.skip 40
i: 
	.word
.text
.global main
main:
	ldr r1, addressA
	ldr r2, addressI
	//initializing i
	mov r3, #0   //this is i, 1 is written to 43
	str r3, [r2] //store r3 into r1. r1 = 1 into main mem
	b test //jumps to text section
body:
	ldr r3, [r2] //
	add r4, r1, r3, LSL #2 //address incrementor
	str r3, [r4] //

	add r3, r3, #1
	str r3, [r2]

	//falls through to test	
test:
	ldr r3, [r2] //r1 has addresss, need value at address
	cmp r3, #10 // i < 10 
	blt body
 end:
	//mov r4, #1
	//add r3, r2, r4, LSL #2
	//ldr r0, [r3]
	mov r0, r3
	bx lr
	
addressA: .word a
addressI: .word i 
