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

    telaLogado cpfUsuario

-- verificaUserLogin cpfUsuario

--verificaUserLogin :: String -> IO()
--verificaUserLogin cpfUsuario = if (not(verificaBD cpfUsuario)) 
                             --       then putStrLn("Usuário não cadastrado")
                               -- else (telaLogado cpfUsuario)

telaLogado :: String -> IO()
telaLogado cpfUsuario = do
    system "cls"
    putStrLn("----")
    putStrLn("Bem-vindx ao Aloka, " ++ cpfUsuario) 
    --- aqui, ou a gente deixa o bem vindo com o cpf (identificador) ou entao faz uma consulta que retorna o nome desse id
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
    | opcao == 1 = telaListarFilmes
    | opcao == 2 = telaFazerLocacao cpfUsuario
    | opcao == 3 = telaRecomendacao cpfUsuario
    | opcao == 4 = telaDevolucao cpfUsuario
    | otherwise = do {putStrLn("Erro! Opção inválida") ; telaPrincipal}


-------------- Sessão Fazer Locação -------------
telaFazerLocacao :: String -> IO()
telaFazerLocacao cpfUsuario = do
    putStrLn("Tela Locação")


-------- Sessão Recomendação da Locadora ---------
telaRecomendacao :: String -> IO()
telaRecomendacao cpfUsuario = do
    putStrLn("Tela Recomendação")


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
telaListarFilmes :: IO()
telaListarFilmes = do
    system "cls"
    -- realiza consulta de dados

    putStrLn("")
    putStrLn("<<Lista de filmes>>") --listando os dados
    putStrLn("---")

    telaPrincipal


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