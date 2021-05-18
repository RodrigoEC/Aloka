:-use_module(library(csv)).
:-include('Arquivos.pl').

cadastraFilme(Id, Titulo, Diretor, Data, Genero, Estoque) :-
    (filmeExiste(Id) -> write('Filme Já Cadastrado');
    addFilme(Id, Titulo, Diretor, Data, Genero, Estoque)).

addFilme(Id, Titulo, Diretor, Data, Genero, Estoque) :-
    open('../arquivos/Produtos.csv', append, File),
    writeln(File, (Id, Titulo, Diretor, Data, Genero, Estoque)),
    close(File).

filmeExiste(IdFilme):-
    lerCsvRowList('Filmes.csv', Filmes),
    verificaNaLista(IdFilme, Filmes).

verificaNaLista(_,[], false).
verificaNaLista(SearchedMovie, [H|T]) :-
     (member(SearchedMovie, H) -> true
     ;verificaNaLista(SearchedMovie, T)).