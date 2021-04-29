module Info where

import System.IO 
import System.IO.Unsafe
import System.IO.Error 
import System.Process
import System.Info
import Control.Concurrent

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
    putStrLn("       -----ADMINISTRADOR----")
    putStrLn("\nOlá, Administrador!")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Cadastrar filme")
    putStrLn("[2] Exibir histórico de locações")
    putStrLn("[3] Gerenciar estoque")
    putStrLn("[4] Voltar ao menu principal\n")

putMsgOpcoesExibirLocacoes :: IO()
putMsgOpcoesExibirLocacoes = do
    putStrLn("       -----ADMINISTRADOR----")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Exibir histórico geral")
    putStrLn("[2] Exibir histórico do cliente")
    putStrLn("[3] Exibir locações em andamento")
    putStrLn("[4] Voltar\n")

putMsgOpcoesGerenciarEstoque :: IO()
putMsgOpcoesGerenciarEstoque = do
    putStrLn("       -----ADMINISTRADOR----")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Adicionar estoque ao filme")
    putStrLn("[2] Verificar disponibilidade de filmes")
    putStrLn("[3] Voltar ao menu inicial")
    putStrLn("[4] Voltar\n")

putMsgOpcaoInvalida :: IO()
putMsgOpcaoInvalida = do
    putStrLn("\nErro: opção inválida. Tente novamente!")
    threadDelay 200000
    putStr("")

putMsgCpfInvalido :: IO()
putMsgCpfInvalido = do
    putStrLn("\nErro: cpf inválido. Tente novamente!")
    threadDelay 200000
    putStr("")

putMsgUserInvalido :: IO()
putMsgUserInvalido = do
    putStrLn("\nErro: usuário não cadastrado!")
    threadDelay 200000
    putStr("")

putMsgIdInvalido :: IO()
putMsgIdInvalido = do
    putStrLn("\nErro: id inválido. Tente novamente!")
    threadDelay 200000
    putStr("")

putMsgGeneroInvalido :: IO()
putMsgGeneroInvalido = do
   putStrLn("\nErro: genêro inválido. Tente novamente!")
   threadDelay 200000
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
    clrScr
    putLogo
    putStrLn("       -------CADASTRO-------")
    putStrLn("\n-----\n")
    putStrLn(cliente)
    putStrLn("\n-----")
    putMsgTeclaEnter

putMsgCadastroFilmeTitulo :: IO()
putMsgCadastroFilmeTitulo = do
    putStrLn("       -------CADASTRO-------")
    putStrLn("Título: ")

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
putMsgResumoCadastroFilme msg = do
    clrScr
    putLogo
    putStrLn("       -------CADASTRO-------")
    putStrLn("-----\n")
    putStrLn(msg)
    putStrLn("\n-----")
    putMsgTeclaEnter

putMsgFilmeIdentificador :: IO()
putMsgFilmeIdentificador = do
    putStrLn("\nIdentificador: ")

putMsgLocacaoFilme :: IO()
putMsgLocacaoFilme = do
    putLogo
    putStrLn("       -VAI UM FILMINHO AI?-")
    putStrLn("\nOBS: Para verificar a lista de filmes basta digitar 'L'!")
    putStrLn("\nID do filme: ")

putMsgLocaFilme :: String -> IO()
putMsgLocaFilme nomeFilme = do
    putStrLn("\nJá pode ir preparando a pipoca...")
    putStrLn("Filme " ++ nomeFilme ++ " alugado com sucesso!")
    putStrLn("---")
    threadDelay 1000000

putMsgRecomendacaoGenero :: IO()
putMsgRecomendacaoGenero = do
    putLogo
    putStrLn("       -----RECOMENDAÇÃO-----")
    putStrLn("\nInsira o gênero: ")

putMsgRecomendacao :: String -> IO()
putMsgRecomendacao filme = do
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

putMsgDevolveFilme :: IO()
putMsgDevolveFilme = do
    putStrLn("\nDevolução realizada, esperamos que tenha gostado!")
    putStrLn("---")
    threadDelay 2000000