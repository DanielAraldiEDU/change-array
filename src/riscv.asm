.data
	
	anunciado: .asciz "Entre com o tamanho dos vetores (máx. = 8 e mín. = 2): "
	tamanhoInvalido: .asciz "Valor inválido, digite novamente: "
	vetoresTrocados: .asciz "\nVetor A e B trocados:"
	
	quebraLinha: .asciz "\n"
	finalVetorMensagem: .asciz "] = "
	
	Vetor_A: .word 0, 0, 0, 0, 0, 0, 0, 0
	vetorAMensagem: .asciz "Vetor A["
	
	Vetor_B: .word 0, 0, 0, 0, 0, 0, 0, 0
	vetorBMensagem: .asciz "Vetor B["
	
	VetorAuxiliar: .word 0, 0, 0, 0, 0, 0, 0, 0
	
.text
	
	#imprime Entre com o tamanho dos vetores (máx. = 8 e mín. = 2): (possível mudança)
  addi a7, zero, 4
  la a0, anunciado 
  ecall
  
  #adicionando a t5 e t6 valores relacionados as condicionais (possível mudança)
  addi t5, zero, 2 
  addi t6, zero, 9
  
  # Verifica se o input é valido
  verificador:
	  addi a7, zero, 5
	  ecall
	  
	  add s11, zero, a0
	  
	  jal endDigitoInvalido
    
    digitoInvalido:
    	# imprime Valor inválido, digite novamente: (possível mudança)
    	addi a7, zero, 4
	    la a0, tamanhoInvalido
	    ecall
	    
	    jal verificador
    endDigitoInvalido:
    	# vai para digitoInvalido se o input for menor que 2 ou maior que 8.
  		blt s11, t5, digitoInvalido
	  	bge s11, t6, digitoInvalido
	  	
  endVerificador:
  
  la s1, Vetor_A # endereço base do Vetor_A
  la s6, VetorAuxiliar # endereço base do VetorAuxiliar
  
  add t0, zero, zero # i=0
  
  # Loop for para iterar nos indices do Vetor_A
  forA:
  	bge t0, s11, endForA # vai para o label endForA se i >= (valor inserido)
  		
  		# imprime Vetor A[ 
			addi a7, zero, 4
			la a0, vetorAMensagem
			ecall
			
			# imprime o indice
			addi a7, zero, 1
			add a0, zero, t0
			ecall 
			
			# imprime ] = 
			addi a7, zero, 4
			la a0, finalVetorMensagem
			ecall
			
			# Lê o input do usuário e armazena em s0
			addi a7, zero, 5
			ecall
			add s0, zero, a0
			
			# armazena no vetor_A e no VetorAuxiliar
			slli t1, t0, 2 #t1 = 4*i
			add s2, s1, t1 #s2 = base(s1) + deslocamento(t1)
			sw s0, 0(s2) 
			add s2, s6, t1 #s2 = base(s6) + deslocamento(t1)
			sw s0, 0(s2) 
				
			addi t0, t0, 1 # i++
			
			jal forA
  endForA:
  
  la s4, Vetor_B # endereço base do Vetor_B
  
  add t0, zero, zero # i=0
  
  # Loop for para iterar nos indices do Vetor_B
  forB:
  	bge t0, s11, endForB # vai para o label endForB se i >= (valor inserido)
  		# imprime Vetor B[ 
			addi a7, zero, 4
			la a0, vetorBMensagem
			ecall
			
			# imprime o indice
			addi a7, zero, 1
			add a0, zero, t0
			ecall 
			
			# imprime ] = 
			addi a7, zero, 4
			la a0, finalVetorMensagem
			ecall
			
			# Lê o input do usuário e armazena em s3
			addi a7, zero, 5
			ecall
			add s3, zero, a0
			
			# armazena no vetor_A e no Vetor_B
			slli t1, t0, 2 #t1 = 4*i
			add s5, s4, t1 #s5 = base(s4) + deslocamento(t1)
			sw s3, 0(s5) 
			add s5, s1, t1
			sw s3, 0(s5) # armazena no vetor_A o valor do Vetor_B
				
			addi t0, t0, 1 # i++
			
			jal forB
  endForB:
  
  add t0, zero, zero
  
  # Loop for fazer o swap VetorB = VetorAuxiliar
  forSwap:
  	bge t0, s11, endForSwap # vai para o label endForSwap se i >= (valor inserido)
			slli t1, t0, 2 #t1 = 4*i
			
			# salva o valor do VetorAuxiliar[i] em a0
			add s9, s6, t1 
			lw a0, 0(s9)
			
			# passa o valor de a0 para s3
			add s3, zero, a0
			
			# passa o valor de s3 para o Vetor_B[i]
			add s9, s4, t1
			sw s3, 0(s9)
				
			addi t0, t0, 1 # i++
			
			jal forSwap
  endForSwap:
  
  add t0, zero, zero # i=0
  
  # imprime texto
  addi a7, zero, 4
	la a0, vetoresTrocados
	ecall
	
	# imprime o Vetor_A
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
			add s8, s1, t1
			lw a0, 0(s8)
			
			addi a7, zero, 1
			ecall 
			
			addi t0, t0, 1
		
			jal showForA
	endShowForA:
	
	add t0, zero, zero # i=0
	
	# imprime o Vetor_B 
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
			add s8, s4, t1
			lw a0, 0(s8)
			
			addi a7, zero, 1
			ecall 
			
			addi t0, t0, 1
		
			jal showForB
	endShowForB:
	