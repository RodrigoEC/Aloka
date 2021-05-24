:- include('FilmeDB.pl').

eh_filme(ID, Result) :- filmeExiste(ID, Result).

filme_disponivel(ID, Result) :- verificaEstoque(ID, Result).

get_estoque(ID, Result) :- getEstoque(ID, Result).

get_titulo(ID, Result) :- getTitulo(ID, Result).

eh_genero_valido(Genero, Result) :- ehGeneroValido(Genero, Result).

lista_filmes_disponiveis() :- 
    getFilmes(Filmes),
    exibe_filmes_disponiveis(Filmes).

exibe_filmes_disponiveis([]).
exibe_filmes_disponiveis([Filme|Filmes]) :- 
    elementByIndex(0, Filme, Id), getEstoque(Id, Estoque),
    (Estoque > 0 -> exibe_filme(Filme), exibe_filmes_disponiveis(Filmes);
    exibe_filmes_disponiveis(Filmes)).

exibe_filme(Filme) :- 
    getAll(Filme, Id, Titulo, Diretor, Data, Genero, Estoque),
    write("["), write(Id), write("] "),
    write("Título: "), write(Titulo), 
    write(", Genero: "), write(Genero), nl.

get_filme_recomendado(Genero, ID) :- recomenda(Genero, ID).