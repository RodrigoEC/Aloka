import System.IO 
import System.IO.Unsafe
import System.IO.Error 
import System.Process
import System.IO.Unsafe(unsafeDupablePerformIO)

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

--- verificaUsuarioBD cpfUsuario (verifica se o cpf digitado existe no bd e retorna um bolean)    
verificaUserLogin::String -> IO()
verificaUserLogin cpfUsuario = if(not(verificaUsuarioBD cpfUsuario)) then voltarTelaErroLogin
                                                else(telaLogado cpfUsuario)

voltarTelaErroLogin::IO()
voltarTelaErroLogin = do
    putStrLn("Usuário não cadastrado")
    telaLogin

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
    mudaTelaLogado opcao cpfUsuario

mudaTelaLogado::Int-> String-> IO()
mudaTelaLogado opcao cpfUsuario -- | opcao == 1 = telaListarFilmes cpfUsuario (Gustavo)
                        | opcao == 2 = telaFazerLocacao cpfUsuario
                        | opcao == 3 = telaRecomendacao cpfUsuario
                     -- | opcao == 4 = telaDevolucao cpfUsuario (Gustavo)
                        | otherwise = telaPrincipal

--------------------------------- Sessão Fazer Locação -------------------------------------------------
telaFazerLocacao::String-> IO()
telaFazerLocacao cpfUsuario = do
    putStrLn("OBS: Caso queira verificar a lista de filmes digite 'L' no lugar do id do folme.")
    putStrLn("ID do filme desejado: ")
    idFilme <- lerEntradaString
    verificaFilme idFilme cpfUsuario

---- verificaExistenciaFilmeBD: verifica se o filme ta cadastrado no bd - retorna um bolean
---- verificaDisponibilidadeBD: verifica se ainda tem copia do filme para alugar, no bd -  retorna um bolean

verificaFilme::String-> String-> IO()
verificaFilme idFilme cpfUsuario|idFilme == "L" = telaListarFilmes cpfUsuario
                                |not(verificaExistenciaFilmeBD idFilme) = voltarTelaErroFilme cpfUsuario
                                |not(verificaDisponibilidadeBD idFilme) = voltarTelaErroIndisponivel cpfUsuario
                                |otherwise = locarFilme idFilme cpfUsuario

voltarTelaErroFilme::String ->IO()
voltarTelaErroFilme cpfUsuario = do
    putStrLn("Filme não cadastrado")
    telaFazerLocacao cpfUsuario

voltarTelaErroIndisponivel::String ->IO()
voltarTelaErroIndisponivel cpfUsuario = do
    putStrLn("Filme indisponível")
    telaFazerLocacao cpfUsuario

---- locarFilmeBD: adiciona um filme no usuario, no bd - retorna uma string "Filme #nomeFilme alugado com sucesso!"
locarFilme:: String-> String-> IO()
locarFilme idFilme cpfUsuario = do
    let alugado = locarFilmeBD
    putStrLn(alugado)
    putStrLn("----")
    telaLogado cpfUsuario

--------------------------------- Sessão Recomendação da Locadora ---------------------------------------
telaRecomendacao::String-> IO()
telaRecomendacao cpfUsuario = do
    putStrLn("Tela Recomendação")

main::IO()
main = do
    telaPrincipal