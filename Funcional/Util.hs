module Util where

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

lerEntradaInt :: IO Int
lerEntradaInt = do
         x <- readLn
         return x

lerEntradaString :: IO String
lerEntradaString = do
         x <- getLine
         return x

carregaLogoInicial :: IO()
carregaLogoInicial = do
   rodaLogoInicial listaLoading "            INICIANDO O"

rodaLogoInicial :: [String] -> String -> IO()
rodaLogoInicial [] _ = threadDelay 200000
rodaLogoInicial (x:xs) msg = do {putLogoInicial x msg; rodaLogoInicial xs msg}

putLogoInicial :: String -> String -> IO()
putLogoInicial x msg = do
   clrScr
   putStrLn("---")
   putStrLn(msg)
   putStrLn(unsafeDupablePerformIO(readFile x))
   threadDelay 200000

carregaLogo :: IO()
carregaLogo = do 
   clrScr
   putStrLn(unsafeDupablePerformIO(readFile "arquivos/logo.txt"))

listaOpcoesMenuInicial :: IO()
listaOpcoesMenuInicial = do
   putStrLn("       ----MENU PRINCIPAL----")
   putStrLn("\nComo deseja prosseguir?")
   putStrLn("[1] Login como cliente")
   putStrLn("[2] Login como administrador")
   putStrLn("[3] Cadastro de usuário")
   putStrLn("[4] Sair\n")

listaOpcoesMenuLogin :: String -> IO()
listaOpcoesMenuLogin nome = do
   putStrLn("       --LUZ, CÂMERA, AÇÃO!--")
   putStrLn("\nOlá, " ++ nome ++ "!")
   putStrLn("\nComo deseja prosseguir?")
   putStrLn("[1] Listar Filmes")
   putStrLn("[2] Fazer locação")
   putStrLn("[3] Recomendação da locadora")
   putStrLn("[4] Devolução da locação")
   putStrLn("[5] Voltar ao menu principal\n")

putMsgSaida :: IO()
putMsgSaida = do
   rodaLogoInicial (reverse listaLoading) "            SAINDO DO"
   clrScr
   putStrLn(unsafeDupablePerformIO(readFile "arquivos/corta.txt"))
   threadDelay 200000
   clrScr
   putStr("")

putMsgOpcaoInvalida :: IO()
putMsgOpcaoInvalida = do
   putStrLn("\nErro: Opção inválida. Tente novamente!")
   threadDelay 200000
   putStr("")

putMsgCpfInvalido :: IO()
putMsgCpfInvalido = do
   putStrLn("\nErro: cpf inválido. Tente novamente!")
   threadDelay 200000
   putStr("")

putMsgIdInvalido :: IO()
putMsgIdInvalido = do
   putStrLn("\nErro: id inválido. Tente novamente!")
   threadDelay 200000
   putStr("")

putInfoLoginCliente :: IO() 
putInfoLoginCliente = do
   putStrLn("       -----LOGIN CLIENTE----")
   putStrLn("\nOlá, cinéfilo! :)")
   putStrLn("Informe o cpf para continuar.")
   putStrLn("\nCPF (apenas números): ")

putInfoCadastroNome :: IO()
putInfoCadastroNome = do
   putStrLn("       -------CADASTRO-------")
   putStrLn("\nNome do usuário: ")

putInfoCadastroCpf :: IO()
putInfoCadastroCpf = do
   putStrLn("--- \nCPF (apenas numeros): ")

putInfoCadastroTelefone :: IO()
putInfoCadastroTelefone = do
   putStrLn("--- \nTelefone (DDD + Número): ")

putInfoCadastroEndereco :: IO()
putInfoCadastroEndereco = do
   putStrLn("--- \nEndereço: ")

putResumoCadastroUsuario :: String -> String -> String -> String -> IO()
putResumoCadastroUsuario nome cpf telefone endereco = do
   clrScr
   putStrLn("---\n")
   putStrLn("Usuário " ++ nome ++ " cadastrado com sucesso!")
   putStrLn("\n--- RESUMO ---\n")
   putStrLn("Nome do usuário: " ++ nome)
   putStrLn("CPF: " ++ cpf)
   putStrLn("Telefone: " ++ telefone)
   putStrLn("Endereço: " ++ endereco)
   putStrLn("\n---")
   threadDelay 1000000

putInfoLocacaoFilme :: IO()
putInfoLocacaoFilme = do
   putStrLn("       -VAI UM FILMINHO AI?-")
   putStrLn("\nOBS: Para verificar a lista de filmes basta digitar 'L'!")
   putStrLn("\nID do filme: ")

putInfoLocaFilme :: String -> IO()
putInfoLocaFilme nomeFilme = do
   putStrLn("\nJá pode ir preparando a pipoca...")
   putStrLn("Filme " ++ nomeFilme ++ " alugado com sucesso!")
   putStrLn("---")
   threadDelay 1000000

putInfoRecomendacao :: String -> IO()
putInfoRecomendacao filme = do
   putStrLn("       -HMM VEJAMOS, JÁ SEI!-")
   putStrLn("\nBaseado no seu perfil, recomendamos o seguinte filme:")
   putStrLn("\n"++ filme ++"\n")

putInfoRecomendaFilme :: IO()
putInfoRecomendaFilme = do
   putStrLn("Você deseja fazer a locação desse filme? [y/n]")

putInfoListaFilmes :: IO()
putInfoListaFilmes = do
   clrScr
   putStrLn("-----DA SÓ UMA OLHADA NA NOSSA LISTA DE FILMES!-----")

putInfoListaFilmesBottom :: IO()
putInfoListaFilmesBottom = do
   putStrLn("\nPressione a tecla ENTER para voltar")

putInfoDevolucaoTop :: IO()
putInfoDevolucaoTop = do
   clrScr
   putStrLn("-----------------------DEVOLUÇÃO----------------------")
   putStrLn("\nUau, Já assistiu?!")
   putStrLn("Você tem a(s) seguinte(s) locação(ões) em andamento:")

putInfoDevolucaoBottom :: IO()
putInfoDevolucaoBottom = do
   putStrLn("Qual locação você deseja encerrar?")
   putStrLn("Para voltar ao menu basta digitar 'M'!")
   putStrLn("\nID da locação: ")

putInfoDevolveFilme :: IO()
putInfoDevolveFilme = do
   putStrLn("\nDevolução realizada, esperamos que tenha gostado!")
   putStrLn("---")
   threadDelay 2000000

ehCpfValido :: String -> Bool
ehCpfValido cpfCliente
   | length cpfCliente /= 11 = False
   | otherwise = all (`elem` ['0'..'9']) cpfCliente

ehIdValido :: String -> Bool
ehIdValido id
   | length id== 0 = False
   | otherwise = all (`elem` ['0'..'9']) id