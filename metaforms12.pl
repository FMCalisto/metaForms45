%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%         SUGESTAO DE IMPLEMENTACAO DO PROJECTO 2011-12
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%---------------------------------------------------------------------
%
%                             Pista Basica
%
%---------------------------------------------------------------------

%---------------------------------------------------------------------
% Predicado que indica explicitamente onde colocar a peca na lista. 
% Cada posicao na lista corresponde a uma casa no tabuleiro. 
% Nesta implementacao a insercao e feita explicitamente na lista.
%---------------------------------------------------------------------

coloca(A, top, left, [A,_,_,_,_,_,_,_,_]).
coloca(A, top, middle, [_,A,_,_,_,_,_,_,_]).
coloca(A, top, right, [_,_,A,_,_,_,_,_,_]).
coloca(A, center, left, [_,_,_,A,_,_,_,_,_]).
coloca(A, center, middle, [_,_,_,_,A,_,_,_,_]).
coloca(A, center, right, [_,_,_,_,_,A,_,_,_]).
coloca(A, bottom, left, [_,_,_,_,_,_,A,_,_]).
coloca(A, bottom, middle, [_,_,_,_,_,_,_,A,_]).
coloca(A, bottom, right, [_,_,_,_,_,_,_,_,A]).

%---------------------------------------------------------------------
%
%                            Pistas Intermedias
%
%---------------------------------------------------------------------

%---------------------------------------------------------------------
% A implementacao dos predicados seguintes e feita recorrendo ao predicado
% coloca. Apenas ha que ter em conta a informacao sobre a linha ou
% a coluna em causa (ou ambas) e acrescentar os casos implicitos. Por exemplo,
% no caso seguinte, do rectangulo vertical, ha ainda que considerar o caso do
% middle.
%---------------------------------------------------------------------

rectanguloVertical(A, Linha, Coluna, Tabuleiro) :- 
     (coloca(A, Linha, Coluna, Tabuleiro); 
      coloca(A, Linha, middle, Tabuleiro)).

rectanguloHorizontal(A, Linha, Coluna, Tabuleiro) :- 
     (coloca(A, Linha, Coluna, Tabuleiro); 
      coloca(A, center, Coluna, Tabuleiro)).

linhaTriplaVertical(A, Linha, Tabuleiro) :-
     coloca(A, Linha, _, Tabuleiro).

linhaTriplaHorizontal(A, Coluna, Tabuleiro) :-
     coloca(A, _, Coluna, Tabuleiro).

quadrado(A, Linha, Coluna, Tabuleiro) :- 
     (coloca(A, Linha, Coluna, Tabuleiro); 
      coloca(A, Linha, middle, Tabuleiro); 
      coloca(A, center, Coluna, Tabuleiro); 
      coloca(A, center, middle, Tabuleiro)).

linhaDuplaVertical(A, Linha, Tabuleiro) :-
    coloca(A, Linha, _, Tabuleiro); 
    coloca(A, center, _, Tabuleiro).

linhaDuplaHorizontal(A, Coluna, Tabuleiro) :-
    coloca(A, _, Coluna, Tabuleiro); 
    coloca(A, _, middle, Tabuleiro).
    
%---------------------------------------------------------------------
%
%                         Pistas Avancadas 
%
%---------------------------------------------------------------------

%---------------------------------------------------------------------
%
% Estas pistas indicam onde nao se pode por as pecas.
% Sao divididas em dois grupos, com tratamentos 
% distintos (Parte 1 e Parte 2), ilustrando duas hipoteses de 
% abordagens diferentes
%
%---------------------------------------------------------------------

%---------------------------------------------------------------------
%
%                               Parte 1
% Sendo dadas as posicoes onde a peca nao pode ocorrer na matriz, 
% descobre-se o conjunto complementar, ou seja, onde podem ocorrer, 
% com base na pista em causa.
%
%---------------------------------------------------------------------

%---------------------------------------------------------------------
% Implementacao das pistas negativas da Parte 1, com base nos elementos
% auxiliares implementados de seguida.
%---------------------------------------------------------------------

matrizNeg(Peca, ListaNeg, Tabuleiro) :- 
        trataNeg('matriz', Peca, ListaNeg, Tabuleiro).

linhaTriplaVerticalNeg(Peca, ListaNeg, Tabuleiro) :- 
        trataNeg('linhaTriplaVertical', Peca, ListaNeg, Tabuleiro).

linhaTriplaHorizontalNeg(Peca, ListaNeg, Tabuleiro) :- 
        trataNeg('linhaTriplaHorizontal', Peca, ListaNeg, Tabuleiro).

linhaDuplaVerticalNeg(Peca, ListaNeg, Tabuleiro) :- 
        trataNeg('linhaDuplaVertical', Peca, ListaNeg, Tabuleiro).

linhaDuplaHorizontalNeg(Peca, ListaNeg, Tabuleiro) :- 
        trataNeg('linhaDuplaHorizontal', Peca, ListaNeg, Tabuleiro).

%---------------------------------------------------------------------
% Predicado auxiliar generico:
% Dada uma pista negativa (pistaNeg), descobre-se quais sao todas as 
% hipoteses de posicoes (ListaTotal) com base no predicado posicoes/2. 
% Depois retira-se da ListaTotal (meuremove/3) a lista das posicoes onde 
% a peca (Peca) nao pode ficar e calcula-se a ListaPos.
% Depois tenta-se colocar a peca numa posicao de ListaPos (colocaPos/4).
%---------------------------------------------------------------------

trataNeg(PistaNeg, Peca, ListaNeg, Tabuleiro) :-
      posicoes(PistaNeg, ListaTotal),
      meuremove(ListaNeg, ListaTotal, ListaPos), 
      colocaPos(PistaNeg, Peca, ListaPos, Tabuleiro).

%---------------------------------------------------------------------
% Predicados auxiliares cujos argumentos sao as posicoes posiveis dadas 
% em cada uma das pistas intermedias. De notar que para a matriz e uma lista
% de pares, ao contrario das outras.
%---------------------------------------------------------------------

posicoes('matriz', [(top, left), (top, middle), (top, right), (center, left), 
                    (center, middle), (center, right), (bottom, left), 
                    (bottom, middle), (bottom, right)]).
posicoes('linhaTriplaVertical', [top, center, bottom]).
posicoes('linhaTriplaHorizontal', [left, middle, right]).
posicoes('linhaDuplaVertical', [top, bottom]).
posicoes('linhaDuplaHorizontal', [left, right]).

%---------------------------------------------------------------------
% Predicado auxiliar que permite remover os elementos de Lista1 da 
% lista [Head|Resto]; Lista2 sera a lista resultante
%---------------------------------------------------------------------

meuremove(_, [], []).
meuremove(Lista1, [Cabeca|Resto], Lista2) :- member(Cabeca, Lista1), !, 
                                             meuremove(Lista1, Resto, Lista2).
meuremove(Lista1, [Cabeca|Resto], [Cabeca|Lista2]) :- meuremove(Lista1, Resto, Lista2).


%---------------------------------------------------------------------
% Predicado auxiliar que indica onde podem ser colocadas as peças, 
% de acordo com o tipo de tabuleiro
%---------------------------------------------------------------------

colocaPos(_, _, [], _).

% Caso da matriz que fica uma lista de pares indicando cada um onde se 
% pode colocar a peca

colocaPos(TipoTabuleiro, Peca, [(Linha, Coluna)|Resto], Tabuleiro) :- !,
   (coloca(Peca, Linha, Coluna, Tabuleiro); 
    colocaPos(TipoTabuleiro, Peca, Resto, Tabuleiro)).

% Para os outros casos

colocaPos(TipoTabuleiro, Peca, [Cabeca|Resto], Tabuleiro) :-
   (colocaDeAcordoComTipoTabuleiro(TipoTabuleiro, Peca, Cabeca, Tabuleiro); 
    colocaPos(TipoTabuleiro, Peca, Resto, Tabuleiro)).


%---------------------------------------------------------------------
% Predicado auxiliar que permite colocar no tabuleiro as pecas de acordo 
% com o tipo de pista (parcial) em jogo.
%---------------------------------------------------------------------

colocaDeAcordoComTipoTabuleiro('linhaTriplaVertical', Peca, Linha, Tabuleiro) :- 
              linhaTriplaVertical(Peca, Linha, Tabuleiro).

colocaDeAcordoComTipoTabuleiro('linhaTriplaHorizontal', Peca, Coluna, Tabuleiro) :- 
              linhaTriplaHorizontal(Peca, Coluna, Tabuleiro).

% As linhas duplas negativas definem-se em funcao das triplas, 
% ou da casas a mais

colocaDeAcordoComTipoTabuleiro('linhaDuplaVertical', Peca, Linha, Tabuleiro) :- 
              linhaTriplaVertical(Peca, Linha, Tabuleiro).

colocaDeAcordoComTipoTabuleiro('linhaDuplaHorizontal', Peca, Coluna, Tabuleiro) :- 
              linhaTriplaHorizontal(Peca, Coluna, Tabuleiro).

%---------------------------------------------------------------------
%
%                               Parte 2
%
% Modo alternativo de resolver o problema: expandir a lista negada em funcao
% do tipo de pista com objectivo de perceber todas as posicoes negadas em
% causa (obter a matrizNeg). Depois aplicar o processo ja implementado para
% a pista matrizNeg.
%---------------------------------------------------------------------

rectanguloVerticalNeg(Peca, ListaNeg, Tabuleiro) :- 
            expandeListaNegada('rectanguloVertical', ListaNeg, [], ListaNegExp),
            matrizNeg(Peca, ListaNegExp, Tabuleiro).

rectanguloHorizontalNeg(Peca, ListaNeg, Tabuleiro) :- 
            expandeListaNegada('rectanguloHorizontal', ListaNeg, [], ListaNegExp),
            matrizNeg(Peca, ListaNegExp, Tabuleiro).

quadradoNeg(Peca, ListaNeg, Tabuleiro) :- 
            expandeListaNegada('quadrado', ListaNeg, [], ListaNegExp),
            matrizNeg(Peca, ListaNegExp, Tabuleiro).

%---------------------------------------------------------------------
% Predicados auxiliares que indicam como expandir a lista negada associada
% a alguns predicados negativos
%---------------------------------------------------------------------

expandeListaNegada(_, [], L, L).

expandeListaNegada('rectanguloVertical', [(Linha, Coluna)|R], LAux, LFinal) :- 
      expandeListaNegada('rectanguloVertical', R, 
      [(Linha, Coluna), (Linha, middle)|LAux], LFinal).

expandeListaNegada('rectanguloHorizontal', [(Linha, Coluna)|R], LAux, LFinal) :- 
      expandeListaNegada('rectanguloHorizontal', R, 
      [(Linha, Coluna), (center, Coluna)|LAux], LFinal).


expandeListaNegada('quadrado', [(Linha, Coluna)|R], LAux, LFinal) :- 
      expandeListaNegada('quadrado', R, 
      [(Linha, Coluna), (Linha, middle), (center, Coluna), (center, middle)|LAux], LFinal).