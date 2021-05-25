:- (initialization main).
:- include('Util.pl').
:- include('Info.pl').
:- include('animacoes.pl').
:- include('Locacao.pl').
:- include('Locadora.pl').

main :-
    cria_intro,
    menu_principal,
    halt.

% Exibição do menu principal do sistema.
menu_principal :-
    opcoesMenuInicial,
    read(Opcao),
    escolheOpcoesMenuPrincipal(Opcao).

% Metodo que recebe uma opção de usuario como parâmetro e é responsável por chamar a função
% adequada. Caso a opção seja invalida o menuPrincipalAdmin é novamente chamado.
escolheOpcoesMenuPrincipal(1) :- login_cliente.
escolheOpcoesMenuPrincipal(2) :- menu_principal_admin.
escolheOpcoesMenuPrincipal(3) :- cadastro_usuario.
escolheOpcoesMenuPrincipal(4) :- cria_outro. %saída do sistema.
escolheOpcoesMenuPrincipal() :- menu_principal.

%  Método de exibição do primeiro menu de opções do admin.
menu_principal_admin :-
    opcoesMenuAdmin,
    adm_read(Opcao),
    escolheOpcoesMenuPrincipalAdmin(Opcao).

% Metodo que recebe uma opção de usuario como parâmetro e é responsável por chamar a função
% adequada. Caso a opção seja invalida o menuPrincipalAdmin é novamente chamado.
escolheOpcoesMenuPrincipalAdmin(1) :- cadastrar_filme.
escolheOpcoesMenuPrincipalAdmin(2) :- exibir_menu_historico.
escolheOpcoesMenuPrincipalAdmin(3) :- menu_admin_gerenciar_estoque.
escolheOpcoesMenuPrincipalAdmin(4) :- menu_principal.
escolheOpcoesMenuPrincipalAdmin(_) :- menu_principal_admin.

% Metodo responsável por receber uma opção do administrador como parâmetro e chamar a função
%escolhida. Caso a opção seja invalida o menu_admin_gerenciar_estoque será novamente executada.
escolheOpcoesGerenciarEstoque(1) :- adicionaFilmeAoEstoque.
escolheOpcoesGerenciarEstoque(2) :- verificaDisponibilidadeFilme.
escolheOpcoesGerenciarEstoque(3) :- opcoesMenuAdmin, adm_read(Opcao), escolheOpcoesMenuPrincipalAdmin(Opcao).
escolheOpcoesGerenciarEstoque(_) :- menu_admin_gerenciar_estoque.

% Metodo de exibição do menu principal do perfil de administrador do sistema.
menu_admin_gerenciar_estoque :-
    opcoesGerenciarEstoque,
    adm_read(Opcao),
    escolheOpcoesGerenciarEstoque(Opcao).

%  Método de exibição do menu de opções de históricos do admin.
exibir_menu_historico :-
    menuHistorico, nl,
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


% Metodo responsavel por realizar o cadastro de um novo usuario no sitema 
% com nome, cpf, telefone e endereco.
cadastro_usuario :- 
    msgCadastroNome,
    read(Nome),
    recebeNomeUsuario(Nome).

% Metodo responsavel por verificar o nome do usuario e seguir para a proxima etapa de cadastro.
recebeNomeUsuario("S") :- menu_principal.
recebeNomeUsuario(Nome) :- 
    msgCadastroCpf,
    read(CPF),
    recebeCpfUsuario(Nome, CPF).

% Metdodo responsavel por verificar o cpf do ususario e segir para a proxima etapa do cadastro.
recebeCpfUsuario(_, "S") :- menu_principal.
recebeCpfUsuario(Nome, CPF) :- 
    msgCadastroTelefone,
    read(Telefone),
    recebeTelefoneUsuario(Nome, CPF, Telefone).

% Metdodo responsavel por verificar o telefone do ususario e segir para a proxima etapa do cadastro.
recebeTelefoneUsuario(_, _, "S") :- menu_principal.
recebeTelefoneUsuario(Nome, CPF, Telefone) :-
    msgCadastroEndereco,
    read(Endereco),
    recebeEnderecoUsuario(Nome, CPF, Telefone, Endereco).

% Metdodo responsavel por verificar o endereco do ususario e segir para a proxima etapa do cadastro.
recebeEnderecoUsuario(_, _, _, "S") :- menu_principal.
recebeEnderecoUsuario(Nome, CPF, Telefone, Endereco) :-
    cadastra_usuario(Nome, CPF, Telefone, Endereco).

% Metdodo responsavel por finalizar o cadastro do usuario.
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

% Metodo responsavel por verificar o cpf do cliente e possibilitar o login.
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


%---------------------------------------Adm/Cadastro/Gerenciamento/Filme------------------------------------------------------
% Método responsável por pedir os dados do filme para que seja possível realizar o cadastro de filme no sistema.
cadastrar_filme :-
    msgCadastroFilmeTitulo,
    read(Titulo),
    recebeTituloFilme(Titulo).

% Metodo reponsavel por verificar o tiulo e  seguir para proxima etapa do cadastro.
recebeTituloFilme("S") :- menu_principal_admin.
recebeTituloFilme(Titulo) :- 
    msgCadastroFilmeGenero, read(Genero),
    recebeGeneroFilme(Genero, Titulo).

% Metodo reponsavel por verificar o genero e  seguir para proxima etapa do cadastro.
recebeGeneroFilme("S", _) :- menu_principal_admin.
recebeGeneroFilme(Genero, Titulo):-
    msgCadastroFilmeDiretor, read(Diretor),
    recebeDiretorFilme(Diretor, Genero, Titulo).

% Metodo reponsavel por verificar o diretor e  seguir para proxima etapa do cadastro.
recebeDiretorFilme("S", _, _) :- menu_principal_admin.
recebeDiretorFilme(Diretor, Genero, Titulo ):-
    msgCadastroFilmeData, read(Data),
    recebeDataFilme(Data, Diretor, Genero, Titulo).

% Metodo reponsavel por verificar a data e  seguir para proxima etapa do cadastro.
recebeDataFilme("S", _, _, _) :- menu_principal_admin.
recebeDataFilme(Data, Diretor, Genero, Titulo):-
    msgFilmeQuantidade, read(Quantidade),
    recebeQuantidadeFilme(Quantidade, Data, Diretor, Genero, Titulo).

% Metodo reponsavel por verificar a quantidade e finalizar o cadastro do filme.
recebeQuantidadeFilme("S", _, _, _, _) :- menu_principal_admin.
recebeQuantidadeFilme(Quantidade, Data, Diretor, Genero, Titulo) :-
    (Quantidade > 0 ->  cadastraFilme(Titulo, Diretor, Data, Genero, Quantidade, Id),
    msgResumoCadastroFilme(Id,Titulo, Genero, Diretor, Data, Quantidade),  retorna(0,menu_principal_admin);
    msgQuantidadeInvalida, retorna(0, cadastrar_filme)).


% Método responsável por verificar a quantidade de um determinado filme no estoque.
verificaDisponibilidadeFilme :-
    msgDisponibilidadeFilmes,
    locadora_lista_todos_filmes,
    msgFilmeIdentificador, read(Id),
    recebeIdFilme(Id).

% Método auxiliar utilizado no método verificaDisponibilidade, responsável por verificar se a opção passada pelo
%usuário é válida e se caso ele digitar "S", ele será redirecionado para o menu anterior.
recebeIdFilme("S"):- menu_admin_gerenciar_estoque.
recebeIdFilme(Id) :- locadora_eh_filme(Id, R),
    (R -> disponibilidade_filme(Id);
    msgFilmeIdNaoCadastrado(Id), retorna(0, verificaDisponibilidadeFilme)).

% Método auxiliar utilizado no método verificaDisponibilidade, responsável por listar a disponibilidade do filme,
%juntamente com sua quantidade e o seu título.
disponibilidade_filme(Id) :-
    getEstoque(Id, Estoque),
    getTitulo(Id, Titulo),
    msgQtdTituloFilme(Estoque, Titulo),
    retorna(0, menu_admin_gerenciar_estoque).


% Método responsável por adicionar uma quantidade X indicada pelo administrador do sistema, no estoque de filmes da locadora.
adicionaFilmeAoEstoque :-
    msgEstoqueFilmes,
    msgFilmeIdentificador,
    read(IdFilme),
    recebeIdFilmeEstoque(IdFilme).

%Método responsável por verificar se a opção passada pelo usuário é válida e se caso ele digitar "S", ele será redirecionado para o menu anterior.
recebeIdFilmeEstoque("S"):- menu_admin_gerenciar_estoque.
recebeIdFilmeEstoque(Id) :- locadora_eh_filme(Id, R),
    (R -> recebeQuantidadeEstoque(Id);
    msgFilmeIdNaoCadastrado(Id), retorna(0, adicionaFilmeAoEstoque)).

%Método responsável por receber a nova quantidade do filme e adicionar a quantidade passada pelo usuario a atual,
%além de verificar se a opção passada pelo usuário é válida e se caso ele digitar "S", ele será redirecionado para o menu anterior.
recebeQuantidadeEstoque("S") :- menu_admin_gerenciar_estoque.
recebeQuantidadeEstoque(IdFilme) :- 
    msgFilmeQuantidade,
    read(Quantidade),
    (Quantidade < 1 -> msgQuantidadeInvalida, retorna(0, adicionaFilmeAoEstoque);
    setEstoque(IdFilme, Quantidade),
    getEstoque(IdFilme, Estoque),
    getTitulo(IdFilme, Titulo),
    msgEstoqueAdicionado(Estoque, Titulo), retorna(0, menu_admin_gerenciar_estoque);
    msgFilmeIdNaoCadastrado(IdFilme), nl, 
    retorna(0, adicionaFilmeAoEstoque)).


% Metodo responsavel por listar todos os filmes disponiveis para locação.
listar_filmes(CPF, X) :-
    msgListaFilmes, nl,
    locadora_lista_filmes_disponiveis,
    retorna(0, X).


% Metodo responsavel por fazer a locação de um filme para um cliente com id do filme e dada da locacao.
locar_filme(CPF) :- 
    msgLocacaoFilme,
    read(Entrada),
    proximaEtapaLocacao(Entrada, CPF).

% Metodo responsavel por fazer verificacoes de entrada e seguir para a proxima etapa da locacao.
proximaEtapaLocacao("S", CPF) :- menu_principal_cliente(CPF).
proximaEtapaLocacao("L", CPF) :- listar_filmes(CPF, locar_filme(CPF)).
proximaEtapaLocacao(ID, CPF) :- locadora_eh_filme(ID, F),
    (F ->  loca_filme(ID, CPF); msgFilmeNaoCadastrado, retorna(0, locar_filme(CPF))).

% Metodo responsavel por receber a data da locacao e segir para a proxima etapa da locacao.
loca_filme(ID, CPF) :- locadora_filme_disponivel(ID, D),
    (not(D) -> msgFilmeNaoDisponivel, retorna(0, locar_filme(CPF));
    msgDataLocacao,
    read(Entrada),
    recebeDataLocacao(Entrada, CPF, ID)).

% Metodo reponsaavel por verificar a data e finalizar a locacao.
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

% Metodo responsavel por verificar o genero e seguir para a proxima etapa de recomendacao.
proximaEtapaRecomendacao("S", CPF) :- menu_principal_cliente(CPF).
proximaEtapaRecomendacao(Genero, CPF) :- locadora_eh_genero_valido(Genero, R),
    (R -> recomenda_filme(Genero, CPF); msgGeneroInvalido, retorna(0, recomendar_filme(CPF))).

% Metodo responsavel por recomendar e solicitar ao cliente a locacao do filme recomendado.
recomenda_filme(Genero, CPF) :-
    locadora_recomenda_filme(Genero, ID),
    locadora_get_titulo(ID, Titulo),
    msgRecomendacao(Titulo),
    msgRecomendaLocacao,
    read(Opcao),
    proximaEtapaRecomenda(Opcao, CPF, ID).

% Metodo responsavel por verificar a opcao do cliente em relacao a locacao e finalizar a recomendacao.
proximaEtapaRecomenda("n", CPF, _) :- menu_principal_cliente(CPF).
proximaEtapaRecomenda("y", CPF, ID) :- loca_filme(ID, CPF).
proximaEtapaRecomenda("S", CPF, ID) :- menu_principal_cliente(CPF).
proximaEtapaRecomenda(_, CPF, _) :- opcaoInvalida, retorna(0, recomendar_filme(CPF)).

% Metodo responsavel por finalizar uma locaçao do cliente e devolver o filme.
devolver_filme(CPF) :- 
    msgDevolucaoTop,
    locadora_lista_locacoes_cliente(CPF),
    msgDevolucaoBottom, read(Entrada),
    proximaEtapaDevolucao(Entrada, CPF).

% Metodo responsavel por verificar o id da locacao e seguir para a proxima etapa da devolucao.
proximaEtapaDevolucao("S", CPF) :- menu_principal_cliente(CPF).
proximaEtapaDevolucao(ID, CPF) :- locadora_locacao_existe(ID, L),
    (L -> devolve_filme(ID, CPF); opcaoInvalida, retorna(0, devolver_filme(CPF))).

% Metodo responsavel por finlizar a devolucao de um filme.
devolve_filme(ID, CPF) :-
    locadora_finaliza_locacao(ID, IDFilme),
    locadora_get_estoque(IDFilme, Estoque),
    msgDevolveFilme(Estoque),
    retorna(0, menu_principal_cliente(CPF)).