import System.IO 
import System.IO.Unsafe
import System.IO.Error 
import System.Process
import Control.Concurrent

---------- Leitura de entradas ----------
lerEntradaInt :: IO Int
lerEntradaInt = do
         x <- readLn
         return x

lerEntradaString :: IO String
lerEntradaString = do
         x <- getLine
         return x

------------- Tela Principal -------------

logo :: String
logo = unsafeDupablePerformIO (readFile "logo.txt")

telaPrincipal :: IO()
telaPrincipal = do
    system "cls"
    putStrLn("---")
    putStrLn("BEM-VINDE AO ALOKA")
    putStrLn(logo)
    putStrLn("\nA SUA LOCADORA VIRTUAL")
    putStrLn("\nComo deseja prosseguir?")
    putStrLn("[1] Login como cliente")
    putStrLn("[2] Login como administrador")
    putStrLn("[3] Cadastro de Usuário")
    putStrLn("[4] Logout")

    opcao <- lerEntradaInt
    mudaTelaInicial opcao

--------------- Muda tela -----------------
mudaTelaInicial :: Int -> IO()
mudaTelaInicial opcao | opcao == 1 = telaLoginCliente
---                   | opcao == 2 = telaAdmistrador (Cláudio)
                      | opcao == 3 = telaCadastroUsuario
                      | opcao == 4 = putStrLn("end")
                      | otherwise = do {putStrLn("Erro! Opção inválida") ; telaPrincipal}

--------------------------------------------
main :: IO()
main = do
    telaPrincipal
--------------------------------------------

-------------- Sessão de Login -------------
telaLoginCliente :: IO()
telaLoginCliente = do
    system "cls"
    putStrLn("----")
    putStrLn("Usuário:")
    cpfUsuario <- lerEntradaString
--  verificaUserLogin cpfUsuario

--- verificaUsuarioBD cpfUsuario (verifica se o cpf digitado existe no bd e retorna um bolean)    
--verificaUserLogin::String -> IO()
--verificaUserLogin cpfUsuario = if(not(verificaUsuarioBD cpfUsuario)) then do {putStrLn("Erro! Usuário não cadastrado") ; telaLogin}
                                                --else(telaLogado cpfUsuario)

----- findClienteByCpfBD: consulta o nome do cliente a partir do seu cpf
telaLogado :: String -> IO()
telaLogado cpfUsuario = do
    system "cls"
    putStrLn("----")
--  let nomeCliente = findClienteByCpfBD cpfUsuario  
    putStrLn("Bem-vindx ao Aloka, " ++ cpfUsuario) -- coloquei com o cps so pra teste mesmo
    putStrLn("Como deseja prosseguir?")
    putStrLn("[1] Listar Filmes")
    putStrLn("[2] Fazer locação")
    putStrLn("[3] Recomendação da locadora")
    putStrLn("[4] Devolução da locação")
    putStrLn("[5] Logout")

    opcao <- lerEntradaInt
    mudaTelaLogado opcao cpfUsuario

mudaTelaLogado :: Int -> String -> IO()
mudaTelaLogado opcao cpfUsuario
    | opcao == 1 = telaListarFilmes cpfUsuario
    | opcao == 2 = telaFazerLocacao cpfUsuario
    | opcao == 3 = telaRecomendacao cpfUsuario
    | opcao == 4 = telaDevolucao cpfUsuario
    | otherwise = do {putStrLn("Erro! Opção inválida") ; telaPrincipal}


-------------- Sessão Fazer Locação -------------
telaFazerLocacao::String-> IO()
telaFazerLocacao cpfUsuario = do
    system "cls"
    putStrLn("OBS: Caso queira verificar a lista de filmes digite '7' no lugar do id do folme.")
    putStrLn("ID do filme desejado: ")
    idFilme <- lerEntradaInt
    verificaFilme idFilme cpfUsuario

---- verificaExistenciaFilmeBD: verifica se o filme ta cadastrado no bd - retorna um boolean
---- verificaDisponibilidadeBD: verifica se ainda tem copia do filme para alugar, no bd -  retorna um boolean
verificaFilme::Int-> String-> IO()
verificaFilme idFilme cpfUsuario|idFilme == 7 = telaListarFilmes cpfUsuario
--                              |not(verificaExistenciaFilmeBD idFilme) = do {putStrLn("Erro! Filme não cadastrado") ; telaFazerLocacao cpfUsuario}
--                              |not(verificaDisponibilidadeBD idFilme) = do {putStrLn("Erro! Filme indisponível") ; telaFazerLocacao cpfUsuario}
                                |otherwise = locarFilme idFilme cpfUsuario

---- locarFilmeBD: adiciona um filme no usuario, no bd
---- pesquisaFilmeBDByID: retorna o nome do filme
locarFilme:: Int-> String-> IO()
locarFilme idFilme cpfUsuario = do
--  locarFilmeBD idFilme cpfUsuario
--  let alugado = pesquisaFilmeBDByID idFilme 
--  putStrLn("Filme " ++ alugado ++ "alugado com sucesso!")
    putStrLn("----")
    telaLogado cpfUsuario

-------- Sessão Recomendação da Locadora ---------
telaRecomendacao :: String -> IO()
telaRecomendacao cpfUsuario = do
    system "cls"
    putStrLn("Baseado no seu perfil nós lhe recomendamos o seguinte filme:")
    recomendaFilme cpfUsuario

---- pesquisaFilmeParaRecomendarBD: retorna o id do filme recomendado, disponivel
---- pesquisaFilmeBDByID: retorna o nome do filme
recomendaFilme:: String-> IO()
recomendaFilme cpfUsuario = do
--  let idFilme = pesquisaFilmeParaRecomendarBD
--  let recomendacao = pesquisaFilmeBDByID idFilme 
--  putStrLn(recomendacao)
    putStrLn("Você deseja fazer a locassao desse filme? [y/n]")
--  let idFilme = pesquisaFilmeParaRecomendarBD
    opcao <- lerEntradaString
--  alugarRecomendado opcao cpfUsuario idFilme

alugarRecomendado:: String-> String-> Int-> IO()
alugarRecomendado opcao cpfUsuario idFilme | opcao == "y" = locarFilme idFilme cpfUsuario
                                           | otherwise = telaLogado cpfUsuario

----------- Sessão Cadastro de Usuario -----------
telaCadastroUsuario :: IO()
telaCadastroUsuario = do
    system "cls"
    putStrLn("Nome do usuário: ")
    nome <- lerEntradaString
    putStrLn("--- \nCPF: ")
    cpf <- lerEntradaString
    putStrLn("--- \nTelefone: ")
    telefone <- lerEntradaString
    putStrLn("--- \nEndereço: ")
    endereco <- lerEntradaString
    
    --faz o cadastro

    system "cls"
    putStrLn("---\n")
    putStrLn("Usuário " ++ nome ++ " cadastrado com sucesso!")
    putStrLn("\n---")
    
    threadDelay 1000000
    telaPrincipal

----------- Sessão Listar Filmes -----------
telaListarFilmes:: String-> IO()
telaListarFilmes cpfUsuario = do
    system "cls"
    -- realiza consulta de dados

    putStrLn("")
    putStrLn("<<Lista de filmes>>") --listando os dados
    putStrLn("---")

    telaLogado cpfUsuario


----------- Sessão Devolucao -----------
telaDevolucao :: String -> IO()
telaDevolucao cpfUsuario = do
    -- consulta dados com base no nome
    
    system "cls"
    putStrLn("Olá " ++ cpfUsuario ++ ", você tem a(s) seguinte(s) locação(ões) em andamento:")

    putStrLn("\n------\n")
    putStrLn("<<Filme1>>") --Listando os dados
    putStrLn("\n-----\n")

    putStrLn("Digite o id da locação que você deseja finalizar: ")
    id <- lerEntradaInt

    --faz a devolucao
    --verifica valor da multa

    putStrLn("\nLocação finalizada!")
    putStrLn("Multa: R$ " ++ "<<valor>>")
    putStrLn("---")

    telaPrincipal