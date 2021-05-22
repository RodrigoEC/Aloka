:- initialization(main).
:- include('Util.pl').
:- include('Info.pl').

% Metodo que cria a animação de introdução do sistema.
cria_intro() :-
    NomesArquivos = ['loading1', 0.3,
                     'loading2', 0.3,
                     'loading3', 0.3,
                     'loading4', 0.3,
                     'logo', 0.3],
    cria_animacao(NomesArquivos).

% Metodo que cria a animação de saída do sistema
cria_outro() :-
    NomesArquivos = ['logo', 0.3,
                     'loading4', 0.3,
                     'loading3', 0.3,
                     'loading2', 0.3,
                     'loading1', 0.3,
                     'claquete', 0.5],
    cria_animacao(NomesArquivos).

% Metodo que recebe uma opção de usuario como parâmetro e é responsável por chamar a função
% adequada. Caso a opção seja invalida o menuPrincipal é novamente chamado.
escolheOpcoesMenu(1) :- writeln(1).
escolheOpcoesMenu(2) :- exibir_historico.
escolheOpcoesMenu(3) :- writeln(3).
escolheOpcoesMenu(4) :- cria_outro.
escolheOpcoesMenu(_) :- 
    putMsgOpcaoInvalida,
    sleep(1),
    menu_principal.

exibir_historico :-
    putOpcoesHistorico,
    nl,
    adm_read(Opcao),
    escolheOpcoesHistorico(Opcao).

escolheOpcoesHistorico(1) :-
    write(7),
    sleep(2),
    exibir_historico.

escolheOpcoesHistorico(2) :-
    write(4),
    sleep(2),
    exibir_historico.
escolheOpcoesHistorico(3) :-
    write(6),
    sleep(2),
    exibir_historico.
escolheOpcoesHistorico(4) :- menu_principal.
escolheOpcoesHistorico(_) :- 
    putMsgOpcaoInvalida,
    sleep(1),
    exibir_historico.
    


% Metodo de exibição do menu principal do sistema.
menu_principal :-
    putMsgOpcoesMenuInicial,
    read(Opcao),
    escolheOpcoesMenu(Opcao).

main :-
    cria_intro,
    menu_principal,
    halt.