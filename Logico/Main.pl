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
escolheOpcoesMenu(2) :- writeln(2).
escolheOpcoesMenu(3) :- writeln(3).
escolheOpcoesMenu(4) :- cria_outro.
escolheOpcoesMenu(_) :- 
    putMsgOpcaoInvalida,
    sleep(1),
    menuPrincipal.

% Metodo de exibição do menu principal do sistema.
menuPrincipal :-
    putMsgOpcoesMenuInicial,
    read(Opcao),
    escolheOpcoesMenu(Opcao).

main :-
    menuPrincipal,
    halt.