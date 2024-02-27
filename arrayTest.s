.data

a:
	.skip 40
i: 
.word
.text
.global main
main:
ldr r1, =a
ldr r2, =i
mov r3, #0
str r3, [r2]
b test
loop:
ldr r3, [r2]
add r4, r1, r3, lsl#2
str r3, [r4]
add r3, r3, #1
str r3, [r2]

test:
ldr r3, [r2]
cmp r3, #10
blt loop

end:
mov r0, r3
bx lr
