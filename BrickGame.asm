jmp main

;---- Declaração das variáveis do jogo ----

posBola: var #4  ; !!!confirmar se pode ser 1 byte!!!
posBarra: var #4
charBarra: var #1
charBolinha: var #1

;---- Inicio do Programa Principal -----

main:
  call InicializaVariaveis
  call ImprimeTela
  loadn r0, #0 ; contador para os mods
  loadn r2, #0 ; para verificar o resultado do módulo
  jmp Loop

InicializaVariaveis:
  push r0
  push r1

  loadn r0, #'_'
  store charBarra	, r0		

  loadn r1, #1180	; posicao inicial barra
  store posBarra, r1

  pop r1
  pop r0
  rts

ImprimeTela:
  call ImprimeBarra
  call ImprimeBlocos
  call ImprimeBolinha
  rts

ImprimeBarra:
  push r0
  push r1

  load r0, posBarra
  load r1, charBarra

  outchar r1, r0

  pop r1
  pop r0

  rts

ImprimeBlocos:


ImprimeBolinha:


Loop:
  call MoveBarra  ; maior velocidade do jogo

  loadn r1, #2
  mod r1, r0, r1
  cmp r1, r2      ; verifica se o resultado do mod deu zero
  ceq MoveBolinha ; chama rotina de movimentacao da bolinha

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

MoveBolinha:


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
