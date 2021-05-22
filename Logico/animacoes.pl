:- include('Util.pl').

% Metodo que cria a animação de introdução do sistema.
cria_intro() :-
    NomesArquivos = [loading1, 0.3, loading2, 0.3, loading3, 0.3, loading4, 0.3, logo, 0.3],
    cria_animacao(NomesArquivos).

% Metodo que cria a animação de saída do sistema
cria_outro() :-
    NomesArquivos = [logo, 0.3, loading4, 0.3, loading3, 0.3, loading2, 0.3, loading1, 0.3, claquete, 0.5],
    cria_animacao(NomesArquivos).

cria_animacao_historico() :-
    NomesArquivos = [load_hist1, 0.2, load_hist2, 0.1, load_hist3, 0.2, load_hist4, 0.1],
    cria_animacao(NomesArquivos).

