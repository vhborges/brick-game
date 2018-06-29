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

;---- escrevendo o primeiro vetor ----

  loadn r0, #80
  store posBlocos1, r0

  loadn r0, #90
  store posBlocos1 + 1, r0

  loadn r0, #100
  store posBlocos1 + 2, r0

  loadn r0, #110
  store posBlocos1 + 3, r0

  load r0, #1
  store posBlocos1 + 4, r0
  store posBlocos1 + 5, r0
  store posBlocos1 + 6, r0
  store posBlocos1 + 7, r0

;---- escrevendo o segundo vetor ----

  loadn r0, #125
  store posBlocos2, r0

  loadn r0, #135
  store posBlocos2 + 1, r0

  loadn r0, #145
  store posBlocos2 + 2, r0

  loadn r0, #155
  store posBlocos2 + 3, r0

  load r0, #1
  store posBlocos2 + 4, r0
  store posBlocos2 + 5, r0
  store posBlocos2 + 6, r0
  store posBlocos2 + 7, r0

;---- escrevendo o terceiro vetor ----

  loadn r0, #160
  store posBlocos3, r0

  loadn r0, #170
  store posBlocos3 + 1, r0

  loadn r0, #180
  store posBlocos3 + 2, r0

  loadn r0, #190
  store posBlocos3 + 3, r0

  load r0, #1
  store posBlocos3 + 4, r0
  store posBlocos3 + 5, r0
  store posBlocos3 + 6, r0
  store posBlocos3 + 7, r0

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
;---- imprimindo o primeiro vetor ----
  push r0
  push r1
  push r2

  load r0, posBlocos1 ; primeira posição do primeiro bloco
  
  load r1, posBlocos1 + 4 ; validade do bloco

  load r2, #1

  cmp r1, r2
  jeq 

ImprimeBola:


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
  inchar r1                     ; le Teclado para controlar a barra
  loadn r2, #'a'
  cmp r1, r2
  jeq MoveBarra_RecalculaPos_A  ;chama funcao para mover para a direita se apertar A

  loadn r2, #'d'
  cmp r1, r2
  jeq MoveBarra_RecalculaPos_D  ;chama funcao para mover para a esquerda se apertar D

  rts

MoveBarra_RecalculaPos_A:
  push r0
  push r1
  push r2

  load r0, posBarra
  load r1, charBarra
  loadn r2, #' '

  outchar r2, r0     ; limpa a posição anterior da barra
  dec r0             ; decrementa a posição da barra (move para esquerda)
  outchar r1, r0     ; imprime a nova posição
  store posBarra, r0 ; armazena a nova posição na memória

  pop r2
  pop r1
  pop r0

  rts

MoveBarra_RecalculaPos_D:
  push r0
  push r1
  push r2

  load r0, posBarra
  load r1, charBarra
  loadn r2, #' '

  outchar r2, r0      ; limpa a posição anterior da barra
  inc r0              ; incrementa a posição da barra (move para direita)
  outchar r1, r0      ; imprime a nova posição
  store posBarra, r0  ; armazena a nova posição na memória

  pop r2
  pop r1
  pop r0

  rts

MoveBola:


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
