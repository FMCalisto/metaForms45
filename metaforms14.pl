%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%       LP 2013/2014
%
%
%       GRUPO NUM: 45
%
%
%       ALUNOS:
%
%       Alexandre Martins Braga Gordo
%       76442
%
%       Francisco Maria Calisto
%       70916
%
%       Luis Carlos de Campos Freitas
%       75983
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-[metaforms12].


% ---------------------------------------------------------------------------------------------------
%
%                            As Pecas
%
% ---------------------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------------------
%
%   Representacao de todas as pecas permitidas neste tabuleiro atraves
%   do functor peca, de ariedade 2. As constantes triangulo, circulo e quadrado
%   representam as formas e as constantes azul, amarelo e vermelho as cores,
%   totalizando 9 pecas possiveis.
%
%
%   peca(forma, cor).
%
%
%   Forma:
%
%       -triangulo;
%       - circulo;
%       - quadrado;
%
%
%   Cor:
%
%       - azul;
%       - amarelo;
%       - vermelho;
%
% ---------------------------------------------------------------------------------------------------

peca(triangulo, azul).
peca(triangulo, amarelo).
peca(triangulo, vermelho).
peca(circulo, azul).
peca(circulo, amarelo).
peca(circulo, vermelho).
peca(quadrado, azul).
peca(quadrado, amarelo).
peca(quadrado, vermelho).


% ---------------------------------------------------------------------------------------------------
%
%                            Pistas Intermedias
%
% ---------------------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------------------
%
%   A implementacao dos predicados que compoem pistas intermedias e feita
%   recorrendo aos predicados importados do ficheiro metaforms12 explicitamente
%   os predicados rectaguloVertical, rectanguloHorizontal e quadrado tendo em conta
%   o predicado coloca implicito nos tres anteriores para assim chegarmos a forma
%   mais reduzida da pista.
%
%   Deste modo, para cada predicado temos em conta a posicao na linha e coluna
%   da variavel Peca.
%
%   - rectanguloVertical: com duas combinacoes possiveis, numa primeira fase recebe uma Peca,
%   uma Linha, uma Coluna convertida atraves do procedimento converte e devolve a posicao
%   no Tabuleiro. Numa segunda fase salta uma casa para a direita atribuindo o valor X+1 a Y
%   alterando assim a Linha e a Coluna final. Aqui sao utilizados os procedimentos converte
%   e coloca como auxiliares.
%
%   - rectanguloHorizontal: com duas combinacoes possiveis, novamente numa primeira fase
%   recebe uma Peca, uma Linha, uma Coluna convertida devolvendo o Tabuleiro. Numa segunda
%   fase salta uma casa para baixo, ou seja, tres casa para a direita atribuindo o valor
%   de X+3 a Y com a alteracao da Linha e da Coluna finais. Os mesmos procedimentos auxiliares
%   sao utilizados.
%
%   - quadrado: a implementacao gera quatro combinacoes para obter a Pista mas tendo em conta
%   que ha sempre a Linha do meio, considerando o Tabuleiro completo 3x3, que tem valores em
%   comum apesar das diferentes combinacoes possiveis. Desta forma temos que converter as
%   Linhas e as Colunas e colocar estas ultimas no Tabuleiro. Numa segunda fase atribuir ao valor
%   Y a contagem da posicao em cause, tendo os casos possiveis de: X+1; X+3; X+4; colocando nas
%   Linhas e Colunas finais do Tabuleiro.
%
% ---------------------------------------------------------------------------------------------------

trioLeft(Peca, Linha, Coluna, Tabuleiro) :- rectanguloVertical(Peca, Linha, Coluna, Tabuleiro).

trioRight(Peca, Linha, Coluna, Tabuleiro):- rectanguloVertical(Peca, Linha, Coluna, Tabuleiro).

cobra(Peca, Linha, Coluna, Tabuleiro) :- rectanguloVertical(Peca, Linha, Coluna, Tabuleiro).

tLeft(Peca, Linha, Coluna, Tabuleiro) :- rectanguloVertical(Peca, Linha, Coluna, Tabuleiro).

tRight(Peca, Linha, Coluna, Tabuleiro) :- rectanguloVertical(Peca, Linha, Coluna, Tabuleiro).

tSimples(Peca, Linha, Coluna, Tabuleiro) :- rectanguloHorizontal(Peca, Linha, Coluna, Tabuleiro).

tInvertido(Peca, Linha, Coluna, Tabuleiro) :- rectanguloHorizontal(Peca, Linha, Coluna, Tabuleiro).

diagonalAguda(Peca, Linha, Coluna, Tabuleiro) :- quadrado(Peca, Linha, Coluna, Tabuleiro).

diagonalGrave(Peca, Linha, Coluna, Tabuleiro) :- quadrado(Peca, Linha, Coluna, Tabuleiro).

cantoTopLeft(Peca, Linha, Coluna, Tabuleiro) :- quadrado(Peca, Linha, Coluna, Tabuleiro).

cantoTopRight(Peca, Linha, Coluna, Tabuleiro) :- quadrado(Peca, Linha, Coluna, Tabuleiro).

cantoBottomLeft(Peca, Linha, Coluna, Tabuleiro) :- quadrado(Peca, Linha, Coluna, Tabuleiro).

cantoBottomRight(Peca, Linha, Coluna, Tabuleiro) :- quadrado(Peca, Linha, Coluna, Tabuleiro).


% ---------------------------------------------------------------------------------------------------
%
% 					Predicado escolhe/3
%
% ---------------------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------------------
%
%   Neste predicado escolhe/3 temos que retirando P a lista [P | R] obtemos R.
%
%   coloca(PrimeiroElemento, Elemento, Tabuleiro - Elemento)
%
%   que recebe uma Peca, com uma determinada Forma e Cor, recebe a Linha, a
%   Coluna em causa e devolve a posicao no Tabuleiro.
%
% ---------------------------------------------------------------------------------------------------

escolhe([P | R], P, R).
escolhe([P | R], E, [P | S]) :- escolhe(R, E, S).


% ---------------------------------------------------------------------------------------------------
%
% 					Predicado permutacoes/2
%
% ---------------------------------------------------------------------------------------------------

% ---------------------------------------------------------------------------------------------------
%
%   Este predicado permutacoes/2 significa que as duas listas que o compoem
%   contem os mesmo elementos dispostos contudo numa ordem diferente
%
% ---------------------------------------------------------------------------------------------------

permutacoes([], []).
permutacoes(L, [P | R]) :- escolhe(L, P, L1), permutacoes(L1, R).


% ---------------------------------------------------------------------------------------------------
%
% 					Predicado check
%
% ---------------------------------------------------------------------------------------------------

check(Tabuleiro, TabuleiroFinal) :-
       TabuleiroStack = [peca(triangulo, azul), peca(triangulo, amarelo), peca(triangulo, vermelho), peca(circulo, azul), peca(circulo, amarelo), peca(circulo, vermelho), peca(quadrado, azul), peca(quadrado, amarelo), peca(quadrado, vermelho)],
       permutacoes(TabuleiroStack, Tabuleiro),
       TabuleiroFinal = Tabuleiro.



