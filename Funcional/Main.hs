import System.IO 
import System.IO.Unsafe
import System.IO.Error 
import System.Process

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
    system "clear"
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
                      | otherwise = putStrLn("Erro! Opção inválida")

--------------------------------------------
main :: IO()
main = do
    telaPrincipal
--------------------------------------------



-------------- Sessão de Login -------------
telaLoginCliente :: IO()
telaLoginCliente = do
    system "clear"
    putStrLn("----")
    putStrLn("Usuário:")

    cpfUsuario <- lerEntradaString
    putStrLn ""
   -- verificaUserLogin cpfUsuario

--verificaUserLogin :: String -> IO()
--verificaUserLogin cpfUsuario = if (not(verificaBD cpfUsuario)) 
                             --       then putStrLn("Usuário não cadastrado")
                               -- else (telaLogado cpfUsuario)

telaLogado :: String -> IO()
telaLogado cpfUsuario = do
    system "clear"
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
    mudaTelaLogado opcao

mudaTelaLogado :: Int -> IO()
mudaTelaLogado opcao    | opcao == 1 = telaListarFilmes
                        | opcao == 2 = telaFazerLocacao
                        | opcao == 3 = telaRecomendacao
                        | opcao == 4 = telaDevolucao "<<usuario>>"
                        | otherwise = telaPrincipal


-------------- Sessão Fazer Locação -------------
telaFazerLocacao :: IO()
telaFazerLocacao = do
    putStrLn("Tela Locação")


-------- Sessão Recomendação da Locadora ---------
telaRecomendacao :: IO()
telaRecomendacao = do
    putStrLn("Tela Recomendação")


----------- Sessão Cadastro de Usuario -----------
telaCadastroUsuario :: IO()
telaCadastroUsuario = do
    putStrLn("Nome do usuário: ")
    nome <- lerEntradaString
    putStrLn("--- \nCPF: ")
    cpf <- lerEntradaString
    putStrLn("--- \nTelefone: ")
    telefone <- lerEntradaString
    putStrLn("--- \nEndereço: ")
    endereco <- lerEntradaString
    
    --faz o cadastro

    putStrLn("---\n")
    putStrLn("Usuário " ++ nome ++ " cadastrado com sucesso!")
    putStrLn("\n---")
    
    main