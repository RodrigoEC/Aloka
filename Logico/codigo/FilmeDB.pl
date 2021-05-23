:-use_module(library(csv)).
:-include('Arquivos.pl').

% Adiciona um filme no arquivo
addFilme(Id, Titulo, Diretor, Data, Genero, Estoque) :-
    open('../dados/Filmes.csv', append, File),
    writeln(File, (Id, Titulo, Diretor, Data, Genero, Estoque)),
    close(File).

% ------------------------------------ Métodos de verificação -------------------------------------------------------

% Verifica se o filme existe, le o arquivo csv e chama o método verificaNaLista que vai ver se o filme está na lista
filmeExiste(IdFilme, Result):-
    lerCsvRowList('Filmes.csv', Filmes),
    verificaNaLista(IdFilme, Filmes, Result).

% Verifica se o estoque é > 0
verificaEstoque(IdFilme, Result):-
    (getEstoque(IdFilme, Estoque), Estoque > 0 -> Result = true;
    Result = false).

% ----------------------------------------------- Getters -----------------------------------------------------------
% Retorna uma lista com todos os filmes cadastrados
getFilmes(Result) :-
    lerCsvRowList('Filmes.csv', Result).

% Retorna o estoque
getEstoque(IdFilme, Estoque) :-
    lerCsvRowList('Filmes.csv', Filmes),
    getEntidadeById(IdFilme, Filmes, Filme),
    elementByIndex(5, Filme, Estoque).

% Retorna Titulo do Filme a partir do Id
getTitulo(Id, Titulo):-
    lerCsvRowList('Filmes.csv', Filmes),
    getEntidadeById(Id, Filmes, Filme),
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
    getEntidadeById(Id, ArrayFilmes, Filme),
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
    getEntidadeById(Id, ArrayFilmes, Filme),
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
    getEntidadeById(Id, ArrayFilmes, Filme),
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
    open('../dados/Filmes.csv', write, File),
    write(File, ''),
    close(File).

% Escreve no csv todos os filmes do array passado como parâmetro
escreverFilmes([]).
escreverFilmes([H|T]) :-
    (getAll(H, Id, Titulo, Diretor, Data, Genero, Estoque),
    addFilme(Id, Titulo, Diretor, Data, Genero, Estoque),
    escreverFilmes(T)).
    
% Retorna o toString de filme
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

% vai gerar um array com todos os filmes de um genero passado como parametro
geraArrayGenero(_, [], []).
geraArrayGenero(Genero, [H|T], Arr):-
    (elementByIndex(4, H, G), member(Genero, [G]) -> geraArrayGenero(Genero, T, Arr1), concatenar(Arr1, [H], Arr)
    ; geraArrayGenero(Genero, T, Arr1), concatenar(Arr1, [], Arr)).

% vai verificar se o genero do filme é valido
ehGeneroValido(Genero, Result):-
    (lerCsvRowList('Filmes.csv', Filmes),
    geraArrayGenero(Genero, Filmes, Arr),
    length(Arr, L), L > 0 -> Result = true
    ;Result = false).

% vai pegar um filme no array de filmes
recomenda(Genero, Id):-
    lerCsvRowList('Filmes.csv', Filmes),
    geraArrayGenero(Genero, Filmes, Arr),
    length(Arr, L),random(0, L, R),
    elementByIndex(R, Arr, Filme),
    elementByIndex(0, Filme, Id).
