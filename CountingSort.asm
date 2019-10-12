.data
	arrayOrig: .word 3223, 234, 453, 5234, 2, 13123, 34, 324234, 45, 2342, 440, 20299, 23834, 112, 124, 434
	arrayFinal: .word 0:16
	arrayCount: .word 0:324234
.text
# Digite a quantidade de itens da lista original(arrayOrig)
add $s6, $zero, 16
	mul $s6, $s6, 4
# Digite o maior valor da lista original(arrayOrig)
add $s7, $zero, 324234
	add $s7, $s7, 1
	mul $s7, $s7, 4

# Limpar Index($t0) e Index 2($t1) para 0
add $t0, $zero, 0
add $t1, $zero, 0
# Atribui à lista de contagem(arrayCount) +1 a cada vez que o valor de index aparece na lista original(arrayOrig)
whileAtribuir:
	beq $t0, $s6, exitAtribuir
	lw $s0, arrayOrig($t0)
	
	#atribuir ao index o valor da posição
	mul $t1, $s0, 4
	 
	lw $s0, arrayCount($t1)
	 	add $s0, $s0, 1 
			sw $s0, arrayCount($t1)

	add $t0, $t0, 4
	j whileAtribuir
exitAtribuir:

# Limpar Index($t0) para 4 e Index 2($t1) para 0
add $t0, $zero, 4
add $t1, $zero, 0
# Soma os valores da lista de contagem(arrayCount) em ordem
whileCount:
	beq $t0, $s7, exitCount
	lw $s0, arrayCount($t0)
	lw $s1, arrayCount($t1)
	
	add $s0, $s0, $s1
		sw $s0, arrayCount($t0)
		
	add $t0, $t0, 4
	add $t1, $t1, 4
	j whileCount
exitCount:

# Limpar Index($t0) para 0
add $t0, $zero, 0
# Ordena os valores da lista original(arrayOrig) na lista final(arrayFinal) segundo os indices da lista de contagem(arrayCount)
whileOrdenacao:
	beq $t0, $s6, exitOrdenacao
	# Captura os valores da lista original(arrayOrig)
	lw $s0, arrayOrig($t0)
		mul $t1, $s0, 4
	#busca o indice na lista de contagem(arayCount)
	lw $s1, arrayCount($t1)
		sub $s1, $s1, 1
			# Subtrai o valor na lista de contagem(caso de repetição)
			sw $s1, arrayCount($t1)
		mul $t2, $s1, 4
	#Armazena o valor na lista final
	sw $s0, arrayFinal($t2)
	
	add $t0, $t0, 4
	j whileOrdenacao
exitOrdenacao:

# Limpar Index($t0) para primeira a posição válida da lista(1)
add $t0, $zero, 0
whilePrint:
	beq $t0, $s6, exitPrint
	
	lw $s0, arrayFinal($t0)
	
	# Imprime o numero
	li $v0, 1
	move $a0, $s0
	syscall
	
	# Imprime um espaço
	li $v0, 11
	la $a0, ' '
	syscall
		
	add $t0, $t0, 4
	j whilePrint
exitPrint: