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


locacao_existe(ID, Result) :- locacaoExiste(ID, Result).

add_locacao(ID, CPF, Data) :- cadastraLocacao(ID, CPF, Data).

finaliza_locacao(ID, IDFilme) :- 
    getLocacaoById(ID, Locacao),
    getAllAttributesLocacao(Locacao, L, IDFilme, C, D, S),
    finalizaLocacao(ID).

lista_locacoes_cliente(CPF) :- 
    getLocacoesEmAndamentoCliente(CPF, Locacoes),
    lista_locacoes(Locacoes).

lista_locacoes([]).
lista_locacoes([Locacao|Locacoes]) :- 
    lista_locacao(Locacao), 
    lista_locacoes(Locacoes).

lista_locacao(Locacao) :- 
    getAllAttributesLocacao(Locacao, IDL, IDF, CPF, Data, Status),
    write("Id locação: "), write(IDL),
    write("\nId filme: "), write(IDF), 
    write("\nCPF cliente: "), write(CPF), 
    write("\nData locação: "), write(Data), 
    write("\nStatus: "), write(Status),
    write("\n---"), nl.
