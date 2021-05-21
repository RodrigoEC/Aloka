:-use_module(library(csv)).
:-include('Arquivos.pl').

% Adiciona um filme no arquivo
addFilme(Id, Titulo, Diretor, Data, Genero, Estoque) :-
    open('../arquivos/Filmes.csv', append, File),
    writeln(File, (Id, Titulo, Diretor, Data, Genero, Estoque)),
    close(File).

% ------------------------------------ Métodos de verificação -------------------------------------------------------

% Verifica se o filme existe, le o arquivo csv e chama o método verificaNaLista que vai ver se o filme está na lista
filmeExiste(IdFilme):-
    lerCsvRowList('Filmes.csv', Filmes),
    verificaNaLista(IdFilme, Filmes).

% Verifica se o estoque é > 0
verificaEstoque(IdFilme):-
    (getEstoque(IdFilme, Estoque), Estoque > 0 -> true;
    false).

% ----------------------------------------------- Getters -----------------------------------------------------------
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

% -------------------------------------------- Setters --------------------------------------------------------------
% Adiciona filmes ao estoque
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

% Remove um filme do estoque a medida que ele foi alugado
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

% Acrescenta um filme ao estoque a medida que ele foi devolvido
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

% ----------------------------------------- Métodos auxiliares ---------------------------------------------------------
% Remove todos os filmes do csv
limparCsvFilmes:-
    open('../arquivos/Filmes.csv', write, File),
    write(File, ''),
    close(File).

% Escreve no csv todos os filmes do array passado como parâmetro
escreverFilmes([]).
escreverFilmes([H|T]) :-
    (getAll(H, Id, Titulo, Diretor, Data, Genero, Estoque),
    addFilme(Id, Titulo, Diretor, Data, Genero, Estoque),
    escreverFilmes(T)).

listarFilmes:-
    lerCsvRowList('Filmes.csv', Filmes),
    listarFilmesAux(Filmes).

listarFilmesAux([]).
listarFilmesAux([H|T]):-
    toString(H, V), writeln(V), listarFilmesAux(T).

toString(F, S):-
    getAll(F, Id, Titulo, Diretor, Data, Genero, Estoque),
    string_concat(Id, ' - ', S1),
    string_concat(S1, Titulo, S2),
    string_concat(S2, ' - ', S3),
    string_concat(S3, Diretor, S4),
    string_concat(S4, ' - ', S5),
    string_concat(S5, Data, S6),
    string_concat(S6, ' - ', S7),
    string_concat(S7, Genero, S8),
    string_concat(S8, ' - ', S9),
    string_concat(S9, Estoque, S).