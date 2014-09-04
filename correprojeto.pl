start :- carregaProjecto, desafios.

carregaProjecto :- ['metaforms12.pl'], ['metaforms14.pl'],['testes-alunos.pl'].

desafios :- correTodosDesafios(1, 6).

correTodosDesafios(Limite, Limite).

correTodosDesafios(Min, Max) :- Min < Max,
            write('teste '), write(Min), writeln(':'),
            desafio(Min, Tabuleiro), write(Tabuleiro), nl, nl,
            Min1 is Min + 1,
            correTodosDesafios(Min1, Max).