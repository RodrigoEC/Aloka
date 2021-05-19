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

% Verifica se o filme está na lista
verificaNaLista(_,[], false).
verificaNaLista(SearchedMovie, [H|T]) :-
     (member(SearchedMovie, H) -> true
     ;verificaNaLista(SearchedMovie, T)).

% Verifica se o estoque é um estoque disponível, le o arquivo csv, chama o método encontraFilme
% que vai encontrar o filme na lista, depois chama o estoqueValido passando o filme que foi encontrado, estoqueValido verifica se o estoque é > 0.
verificaEstoque(IdFilme):-
    lerCsvRowList('Filmes.csv', Filmes),
    encontraFilme(IdFilme, Filmes, Filme),
    estoqueValido(Filme).

% encontra o filme na lista
encontraFilme(_, [Filme|_], Filme):- !.
encontraFilme(IdFilme, [H|T], Filme) :-
    (member(IdFilme, H) -> H;
    encontraFilme(IdFilme, T, Filme)).

% Verifica se o estoque é > 0
estoqueValido(Filme):-
    (getEstoque(Filme, Estoque), Estoque > 0 -> true;
    false).

% Retorna o estoque
getEstoque(Filme, Estoque) :-
    elementByIndex(5, Filme, Estoque).

% Método utilitário que retorna um elemento por seu indice
elementByIndex(0, [H|_], H):- !.
elementByIndex(I, [_|T], E):- X is I - 1, elementByIndex(X, T, E).