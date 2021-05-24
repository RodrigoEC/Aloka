:- (initialization main).
:- include('Util.pl').
:- include('Info.pl').
:- include('animacoes.pl').
:- include('Locacao.pl').
:- include('Cliente.pl').
:- include('Filme.pl').

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
    adiciona_cliente(Nome, CPF, Telefone, Endereco, Resumo),
    msgResumoCadastroUsuario(Resumo),
    read(Opcao),
    retorna(Opcao, menu_principal).

retorna("S", X) :- X.
retorna(_, X) :- msgDigiteS, read(Opcao), retorna(Opcao, X).


login_cliente :- 
    msgLoginCliente,
    read(Entrada),
    verificaEntradaLoginCliente(Entrada).

verificaEntradaLoginCliente("S") :- menu_principal.
verificaEntradaLoginCliente(CPF) :- eh_cliente(CPF, R),
    (R -> menu_principal_cliente(CPF); msgUserInvalido, retorna(0, login_cliente)).
verificaEntradaLoginCliente(_) :- opcaoInvalida, login_cliente.

menu_principal_cliente(CPF) :- 
    get_nome(CPF, Nome),
    opcoesMenuCliente(Nome),
    cliente_read(Opcao),
    escolheOpcoesMenuPrincipalCliente(Opcao, CPF).

escolheOpcoesMenuPrincipalCliente(1, CPF) :- listar_filmes(CPF, menu_principal_cliente(CPF)).
escolheOpcoesMenuPrincipalCliente(2, CPF) :- locar_filme(CPF).
escolheOpcoesMenuPrincipalCliente(3, CPF) :- recomendar_filme(CPF).
escolheOpcoesMenuPrincipalCliente(4, CPF) :- devolver_filme(CPF).
escolheOpcoesMenuPrincipalCliente(5, CPF) :- menu_principal.
escolheOpcoesMenuPrincipalAdmin(_, CPF) :- menu_principal_cliente(CPF).

listar_filmes(CPF, X) :-
    msgListaFilmes, nl,
    lista_filmes,
    retorna(0, X).

locar_filme(CPF) :- 
    msgLocacaoFilme,
    read(Entrada),
    verificaEntradaLocacao(Entrada, CPF).

verificaEntradaLocacao(Entrada, CPF) :- ID is Entrada,
    (Entrada =:= "S" -> menu_principal_cliente(CPF);
    Entrada =:= "L" -> listar_filmes(CPF, 'L');
    /*verificaIdFilme(ID) -> loca_filme(ID, CPF),  menu_principal_cliente(CPF);*/
    msgIdInvalido, locar_filme(CPF)).
