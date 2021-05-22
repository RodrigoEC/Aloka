
:- include('Util.pl').

putOpcoesHistorico :-
    put_logo_historico(),
    writeln('Como deseja prosseguir?'),
    writeln('[1] Exibir histórico geral'),
    writeln('[2] Exibir histórico do cliente'),
    writeln('[3] Exibir locações em andamento'),
    writeln('[4] Voltar ao menu inicial').

putMsgOpcoesMenuInicial() :-
    put_logo(),
    writeln('       ----MENU PRINCIPAL----'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Login como cliente'),
    writeln('[2] Login como administrador'),
    writeln('[3] Cadastro de usuário'),
    writeln('[4] Sair\n').

putMsgOpcoesMenuCliente(Nome) :-
    put_logo(),
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
    writeln('[5] Voltar ao menu principal\n').

putMsgOpcoesMenuAdmin() :- 
    put_logo(),
    writeln('       -----ADMINISTRADOR----'),
    writeln('\nOlá, Administrador!'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Cadastrar filme'),
    writeln('[2] Exibir histórico de locações'),
    writeln('[3] Gerenciar estoque'),
    writeln('[4] Voltar ao menu principal\n').

putMsgOpcoesExibirLocacoes() :-
    put_logo(),
    writeln('       -----ADMINISTRADOR----'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Exibir histórico geral'),
    writeln('[2] Exibir histórico do cliente'),
    writeln('[3] Exibir locações em andamento'),
    writeln('[4] Voltar\n').

putMsgOpcoesGerenciarEstoque() :-
    put_logo(),
    writeln('       -----ADMINISTRADOR----'),
    writeln('\nComo deseja prosseguir?'),
    writeln('[1] Adicionar estoque ao filme'),
    writeln('[2] Verificar disponibilidade de filmes'),
    writeln('[3] Voltar ao menu inicial\n').

putMsgOpcaoInvalida() :- 
    writeln('\nErro: opção inválida!').

putMsgCpfInvalido() :- 
    writeln('\nErro: CPF inválido!'),
    write('').

putMsgUserInvalido() :-
    writeln('\nErro: usuário não cadastrado!'),
    write('').

putMsgIdInvalido() :-
    writeln('\nErro: id inválido!'),
    write('').

putMsgGeneroInvalido() :-
   writeln('\nErro: gênero inválido!'),
   write('').

putMsgQuantidadeInvalida() :-
   writeln('\nErro: quantidade inválida!'),
   write('').

putMsgFilmeNaoCadastrado() :-
   writeln('\nErro: filme não cadastrado!'),
   write('').

putMsgFilmeNaoDisponivel() :-
   writeln('\nErro: filme indisponível!'),
   write('').

putMsgLoginCliente() :-
    put_logo(),
    writeln('       -----LOGIN CLIENTE----\n'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),
    writeln('\nOlá, cinéfilo! :)\n'),

    writeln('Informe o seu CPF para continuar.'),
    writeln('\nCPF (apenas números): ').


putMsgCadastroNome() :-
    put_logo(),
    writeln('       -------CADASTRO-------'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),
    writeln('\nNome do usuário: ').

putMsgCadastroCpf() :-
    writeln('--- \nCPF (apenas números): ').

putMsgCadastroTelefone() :-
    writeln('--- \nTelefone (DDD + Número): ').

putMsgCadastroEndereco() :-
    writeln('--- \nEndereço: ').

putMsgResumoCadastroUsuario(cliente) :-
    put_logo(),
    writeln('       -------CADASTRO-------'),
    writeln('\n-----\n'),
    writeln(cliente),
    writeln('\n-----').


putMsgCadastroFilmeTitulo() :-
    put_logo(),
    writeln('       -------CADASTRO-------'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),
    write(''),
    writeln('\nTítulo: ').

putMsgCadastroFilmeGenero() :-
    writeln('Gênero: ').

putMsgCadastroFilmeDiretor() :-
    writeln('Diretor(a): ').

putMsgCadastroFilmeData() :-
    writeln('Data de lançamento (dd/mm/aaaa): ').

putMsgFilmeQuantidade() :-
    writeln('Quantidade: ').

putMsgResumoCadastroFilme(Filme) :-
    put_logo(),
    writeln('       -------CADASTRO-------'),
    writeln('\n-----\n'),
    writeln(Filme),
    writeln('\n-----'),
    write('').

putMsgFilmeIdentificador() :-
    writeln('\nID do filme: ').

putMsgLocacaoFilme() :-
    put_logo(),
    writeln('       -VAI UM FILMINHO AI?-'),
    writeln('\nOBS: Para verificar a lista de filmes basta digitar "L"!'),
    writeln('     Para voltar ao menu basta digitar "S"!\n'),
    writeln('\nID do filme: ').

putMsgDataLocacao() :-
   writeln('Insira a data da locação (dd/mm/aaaa): ').

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
    write('').

putMsgHistoricoLocacoes() :-
    put_logo(),
    writeln('       --HISTÓRICO LOCAÇÕES--'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n').

putMsgHistoricoLocacoesCpf() :-
    writeln('\nDigite o CPF do cliente: ').

putMsgHistoricoLocacoesAndamento() :-
    put_logo(),
    writeln('       --LOCAÇÕES ANDAMENTO--').

putMsgEstoqueFilmes() :-
    put_logo(),
    writeln('       ---ADICIONA ESTOQUE---'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n').

putMsgDisponibilidadeFilmes() :-
    put_logo(),
    writeln('       ----DISPONIBILIDADE---'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n').

putMsgRecomendacaoGenero() :-
    put_logo(),
    writeln('       -----RECOMENDAÇÃO-----'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),   
    writeln('\nInsira o gênero: '),.

putMsgRecomendacao(NomeFilme) :-
    put_logo(),
    writeln('       -HMM VEJAMOS, JÁ SEI!-'),
    writeln('\nOBS: Para voltar ao menu basta digitar "S"!\n'),   
    write('\nBaseado no seu perfil, recomendamos o seguinte filme: '),
    writeln(NomeFilme),
    writeln('').

putMsgRecomendaLocacao() :-
    writeln('Você deseja fazer a locação desse filme? [y/n]').

putMsgListaFilmes() :-
    put_logo(),
    writeln('       ----LISTA DE FILMES---').

putMsgTeclaEnter() :-
    writeln('\nPressione a tecla ENTER para voltar').

putMsgDevolucaoTop() :-
    put_logo(),
    writeln('       -------DEVOLUÇÃO------'),
    writeln('\nUau, já assistiu?!'),
    writeln('Você tem a(s) seguinte(s) locação(ões) em andamento:').

putMsgDevolucaoBottom() :-
    writeln('Qual locação você deseja encerrar?'),
    writeln('OBS: Para voltar ao menu basta digitar "S"!'),
    writeln('\nID da locação: ').

putMsgDevolveFilme(Qtd):-
    writeln('\nDevolução realizada, esperamos que tenha gostado!'),
    writeln(''),
    string_concat('Agora temos: ', Qtd, Return),
    write(Return),
    writeln(' unidade(s) disponivel(is).'),
    write('---'),
    write('').
