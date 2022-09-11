#Disciplina: Arquitetura e Organiza��o de Processadores
#Atividade: Avalia��o 01 � Programa��o em Linguagem de Montagem
#Exerc�cio 01
#Aluno: Nathalia Suzin
#Em C++:
#include <iostream>
#using namespace std;
#int main(){
#    int x, y, soma;
#	cout << "\nEntre com o valor de x: ";
#	cin >> x;
#	cout << "\nEntre com o valor de y: ";
#	cin >> y;
#	soma = x + y;
#	cout << "\nA soma de x e y � igual a: " << soma;
#   return 0;
#}

	.data	# segmento de dados
	
str1:	.asciiz "\nEntre com o valor de x: "	#asciiz = aloca espa�o para guardar string
str2:	.asciiz "\nEntre com o valor de y: "
str3:	.asciiz "\nA soma de x e y � igual a: "

	.text   # segmento de c�digo

main:   
	li $v0, 4	# $v0 indica o c�digo de chamada // 4 = print_string
	la $a0, str1	 
	syscall		# mostra a mensagem em str1 // $a0 = argumento

	li $v0, 5	# $v0 indica o c�digo de chamada // 5 = read_int            
	syscall         # litura do valor
	add $s1, $v0, $zero	#salva o valor de $v0 em $s1 (� somado com zero para n�o dar diverg�ncia no valor)
	
	li $v0, 4
	la $a0, str2	
	syscall		# mostra a mensagem em str2
	
	li $v0, 5
	syscall
	add $s2, $v0, $zero
	
	add $s0, $s1, $s2	# executa a soma dos valores de $s1 e $s2 e salva o resultado em $s0
	
	li $v0, 4
	la $a0, str3
	syscall		# mostra mensagem em str3
	
	li $v0, 1	# $v0 chama o c�digo // 1 = print_int
	add $a0, $s0, $zero	# adiciona no argumento $a0 o resultado salvo em $s0 somado com $zero para n�o dar diverg�ncia no valor
	syscall		# mostra resultado da soma dos valores de $s1 e $s2

#poderia ser feito tamb�m:
#	li $v0, 4
#	la $a0, str3
#	syscall
#	
#	li $v0, 1
#	add $a0, $s1, $s2	# a adi��o � feita anteriormente a chamada do syscall, executando uma instru��o a menos
#	syscall
	
	
