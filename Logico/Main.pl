:- (initialization main).
:- include('Util.pl').
:- include('Info.pl').
:- include('animacoes.pl').
:- include('Locacao.pl').

% Exibição do menu principal do sistema.
menu_principal :-
    opcoesMenuInicial,
    read(Opcao),
    escolheOpcoesMenuPrincipal(Opcao).

% Método que realiza a seleção e exibição das opções referentes ao menu de funcionalidades do administrador.
escolheOpcoesMenuPrincipal(1) :- write('Login como cliente').
escolheOpcoesMenuPrincipal(2) :- menu_principal_admin.
escolheOpcoesMenuPrincipal(3) :- write('Cadastro de usuário').
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

% Opção 01 do histórico. É exibido ao usuário o histórico geral de locações do sistema.
escolhe_opcoes_historico(1) :-
    logo_historico(),

    exibe_historico_geral(),
    opcoesHistorico,

    nl,
    adm_read(Opcao),
    escolhe_opcoes_historico(Opcao).

% Opção 02 do histórico. É exibido ao usuário o histórico de locações de um cliente em específico.
escolhe_opcoes_historico(2) :-
    logo_historico(),

    msgVoltarMenuAnterior(),
    msgCadastroCpf(),
    adm_read(CPF),
    (CPF = 'S' -> exibir_menu_historico();

    exibe_historico_cliente(CPF),
    opcoesHistorico,

    nl,
    adm_read(Opcao),
    escolhe_opcoes_historico(Opcao)).

% Opção 03 do histórico. É exibido ao usuário as locações que estão em andamento no momento.
escolhe_opcoes_historico(3) :-
    logo_historico(),
    
    exibe_historico_em_andamento(),
    opcoesHistorico,

    nl,
    adm_read(Opcao),
    escolhe_opcoes_historico(Opcao).

% Opção 04 do histórico. O usuário é redirecionado para o menu de opções do admin.
escolhe_opcoes_historico(4) :- menu_principal_admin.
% Caso o usuário passe uma entrada que não se encaixa nas quatro opções acima uma mensagem de erro é
% exibida e o sistema volta ao menu de históricos depois de 1 segundo.
escolhe_opcoes_historico(_) :-
    opcaoInvalida,
    sleep(1),
    exibir_menu_historico.

main :-
    cria_intro,
    menu_principal,
    halt.