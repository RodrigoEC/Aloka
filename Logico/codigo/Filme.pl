:- include('FilmeDB.pl').

lista_filmes() :- 
    getFilmes(Filmes),
    exibe_filmes(Filmes).

exibe_filmes([]).
exibe_filmes([Filme|Filmes]) :- elementByIndex(0, Filme, Id), getEstoque(Id, Estoque),
    (Estoque > 0 -> exibe_filme(Filme), exibe_filmes(Filmes);
    exibe_filmes(Filmes)).

exibe_filme(Filme) :- 
    getAll(Filme, Id, Titulo, Diretor, Data, Genero, Estoque),
    write("["), write(Id), write("] "),
    write("Título: "), write(Titulo), 
    write(", Genero: "), write(Genero), nl.