:- include('Util.pl').

% Metodo que cria a animação de introdução do sistema.
cria_intro() :-
    Path = 'logo/',
    NomesArquivos = [loading1, 0.3, loading2, 0.3, loading3, 0.3, loading4, 0.3, logo, 0.3],
    cria_animacao(NomesArquivos, Path).

% Metodo que cria a animação de saída do sistema
cria_outro() :-
    NomesArquivos = [logo, 0.3, loading4, 0.3, loading3, 0.3, loading2, 0.3, loading1, 0.3, claquete, 0.5],
    cria_animacao(NomesArquivos, 'logo/').

% Metodo que cria a animação do menu de histórico
cria_animacao_historico() :-
    NomesArquivos = [load_hist1, 0.1, 
                     load_hist2, 0.1,
                     load_hist3, 0.1,
                     load_hist4, 0.1,
                     load_hist5, 0.1,
                     load_hist6, 0.1,
                     load_hist7, 0.1,
                     load_hist8, 0.1,
                     load_hist9, 0.1,
                     load_hist10, 0.1,
                     load_hist11, 0.1,
                     load_hist12, 0.1,
                     load_hist13, 0.1,
                     load_hist14, 0.1,
                     load_hist15, 0.1,
                     load_hist14, 0.1,
                     load_hist13, 0.1,
                     load_hist12, 0.1,
                     load_hist11, 0.1,
                     load_hist10, 0.1],
    cria_animacao(NomesArquivos, 'historico/').

