import System.IO 
import System.IO.Unsafe
import System.IO.Error 
import System.Process

------------------------------ Ler entradas ---------------------------------------------------------------
lerEntradaInt :: IO Int
lerEntradaInt = do
         x <- readLn
         return x

lerEntradaString :: IO String
lerEntradaString = do
         x <- getLine
         return x

--- Tela Principal
telaPrincipal::IO()
telaPrincipal = do
    system "clear"
    putStrLn("---")
    putStrLn("BEM-VINDE AO ALOKA")
    putStrLn("A SUA LOCADORA VIRTUAL")
    putStrLn("Como deseja prosseguir?")
    putStrLn("[1] Login como cliente")
    putStrLn("[2] Login como administrador")
    putStrLn("[3] Cadastro de Usuário")
    opcao <- lerEntradaInt
    mudaTelaInicial opcao

--- Muda tela
mudaTelaInicial::Int-> IO()
mudaTelaInicial opcao | opcao == 1 = telaLogin
---                   | opcao == 2 = telaAdmistrador (Cláudio)
---                   | opcao == 3 = telaCadastroUsuario (Gustavo)
                      | otherwise = putStrLn("Erro! Opção inválida")

----------------------------------- Sessão de Login ----------------------------------------------
telaLogin::IO()
telaLogin = do
    system "clear"
    putStrLn("----")
    putStrLn("Usuário:")
    cpfUsuario <- lerEntradaString
    verificaUserLogin cpfUsuario

--- verificaBD cpfUsuario (verifica se o cpf digitado existe no bd e retorna um bolean)    
verificaUserLogin::String -> IO()
verificaUserLogin cpfUsuario = if(not(verificaBD cpfUsuario)) then putStrLn("Usuário não cadastrado")
                                                else(telaLogado cpfUsuario)

telaLogado::String -> IO()
telaLogado cpfUsuario = do
    system "clear"
    putStrLn("----")
    putStrLn("Bem-vindx ao Aloka, "++ cpfUsuario) --- aqui, ou a gente deixa o bem vindo com o cpf (identificador) ou entao faz uma consulta que retorna o nome desse id
    putStrLn("Como deseja prosseguir?")
    putStrLn("[1] Listar Filmes")
    putStrLn("[2] Fazer locação")
    putStrLn("[3] Recomendação da locadora")
    putStrLn("[4] Devolução da locação")
    putStrLn("[5] Logout")
    opcao <- lerEntradaInt
    mudaTelaLogado opcao

mudaTelaLogado::Int-> IO()
mudaTelaLogado opcao -- | opcao == 1 = telaListarFilmes (Gustavo)
                        | opcao == 2 = telaFazerLocacao
                        | opcao == 3 = telaRecomendacao
                     -- | opcao == 4 = telaDevolucao (Gustavo)
                        | otherwise = telaPrincipal

--------------------------------- Sessão Fazer Locação -------------------------------------------------
telaFazerLocacao::IO()
telaFazerLocacao = do
    putStrLn("Tela Locação")

--------------------------------- Sessão Recomendação da Locadora ---------------------------------------
telaRecomendacao::IO()
telaRecomendacao = do
    putStrLn("Tela Recomendação")

main::IO()
main = do
    telaPrincipal