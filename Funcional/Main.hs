import System.IO 
import System.IO.Unsafe
import System.IO.Error 
import System.Process
import System.Info
import Control.Concurrent

---------------- Utilitarios ---------------
lerEntradaInt :: IO Int
lerEntradaInt = do
         x <- readLn
         return x

lerEntradaString :: IO String
lerEntradaString = do
         x <- getLine
         return x

clrScr = if os == "mingw32"
            then system "cls" 
         else system "clear"

--------------------------------------------

main :: IO()
main = do
    telaPrincipal

--------------------------------------------



------------- Tela Principal -------------
logo :: String
logo = unsafeDupablePerformIO (readFile "logo.txt")

telaPrincipal :: IO()
telaPrincipal = do
    carregaLogo
    clrScr
    putStrLn(logo)
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Login como cliente")
    putStrLn("[2] Login como administrador")
    putStrLn("[3] Cadastro de Usuário")
    putStrLn("[4] Sair\n")

    opcao <- lerEntradaInt
    mudaTelaPrincipal opcao

mudaTelaPrincipal :: Int -> IO()
mudaTelaPrincipal opcao | opcao == 1 = telaLoginCliente
--                      | opcao == 2 = telaAdmistrador (Cláudio)
                        | opcao == 3 = telaCadastroUsuario
                        | opcao == 4 = putStrLn("\nHasta la vista, baby!")
                        | otherwise = do {putStrLn("Erro: Opção inválida. Tente novamente!") ; telaPrincipal}


-------------- Sessão de Login -------------
telaLoginCliente :: IO()
telaLoginCliente = do
    clrScr
    putStrLn(logo)
    putStrLn("       -----LOGIN CLIENTE----")
    putStrLn("\nOlá, cinéfilo! :)")
    putStrLn("Informe o cpf para continuar.")
    putStrLn("\nCPF (apenas números): ")
    cpfUsuario <- lerEntradaString

    --  verificaUserLogin cpfUsuario

    putStrLn "<<login realizado>>" --codigo provisorio
    telaLogado cpfUsuario

--verificaUsuarioBD cpfUsuario (verifica se o cpf digitado existe no bd e retorna um bolean)    
--verificaUserLogin :: String -> IO()
--verificaUserLogin cpfUsuario = if(not(verificaUsuarioBD cpfUsuario)) 
--                                 then do {putStrLn("Erro! Usuário não cadastrado") ; telaLogin}
--                               else(telaLogado cpfUsuario)

telaLogado :: String -> IO()
telaLogado cpfUsuario = do
    clrScr
    putStrLn(logo)

    -- Consultar bd para obter o nome do usuario

    putStrLn("\nÉ você, " ++ "<<nome>>" ++ "!") 
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Listar Filmes")
    putStrLn("[2] Fazer locação")
    putStrLn("[3] Recomendação da locadora")
    putStrLn("[4] Devolução da locação")
    putStrLn("[5] Voltar ao menu principal\n")

    opcao <- lerEntradaInt
    mudaTelaLogado opcao cpfUsuario

mudaTelaLogado :: Int -> String -> IO()
mudaTelaLogado opcao cpfUsuario
    | opcao == 1 = telaListarFilmes cpfUsuario 'I'
    | opcao == 2 = telaFazerLocacao cpfUsuario
    | opcao == 3 = telaRecomendacao cpfUsuario
    | opcao == 4 = telaDevolucao cpfUsuario
    | otherwise = do {putStrLn("Erro: Opção inválida. Tente novamente!") ; telaPrincipal}


----------- Sessão Cadastro de Usuario -----------
telaCadastroUsuario :: IO()
telaCadastroUsuario = do
    clrScr
    putStrLn(logo)
    putStrLn("       -------CADASTRO-------")
    putStrLn("\nNome do usuário: ")
    nome <- lerEntradaString
    putStrLn("--- \nCPF (apenas numeros): ")
    cpf <- lerEntradaString 
    putStrLn("--- \nTelefone (DDD + Número): ")
    telefone <- lerEntradaString
    putStrLn("--- \nEndereço: ")
    endereco <- lerEntradaString
    
    --faz o cadastro

    resumoCadastroCliente nome cpf telefone endereco
    threadDelay 2000000
    telaPrincipal

resumoCadastroCliente :: String -> String -> String -> String -> IO()
resumoCadastroCliente nome cpf telefone endereco = do
    clrScr
    putStrLn("---\n")
    putStrLn("Usuário " ++ nome ++ " cadastrado com sucesso!")
    putStrLn("\n--- RESUMO ---\n")
    putStrLn("Nome do usuário: " ++ nome)
    putStrLn("CPF: " ++ cpf)
    putStrLn("Telefone: " ++ telefone)
    putStrLn("Endereço: " ++ endereco)
    putStrLn("\n---")


-------------- Sessão Fazer Locação -------------
telaFazerLocacao :: String -> IO()
telaFazerLocacao cpfUsuario = do
    clrScr
    putStrLn(logo)
    putStrLn("       -VAI UM FILMINHO AI?-")
    putStrLn("\nOBS: Para verificar a lista de filmes basta digitar 0!")
    putStrLn("\nID do filme: ")
    
    idFilme <- lerEntradaInt
    verificaFilme idFilme cpfUsuario

---- verificaExistenciaFilmeBD: verifica se o filme ta cadastrado no bd - retorna um boolean
---- verificaDisponibilidadeBD: verifica se ainda tem copia do filme para alugar, no bd -  retorna um boolean

verificaFilme :: Int -> String -> IO()
verificaFilme idFilme cpfUsuario
    | idFilme == 0 = telaListarFilmes cpfUsuario 'L'
--  | not(verificaExistenciaFilmeBD idFilme) = do {putStrLn("Erro! Filme não cadastrado") ; telaFazerLocacao cpfUsuario}
--  | not(verificaDisponibilidadeBD idFilme) = do {putStrLn("Erro! Filme indisponível") ; telaFazerLocacao cpfUsuario}
    | otherwise = locarFilme idFilme cpfUsuario

---- locarFilmeBD: adiciona um filme no usuario, no bd
---- pesquisaFilmeBDByID: retorna o nome do filme
locarFilme :: Int -> String -> IO()
locarFilme idFilme cpfUsuario = do
--  locarFilmeBD idFilme cpfUsuario
--  let alugado = pesquisaFilmeBDByID idFilme 
    
    putStrLn("\nJá pode ir preparando a pipoca...")
    putStrLn("Filme " ++ "<<nome>>" ++ " alugado com sucesso!")
    putStrLn("---")

    threadDelay 2000000
    telaLogado cpfUsuario

-------- Sessão Recomendação da Locadora ---------
telaRecomendacao :: String -> IO()
telaRecomendacao cpfUsuario = do
    clrScr
    putStrLn(logo)
    putStrLn("       -HMM VEJAMOS, JÁ SEI!-")
    putStrLn("\nBaseado no seu perfil, recomendamos o seguinte filme:")
    putStrLn("\n<<Resumo do Filme>>\n")
    recomendaFilme cpfUsuario

---- pesquisaFilmeParaRecomendarBD: retorna o id do filme recomendado, disponivel
---- pesquisaFilmeBDByID: retorna o nome do filme
recomendaFilme:: String-> IO()
recomendaFilme cpfUsuario = do
--  let idFilme = pesquisaFilmeParaRecomendarBD
--  let recomendacao = pesquisaFilmeBDByID idFilme 
--  putStrLn(recomendacao)
    putStrLn("Você deseja fazer a locação desse filme? [y/n]")
--  let idFilme = pesquisaFilmeParaRecomendarBD
    opcao <- lerEntradaString

    putStrLn("") -- provisorio
--  alugarRecomendado opcao cpfUsuario idFilme

alugarRecomendado:: String-> String-> Int-> IO()
alugarRecomendado opcao cpfUsuario idFilme 
    | opcao == "y" = locarFilme idFilme cpfUsuario
    | otherwise = telaLogado cpfUsuario


----------- Sessão Listar Filmes -----------
telaListarFilmes:: String -> Char -> IO()
telaListarFilmes cpfUsuario telaAnterior = do
    clrScr
    -- realiza consulta de dados
    putStrLn("-----DA SÓ UMA OLHADA NA NOSSA LISTA DE FILMES!-----")
    putStrLn("\n<<Lista de filmes>>\n") --listando os dados
    putStrLn("---")

    putStrLn("\nPressione a tecla ENTER para voltar")
    opcao <- lerEntradaString
    if (telaAnterior == 'L')
        then telaFazerLocacao cpfUsuario
    else telaLogado cpfUsuario


----------- Sessão Devolucao -----------
telaDevolucao :: String -> IO()
telaDevolucao cpfUsuario = do
    -- consulta dados
    
    clrScr
    putStrLn("-----------------------DEVOLUÇÃO----------------------")
    putStrLn("\nUau, Já assistiu?!")
    putStrLn("Você tem a(s) seguinte(s) locação(ões) em andamento:")

    putStrLn("\n---")
    putStrLn("\n<<Lista de filmes>>\n") --Listando os dados
    putStrLn("---\n")

    putStrLn("Qual filme você quer devolver?")
    putStrLn("Se acha que precisa assistir novamente basta digitar 0!")
    putStrLn("\nID do filme: ")

    idFilme <- lerEntradaInt
    verificaFilmeDevolucao idFilme cpfUsuario

    threadDelay 2000000
    telaPrincipal

verificaFilmeDevolucao :: Int -> String -> IO()
verificaFilmeDevolucao idFilme cpfUsuario
    | idFilme == 0 = telaLogado cpfUsuario
    | otherwise = devolverFilme idFilme cpfUsuario

devolverFilme :: Int -> String -> IO()
devolverFilme idFilme cpfUsuario = do 
    --faz a devolucao
    --verifica valor da multa
    putStrLn("\nDevolução realizada, esperamos que tenha gostado!")
    putStrLn("Multa: R$ " ++ "<<valor>>")
    putStrLn("---")


carregaLogo :: IO()
carregaLogo = do
    clrScr
    putStrLn(unsafeDupablePerformIO(readFile "loading1.txt"))
    threadDelay 200000
    clrScr
    putStrLn(unsafeDupablePerformIO(readFile "loading2.txt"))
    threadDelay 200000
    clrScr
    putStrLn(unsafeDupablePerformIO(readFile "loading3.txt"))
    threadDelay 200000
    clrScr
    putStrLn(unsafeDupablePerformIO(readFile "loading4.txt"))
    threadDelay 1000000