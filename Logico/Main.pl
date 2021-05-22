:- (initialization main).
:- include('Util.pl').
:- include('Info.pl').
:- include('animacoes.pl').


% Método que realiza a seleção e exibição das opções referentes ao menu de funcionalidades do administrador.
escolheOpcoesMenuPrincipal(1) :- write('Login como cliente').
escolheOpcoesMenuPrincipal(2) :- opcoesMenuAdmin.
escolheOpcoesMenuPrincipal(3) :- write('Cadastro de usuário').
escolheOpcoesMenuPrincipal(4) :- cria_outro.
escolheOpcoesMenuPrincipal(_) :- opcaoInvalida, menu_principal.

% Metodo que recebe uma opção de usuario como parâmetro e é responsável por chamar a função
% adequada. Caso a opção seja invalida o menuPrincipalAdmin é novamente chamado.
escolheOpcoesMenuPrincipalAdmin(1) :- cadastrar_filme.
escolheOpcoesMenuPrincipalAdmin(2) :- exibir_menu_historico.
escolheOpcoesMenuPrincipalAdmin(3) :- menu_admin_gerenciar_estoque.
escolheOpcoesMenuPrincipalAdmin(4) :- cria_outro.
escolheOpcoesMenuPrincipalAdmin(_) :- opcaoInvalida, menu_principal_admin.

% Metodo responsável por receber uma opção do administrador como parâmetro e chamar a função
%escolhida. Caso a opção seja invalida o menu_admin_gerenciar_estoque será novamente executada.
escolheOpcoesGerenciarEstoque(1) :- adicionaFilmeAoEstoque.
escolheOpcoesGerenciarEstoque(2) :- verificaDisponibilidadeFilme.
escolheOpcoesGerenciarEstoque(3) :- opcoesMenuAdmin.
escolheOpcoesGerenciarEstoque(_) :- opcaoInvalida, menu_admin_gerenciar_estoque.

% Método responsável por verificar a disponibilidade de filmes no estoque da locadora.
verificaDisponibilidadeFilme :-
    msgDisponibilidadeFilmes,
    nl,
    adm_read(Opcao),
    escolheOpcoesGerenciarEstoque(Opcao).

% Método responsável por adicionar uma quantidade X indicada pelo administrador do sistema, no estoque de filmes da locadora.
adicionaFilmeAoEstoque :-
    msgEstoqueFilmes,
    nl,
    adm_read(Opcao),
    escolheOpcoesGerenciarEstoque(Opcao),
    msgFilmeIdentificador,
    msgFilmeQuantidade.

% Exibição do menu principal do sistema.
menu_principal :-
    opcoesMenuInicial,
    read(Opcao),
    escolheOpcoesMenuPrincipal(Opcao).

% Metodo de exibição do menu principal do perfil de administrador do sistema.
menu_admin_gerenciar_estoque :-
    opcoesGerenciarEstoque,
    read(Opcao),
    escolheOpcoesGerenciarEstoque(Opcao).

menu_principal_admin :-
    opcoesMenuAdmin,
    read(Opcao),
    escolheOpcoesMenuPrincipalAdmin(Opcao).

% Método responsável por pedir os dados do filme para que seja possível realizar o cadastro de filme no sistema.
cadastrar_filme :-
    msgCadastroFilmeTitulo,
    msgCadastroFilmeGenero,
    msgCadastroFilmeDiretor,
    msgCadastroFilmeData,
    msgFilmeQuantidade.

exibir_menu_historico :-
    opcoesHistorico,
    nl,
    read(Opcao),
    escolheOpcoesHistorico(Opcao).

escolheOpcoesHistorico(1) :-
    write(7),
    sleep(2),
    exibir_menu_historico.

escolheOpcoesHistorico(2) :-
    write(4),
    sleep(2),
    exibir_menu_historico.

escolheOpcoesHistorico(3) :-
    write(6),
    sleep(2),
    exibir_menu_historico.

escolheOpcoesHistorico(4) :-
    menu_principal.

escolheOpcoesHistorico(_) :-
    opcaoInvalida,
    sleep(1),
    exibir_menu_historico.

main :-
    cria_intro,
    menu_principal,
    menu_principal_admin,
    halt.