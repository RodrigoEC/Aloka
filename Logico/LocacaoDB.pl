:-use_module(library(csv)).
:-include('Arquivos.pl').

% Cadastra uma locação ao fim do arquivo Locacoes.csv
cadastraLocacao(IdFilme, CpfCliente, DataLocacao) :-
    Status = 'em andamento',
    geraIdLocacao(IdLocacao),
    getLocacaoById(IdLocacao, Locacao),
    (not(member(_,Locacao))
        -> open('./dados/Locacoes.csv', append, File),
        writeln(File, (IdLocacao, IdFilme, CpfCliente, DataLocacao, Status)),
        close(File),
        aluga(IdFilme)
        ; cadastraLocacao(IdFilme, CpfCliente, DataLocacao)
    ).

%Gera o Id da locação de forma randômica
geraIdLocacao(Id):-
    random(0, 1000, Id).

locacaoExiste(IdLocacao, Result):-
    lerCsvRowList('Locacoes.csv', Locacoes),
    verificaNaLista(IdLocacao, Locacoes, Result).

% Retorna uma lista com todas as locações cadastradas
getLocacoes(Result) :-
    lerCsvRowList('Locacoes.csv', Result).

% Recupera uma Locacao pelo id
getLocacaoById(IdLocacao, Result) :-
    getLocacoes(Locacoes),
    getEntidadeById(IdLocacao, Locacoes, Result).

%Retorna um lista com todas as locações com status em andamento
getLocacoesEmAndamento(Result) :-
    getLocacoes(Locacoes),
    filtraLocacoesEmAndamento(Locacoes, Result).

%Retorna o Id do filme de uma locação
getIdFilmeFromLocacao(IdLocacao, Result):-
    getLocacaoById(IdLocacao, Locacao),
    elementByIndex(1, Locacao, Result).

% Recupera Locacoes pelo id do cliente
getLocacoesCliente(CpfCliente, Result) :-
    getLocacoes(Locacoes),
    filtraLocacoesByIdCliente(CpfCliente, Locacoes, Result).

% Recupera Locacoes em andamento pelo id do cliente
getLocacoesEmAndamentoCliente(CpfCliente, Result) :-
    getLocacoes(Locacoes),
    filtraLocacoesByIdCliente(CpfCliente, Locacoes, R),
    filtraLocacoesEmAndamento(R, Result).

%Filtra as locações a partir do id do cliente
filtraLocacoesByIdCliente(_, [], []).
filtraLocacoesByIdCliente(CpfCliente, [[Id, _, Cpf, _, _]|Locacoes], Result):- 
    (CpfCliente =:= Cpf
        -> getLocacaoById(Id, Locacao),
        filtraLocacoesByIdCliente(CpfCliente, Locacoes, R),
        Result = [Locacao|R]
        ; filtraLocacoesByIdCliente(CpfCliente, Locacoes, Result)
    ).

%Filtra as locações a partir do status em andamento
filtraLocacoesEmAndamento([], []).
filtraLocacoesEmAndamento([[Id, _, _, _, Status]|Locacoes], Result):- 
    (\+(Status \== 'em andamento')
        -> getLocacaoById(Id, Locacao),
        filtraLocacoesEmAndamento(Locacoes, R),
        Result = [Locacao|R]
        ; filtraLocacoesEmAndamento(Locacoes, Result)
    ).

% Transforma uma locação em uma representação em String
locacaoToString(Locacao, Result):-
    getAllAttributesLocacao(Locacao, IdLocacao, IdFilme, Cpf, Data, Status),
    string_concat(IdLocacao, ' - ', S1),
    string_concat(S1, IdFilme, S2),
    string_concat(S2, ' - ', S3),
    string_concat(S3, Cpf, S4),
    string_concat(S4, ' - ', S5),
    string_concat(S5, Data, S6),
    string_concat(S6, ' - ', S7),
    string_concat(S7, Status, Result).

% --------------------- finalizar locação ---------------------
finalizaLocacao(IdLocacao):-
    getLocacoes(Locacoes),
    getLocacaoById(IdLocacao, Locacao),
    remover(Locacao, Locacoes, Result),
    removeind(4, Locacao, LocacaoSemStatus), %TODO: mudar o índice
    concatenar(LocacaoSemStatus, ["finalizado"], LocacaoFinalizada),
    concatenar(Result, [LocacaoFinalizada], NewLocacoes),
    limpaCsvLocacoes,
    escreveLocacoes(NewLocacoes),
    getEntidadeId(LocacaoFinalizada, IdLocacaoFinalizada),
    getLocacaoById(IdLocacaoFinalizada, [_,IdFilme,_,_,_]),
    setEstoque(IdFilme, 1).

%Limpa os dados do csv Locacoes.csv
limpaCsvLocacoes:-
    open('./dados/Locacoes.csv', write, File),
    write(File, ''),
    close(File).

%Volta a registrar todas as locações no arquivo Locacoes.csv
escreveLocacoes([]).
escreveLocacoes([H|T]) :-
    (getAllAttributesLocacao(H, IdLocacao, IdFilme, Cpf, Data, Status),
    setLocacao(IdLocacao, IdFilme, Cpf, Data, Status),
    escreveLocacoes(T)).

setLocacao(IdLocacao, IdFilme, CpfCliente, DataLocacao, Status) :-
    open('./dados/Locacoes.csv', append, File),
    writeln(File, (IdLocacao, IdFilme, CpfCliente, DataLocacao, Status)),
    close(File).

% Retorna todos os atributos de locacao
getAllAttributesLocacao([IdLocacao, IdFilme, CpfCliente, DataLocacao, Status], IdLocacao, IdFilme, CpfCliente, DataLocacao, Status).
