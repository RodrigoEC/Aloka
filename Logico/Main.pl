:- initialization(main).
:- include('Util.pl').


cria_intro :-
    NomesArquivos = ['loading1', 'loading2', 'loading3', 'loading4', 'logo'],
    cria_animacao(NomesArquivos).

main :-
    cria_intro,
    halt.