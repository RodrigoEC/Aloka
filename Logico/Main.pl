:- (initialization main).
:- include('Util.pl').
:- include('Info.pl').

% Metodo que cria a animação de introdução do sistema.
cria_intro() :-
    NomesArquivos=[loading1, 0.3, loading2, 0.3, loading3, 0.3, loading4, 0.3, logo, 0.3],
    cria_animacao(NomesArquivos).

% Metodo que cria a animação de saída do sistema
cria_outro() :-
    NomesArquivos=[logo, 0.3, loading4, 0.3, loading3, 0.3, loading2, 0.3, loading1, 0.3, claquete, 0.5],
    cria_animacao(NomesArquivos).

% Método que realiza a seleção e exibição das opções referentes ao menu de funcionalidades do administrador.
escolheOpcoesMenuPrincipal(1) :- write('Login como cliente').
escolheOpcoesMenuPrincipal(2) :- opcoesMenuAdmin.
escolheOpcoesMenuPrincipal(3) :- write('Cadastro de usuário').
escolheOpcoesMenuPrincipal(4) :- cria_outro.
escolheOpcoesMenuPrincipal(_) :- opcaoInvalida, menu_principal.

% Metodo que recebe uma opção de usuario como parâmetro e é responsável por chamar a função
% adequada. Caso a opção seja invalida o menuPrincipalAdmin é novamente chamado.
escolheOpcoesMenuPrincipalAdmin(1) :- cadastrar_filme.
escolheOpcoesMenuPrincipalAdmin(2) :- exibir_historico.
escolheOpcoesMenuPrincipalAdmin(3) :- writeln(3).
escolheOpcoesMenuPrincipalAdmin(4) :- cria_outro.
escolheOpcoesMenuPrincipalAdmin(_) :- opcaoInvalida, menu_principal_admin.

exibir_historico :-
    opcoesHistorico,
    nl,
    read(Opcao),
    escolheOpcoesHistorico(Opcao).

escolheOpcoesHistorico(1) :-
    write(7),
    sleep(2),
    exibir_historico.

escolheOpcoesHistorico(2) :-
    write(4),
    sleep(2),
    exibir_historico.

escolheOpcoesHistorico(3) :-
    write(6),
    sleep(2),
    exibir_historico.

escolheOpcoesHistorico(4) :-
    menu_principal.

escolheOpcoesHistorico(_) :-
    opcaoInvalida,
    sleep(1),
    exibir_historico.

% Exibição do menu principal do sistema.
menu_principal :-
    opcoesMenuInicial,
    read(Opcao),
    escolheOpcoesMenuPrincipal(Opcao).

% Metodo de exibição do menu principal do perfil de administrador do sistema.
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

main :-
    cria_intro,
    menu_principal,
    menu_principal_admin,
    halt.