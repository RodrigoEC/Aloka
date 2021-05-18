:-use_module(library(csv)).
:-include('Arquivos.pl').

cadastraFilme(Id, Titulo, Diretor, Data, Genero, Estoque) :-
    open('../arquivos/Produtos.csv', append, File),
    writeln(File, (Id, Titulo, Diretor, Data, Genero, Estoque)),
    close(File).