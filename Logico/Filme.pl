:- include('FilmeDB.pl').

% Método responsável por verificar se o id passado como parâmetro é de um filme cadastrado.
eh_filme(ID, Result) :-
    filmeExiste(ID, Result).

% Método responsável por verificar se o id passado como parâmetro é de um filme disponivel.
filme_disponivel(ID, Result) :-
    verificaEstoque(ID, Result).

% Metodo responsavel por retornar o estoque a partir do id de um filme.
get_estoque(ID, Result) :-
    getEstoque(ID, Result).

% Metodo responsavel por retornar o titulo a partir do id de um filme.
get_titulo(ID, Result) :-
    getTitulo(ID, Result).

% Metodo responsavel por rverificar se um genero esta cadastrado.
eh_genero_valido(Genero, Result) :-
    ehGeneroValido(Genero, Result).

% Metodo responsavel por  listar todos os filmes disponiveis no estoque.
lista_filmes_disponiveis() :-
    getFilmes(Filmes),
    exibe_filmes_disponiveis(Filmes).

% Metodo responsavel por  exibir todos os filmes disponiveis no estoque.
exibe_filmes_disponiveis([]).
exibe_filmes_disponiveis([Filme|Filmes]) :- 
    elementByIndex(0, Filme, Id), getEstoque(Id, Estoque),
    (Estoque > 0 -> exibe_filme(Filme), exibe_filmes_disponiveis(Filmes);
    exibe_filmes_disponiveis(Filmes)).

% Metodo responsavel por  exibir um filme cadastrado.
exibe_filme(Filme) :- 
    getAll(Filme, Id, Titulo, Diretor, Data, Genero, Estoque),
    write("["), write(Id), write("] "),
    write("Título: "), write(Titulo), 
    write(", Genero: "), write(Genero), nl.

% Método responsável por realizar o cadastro de um filme.
cadastraFilme(Titulo, Diretor, Data, Genero, Estoque, Id) :- 
    addFilme(Titulo, Diretor, Data, Genero, Estoque, Id).

% Método responsável por listar todos os filmes cadastrados.
lista_todos_filmes() :- 
    getFilmes(Filmes),
    exibe_todos_filmes(Filmes).

% Método responsável por exibir todos os filmes cadastrados.
exibe_todos_filmes([]).
exibe_todos_filmes([Filme|Filmes]) :- 
    exibe_filme(Filme),
    exibe_todos_filmes(Filmes).

% Metodo responsavel por recomendar um filme com base no genero recebido.
get_filme_recomendado(Genero, ID) :- recomenda(Genero, ID).