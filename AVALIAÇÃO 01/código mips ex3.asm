#Disciplina: Arquitetura e Organização de Processadores
#Atividade: Avaliação 01 – Programação em Linguagem de Montagem
#Exercício 03
#Aluno: Nathalia Suzin e Felipe dos Santos
#include <iostream>
#using namespace std;
#int main() {
#    int i, vet[8];
#    for(i=0;i<8;i++){
#        cout << "Entre com A[" << i << "]: ";
#        cin >> vet[i];
#    }
#    for(i=0;i<8;i++)
#        cout << "\nA[" << i << "] = [" << vet[i] << "]";
#    return 0;
#}

               .data

contStr:       .asciiz "\nEntre com A["
contVet:       .asciiz "\nA["
contEnd:       .asciiz "]: "
vet:           .word	0,0,0,0,0,0,0,0

                .text

main:

        la $s1, vet 		# guarda no $s1 o endereco do vet
        addi $s2, $zero, 0 	# guarda no $s2 o valor 0 // para que o i nao receba qualquer valor que ja esteja guardado na memoria
        
        add $t1, $s2, $s2	# $t1 = $s2 + $s2 
        add $t1, $t1, $t1 	# $t1 = $t1 + $t1 // x2 
        add $t1, $t1, $s1 	# $t1 = $t1 + endereco // calcula endereco base
        
        lw $t2, 0($t1)		# carrega no $t2 o endereco base
        addi $s0, $zero, 0     	# $s0 receber o valor 0, para que nao retorne qualquer valor salvo na memoria e para que o loop comece em 0
	addi $sp, $sp, -32 	# Stack Point recebe aloca 8 words // cada word 4 bites, no mips o SP ele diminui sendo -4
loop1:
	
        li $v0, 4 		# carrega o servico 4 (Ponteiro para string)
        la $a0, contStr 	#  carrega ptr p/ string (Mostra a mensagem na tela)
        syscall			# Chama o servico 4
	
        li $v0, 1 		# carrega o servico 1 (inteiro)
        la $a0, ($s0) 		# carrega no $a0 o valor inteiro do $s0 (loop)
        syscall 		# Chama o servico 1
	addi $s0, $s0, 1 	# Salva no $s0, o valor do $s0 + 1
        addi $sp, $sp, 4
        
        li $v0, 4 		# carrega o servico 4 (Ponteiro para string)
        la $a0, contEnd		#  carrega ptr p/ string (Mostra a mensagem na tela)
        syscall 		# Chama o servico 4

        li $v0, 5 		# carrega o servico 5
        syscall 		# Chama o servico 5
        add $t2, $v0, $zero	# o que o usuario digitar sera adicionado ao t2
        sw $t2, 0($sp) 
        
        blt $s0,8, loop1	# Desvia se menor que 8, equanto $s0 (loop), for menor que 8, vai redirecionar para o loop1

reset:
	addi $s0, $zero, 0	# Funcao para resetar o $s0(loop)
	addi $sp, $sp, -32	# Funcao para resetar o Stack Point. 
	j loop2			# J = Jump, pula para o loop 2, para que seja feita o print dos resultados
        
        
loop2:
	
        li $v0, 4 		# carrega o servico 4 (Ponteiro para string)
        la $a0, contVet 	# carrega ptr p/ string (Mostra a mensagem na tela)
        syscall 		# Chama o servico 4
	
        li $v0, 1 		# carrega o servico 1 (inteiro)
        la $a0, ($s0) 		# carrega no $a0 o valor inteiro do $s0 (loop)
        syscall 		# Chama o servico 1
	addi $s0, $s0, 1	# Salva no $s0, o valor do $s0 + 1
        addi $sp, $sp, 4	# $sp = $sp + 4, toda vez que o loop acontece, ele adiciona +4 bites para que ele seja direcionado para a proxima posicao do SP
        
        li $v0, 4 		# carrega o servico 4 (Ponteiro para string)
        la $a0, contEnd 	# carrega ptr p/ string (Mostra a mensagem na tela)
        syscall 		# Chama o servico 4
        
        li $v0, 1		# carrega o servico 1 (inteiro)
        lw $t2, 0($sp)		# carrega na posicao $t2, o numero salvo no SP na posicao 0 (pois sua posicao ja foi calculada anteriormente)
        la $a0, ($t2)		# carrega ptr p/ string (Mostra a mensagem na tela)
        syscall			# Chama o servico 1
        
        
        blt $s0,8, loop2	# Desvia se menor que 8, equanto $s0 (loop), for menor que 8, vai redirecionar para o loop2
        
        j Exit			# Quando o loop chegar em 8, J = Jump, vai pular para o Exit.
        

Exit: 
	nop			# Null operation, ele ira terminar o codigo e nao fara mais nada!
