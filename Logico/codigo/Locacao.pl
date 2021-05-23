:- include('Util.pl').
:- include('LocacaoDB.pl').

% Metodo que exibe o histórico geral de locações do sistema.
exibe_historico_geral() :- 
    getLocacoes(Locacoes),
    exibeLocacoes(Locacoes).

% Metodo que exibe todos as locações feitas por um cliente em específico.
exibe_historico_cliente(CPF) :-
    getLocacoesCliente(CPF, Locacoes),
    exibeLocacoes(Locacoes).

% Método que exibe todas as locações qu estão atualmente em andamento no sistema.
exibe_historico_em_andamento() :-
    getLocacoesEmAndamento(Locacoes),
    exibeLocacoes(Locacoes).

% Metodo que exibe as informações de uma locação que é passada como parâmetro.
exibeLocacao(Locacao) :-
    writeln('------'),
    exibe_por_index(Locacao, 0, IdLocacao),
    write('Id da locação: '), writeln(IdLocacao),
    writeln('---'),

    exibe_por_index(Locacao, 1, Filme),
    write('Id do filme: '), writeln(Filme),
    writeln('---'),

    exibe_por_index(Locacao, 2, Cliente),
    write('CPF do Cliente: '), writeln(Cliente),
    writeln('---'),

    exibe_por_index(Locacao, 3, DataLocacao),
    write('Data de locação: '), writeln(DataLocacao),
    writeln('---'),

    exibe_por_index(Locacao, 4, Situacao),
    write('Situação: '), writeln(Situacao),
    writeln('------'),
    nl.

% Metodo que exibe as informações de uma lista de Locações que é passada como parâmetro da função.
exibeLocacoes([]) :- msgCpfInvalido(), sleep(2), clear(), logo_historico(). 
exibeLocacoes([Locacao]) :- exibeLocacao(Locacao).
exibeLocacoes([Locacao|Resto]) :-
    exibeLocacao(Locacao),
    exibeLocacoes(Resto).