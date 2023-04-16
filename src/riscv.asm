# Disciplina: Arquitetura e Organizacao de Computadores
# Atividade: Avaliacao 01  Programacao em Linguagem de Montagem
# Programa 01
# Grupo: - Daniel Sansao Araldi
# - Rafael Mota Alves

.data
	
	anunciado: .asciz "Entre com o tamanho dos vetores (m�x. = 8 e m�n. = 2): "
	tamanhoInvalido: .asciz "Valor inv�lido, digite novamente: "
	vetoresTrocados: .asciz "\nVetor A e B trocados:"
	
	quebraLinha: .asciz "\n"
	finalVetorMensagem: .asciz "] = "
	
	Vetor_A: .word 0, 0, 0, 0, 0, 0, 0, 0
	vetorAMensagem: .asciz "Vetor A["
	
	Vetor_B: .word 0, 0, 0, 0, 0, 0, 0, 0
	vetorBMensagem: .asciz "Vetor B["
	
	VetorAuxiliar: .word 0, 0, 0, 0, 0, 0, 0, 0
	
.text
	
  # Imprime "Entre com o tamanho dos vetores (m�x. = 8 e m�n. = 2): ".
  addi a7, zero, 4
  la a0, anunciado 
  ecall
  
  # Adicionando a t5 e t6 valores relacionados as condicionais.
  addi t5, zero, 2 
  addi t6, zero, 9
  
  # Verifica e pergunta ao usu�rio sobre o d�gito que ele informou.
  verificador:
	  addi a7, zero, 5
	  ecall
	  
	  add s11, zero, a0
	  
	  jal endDigitoInvalido # Pula para a label endDigitoInvalido.
    
    digitoInvalido:
    	# Imprime "Valor inv�lido, digite novamente: ", caso o d�gito informado seja inv�lido.
    	addi a7, zero, 4
	    la a0, tamanhoInvalido
	    ecall
	    
	    jal verificador
    endDigitoInvalido:
    	# Pula para a label de digitoInvalido se o valor informado � menor que 2 ou maior e igual a 9.
  		blt s11, t5, digitoInvalido
	  	bge s11, t6, digitoInvalido
	  	
  endVerificador:
  
  la s1, Vetor_A # Endere�o base do Vetor_A.
  la s6, VetorAuxiliar # Endere�o base do VetorAuxiliar.
  
  add t0, zero, zero # i (t0) = 0
  
  # Loop for para iterar nos �ndices do Vetor_A.
  forA:
  	bge t0, s11, endForA # Vai para o label endForA se i >= valor de s11 informado no bloco verificador
  		
  		# Imprime "Vetor A["
			addi a7, zero, 4
			la a0, vetorAMensagem
			ecall
			
			# Imprime o �ndice.
			addi a7, zero, 1
			add a0, zero, t0
			ecall 
			
			# Imprime "] = ".
			addi a7, zero, 4
			la a0, finalVetorMensagem
			ecall
			
			# L� o valor inserido pelo usu�rio e armazena em s0.
			addi a7, zero, 5
			ecall
			add s0, zero, a0
			
			# Armazena no Vetor_A e no VetorAuxiliar.
			slli t1, t0, 2 # t1 = 4 * i.
			add s2, s1, t1 # s2 = base(s1) + deslocamento(t1).
			sw s0, 0(s2) 
			add s2, s6, t1 # s2 = base(s6) + deslocamento(t1).
			sw s0, 0(s2) 
				
			addi t0, t0, 1 # i++
			
			jal forA
  endForA:
  
  la s4, Vetor_B # Endere�o base do Vetor_B.
  
  add t0, zero, zero # i = 0
  
  # Loop for para iterar nos �ndices do Vetor_B.
  forB:
  	bge t0, s11, endForB # Vai para o label endForB se i >= valor de s11 informado no bloco verificador
  		# Imprime "Vetor B[".
			addi a7, zero, 4
			la a0, vetorBMensagem
			ecall
			
			# Imprime o �ndice.
			addi a7, zero, 1
			add a0, zero, t0
			ecall 
			
			# Imprime "] = ".
			addi a7, zero, 4
			la a0, finalVetorMensagem
			ecall
			
			# L� o valor inserido pelo usu�rio e armazena em s3.
			addi a7, zero, 5
			ecall
			add s3, zero, a0
			
			# Armazena no vetor_A e no Vetor_B.
			slli t1, t0, 2 # t1 = 4 * i
			add s2, s4, t1 # s2 = base(s4) + deslocamento(t1).
			sw s3, 0(s2) 
			add s2, s1, t1
			sw s3, 0(s2) # Armazena no vetor_A o valor do Vetor_B.
				
			addi t0, t0, 1 # i++
			
			jal forB
  endForB:
  
  add t0, zero, zero
  
  # Loop for fazer o troca dos valores do Vetor_B para VetorAuxiliar (Vetor_B = VetorAuxiliar).
  forSwap:
  	bge t0, s11, endForSwap # Vai para o label endForSwap se i >= valor de s11 informado no bloco verificador
			slli t1, t0, 2 # t1 = 4 * i
			
			# Salva o valor do VetorAuxiliar[i] em a0.
			add s2, s6, t1 
			lw a0, 0(s2)
			
			# Passa o valor de a0 para s3.
			add s3, zero, a0
			
			# Passa o valor de s3 para o Vetor_B[i].
			add s2, s4, t1
			sw s3, 0(s2)
				
			addi t0, t0, 1 # i++
			
			jal forSwap
  endForSwap:
  
  add t0, zero, zero # i = 0
  
  # Imprime o texto de "\nVetor A e B trocados:".
  addi a7, zero, 4
	la a0, vetoresTrocados
	ecall
	
	# Imprime os valores do respectivos �ndices do Vetor_A.
	showForA: 
		bge t0, s11, endShowForA
			addi a7, zero, 4
			la a0, quebraLinha
			ecall
			
			addi a7, zero, 4
			la a0, vetorAMensagem
			ecall
			
			addi a7, zero, 1
			add a0, zero, t0
			ecall 
			
			addi a7, zero, 4
			la a0, finalVetorMensagem
			ecall
			
			slli t1, t0, 2
			add s2, s1, t1
			lw a0, 0(s2) # Mostra o valor do �ndice do Vetor_A.
			
			addi a7, zero, 1
			ecall 
			
			addi t0, t0, 1
		
			jal showForA
	endShowForA:
	
	add t0, zero, zero # i=0
	
	# Imprime os valores dos respectivos �ndices do Vetor_B.
	showForB: 
		bge t0, s11, endShowForB
			addi a7, zero, 4
			la a0, quebraLinha
			ecall
			
			addi a7, zero, 4
			la a0, vetorBMensagem
			ecall
			
			addi a7, zero, 1
			add a0, zero, t0
			ecall 
			
			addi a7, zero, 4
			la a0, finalVetorMensagem
			ecall
			
			slli t1, t0, 2
			add s2, s4, t1
			lw a0, 0(s2) # Mostra o valor do �ndice do Vetor_B.
			
			addi a7, zero, 1
			ecall 
			
			addi t0, t0, 1
		
			jal showForB
	endShowForB:
	