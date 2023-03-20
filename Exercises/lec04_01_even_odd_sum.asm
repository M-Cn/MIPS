.data
	vector: .word 4, -1, 5, 500, 0, 10000, -256
	vec_size: .word 7
	sum: .word 0, 0
.text
main:	lw $s0, sum		#s0 = sum[0]
	lw $s1, sum+4		#s1 = sum[1]
	lw $s2, vec_size	#s2 = vec_size
	xor $t0, $t0, $t0	#loop index
	xor $t3, $t3, $t3	#offset
loop:	bge $t0, $s2, end	#if index > vec_size => goto end
	sll $t1, $t0, 2		#offset = index * 4
	lw $t2, vector($t1)	#t2 = vector[index]
	addi $t0, $t0, 1	#index++
	not $t3, $t3		#t3 != t3
	beq $t3, $0, odd	#if t3 == 0 => goto odd
	add $s0, $s0, $t2	#s0 += vector[index]
	j loop
odd:	add $s1, $s1, $t2	#s1 += vector[index]
	j loop
end:	sw $s0, sum		#sum[0] = s0
	sw $s1, sum+4		#sum[1] = s1