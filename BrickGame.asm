jmp main

;---- Declaração das variáveis do jogo ----

posBola: var #1
posBarra: var #1
posBlocos1: var #8
posBlocos2: var #8
posBlocos3: var #8
charBarra: var #1
charBola: var #1
charBloco: var #1
tamBloco: var #1
incBola: var #1
incBolaNegativo: var #1

;---- Inicio do Programa Principal -----

main:
  call InicializaVariaveis
  call ImprimeTela
  loadn r0, #0 ; contador para os mods
  loadn r2, #0 ; para verificar o resultado do módulo
  jmp Loop

InicializaVariaveis:
  push r0

  loadn r0, #'_'
  store charBarra, r0		

  loadn r0, #'='
  store charBloco, r0

  loadn r0, #'*'
  store charBola, r0

  loadn r0, #5
  store tamBloco, r0

  loadn r0, #1140	; posicao inicial da barra
  store posBarra, r0

  loadn r0, #1100 ; posicao inicial da bola
  store posBola, r0

  loadn r0, #41   ; incremento inicial da bola
  store incBola, r0

  loadn r0, #1    ; o numero do incBola é negativo
  store incBolaNegativo, r0
  
;---- escrevendo no primeiro vetor ----
  ;--------posicao do primeiro char de cada barra. (comprimento de 5 chars por barra) 
  loadn r0, #80
  loadn r1, #posBlocos1
  storei r1, r0 
  
  loadn r0, #90
  inc r1
  storei r1, r0
  
  loadn r0, #100
  inc r1
  storei r1, r0
  
  loadn r0, #110
  inc r1
  storei r1, r0
  ;--------#posicao
  ;--------validade
  loadn r0, #1
  inc r1
  storei r1, r0
  inc r1
  storei r1, r0
  inc r1
  storei r1, r0
  inc r1
  storei r1, r0
  ;--------validade
  
;---- escrevendo no segundo vetor ----
  ;--------#posicao
  loadn r0, #125
  loadn r1, #posBlocos2
  storei r1, r0
  
  loadn r0, #135
  inc r1
  storei r1, r0
  
  loadn r0, #145
  inc r1
  storei r1, r0
  
  loadn r0, #155
  inc r1
  storei r1, r0
  ;--------#posicao
  ;--------validade
  loadn r0, #1
  inc r1
  storei r1, r0
  inc r1
  storei r1, r0
  inc r1
  storei r1, r0
  inc r1
  storei r1, r0
  ;--------validade
  
;---- escrevendo no terceiro vetor ----
  ;--------#posicao
  loadn r0, #160
  loadn r1, #posBlocos3
  storei r1, r0
  
  loadn r0, #170
  inc r1
  storei r1, r0
  
  loadn r0, #180
  inc r1
  storei r1, r0
  
  loadn r0, #190
  inc r1
  storei r1, r0
  ;--------#posicao
  ;--------validade
  loadn r0, #1
  inc r1
  storei r1, r0
  inc r1
  storei r1, r0
  inc r1
  storei r1, r0
  inc r1
  storei r1, r0
  ;--------validade
  
  pop r0
  rts

ImprimeTela:
  call ImprimeBarra
  call ImprimeBlocos
  call ImprimeBola
  rts

ImprimeBarra:
  push r0
  push r1
  push r2

  load r0, posBarra
  load r1, charBarra
  outchar r1, r0

  mov r2, r0      ;
  inc r2          ; aumenta a barra à direita
  outchar r1, r2  ;

  mov r2, r0      ;
  dec r2          ; aumenta a barra à esquerda
  outchar r1, r2  ;

  pop r2
  pop r1
  pop r0
  
  rts

ImprimeBlocos:
  push r0
  
  ;imprime blocos do primeiro vetor
  loadn r0, #posBlocos1
  
  loadi r7 ,r0 
  call ImprimeBlocoLoop ; imprime primeiro bloco
  
  inc r0
  loadi r7, r0
  call ImprimeBlocoLoop ; imprime segundo bloco
  
  inc r0
  loadi r7, r0
  call ImprimeBlocoLoop ; imprime terceiro bloco
  
  inc r0
  loadi r7, r0
  call ImprimeBlocoLoop ; imprime quarto bloco
  ;---------------------------------------------
  
  ;imprime blocos do segundo vetor
  loadn r0, #posBlocos2
  
  loadi r7 ,r0 
  call ImprimeBlocoLoop ; imprime primeiro bloco
  
  inc r0
  loadi r7, r0
  call ImprimeBlocoLoop ; imprime segundo bloco
  
  inc r0
  loadi r7, r0
  call ImprimeBlocoLoop ; imprime terceiro bloco
  
  inc r0
  loadi r7, r0
  call ImprimeBlocoLoop ; imprime quarto bloco
  
  ;---------------------------------------------
  
  ;imprime blocos do terceiro vetor
  loadn r0, #posBlocos3
  
  loadi r7 ,r0 
  call ImprimeBlocoLoop ; imprime primeiro bloco
  
  inc r0
  loadi r7, r0
  call ImprimeBlocoLoop ; imprime segundo bloco
  
  inc r0
  loadi r7, r0
  call ImprimeBlocoLoop ; imprime terceiro bloco
  
  inc r0
  loadi r7, r0
  call ImprimeBlocoLoop ; imprime quarto bloco
  
  pop r0
  rts

ImprimeBlocoLoop: ; r7 = posicao inicial de print
  push r0
  
  load r0, charBloco
  outchar r0, r7
  inc r7
  outchar r0, r7
  inc r7
  outchar r0, r7
  inc r7
  outchar r0, r7
  inc r7
  outchar r0, r7
  
  pop r0
  
  rts

ImprimeBola:
  push r0
  push r1

  load r0, charBola
  load r1, posBola
  outchar r0, r1

  pop r1
  pop r0

  rts

Loop:
  call MoveBarra  ; maior velocidade do jogo

  loadn r1, #2
  mod r1, r0, r1
  cmp r1, r2      ; verifica se o resultado do mod deu zero
  ceq MoveBola ; chama rotina de movimentacao da bolinha

  call Delay
  inc r0          ; incrementa o contador
  jmp Loop

MoveBarra:
  push r1
  push r2

  inchar r1                     ; le teclado para controlar a barra
  loadn r2, #'a'
  cmp r1, r2
  ceq MoveBarra_RecalculaPos_A  ;chama funcao para mover para a direita se apertar A

  loadn r2, #'d'
  cmp r1, r2
  ceq MoveBarra_RecalculaPos_D  ;chama funcao para mover para a esquerda se apertar D

  pop r2
  pop r1

  rts

MoveBarra_RecalculaPos_A:
  push r0 ; barra
  push r1 ; barra - 1
  push r2 ; barra + 1
  push r3 ; char '_'
  push r4 ; char ' '
  push r5 ; posição limite
  
  load r0, posBarra
  loadn r5, #1121
  cmp r0, r5
  jeq Retorna
  
  mov r1, r0
  inc r1
  
  mov r2, r0
  dec r2
  
  load r3, charBarra
  loadn r4, #' '

  ; limpa a posição anterior da barra
  outchar r4, r0
  outchar r4, r1
  outchar r4, r2
  ; decrementa a posição da barra (move para esquerda)
  dec r0  
  dec r1  
  dec r2  
  ; imprime a nova posição
  outchar r3, r0
  outchar r3, r1
  outchar r3, r2
  
  store posBarra, r0 ; armazena a nova posição na memória

Retorna:
  pop r5
  pop r4
  pop r3
  pop r2
  pop r1
  pop r0
  rts

MoveBarra_RecalculaPos_D:
  push r0 ; barra
  push r1 ; barra + 1
  push r2 ; barra - 1
  push r3 ; char '_'
  push r4 ; char ' '
  push r5 ; posição limite

  load r0, posBarra
  loadn r5, #1158
  cmp r0, r5
  jeq Retorna
  
  mov r1, r0
  inc r1
  
  mov r2, r0
  dec r2
  
  load r3, charBarra
  loadn r4, #' '

  ; limpa a posição anterior da barra
  outchar r4, r0
  outchar r4, r1
  outchar r4, r2
  ; incrementa a posição da barra (move para esquerda)
  inc r0  
  inc r1  
  inc r2  
  ; imprime a nova posição
  outchar r3, r0
  outchar r3, r1
  outchar r3, r2
  
  store posBarra, r0 ; armazena a nova posição na memória

  Retorna:
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

MoveBola:
  push r0
  push r1
  push r2
  push r3
  push r4

  loadn r0, #' '    ;
  load r1, posBola  ; Apaga a posição atual da bola
  outchar r0, r1    ;

  load r0, charBola         ;
  load r2, incBola          ; obtém o valor de incremento da bola
  load r3, incBolaNegativo  ;

  loadn r4, #1    ;
  cmp r3, r4      ; verifica se o incremento é negativo
  jeq Negativo    ;
  add r1, r1, r2  ; se não for, adiciona o incremento da posição atual
  jmp Pula        ; e pula a instrução de sub
  Negativo:
    sub r1, r1, r2  ; se for, subtrai o incremento da posição atual
  Pula:
    outchar r0, r1  ; escreve a nova posição da bola

    store posBola, r1 ; armazena a nova posição na memória

    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

Delay:
  push r0
  push r1

  loadn r1, #200

  Delay_volta2:
    loadn r0, #3000

  Delay_volta: 
    dec r0
    jnz Delay_volta	
    dec r1
    jnz Delay_volta2

  pop r1
  pop r0

  rts	
