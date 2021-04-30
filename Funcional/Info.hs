module Info where

import System.IO.Unsafe
import System.Process
import System.Info
import Control.Concurrent
import Util

clrScr = if os == "mingw32"
            then system "cls" 
         else system "clear"

listaLoading = [
    "arquivos/loading1.txt",
    "arquivos/loading2.txt",
    "arquivos/loading3.txt",
    "arquivos/loading4.txt"]

putLogoInicial :: IO()
putLogoInicial = do
    carregaLogoInicial listaLoading "            INICIANDO O"

carregaLogoInicial :: [String] -> String -> IO()
carregaLogoInicial [] _ = threadDelay 200000
carregaLogoInicial (x:xs) msg = do {formataLogoInicial x msg; carregaLogoInicial xs msg}

formataLogoInicial :: String -> String -> IO()
formataLogoInicial x msg = do
    clrScr
    putStrLn("---")
    putStrLn(msg)
    putStrLn(unsafeDupablePerformIO(readFile x))
    threadDelay 200000

putLogo :: IO()
putLogo = do
    clrScr
    putStrLn(unsafeDupablePerformIO(readFile "arquivos/logo.txt"))

putMsgSaida :: IO()
putMsgSaida = do
    carregaLogoInicial (reverse listaLoading) "            SAINDO DO"
    clrScr
    putStrLn(unsafeDupablePerformIO(readFile "arquivos/corta.txt"))
    threadDelay 200000
    clrScr
    putStr("")

putMsgOpcoesMenuInicial :: IO()
putMsgOpcoesMenuInicial = do
    putLogo
    putStrLn("       ----MENU PRINCIPAL----")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Login como cliente")
    putStrLn("[2] Login como administrador")
    putStrLn("[3] Cadastro de usuário")
    putStrLn("[4] Sair\n")

putMsgOpcoesMenuCliente :: String -> IO()
putMsgOpcoesMenuCliente nome = do
    putLogo
    putStrLn("       --LUZ, CÂMERA, AÇÃO!--")
    putStrLn("\nOlá, " ++ nome ++ "!")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Listar Filmes")
    putStrLn("[2] Fazer locação")
    putStrLn("[3] Recomendação da locadora")
    putStrLn("[4] Devolução da locação")
    putStrLn("[5] Voltar ao menu principal\n")

putMsgOpcoesMenuAdmin :: IO()
putMsgOpcoesMenuAdmin = do
    putLogo
    putStrLn("       -----ADMINISTRADOR----")
    putStrLn("\nOlá, Administrador!")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Cadastrar filme")
    putStrLn("[2] Exibir histórico de locações")
    putStrLn("[3] Gerenciar estoque")
    putStrLn("[4] Voltar ao menu principal\n")

putMsgOpcoesExibirLocacoes :: IO()
putMsgOpcoesExibirLocacoes = do
    putLogo
    putStrLn("       -----ADMINISTRADOR----")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Exibir histórico geral")
    putStrLn("[2] Exibir histórico do cliente")
    putStrLn("[3] Exibir locações em andamento")
    putStrLn("[4] Voltar\n")

putMsgOpcoesGerenciarEstoque :: IO()
putMsgOpcoesGerenciarEstoque = do
    putLogo
    putStrLn("       -----ADMINISTRADOR----")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Adicionar estoque ao filme")
    putStrLn("[2] Verificar disponibilidade de filmes")
    putStrLn("[3] Voltar ao menu inicial\n")

putMsgOpcaoInvalida :: IO()
putMsgOpcaoInvalida = do
    putStrLn("\nErro: opção inválida!")
    putMsgTeclaEnter
    opcao <- Util.lerEntradaString
    putStr("")

putMsgCpfInvalido :: IO()
putMsgCpfInvalido = do
    putStrLn("\nErro: cpf inválido!")
    putMsgTeclaEnter
    opcao <- Util.lerEntradaString
    putStr("")

putMsgUserInvalido :: IO()
putMsgUserInvalido = do
    putStrLn("\nErro: usuário não cadastrado!")
    putMsgTeclaEnter
    opcao <- Util.lerEntradaString
    putStr("")

putMsgIdInvalido :: IO()
putMsgIdInvalido = do
    putStrLn("\nErro: id inválido!")
    putMsgTeclaEnter
    opcao <- Util.lerEntradaString
    putStr("")

putMsgGeneroInvalido :: IO()
putMsgGeneroInvalido = do
   putStrLn("\nErro: genêro inválido!")
   putMsgTeclaEnter
   opcao <- Util.lerEntradaString
   putStr("")

putMsgQuantidadeInvalida :: IO()
putMsgQuantidadeInvalida = do
   putStrLn("\nErro: quantidade inválida!")
   putMsgTeclaEnter
   opcao <- Util.lerEntradaString
   putStr("")

putMsgFilmeNaoCadastrado :: IO()
putMsgFilmeNaoCadastrado  = do
   putStrLn("\nErro: filme não cadastrado!")
   putMsgTeclaEnter
   opcao <- Util.lerEntradaString
   putStr("")

putMsgFilmeNaoDisponivel::IO()
putMsgFilmeNaoDisponivel = do
   putStrLn("\nErro: filme indisponível!")
   putMsgTeclaEnter
   opcao <- Util.lerEntradaString
   putStr("")

putMsgLoginCliente :: IO() 
putMsgLoginCliente = do
    putLogo
    putStrLn("       -----LOGIN CLIENTE----")
    putStrLn("\nOlá, cinéfilo! :)")
    putStrLn("Informe o seu CPF para continuar.")
    putStrLn("\nCPF (apenas números): ")

putMsgCadastroNome :: IO()
putMsgCadastroNome = do
    putLogo
    putStrLn("       -------CADASTRO-------")
    putStrLn("\nNome do usuário: ")

putMsgCadastroCpf :: IO()
putMsgCadastroCpf = do
    putStrLn("--- \nCPF (apenas numeros): ")

putMsgCadastroTelefone :: IO()
putMsgCadastroTelefone = do
    putStrLn("--- \nTelefone (DDD + Número): ")

putMsgCadastroEndereco :: IO()
putMsgCadastroEndereco = do
    putStrLn("--- \nEndereço: ")

putMsgResumoCadastroUsuario :: String -> IO()
putMsgResumoCadastroUsuario cliente = do
    putLogo
    putStrLn("       -------CADASTRO-------")
    putStrLn("\n-----\n")
    putStrLn(cliente)
    putStrLn("\n-----")
    putMsgTeclaEnter

putMsgCadastroFilmeTitulo :: IO()
putMsgCadastroFilmeTitulo = do
    putLogo
    putStrLn("       -------CADASTRO-------")
    putStrLn("\nTítulo: ")

putMsgCadastroFilmeGenero :: IO()
putMsgCadastroFilmeGenero = do
    putStrLn("Gênero: ")

putMsgCadastroFilmeDiretor :: IO()
putMsgCadastroFilmeDiretor = do
    putStrLn("Diretor: ")

putMsgCadastroFilmeData :: IO()
putMsgCadastroFilmeData = do
    putStrLn("Data de lançamento (dd/mm/aaaa): ")

putMsgFilmeQuantidade :: IO()
putMsgFilmeQuantidade = do
    putStrLn("Quantidade: ")

putMsgResumoCadastroFilme :: String -> IO()
putMsgResumoCadastroFilme filme = do
    putLogo
    putStrLn("       -------CADASTRO-------")
    putStrLn("\n-----\n")
    putStrLn(filme)
    putStrLn("\n-----")
    putMsgTeclaEnter
    opcao <- Util.lerEntradaString
    putStr("")

putMsgFilmeIdentificador :: IO()
putMsgFilmeIdentificador = do
    putStrLn("\nID do filme: ")

putMsgLocacaoFilme :: IO()
putMsgLocacaoFilme = do
    putLogo
    putStrLn("       -VAI UM FILMINHO AI?-")
    putStrLn("\nOBS: Para verificar a lista de filmes basta digitar 'L'!")
    putStrLn("\nID do filme: ")

putMsgDataLocacao :: IO()
putMsgDataLocacao = do
   putStrLn("Insira a data da locação (dd/mm/aaaa): ")

putMsgLocaFilme :: String -> String -> IO()
putMsgLocaFilme nomeFilme qtd = do
    putStrLn("\nJá pode ir preparando a pipoca...")
    putStrLn("Filme " ++ nomeFilme ++ " alugado com sucesso!")
    putStrLn("Agora só temos: " ++ qtd ++ " unidade(s) disponivel(is).")
    putStrLn("---")
    putMsgTeclaEnter
    opcao <- Util.lerEntradaString
    putStr("")

putMsgHistoricoLocacoes :: IO()
putMsgHistoricoLocacoes = do
    putLogo
    putStrLn("       --HISTÓRICO LOCAÇÕES--")

putMsgHistoricoLocacoesCpf :: IO()
putMsgHistoricoLocacoesCpf = do
    putStrLn("\nDigite o CPF do cliente: ")

putMsgHistoricoLocacoesAndamento :: IO()
putMsgHistoricoLocacoesAndamento = do
    putLogo
    putStrLn("       --LOCAÇÕES ANDAMENTO--")

putMsgEstoqueFilmes :: IO()
putMsgEstoqueFilmes = do
    putLogo
    putStrLn("       ---ADICIONA ESTOQUE---")

putMsgDisponibilidadeFilmes :: IO()
putMsgDisponibilidadeFilmes = do
    putLogo
    putStrLn("       ----DISPONIBILIDADE---")

putMsgRecomendacaoGenero :: IO()
putMsgRecomendacaoGenero = do
    putLogo
    putStrLn("       -----RECOMENDAÇÃO-----")
    putStrLn("\nInsira o gênero: ")

putMsgRecomendacao :: String -> IO()
putMsgRecomendacao filme = do
    putLogo
    putStrLn("       -HMM VEJAMOS, JÁ SEI!-")
    putStrLn("\nBaseado no seu perfil, recomendamos o seguinte filme:")
    putStrLn("\n"++ filme ++"\n")

putMsgRecomendaLocacao :: IO()
putMsgRecomendaLocacao = do
    putStrLn("Você deseja fazer a locação desse filme? [y/n]")

putMsgListaFilmes :: IO()
putMsgListaFilmes = do
    putLogo
    putStrLn("       ----LISTA DE FILMES---")

putMsgTeclaEnter :: IO()
putMsgTeclaEnter = do
    putStrLn("\nPressione a tecla ENTER para voltar")

putMsgDevolucaoTop :: IO()
putMsgDevolucaoTop = do
    putLogo
    putStrLn("       -------DEVOLUÇÃO------")
    putStrLn("\nUau, Já assistiu?!")
    putStrLn("Você tem a(s) seguinte(s) locação(ões) em andamento:")

putMsgDevolucaoBottom :: IO()
putMsgDevolucaoBottom = do
    putStrLn("Qual locação você deseja encerrar?")
    putStrLn("Para voltar ao menu basta digitar 'M'!")
    putStrLn("\nID da locação: ")

putMsgDevolveFilme :: String -> IO()
putMsgDevolveFilme qtd = do
    putStrLn("\nDevolução realizada, esperamos que tenha gostado!")
    putStrLn("Agora temos: " ++ qtd ++ " unidade(s) disponivel(is).")
    putStrLn("---")
    putMsgTeclaEnter
    opcao <- Util.lerEntradaString
    putStr("")