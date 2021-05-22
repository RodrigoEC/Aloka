:- include('Util.pl').
 
 % Método que faz a exibição das opções destinadas ao histórico.
opcoesHistorico() :-
    put_logo_historico(),
    writeln('Como deseja prosseguir?'),
    writeln('[1] Exibir histórico geral'),
    writeln('[2] Exibir histórico do cliente'),
    writeln('[3] Exibir locações em andamento'),
    writeln('[4] Voltar ao menu inicial').

% Método que realiza a exibição das opções relacionadas ao menu inicial.
opcoesMenuInicial() :-
    put_logo(),
    writeln('       ----MENU PRINCIPAL----'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Login como cliente'),
    writeln('[2] Login como administrador'),
    writeln('[3] Cadastro de usuário'),
    writeln('[4] Sair\n').

% Método que realiza a exibição das opções relacionadas ao menu do cliente.
opcoesMenuCliente(Nome) :-
    put_logo(),
    write('       --LUZ, CÂMERA, AÇÃO!--'),
    nl,
    string_concat('             Olá, ', Nome, Return),
    nl,
    write(Return),
    writeln('!'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Listar filmes'),
    writeln('[2] Fazer locação'),
    writeln('[3] Recomendação da locadora'),
    writeln('[4] Devolução da locação'),
    writeln('[5] Voltar ao menu principal\n').

% Método que realiza a exibição das opções relacionadas ao menu do administrador.
opcoesMenuAdmin() :- 
    put_logo(),
    writeln('       -----ADMINISTRADOR-----'),
    writeln('\nOlá, Administrador!'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Cadastrar filme'),
    writeln('[2] Exibir histórico de locações'),
    writeln('[3] Gerenciar estoque'),
    writeln('[4] Voltar ao menu principal\n').

% Método que realiza a exibição das opções relacionadas às exibições dos históricos de locações.
opcoesExibirLocacoes() :-
    put_logo(),
    writeln('       -----ADMINISTRADOR-----'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Exibir histórico geral'),
    writeln('[2] Exibir histórico do cliente'),
    writeln('[3] Exibir locações em andamento'),
    writeln('[4] Voltar\n').

% Método que realiza a exibição das opções relacionadas à adição e verificação do estoque da locadora .
opcoesGerenciarEstoque() :-
    put_logo(),
    writeln('       -----ADMINISTRADOR-----'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Adicionar estoque ao filme'),
    writeln('[2] Verificar disponibilidade de filmes'),
    writeln('[3] Voltar ao menu inicial\n').

% Método que faz a exibição de erro quando uma dada opção escolhida é inválida.
opcaoInvalida() :- 
    writeln('\nErro: opção inválida!').

% Método que faz a exibição de erro quando o CPF digitado é inválido.
msgCpfInvalido() :- 
    writeln('\nErro: CPF inválido!').

% Método que realiza a exibição de erro quando o nome de usuário digitado é inválido.
msgUserInvalido() :-
    writeln('\nErro: usuário não cadastrado!').

% Método que realiza a exibição de erro quando o identificador do usuário digitado é inválido.
msgIdInvalido() :-
    writeln('\nErro: id inválido!').

% Método que realiza a exibição de erro quando o gênero de filme digitado é inválido.
msgGeneroInvalido() :-
   writeln('\nErro: gênero inválido!').

% Método que realiza a exibição de erro quando a quantidade digitada é inválida.
msgQuantidadeInvalida() :-
   writeln('\nErro: quantidade inválida!').

% Método que realiza a exibição de erro quando o filme requerido para locação não está devidamente cadastrado no sistema.
msgFilmeNaoCadastrado() :-
   writeln('\nErro: filme não cadastrado!').

% Método que realiza a exibição de erro quando o filme requerido para a locação não está disponível no estoque da locadora.
msgFilmeNaoDisponivel() :-
   writeln('\nErro: filme indisponível!').

% Método que realiza a exibição do menu de login destinado ao cliente da locadora.
msgLoginCliente() :-
    put_logo(),
    writeln('       -----LOGIN CLIENTE-----\n'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),
    writeln('\nOlá, cinéfilo(a)! :)\n'),

    writeln('Informe o seu CPF para continuar.'),
    writeln('\nCPF (apenas números): ').

% Método que realiza a exibição do menu de cadastro destinado ao cliente da locadora.
msgCadastroNome() :-
    put_logo(),
    writeln('       -------CADASTRO-------'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),
    writeln('\nNome do usuário: ').

% Método que realiza a exibição de mensagem de pedido de CPF ao cliente da locadora.
msgCadastroCpf() :-
    writeln('--- \nCPF (apenas números): ').

% Método que realiza a exibição de mensagem de pedido de telefone ao cliente da locadora.
msgCadastroTelefone() :-
    writeln('--- \nTelefone (DDD + Número): ').

% Método que realiza a exibição de mensagem de pedido de endereco ao cliente da locadora.
msgCadastroEndereco() :-
    writeln('--- \nEndereço: ').

% Método que realiza a exibição de mensagem de pedido de gênero do filme a ser cadastrado no sistema.
msgCadastroFilmeGenero() :-
    writeln('Gênero: ').

% Método que realiza a exibição de mensagem de pedido de nome do diretor do filme a ser cadastrado no sistema.
msgCadastroFilmeDiretor() :-
    writeln('Diretor(a): ').

% Método que realiza a exibição de mensagem de pedido de data de lançamento do filme a ser cadastrado no sistema.
msgCadastroFilmeData() :-
    writeln('Data de lançamento (dd/mm/aaaa): ').

% Método que realiza a exibição de mensagem de pedido da quantidade do determinado filme a ser cadastrado no sistema.
msgFilmeQuantidade() :-
    writeln('Quantidade: ').

% Método que realiza a exibição de resumo do cadastro do cliente.
msgResumoCadastroUsuario(Cliente) :-
    put_logo(),
    writeln('       -------CADASTRO-------'),
    writeln('\n-----\n'),
    writeln(Cliente),
    writeln('\n-----').


% Método que realiza a exibição de resumo do cadastro do cliente.
msgResumoCadastroFilme(Filme) :-
    put_logo(),
    writeln('       -------CADASTRO-------'),
    writeln('\n-----\n'),
    writeln(Filme),
    writeln('\n-----\n').

% Método que realiza a exibição do pedido do identificador do filme para que este possa ser listado, caso esteja disponível para locação.
msgLocacaoFilme() :-
    put_logo(),
    writeln('       -VAI UM FILMINHO AI?-'),
    writeln('\nOBS: Para verificar a lista de filmes basta digitar "L"!'),
    writeln('     Para voltar ao menu basta digitar "S"!\n'),
    writeln('\nID do filme: ').

% Método que realiza o pedido de data de locação ao cliente.
msgDataLocacao() :-
   writeln('Insira a data da locação (dd/mm/aaaa): ').

% Método que realiza a exibição de mensagens de sucesso de locação e quantidade restantes do dado filme alugado no estoque.
msgLocaFilme(NomeFilme, Qtd) :-
    writeln('\nJá pode ir preparando a pipoca...\n'),
    string_concat('Filme, ', NomeFilme, Return),
    write(Return),
    writeln(' alugado com sucesso!\n'),
    string_concat('Agora só temos: ', Qtd, R),
    write(R),
    writeln(' unidade(s) disponivel(is).'),
    writeln('---\n').

% Método que realiza a exibição da logo de histórico de locacoes.
msgHistoricoLocacoes() :-
    put_logo_historico(),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n').

% Método que realiza o pedido de cpf do cliente para que sua(s) locação(oes) possa(m) ser listada(s).
msgHistoricoLocacoesCpf() :-
    put_logo_historico(),
    writeln('\nDigite o CPF do cliente: ').

% Método que exibe mensagem inicial da listagem de locações em andamento.
msgHistoricoLocacoesAndamento() :-
    put_logo_historico(),
    writeln('       --LOCAÇÕES ANDAMENTO--').

% Método que exibe mensagem inicial da adição de filmes ao estoque.
msgEstoqueFilmes() :-
    put_logo(),
    writeln('       ---ADICIONA ESTOQUE---'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n').

% Método que exibe mensagem inicial em relação a disponibilidade de filmes no estoque.
msgDisponibilidadeFilmes() :-
    put_logo(),
    writeln('       ----DISPONIBILIDADE---'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n').

% Método que realiza a pergunta de se o cliente deseja receber recomendações de filmes.
msgRecomendaLocacao() :-
    writeln('Você deseja fazer a locação desse filme? [y/n]').

% Método que exibe mensagem inicial da recomendação de filmes para locações por parte da locadora para o cliente.
msgRecomendacaoGenero() :-
    put_logo(),
    writeln('       -----RECOMENDAÇÃO-----'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),   
    writeln('\nInsira o gênero: ').

% Método que exibe mensagem inicial do resultado da recomendação de filmes para locações por parte da locadora para o cliente.
msgRecomendacao(NomeFilme) :-
    put_logo(),
    writeln('       -HMM VEJAMOS, JÁ SEI!-'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),   
    write('\nBaseado no seu perfil, recomendamos o seguinte filme: '),
    writeln(NomeFilme).

% Método que exibe mensagem inicial em relação a listagem de filmes.
msgListaFilmes() :-
    put_logo(),
    writeln('       ----LISTA DE FILMES---').

% Método que realiza a exibição da mensagem de instrução para voltar alguma operação no sistema.
msgTeclaEnter() :-
    writeln('\nPressione a tecla ENTER para voltar').

% Método que exibe a mensagem inicial para a operação de devolução de um dado filme locado juntamente com a mensagem inicial que irá conter todas as locações em andamento.
msgDevolucaoTop() :-
    put_logo(),
    writeln('       -------DEVOLUÇÃO------'),
    writeln('\nUau, já assistiu?!'),
    writeln('Você possui a(s) seguinte(s) locação(ões) em andamento:').

% Método que realiza a exibição de mensagem inicial relacionada a devolução de um dado filme.
msgDevolucaoBottom() :-
    writeln('Qual locação você deseja encerrar?\n'),
    writeln('OBS: Para voltar ao menu basta digitar "S"!'),
    writeln('\nID da locação: ').

% Método que realiza a exibição de mensagem inicial de sucesso da devolução do dado filme alugado.
msgDevolveFilme(Qtd):-
    writeln('\nDevolução realizada, esperamos que tenha gostado!\n'),
    string_concat('Agora temos: ', Qtd, Return),
    write(Return),
    writeln(' unidade(s) disponivel(is).'),
    write('---\n').
