:- include('Locacao.pl').
:- include('Filme.pl').
:- include('Cliente.pl').

locadora_eh_cliente(CPF, Result) :- eh_cliente(CPF, Result).

locadora_get_nome(CPF, Result) :- get_nome(CPF, Result).

locadora_add_cliente(Nome, CPF, Telefone, Endereco, Result) :-
    add_cliente(Nome, CPF, Telefone, Endereco, Result).

locadora_eh_filme(ID, Result) :- eh_filme(ID, Result).

locadora_filme_disponivel(ID, Result) :- filme_disponivel(ID, Result).

locadora_get_estoque(ID, Result) :- get_estoque(ID, Result).

locadora_get_titulo(ID, Result) :- get_titulo(ID, Result).

locadora_lista_filmes :- lista_filmes.

locadora_add_locacao(ID, CPF, Data) :- add_locacao(ID, CPF, Data).

locadora_eh_genero_valido(Genero, Result) :- eh_genero_valido(Genero, Result).

locadora_recomenda_filme(Genero, ID) :- get_filme_recomendado(Genero, ID).