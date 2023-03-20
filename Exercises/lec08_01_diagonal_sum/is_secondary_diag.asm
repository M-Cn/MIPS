.globl		is_secondary_diag

.data

.text
is_secondary_diag:						#is_secondary_diag(int x, int y, int size)
			sw		$ra, ($sp)
			subi		$sp, $sp, 4
			sw		$t0, ($sp)
			move	$t0, $a2
			subi		$t0, $t0, 1		#t0 = N - 1
			sub		$t0, $t0, $a0		#t0 = t0 - x
			bne		$a1, $t0, false		#if	(y != N -1 - x) goto false
			lw		$t0, ($sp)
			addi		$sp, $sp, 4
			lw		$ra, ($sp)
			addi		$v0, $0, 1
			jr		$ra
false:
			lw		$t0, ($sp)
			addi		$sp, $sp, 4
			lw		$ra, ($sp)
			addi		$v0, $0, 0
			jr		$ra