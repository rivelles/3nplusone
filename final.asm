######################################################################
#                                                                    #
#	EP de Organizacao de Computadores Digitais - 2012            #
#	LUCAS FIGUEIREDO RIVELLES - 6776682                          #
#	EDUARDO MARTINS PINTO - 6776873                              #
#	turma 04                                                     #
#                                                                    #
######################################################################


		.data
msg1:	.asciiz "Insira o primeiro numero inteiro (0 < n < 1.000.000): "
msg2:	.asciiz "\nInsira o segundo numero inteiro (0 < n < 1.000.000): "
msg3:	.asciiz "\nTamanho cíclico máximo: "

		.text
.globl main

main:
		li	$v0, 4			# coloca o valor 4 no registrador v0, para indicar que syscall sera impressao de string
		la	$a0, msg1		# transfere o conteudo de msg1 para o registrador a0, que sera lido pelo syscall
		syscall				# faz a chamada ao S.O.
		li	$v0, 5			# coloca o valor 5 no registrador v0, para indicar que syscall sera ler um int
		syscall				# faz a chamada ao S.O. e grava o valor recebido em t0
		move	$t0, $v0
		li	$t1, 0			# carrega 0 em t1
		blez	$t0, fim		# se o valor de t0 for menor ou igual a 0, vai para o fim do programa
		li	$t3, 999999
		slt	$t2, $t0, $t3		# se o valor de t0 for maior que 999999, t2=0
		blez	$t2, fim		# se t2 = 0, vai para o fim do programa
		li	$v0, 4			# coloca o valor 4 no registrador v0, para indicar que syscall sera impressao de string
		la	$a0, msg2		# transfere o conteudo de msg2 para o registrador a0, que sera lido pelo syscall
		syscall
		li	$v0, 5			# coloca o valor 5 no registrador v0, para indicar que syscall sera ler um int
		syscall				# faz a chamada ao S.O. e grava o valor recebido em t1
		move	$t1, $v0		# guarda o inteiro lido em t1
		li	$t2, 0			# carrega 0 em t2
		blez	$t1, fim		# se o valor de t1 for menor ou igual a 0, vai para o fim do programa
		slt	$t2, $t0, $t3		# se o valor de t0 for maior que 999999, t2=0
		blez	$t2, fim		# se t2 = 0, vai para o fim do programa
		slt	$t2, $t0, $t1		# se o valor de t1 for maior que t0, t2=0
		blez 	$t2, fim		# se t2=0, vai para o fim do programa
		move	$t3, $t0		# move t0 para t3 para servir como contador
		move	$t4, $t1		# move t1 para t4 para servir como limite do contador
		li	$t7, 0			# carrega 0 em t7, que eh o tamanho ciclico maximo

verifica_loop:
		li	$t6, 0			# atribui 0 a t6, que sera o tamanho ciclico de cada elemento
		move	$t5, $t3		# move conteudo de t3 para t5 para ser manipulado dentro dos outros loops
		slt	$t0, $t3, $t4		# se t3 < t4, t0=1
		li	$t1, 1			# carrega 1 em t1
		beq	$t0, $t1, loop_interno	# se t0=1, continua loop
		beq	$t3, $t4, loop_interno	# se t3=t4, continua loop
		j	finaliza_loop		# senao, termina loop

loop_interno:
		addi	$t6, $t6, 1		# incrementa t6
		li	$t0, 1			# carrega 1 em t0
		beq	$t5, $t0, verifica_max	# se t5=1, vai para verifica_max
		li	$t0, 2			# carrega 2 em t0
		rem 	$t1, $t5, $t0		# guarda o resto da divisao de t5 por t0 (2) em t1
		bgtz	$t1, impar		# salta para impar se o resto da divisao for maior que (0)
		li	$t0, 0			# guarda 0 em t2, para comparar com o resto da divisao
		beq	$t1, $t0, par		# salta para par se o resto da divisao for igual a t0 (0)

verifica_max:
		addi	$t3, $t3, 1		# incrementa t3
		slt	$t0, $t7, $t6		# se t7 eh menor que t6, t0=1
		li	$t1, 1			# carrega 1 em t1
		beq	$t0, $t1, atribui_max	# se t0 = 1, vai para atribui_max
		j	verifica_loop		# senao, volta para verifica_loop
		
atribui_max:
		move	$t7, $t6		# atribui o conteudo de t6 a t7
		j	verifica_loop		

impar:
		li	$t0, 3			# guarda 3 em t0, para multiplicar pelo valor em t5
		mul	$t5, $t5, $t0		# multiplica t5 por 3 (t0) e salva em t5
		addi	$t5, $t5, 1		# soma 1 ao valor de t5	e salva em t5
		j	loop_interno		# retorna ao loop interno

par:
		li	$t1, 2			# guarda 2 em t1, para ser dividido por t5
		div	$t5, $t5, $t1		# divide t5 por 2 (t1) e salva em t5
		j	loop_interno		# retorna ao loop interno

finaliza_loop:
		li	$v0, 4			# coloca o valor 4 no registrador v0, para indicar que syscall sera impressao de string
		la	$a0, msg3		# transfere o conteudo de msg3 para o registrador a0, que sera lido pelo syscall
		syscall				# faz a chamada ao S.O.
		li	$v0, 1			# imprimir inteiro
		move	$a0, $t7		# move conteudo de t7 para a0 para ser impresso
		syscall
		j	fim			# termina execucao

fim:
		li	$v0, 10			# termina a execucao do programa
		syscall
