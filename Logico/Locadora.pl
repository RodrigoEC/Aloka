:- include('Locacao.pl').
:- include('Filme.pl').
:- include('Cliente.pl').

% Metodo responsavel por chamar a funcao de verificar se um cliente esta cadastrado.
locadora_eh_cliente(CPF, Result) :- eh_cliente(CPF, Result).

% Metodo responsavel por chamar a funcao que retorna o nome do cliente a partir do seu cpf.
locadora_get_nome(CPF, Result) :- get_nome(CPF, Result).

% Metodo responsavel por chamar a funcao que cadatra um cliente no sistema.
locadora_add_cliente(Nome, CPF, Telefone, Endereco, Result) :-
    add_cliente(Nome, CPF, Telefone, Endereco, Result).

% Metodo responsavel por chamar a funcao que verifica se um filme esta cadastrado.
locadora_eh_filme(ID, Result) :- eh_filme(ID, Result).

% Metodo responsavel por chamar a funcao que verifica se um filme esta disponivel.
locadora_filme_disponivel(ID, Result) :- filme_disponivel(ID, Result).

% Metodo responsavel por chamar a funcao que retorna o estoque de um filme a partir do id.
locadora_get_estoque(ID, Result) :- get_estoque(ID, Result).

% Metodo responsavel por chamar a funcao que retorna o titulo de um filme a partir do id.
locadora_get_titulo(ID, Result) :- get_titulo(ID, Result).

% Metodo responsavel por chamar a funcao que lista os filmes disponiveis.
locadora_lista_filmes_disponiveis :- lista_filmes_disponiveis.

% Metodo responsavel por chamar a funcao que lista todos os filmes.
locadora_lista_todos_filmes :- lista_todos_filmes.

% Metodo responsavel por chamar a funcao que cadastra uma locacao no sistema.
locadora_add_locacao(ID, CPF, Data) :- add_locacao(ID, CPF, Data).

% Metodo responsavel por chamar a funcao que verifica se um genero esta cadastrado.
locadora_eh_genero_valido(Genero, Result) :- eh_genero_valido(Genero, Result).

% Metodo responsavel por chamar a funcao que recomenda um filme com base no genero.
locadora_recomenda_filme(Genero, ID) :- get_filme_recomendado(Genero, ID).

% Metodo responsavel por chamar a funcao que lista as locacoes em andamento de um cliente.
locadora_lista_locacoes_cliente(CPF) :- lista_locacoes_cliente(CPF).

% Metodo responsavel por chamar a funcao que verifica se uma locacao esta cadastrada.
locadora_locacao_existe(ID, Result) :- locacao_existe(ID, Result).

% Metodo responsavel por chamar a funcao que finaliza uma locacao e retora o id do filme devolvido.
locadora_finaliza_locacao(ID, IDfilme) :- finaliza_locacao(ID, IDfilme).
