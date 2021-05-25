:- include('FilmeDB.pl').

%Método responsável por verificar se o id passado como parâmetro é de um filme cadastrado.
eh_filme(ID, Result) :-
    filmeExiste(ID, Result).

filme_disponivel(ID, Result) :-
    verificaEstoque(ID, Result).

get_estoque(ID, Result) :-
    getEstoque(ID, Result).

get_titulo(ID, Result) :-
    getTitulo(ID, Result).

eh_genero_valido(Genero, Result) :-
    ehGeneroValido(Genero, Result).

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

%Método responsável por realizar o cadastro de um filme.
cadastraFilme(Titulo, Diretor, Data, Genero, Estoque, Id) :- 
    addFilme(Titulo, Diretor, Data, Genero, Estoque, Id).

%Método responsável por listar todos os filmes cadastrados.
lista_todos_filmes() :- 
    getFilmes(Filmes),
    exibe_todos_filmes(Filmes).

%Método responsável por exibir todos os filmes cadastrados.
exibe_todos_filmes([]).
exibe_todos_filmes([Filme|Filmes]) :- 
    exibe_filme(Filme),
    exibe_todos_filmes(Filmes).

get_filme_recomendado(Genero, ID) :- recomenda(Genero, ID).