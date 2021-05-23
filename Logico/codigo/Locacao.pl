:- include('Util.pl').
:- include('LocacaoDB.pl').

exibe_historico_geral() :- 
    getLocacoes(Locacoes),
    exibeLocacoes(Locacoes).

exibe_historico_cliente(CPF) :-
    getLocacoesCliente(CPF, Locacoes),
    exibeLocacoes(Locacoes).

exibe_historico_em_andamento() :-
    getLocacoesEmAndamento(Locacoes),
    exibeLocacoes(Locacoes).

exibeLocacao(Info) :-
    writeln('------'),
    exibe_por_index(Info, 0, IdLocacao),
    write('Id da locação: '), writeln(IdLocacao),
    writeln('---'),

    exibe_por_index(Info, 1, Filme),
    write('Id do filme: '), writeln(Filme),
    writeln('---'),

    exibe_por_index(Info, 2, Cliente),
    write('CPF do Cliente: '), writeln(Cliente),
    writeln('---'),

    exibe_por_index(Info, 3, DataLocacao),
    write('Data de locação: '), writeln(DataLocacao),
    writeln('---'),

    exibe_por_index(Info, 4, Situacao),
    write('Situação: '), writeln(Situacao),
    writeln('------'),
    nl.

exibeLocacoes([Locacao]) :- exibeLocacao(Locacao).
exibeLocacoes([Locacao|Resto]) :-
    exibeLocacao(Locacao),
    exibeLocacoes(Resto).