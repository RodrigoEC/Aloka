:-use_module(library(csv)).
:-include('Arquivos.pl').

% Adiciona um filme no arquivo
addFilme(Id, Titulo, Diretor, Data, Genero, Estoque) :-
    open('../arquivos/Filmes.csv', append, File),
    writeln(File, (Id, Titulo, Diretor, Data, Genero, Estoque)),
    close(File).

% Verifica se o filme existe, le o arquivo csv e chama o método verificaNaLista que vai ver se o filme está na lista
filmeExiste(IdFilme):-
    lerCsvRowList('Filmes.csv', Filmes),
    verificaNaLista(IdFilme, Filmes).

% Verifica se o estoque é > 0
verificaEstoque(IdFilme):-
    (getEstoque(IdFilme, Estoque), Estoque > 0 -> true;
    false).

% Retorna o estoque
getEstoque(IdFilme, Estoque) :-
    lerCsvRowList('Filmes.csv', Filmes),
    pegaEntidade(IdFilme, Filmes, Filme),
    elementByIndex(5, Filme, Estoque).

% Retorna Titulo do Filme a partir do Id
getTitulo(Id, Titulo):-
    lerCsvRowList('Filmes.csv', Filmes),
    pegaEntidade(Id, Filmes, Filme),
    elementByIndex(1, Filme, Titulo).

listaFilmes(Filme):-
    lerCsvRowList('Filmes.csv', Filmes),
    iteraFilme(Filmes, Filme).

iteraFilme([F|_], F):- !.
iteraFilme([H|T], H):-
    iteraFilme(T, Filme).

% Retorna todos os atributos de filme
getAll(Id, Titulo, Diretor, Data, Genero, Estoque):-
    lerCsvRowList('Filmes.csv', Filmes),
    pegaEntidade(Id, Filmes, Filme),
    elementByIndex(1, Filme, Titulo),
    elementByIndex(2, Filme, Diretor),
    elementByIndex(3, Filme, Data),
    elementByIndex(4, Filme, Genero), 
    elementByIndex(5, Filme, Estoque).

setEstoque(Id, NovoEstoque):-
    getAll(Id, Titulo, Diretor, Data, Genero, Estoque),
    addFilme(Id, Titulo, Diretor, Data, Genero, Estoque+NovoEstoque).