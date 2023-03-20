.globl		main

.data
MATRIX: 		.word 	1, 2, 3, 4, 5, 6, 7, 8, 9
N:			.word 	3
index:		.asciiz 	"Index: "
result:		.asciiz	"Result: "
matrix_elem:	.asciiz	"Matrix[]: "
newline:		.asciiz 	"\n"
x:			.asciiz	"x: "
y:			.asciiz	"y: "
	
.text
main:	
			xor 		$s0, $s0, $s0			#sum	
			lw		$s1, N				#N
			xor 		$s2, $s2, $s2			#matrix[offset]
			xor 		$t8, $t8, $t8			#offset
			xor		$t0, $t0, $t0			#x
for_outer:
			bge		$t0, $s1, end_outer		#for (idx-x = 0, idx-x < N, idx_x++), boundary check
			xor		$t1, $t1, $t1			#y
for_inner:
			bge 		$t1, $s1, end_inner		#for (idx_y = 0, idx_y < N, idx_y++), boundary check
			move	$a0, $t0
			move	$a1, $t1
			lw		$a2, N
			jal		is_main_diag
			bnez		$v0, sum				#if (is_main_diag(idx_x, idx_y, N) goto sum
			move	$a0, $t0
			move	$a1, $t1
			lw		$a2, N
			jal		is_secondary_diag		#is_secondary_diag(idx_x, idx_y, N) goto sum
			bnez		$v0, sum
			j		next
sum:
			move	$t8, $t0				#t8 = idx_x
			move 	$t3, $t1				#t3 = idx_y
			lw		$t4, N				
			sub		$t4, $t4, 1			#t4 = N - 1
			mul		$t3, $t3, $t4			#t3 = t3 * t4 (idx_y *= N - 1)
			add		$t8, $t8, $t3			#t8 += t3 (index = idx_x + idx_y * (N - 1))	
			move	$a0, $t8
			la		$a1, index
			jal		print_lab_int			#DEBUG print_int(t8))
			sll		$t8, $t8, 2			#t8 *= 4 (offset = index * 4)
			lw		$s2, MATRIX($t8)		#s2 = MATRIX + offset (s2 = matrix[index]
			move	$a0, $s2
			la		$a1, matrix_elem
			jal		print_lab_int			#DEBUG print_lab_int(s2, matrix_elem) print matrix[index] with label matrix_elem
			move	$a0, $s2
			add		$s0, $s0, $s2			#s0 *= s2 (sum += matrix[index])
next:
			addi		$t1, $t1, 1			#idx_y++ goto for_inner
			j		for_inner
end_inner:	
			addi		$t0, $t0, 1			#idx_x++ goto for_outer
			j		for_outer					
end_outer:
			move	$a0, $s0
			la		$a1, result
			jal 		print_lab_int			#print_lab_int(s0, result) print sum with label result
			addi		$a0, $0, 0
			jal 		exit2					#exit with code 0
