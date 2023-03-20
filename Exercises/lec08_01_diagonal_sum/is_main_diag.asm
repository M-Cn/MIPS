.globl		is_main_diag

.data

.text
is_main_diag:	#is_main_diag(int x, int y, int size)
			bne		$a0, $a1, false
			addi		$v0, $0, 1
			jr		$ra
false:
			addi		$v0, $0, 0
			jr		$ra