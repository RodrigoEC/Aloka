:- include('Util.pl').
:- include('LocacaoDB.pl').

exibe_historico_geral() :- 
    nl,
    writeln('Histórico geral ainda não implementado!!'),
    nl.

exibe_historico_cliente(CPF) :-
    nl,
    writeln('Histórico do cliente ainda não implementado!!'),
    writeln(CPF),
    nl.

exibe_historico_em_andamento() :-
    nl,
    writeln('Histórico das locacoes em andamento ainda não implementado!!'),
    nl.

exibeLocacao(Info) :-
    nl,
    exibe_por_index(Info, 0, Cliente),
    write('Cliente: '), writeln(Cliente),
    writeln('---'),

    exibe_por_index(Info, 1, Filme),
    write('filme: '), writeln(Filme),
    writeln('---'),

    exibe_por_index(Info, 2, DataLocacao),
    write('Data de locação: '), writeln(DataLocacao),
    writeln('---'),

    exibe_por_index(Info, 3, Situacao),
    write('Situação: '), writeln(Situacao),
    writeln('----'),
    nl.

exibeLocacoes([Locacao]) :- exibeLocacao(Locacao).
exibeLocacoes([Locacao|Resto]) :-
    exibeLocacao(Locacao),
    writeln('<- - - ->'),
    exibeLocacoes(Resto).


add_locacao(ID, CPF, Data) :- cadastraLocacao(ID, CPF, Data).
