:- initialization(main).
:- include('Util.pl').


cria_intro :-
    NomesArquivos = ['loading1', 0.3, 'loading2', 0.3, 'loading3', 0.3, 'loading4', 0.3, 'logo', 0.3],
    cria_animacao(NomesArquivos).

cria_outro :-
    NomesArquivos = ['logo', 0.3, 'loading4', 0.3, 'loading3', 0.3, 'loading2', 0.3, 'loading1', 0.3, 'claquete', 0.5],
    cria_animacao(NomesArquivos).

main :-
    cria_intro,
    putLogo,
    cria_outro,
    halt.