
putMsgOpcoesMenuInicial() :-
    %putLogo(),
    writeln('       ----MENU PRINCIPAL----'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Login como cliente'),
    writeln('[2] Login como administrador'),
    writeln('[3] Cadastro de usuário'),
    writeln('[4] Sair\n'), halt().

putMsgOpcoesMenuCliente(Nome) :-
    %putLogo(),
    writeln('       --LUZ, CÂMERA, AÇÃO!--'),
    string_concat('             \nOlá, ', Nome, Return),
    write(''),
    write(Return),
    writeln('!'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Listar filmes'),
    writeln('[2] Fazer locação'),
    writeln('[3] Recomendação da locadora'),
    writeln('[4] Devolução da locação'),
    writeln('[5] Voltar ao menu principal\n'), halt(0).

putMsgOpcoesMenuAdmin() :- 
    %putLogo().
    writeln('       -----ADMINISTRADOR----'),
    writeln('\nOlá, Administrador!'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Cadastrar filme'),
    writeln('[2] Exibir histórico de locações'),
    writeln('[3] Gerenciar estoque'),
    writeln('[4] Voltar ao menu principal\n'), halt().

putMsgOpcoesExibirLocacoes() :-
    %putLogo().
    writeln('       -----ADMINISTRADOR----'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Exibir histórico geral'),
    writeln('[2] Exibir histórico do cliente'),
    writeln('[3] Exibir locações em andamento'),
    writeln('[4] Voltar\n'), halt().

putMsgOpcoesGerenciarEstoque() :-
    %putLogo().
    writeln('       -----ADMINISTRADOR----'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Adicionar estoque ao filme'),
    writeln('[2] Verificar disponibilidade de filmes'),
    writeln('[3] Voltar ao menu inicial\n'), halt().

putMsgOpcaoInvalida() :- 
    write('\nErro: opção inválida!'),
    %putMsgTeclaEnter().
    %opcao = Util.lerEntradaString
    write(''), halt().

putMsgCpfInvalido() :- 
    writeln('\nErro: CPF inválido!'),
    %putMsgTeclaEnter()
    %opcao = Util.lerEntradaString
    write(''), halt().

putMsgUserInvalido() :-
    writeln('\nErro: usuário não cadastrado!'),
    %putMsgTeclaEnter()
    %opcao = Util.lerEntradaString
    write(''), halt().

putMsgIdInvalido() :-
    writeln('\nErro: id inválido!'),
    %putMsgTeclaEnter()
    %opcao = Util.lerEntradaString
    write(''), halt().

putMsgGeneroInvalido() :-
   writeln('\nErro: gênero inválido!'),
   %putMsgTeclaEnter()
   %opcao = Util.lerEntradaString
   write(''), halt().

putMsgQuantidadeInvalida() :-
   writeln('\nErro: quantidade inválida!'),
   %putMsgTeclaEnter()
   %opcao = Util.lerEntradaString
   write(''), halt().

putMsgFilmeNaoCadastrado() :-
   writeln('\nErro: filme não cadastrado!'),
   %putMsgTeclaEnter()
   %opcao = Util.lerEntradaString
   write(''), halt().

putMsgFilmeNaoDisponivel() :-
   writeln('\nErro: filme indisponível!'),
   %putMsgTeclaEnter()
   %opcao = Util.lerEntradaString
   write(''), halt().

putMsgLoginCliente() :-
    %putLogo().
    writeln('       -----LOGIN CLIENTE----\n'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),
    writeln('\nOlá, cinéfilo! :)\n'),

    writeln('Informe o seu CPF para continuar.'),
    writeln('\nCPF (apenas números): '), halt().


putMsgCadastroNome() :-
    %putLogo().
    writeln('       -------CADASTRO-------'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),
    writeln('\nNome do usuário: '), halt().

putMsgCadastroCpf() :-
    writeln('--- \nCPF (apenas números): '), halt().

putMsgCadastroTelefone() :-
    writeln('--- \nTelefone (DDD + Número): '), halt().

putMsgCadastroEndereco() :-
    writeln('--- \nEndereço: '), halt().

putMsgResumoCadastroUsuario(cliente) :-
    %putLogo().
    writeln('       -------CADASTRO-------'),
    writeln('\n-----\n'),
    writeln(cliente),
    writeln('\n-----'),

    %putMsgTeclaEnter().
    halt().

putMsgCadastroFilmeTitulo() :-
    %putLogo().
    writeln('       -------CADASTRO-------'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),
    write(''),
    writeln('\nTítulo: '), halt().

putMsgCadastroFilmeGenero() :-
    writeln('Gênero: '), halt().

putMsgCadastroFilmeDiretor() :-
    writeln('Diretor(a): '), halt().

putMsgCadastroFilmeData() :-
    writeln('Data de lançamento (dd/mm/aaaa): '), halt().

putMsgFilmeQuantidade() :-
    writeln('Quantidade: '), halt().

putMsgResumoCadastroFilme(Filme) :-
    %putLogo()
    writeln('       -------CADASTRO-------'),
    writeln('\n-----\n'),
    writeln(Filme),
    writeln('\n-----'),
    %putMsgTeclaEnter().
    %opcao = Util.lerEntradaString,
    write(''), halt().

putMsgFilmeIdentificador() :-
    writeln('\nID do filme: '), halt().

putMsgLocacaoFilme() :-
    %putLogo().
    writeln('       -VAI UM FILMINHO AI?-'),
    writeln('\nOBS: Para verificar a lista de filmes basta digitar "L"!'),
    writeln('     Para voltar ao menu basta digitar "S"!\n'),
    writeln('\nID do filme: '), halt().

putMsgDataLocacao() :-
   writeln('Insira a data da locação (dd/mm/aaaa): '), halt().

putMsgLocaFilme(NomeFilme, Qtd) :-
    writeln('\nJá pode ir preparando a pipoca...'),
    writeln(''),
    string_concat('Filme, ', NomeFilme, Return),
    write(Return),
    writeln(' alugado com sucesso!'),
    writeln(''),
    string_concat('Agora só temos: ', Qtd, R),
    write(R),
    writeln(' unidade(s) disponivel(is).'),
    writeln('---'),
    %putMsgTeclaEnter()
    %opcao = Util.lerEntradaString
    write(''), halt().

putMsgHistoricoLocacoes() :-
    %putLogo().
    writeln('       --HISTÓRICO LOCAÇÕES--'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'), halt().

putMsgHistoricoLocacoesCpf() :-
    writeln('\nDigite o CPF do cliente: '), halt().

putMsgHistoricoLocacoesAndamento() :-
    %putLogo().
    writeln('       --LOCAÇÕES ANDAMENTO--'), halt().

putMsgEstoqueFilmes() :-
    %putLogo().
    writeln('       ---ADICIONA ESTOQUE---'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'), halt().

putMsgDisponibilidadeFilmes() :-
    %putLogo().
    writeln('       ----DISPONIBILIDADE---'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'), halt().

putMsgRecomendacaoGenero() :-
    %putLogo().
    writeln('       -----RECOMENDAÇÃO-----'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),   
    writeln('\nInsira o gênero: '), halt().

putMsgRecomendacao(Filme) :-
    %putLogo().
    writeln('       -HMM VEJAMOS, JÁ SEI!-'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),   
    writeln('\nBaseado no seu perfil, recomendamos o seguinte filme:'),
    writeln(''),
    string_concat('\n ', Filme, Return),
    writeln(''), halt().

putMsgRecomendaLocacao() :-
    writeln('Você deseja fazer a locação desse filme? [y/n]'), halt().

putMsgListaFilmes() :-
    %putLogo().
    writeln('       ----LISTA DE FILMES---'), halt().

putMsgTeclaEnter() :-
    writeln('\nPressione a tecla ENTER para voltar'), halt().

putMsgDevolucaoTop() :-
    %putLogo().
    writeln('       -------DEVOLUÇÃO------'),
    writeln('\nUau, já assistiu?!'),
    writeln('Você tem a(s) seguinte(s) locação(ões) em andamento:'), halt().

putMsgDevolucaoBottom() :-
    writeln('Qual locação você deseja encerrar?'),
    writeln('OBS: Para voltar ao menu basta digitar "S"!'),
    writeln('\nID da locação: '), halt().

putMsgDevolveFilme(Qtd):-
    writeln('\nDevolução realizada, esperamos que tenha gostado!'),
    writeln(''),
    string_concat('Agora temos: ', Qtd, Return),
    write(Return),
    writeln(' unidade(s) disponivel(is).'),
    write('---'),
    %putMsgTeclaEnter().
    %opcao = Util.lerEntradaString
    write(''), halt().