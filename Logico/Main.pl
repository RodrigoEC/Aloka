:- initialization(main).
:- include('Util.pl').
:- include('Info.pl').

cria_intro() :-
    NomesArquivos = ['loading1', 0.3,
                     'loading2', 0.3,
                     'loading3', 0.3,
                     'loading4', 0.3,
                     'logo', 0.3],
    cria_animacao(NomesArquivos).

cria_outro() :-
    NomesArquivos = ['logo', 0.3,
                     'loading4', 0.3,
                     'loading3', 0.3,
                     'loading2', 0.3,
                     'loading1', 0.3,
                     'claquete', 0.5],
    cria_animacao(NomesArquivos).

escolheOpcoes(1) :- writeln(1).
escolheOpcoes(2) :- writeln(2).
escolheOpcoes(3) :- writeln(3).
escolheOpcoes(4) :- cria_outro.
escolheOpcoes(_) :- 
    putMsgOpcaoInvalida,
    sleep(1),
    menuPrincipal.

menuPrincipal :-
    putMsgOpcoesMenuInicial,
    read(Opcao),
    escolheOpcoes(Opcao).

main :-
    menuPrincipal,
    halt.