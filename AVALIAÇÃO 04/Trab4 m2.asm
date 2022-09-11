# Disciplina: Arquitetura e Organização de Processadores
# Atividade: Avaliação 04 – Programação de Procedimentos
# Alunos: Felipe dos Santos e Nathalia Suzin

		.data
		
Vetor_A:	.word	0,0,0,0,0,0,0,0
sizeVet:	.asciiz	"\nEntre com o tamanho do vetor (mín=2 e máx=8): "
msgInvalid:	.asciiz "\nValor inválido."
contVet:	.asciiz	"\nVetor_A["
contEnd:	.asciiz	"]: "
testeEnd:	.asciiz "Fim!"
		
		.text
	
	li $s1, 7
	li $s2, 8
	li $s3, 9
	
	li $s6, 0		# i = 0
	li $s7, 0		# j = 0

	j Main



Invalidez:

	li $v0, 4		# Carrega o serviço 4 (Ponteiro para string)
        la $a0, msgInvalid	# Carega ptr p/ string (Mostra a mensagem na tela)
        syscall			# Chama o serviço 4
        
# Fim da área que verifica a entrada de dados do tamanho do vetor

# Início da área que verifica a entrada de dados do tamanho do vetor
TamanhoVetor:
	
	li $v0, 4 		# Carrega o servico 4 (Ponteiro para string)
        la $a0, sizeVet 	# Carega ptr p/ string (Mostra a mensagem na tela)
        syscall			# Chama o servico 4
        
        li $v0, 5 		# Carrega o servico 5
        syscall 		# Chama o servico 5
        add $s0, $v0, $zero	# O que o usuario digitar sera adicionado ao $s0
        
        blt $s0, 2, Invalidez		# Se o valor digitado for menor que 2, volta para "Invalidez"
        bgt $s0, 8, Invalidez	# Se o valor digitado for maior que 8, volta para "Invalidez"
        
        jr $ra			# Volta para Main se tamanho é válido!       

# Área para leitura dos vetores
VoltarMain:
	subi $sp, $sp, 16	# Cria uma pilha com 1 espaço
 	sw $ra, 0($sp)		# Guarda valor do $ra (main)
 	sw $a0, 4($sp)		# Guarda o tamanho do vetor na pilha
 	sw $s1, 8($sp)		# Carrega o valor inicial de $s1 na pilha
 	sw $s2, 12($sp)		# Carrega o valor inicial de $s2 na pilha
 	sw $s3, 16($sp)		# Carrega o valor inicial de $s3 na pilha
 	
LerVetor:
		
	li $v0, 4 		# Carrega o servico 4 (Ponteiro para string)
        la $a0, contVet		# Carrega ptr p/ string (Mostra a mensagem na tela)
        syscall			# Chama o servico 4
	
        li $v0, 1 		# Carrega o servico 1 (inteiro)
        la $a0, ($s6) 		# Carrega no $a0 o valor inteiro do indice
        syscall 		# Chama o servico 1
        
        li $v0, 4 		# Carrega o servico 4 (Ponteiro para string)
        la $a0, contEnd		# Carrega ptr p/ string (Mostra a mensagem na tela)
        syscall 		# Chama o servico 4
	
	li $v0, 5 		# Carrega o servico 5
        syscall 		# Chama o servico 5
        add $s1, $v0, $zero	# O que o usuario digitar sera adicionado ao $s1
        
        jal  MulIndice		# Função que faz a multiplicação do índice
        
        add $t7, $t7, $a1	# Guarda no $t7, End. Absoluto = 4*i + End.Base
      	sw $s1, 0($t7)		# Salva no vetor o número que o usuario digitou, usando o End. Absoluto
               
        
        addi $s6, $s6, 1       	# i = i + 1
        
        blt $s6, $s0, LerVetor	# Se indice for menor que o valor escolhido pelo usuario, volta para LerVetores
        
        addi $s6, $zero, 0	# i = 0
        lw $a0, 0($sp)		# Carrega o tamanho do vetor de volta para $a0	
      
        subi $t3, $s0, 1	# Tamanho do vetor - 2, para ser usado no BubbleSort
        
       
# BubbleSort vai realizar a tarefa de arruamar os elementos no vetor
BubbleSort:	
	beq $s7, $s0, finalizar
	
	jal MulIndice		# 4*i
	add $s3, $t7, $a1	# Guarda em $s3 o End. Absoluto do Vetor_A [i]
	lw $s1, 0($s3)		# Guarda o Valor 1
		
	addi $s6, $s6, 1	# i = i + 1
	
	jal MulIndice		# 4*i
	add $s4, $t7, $a1	# Guarda em $s4 o End. Absoluto do Vetor_A [i+1]
	lw $s2, 0($s4)		# Guarda o Valor 2
	
	 
	
	bgt $s1, $s2, troca	# Se o valor 1 > valor 2, volta para o BubbleSort
	jal ntroca


# Fim da área para leitura dos vetores

# Calcular 4*i
MulIndice:
	mul $t7, $s6, 4		# Guarda no $s7 o valor do indice multiplicado por 4
	jr $ra			# Retorna para Calcular o endereço absoluto e guardar no vetor
# Fim calculo 4*i

troca:
	
	sw $s2, 0($s3)		# Guarda o valor do Vetor_A [i + 1] na posicao  Vetor_A [i] 
	sw $s1, 0($s4)		# Guarda o valor do Vetor_A [i] na posicao  Vetor_A [i + 1]
	

	blt $s6, $t3, BubbleSort# Enquanto i < tamanho - 1
	addi $s7, $s7, 1	# j = j + 1
	li $s6, 0
	blt $s7, $s0, BubbleSort# Enquanto j < tamanho
		
	j finalizar
			
	jr $ra			# Volta para a main apos o comando = " jal VoltarMain "
	
ntroca:
	

	blt $s6, $t3, BubbleSort# Enquanto i < tamanho - 1
	addi $s7, $s7, 1	# j = j + 1
	li $s6, 0
	blt $s7, $s0, BubbleSort# Enquanto j < tamanho
	
	j finalizar
	
finalizar:

	lw $s3, 16($sp)		# Carrega o tamanho do vetor em $s3
	lw $s2, 12($sp)		# Carrega o tamanho do vetor em $s2
	lw $s1, 8($sp)		# Carrega o tamanho do vetor em $s1
	lw $a0, 4($sp)		# Carrega o tamanho do vetor em $a0
	lw $ra, 0($sp)		# Carrega o endereco $ra (main) de volta em $ra
	addi $sp, $sp, 16	# Desforma a pilha 
	
	jr $ra
	
# Fim do BubbleSort

MostrarTela:			# Mostra o resultado do vetor na tela

	
	li $v0, 4 		# Carrega o servico 4 (Ponteiro para string)
        la $a0, contVet		# Carrega ptr p/ string (Mostra a mensagem na tela)
        syscall			# Chama o servico 4
	
        li $v0, 1 		# Carrega o servico 1 (inteiro)
        la $a0, ($s6) 		# Carrega no $a0 o valor inteiro do indice
        syscall 		# Chama o servico 1
        
        li $v0, 4 		# Carrega o servico 4 (Ponteiro para string)
        la $a0, contEnd		# Carrega ptr p/ string (Mostra a mensagem na tela)
        syscall 		# Chama o servico 4
        
        mul $t7, $s6, 4		# $t7 = 4*1
        add $t7, $a1, $t7 	# $t7 = endereco base + 4*i
        lw $s7, 0($t7) 		# $t2 receber o valor de A[i]
        
        li $v0, 1 		# Carrega o servico 1 (inteiro)
        la $a0, ($s7) 		# Carrega no $a0 o valor inteiro do indice
        syscall 		# Chama o servico 1
        
        addi $s6, $s6, 1       	# i = i + 1
	
	blt $s6, $s0, MostrarTela# Enquanto i < N de vetores
        
      	jr $ra			# Volta para Main
	
Main:	
	la $a1, Vetor_A		# Carrega no $a1 o endereço do Vetor_A
			
	jal TamanhoVetor	# Manda para leitura do tamanho do Vetor
	add $a0, $s0, $zero	# Guarda no $s0 o tamanho do vetor 
	
	jal VoltarMain		# Manda para a pilha que irá guaradar o $a0 e o $ra de retorno para proxima linha do main
	
	li $s6, 0		# i = 0
	jal MostrarTela		# Funcao para mostrar os vetores de forma ordenada na tela
	
Exit:

	nop			# NOP  - Sem mais operacoes, parada do programa
	
	
