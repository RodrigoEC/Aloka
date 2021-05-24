:- (initialization main).
:- include('Util.pl').
:- include('Info.pl').
:- include('animacoes.pl').
:- include('Locacao.pl').
:- include('Locadora.pl').

% Exibição do menu principal do sistema.
menu_principal :-
    opcoesMenuInicial,
    read(Opcao),
    escolheOpcoesMenuPrincipal(Opcao).

% Método que realiza a seleção e exibição das opções referentes ao menu de funcionalidades do administrador.
escolheOpcoesMenuPrincipal(1) :- login_cliente.
escolheOpcoesMenuPrincipal(2) :- menu_principal_admin.
escolheOpcoesMenuPrincipal(3) :- cadastro_usuario.
escolheOpcoesMenuPrincipal(4) :- cria_outro.
escolheOpcoesMenuPrincipal(_) :- opcaoInvalida, menu_principal.


%  Método de exibição do primeiro menu de opções do admin.
menu_principal_admin :-
    opcoesMenuAdmin,
    adm_read(Opcao),
    escolheOpcoesMenuPrincipalAdmin(Opcao).

% Metodo que recebe uma opção de usuario como parâmetro e é responsável por chamar a função
% adequada. Caso a opção seja invalida o menuPrincipalAdmin é novamente chamado.
escolheOpcoesMenuPrincipalAdmin(1) :- cadastrar_filme, sleep(2), adm_read(Opcao), escolheOpcoesMenuPrincipalAdmin(Opcao).
escolheOpcoesMenuPrincipalAdmin(2) :- exibir_menu_historico.
escolheOpcoesMenuPrincipalAdmin(3) :- menu_admin_gerenciar_estoque.
escolheOpcoesMenuPrincipalAdmin(4) :- menu_principal.
escolheOpcoesMenuPrincipalAdmin(_) :- opcaoInvalida, menu_principal_admin.

% Metodo responsável por receber uma opção do administrador como parâmetro e chamar a função
%escolhida. Caso a opção seja invalida o menu_admin_gerenciar_estoque será novamente executada.
escolheOpcoesGerenciarEstoque(1) :- adicionaFilmeAoEstoque.
escolheOpcoesGerenciarEstoque(2) :- verificaDisponibilidadeFilme.
escolheOpcoesGerenciarEstoque(3) :- sleep(2),opcoesMenuAdmin, adm_read(Opcao), escolheOpcoesMenuPrincipalAdmin(Opcao).
escolheOpcoesGerenciarEstoque(_) :- opcaoInvalida, sleep(2), menu_admin_gerenciar_estoque.

% Método responsável por verificar a disponibilidade de filmes no estoque da locadora.
verificaDisponibilidadeFilme :-
    msgDisponibilidadeFilmes,
    sleep(2),
    msgDisponibilidadeFilmes,
    adm_read(Opcao),
    escolheOpcoesGerenciarEstoque(Opcao). 

% Método responsável por adicionar uma quantidade X indicada pelo administrador do sistema, no estoque de filmes da locadora.
adicionaFilmeAoEstoque :-
    msgEstoqueFilmes,
    msgFilmeIdentificador,
    msgFilmeQuantidade,
    sleep(2),
    msgEstoqueFilmes,
    adm_read(Opcao),
    escolheOpcoesGerenciarEstoque(Opcao).

% Metodo de exibição do menu principal do perfil de administrador do sistema.
menu_admin_gerenciar_estoque :-
    opcoesGerenciarEstoque,
    adm_read(Opcao),
    escolheOpcoesGerenciarEstoque(Opcao).

% Método responsável por pedir os dados do filme para que seja possível realizar o cadastro de filme no sistema.
cadastrar_filme :-
    msgCadastroFilmeTitulo,
    msgCadastroFilmeGenero,
    msgCadastroFilmeDiretor,
    msgCadastroFilmeData,
    msgFilmeQuantidade. 

%  Método de exibição do menu de opções de históricos do admin.
exibir_menu_historico :-
    menuHistorico,
    nl,
    adm_read(Opcao),
    escolhe_opcoes_historico(Opcao).

escolhe_opcoes_historico(1) :-
    logo_historico(),

    exibe_historico_geral(),
    opcoesHistorico,

    nl,
    adm_read(Opcao),
    escolhe_opcoes_historico(Opcao).

escolhe_opcoes_historico(2) :-
    logo_historico(),

    write('Digite o CPF do cliente: '),
    read(CPF),
    exibe_historico_cliente(CPF),
    opcoesHistorico,

    nl,
    adm_read(Opcao),
    escolhe_opcoes_historico(Opcao).

escolhe_opcoes_historico(3) :-
    logo_historico(),
    
    exibe_historico_em_andamento(),
    opcoesHistorico,

    nl,
    adm_read(Opcao),
    escolhe_opcoes_historico(Opcao).

escolhe_opcoes_historico(4) :- menu_principal_admin.
escolhe_opcoes_historico(_) :-
    opcaoInvalida,
    sleep(1),
    exibir_menu_historico.

main :-
    cria_intro,
    menu_principal,
    halt.


% Metodo responsavel por realizar o cadastro de um novo usuario no sitema 
% com nome, cpf, telefone e endereco.
cadastro_usuario :- 
    msgCadastroNome,
    read(Nome),
    recebeNomeUsuario(Nome).

recebeNomeUsuario("S") :- menu_principal.
recebeNomeUsuario(Nome) :- 
    msgCadastroCpf,
    read(CPF),
    recebeCpfUsuario(Nome, CPF).

recebeCpfUsuario(_, "S") :- menu_principal.
recebeCpfUsuario(Nome, CPF) :- 
    msgCadastroTelefone,
    read(Telefone),
    recebeTelefoneUsuario(Nome, CPF, Telefone).

recebeTelefoneUsuario(_, _, "S") :- menu_principal.
recebeTelefoneUsuario(Nome, CPF, Telefone) :-
    msgCadastroEndereco,
    read(Endereco),
    recebeEnderecoUsuario(Nome, CPF, Telefone, Endereco).

recebeEnderecoUsuario(_, _, _, "S") :- menu_principal.
recebeEnderecoUsuario(Nome, CPF, Telefone, Endereco) :-
    cadastra_usuario(Nome, CPF, Telefone, Endereco).

cadastra_usuario(Nome, CPF, Telefone, Endereco) :-
    locadora_add_cliente(Nome, CPF, Telefone, Endereco, Resumo),
    msgResumoCadastroUsuario(Resumo),
    read(Opcao),
    retorna(Opcao, menu_principal).


% Metodo responsavel por retornar a uma funcao especifica X, 
% ou persistir em caso de opcao invalida.
retorna("S", X) :- X.
retorna(_, X) :- msgDigiteS, read(Opcao), retorna(Opcao, X).

% Metodo responsavel por realizar o login de um clinete ao sistema.
login_cliente :- 
    msgLoginCliente,
    read(Entrada),
    proximaEtapaLoginCliente(Entrada).

proximaEtapaLoginCliente("S") :- menu_principal.
proximaEtapaLoginCliente(CPF) :- locadora_eh_cliente(CPF, R),
    (R -> menu_principal_cliente(CPF); msgUserInvalido, retorna(0, login_cliente)).

% Metodo de exibição do menu de opções do cliente.
menu_principal_cliente(CPF) :- 
    locadora_get_nome(CPF, Nome),
    opcoesMenuCliente(Nome),
    cliente_read(Opcao),
    escolheOpcoesMenuPrincipalCliente(Opcao, CPF).

% Metodo que recebe uma opção de usuario como parâmetro e é responsável por chamar a função
% adequada. Caso a opção seja invalida o menuPrincipalAdmin é novamente chamado.
escolheOpcoesMenuPrincipalCliente(1, CPF) :- listar_filmes(CPF, menu_principal_cliente(CPF)).
escolheOpcoesMenuPrincipalCliente(2, CPF) :- locar_filme(CPF).
escolheOpcoesMenuPrincipalCliente(3, CPF) :- recomendar_filme(CPF).
escolheOpcoesMenuPrincipalCliente(4, CPF) :- devolver_filme(CPF).
escolheOpcoesMenuPrincipalCliente(5, CPF) :- menu_principal.
escolheOpcoesMenuPrincipalAdmin(_, CPF) :- menu_principal_cliente(CPF).


% Metodo responsavel por listar todos os filmes disponiveis para locação.
listar_filmes(CPF, X) :-
    msgListaFilmes, nl,
    locadora_lista_filmes,
    retorna(0, X).


% Metodo responsavel por fazer a locação de um filme para um cliente.
locar_filme(CPF) :- 
    msgLocacaoFilme,
    read(Entrada),
    proximaEtapaLocacao(Entrada, CPF).

proximaEtapaLocacao("S", CPF) :- menu_principal_cliente(CPF).
proximaEtapaLocacao("L", CPF) :- listar_filmes(CPF, locar_filme(CPF)).
proximaEtapaLocacao(ID, CPF) :- locadora_eh_filme(ID, F),
    (F ->  loca_filme(ID, CPF); msgFilmeNaoCadastrado, retorna(0, locar_filme(CPF))).

loca_filme(ID, CPF) :- locadora_filme_disponivel(ID, D),
    (not(D) -> msgFilmeNaoDisponivel, retorna(0, locar_filme(CPF));
    msgDataLocacao,
    read(Entrada),
    recebeDataLocacao(Entrada, CPF, ID)).

recebeDataLocacao("S", CPF, _) :- menu_principal_cliente(CPF).
recebeDataLocacao(Data, CPF, ID) :- 
    locadora_add_locacao(ID, CPF, Data),
    locadora_get_titulo(ID, Titulo),
    locadora_get_estoque(ID, Estoque),
    msgLocaFilme(Titulo, Estoque),
    retorna(0, menu_principal_cliente(CPF)).


% Metodo responsavel por recomendar um filme ao cliente com base no genero ecolhido.
recomendar_filme(CPF) :- 
    msgRecomendacaoGenero,
    read(Entrada),
    proximaEtapaRecomendacao(Entrada, CPF).

proximaEtapaRecomendacao("S", CPF) :- menu_principal_cliente(CPF).
proximaEtapaRecomendacao(Genero, CPF) :- locadora_eh_genero_valido(Genero, R),
    (R -> recomenda_filme(Genero, CPF); msgGeneroInvalido, retorna(0, recomendar_filme(CPF))).

recomenda_filme(Genero, CPF) :-
    locadora_recomenda_filme(Genero, ID),
    locadora_get_titulo(ID, Titulo),
    msgRecomendacao(Titulo),
    msgRecomendaLocacao,
    read(Opcao),
    proximaEtapaRecomenda(Opcao, CPF, ID).

proximaEtapaRecomenda("n", CPF, _) :- menu_principal_cliente(CPF).
proximaEtapaRecomenda("y", CPF, ID) :- loca_filme(ID, CPF).
proximaEtapaRecomenda("S", CPF, ID) :- menu_principal_cliente(CPF).
proximaEtapaRecomenda(_, CPF, _) :- opcaoInvalida, retorna(0, recomendar_filme(CPF)).

% Metodo responsavel por finalizar uma locaçao do cliente e devolver o filme.
devolver_filme(CPF) :- 
    msgDevolucaoTop,
    locadora_lista_locacoes_cliente(CPF),
    msgDevolucaoBottom,
    read(Entrada),
    proximaEtapaDevolucao(Entrada, CPF).

proximaEtapaDevolucao("S", CPF) :- menu_principal_cliente(CPF).
proximaEtapaDevolucao(ID, CPF) :- locadora_locacao_existe(ID, L),
    (L -> devolve_filme(ID, CPF); opcaoInvalida, retorna(0, devolver_filme(CPF))).

devolve_filme(ID, CPF) :-
    locadora_finaliza_locacao(ID, IDFilme),
    locadora_get_estoque(IDFilme, Estoque),
    msgDevolveFilme(Estoque),
    retorna(0, menu_principal_cliente(CPF)).