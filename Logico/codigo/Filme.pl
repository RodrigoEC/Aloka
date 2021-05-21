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
    getEntidadeId(IdFilme, Filmes, Filme),
    elementByIndex(5, Filme, Estoque).

% Retorna Titulo do Filme a partir do Id
getTitulo(Id, Titulo):-
    lerCsvRowList('Filmes.csv', Filmes),
    getEntidadeId(Id, Filmes, Filme),
    elementByIndex(1, Filme, Titulo).


% Retorna todos os atributos de filme
getAll(Filme, Id, Titulo, Diretor, Data, Genero, Estoque):-
    elementByIndex(0, Filme, Id),
    elementByIndex(1, Filme, Titulo),
    elementByIndex(2, Filme, Diretor),
    elementByIndex(3, Filme, Data),
    elementByIndex(4, Filme, Genero), 
    elementByIndex(5, Filme, Estoque).

setEstoque(Id, Valor):-
    lerCsvRowList('Filmes.csv', ArrayFilmes),
    getEntidadeId(Id, ArrayFilmes, Filme),
    remover(Filme, ArrayFilmes, Filmes),
    elementByIndex(5, Filme, Estoque),
    E is Estoque + Valor,
    removeind(5, Filme, FilmeSemEstoque),
    concatenar(FilmeSemEstoque, [E], FilmeFinal),
    concatenar(Filmes, [FilmeFinal], FilmesFinal),
    limparCsvFilmes,
    escreverFilmes(FilmesFinal).

limparCsvFilmes:-
    open('../arquivos/Filmes.csv', write, File),
    write(File, ''),
    close(File).

escreverFilmes([]).
escreverFilmes([H|T]) :-
    (getAll(H, Id, Titulo, Diretor, Data, Genero, Estoque),
    addFilme(Id, Titulo, Diretor, Data, Genero, Estoque),
    escreverFilmes(T)).

aluga(Id):-
    lerCsvRowList('Filmes.csv', ArrayFilmes),
    getEntidadeId(Id, ArrayFilmes, Filme),
    remover(Filme, ArrayFilmes, Filmes),
    elementByIndex(5, Filme, Estoque),
    E is Estoque - 1,
    removeind(5, Filme, FilmeSemEstoque),
    concatenar(FilmeSemEstoque, [E], FilmeFinal),
    concatenar(Filmes, [FilmeFinal], FilmesFinal),
    limparCsvFilmes,
    escreverFilmes(FilmesFinal).

devolve(Id):-
    lerCsvRowList('Filmes.csv', ArrayFilmes),
    getEntidadeId(Id, ArrayFilmes, Filme),
    remover(Filme, ArrayFilmes, Filmes),
    elementByIndex(5, Filme, Estoque),
    E is Estoque + 1,
    removeind(5, Filme, FilmeSemEstoque),
    concatenar(FilmeSemEstoque, [E], FilmeFinal),
    concatenar(Filmes, [FilmeFinal], FilmesFinal),
    limparCsvFilmes,
    escreverFilmes(FilmesFinal).