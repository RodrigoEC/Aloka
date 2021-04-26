module Admin where

import qualified Util


opcoesMenuAdministrador =
    "\n----" ++
    "\nBem-vindo ao Aloka, Administrador!" ++
    "\n----" ++
    "\nComo deseja prosseguir?" ++
    "\n[1] Cadastrar filme" ++
    "\n[2] Cadastrar locação" ++
    "\n[3] Exibir histórico de locações" ++
    "\n[4] Gerenciar estoque" ++
    "\n[5] Sair" ++
    "\n"


menuAdmistrador :: IO()
menuAdmistrador = do
    putStrLn(opcoesMenuAdministrador)
    opcao <- Util.lerEntradaString
    processaOpcao opcao


processaOpcao :: String -> IO()
processaOpcao opcao 
    | opcao == "1" = cadastrarFilme
    | opcao == "2" = cadastrarLocacao
    | opcao == "3" = exibirLocacoes
    | opcao == "4" = gerenciarEstoque
    | opcao == "5" = Util.putMsgSaida -- pelo figma aqui ficaria pra voltar pra tela inicial, só que fiquei meio na dúvida sobre o aumento do acoplamento...
    | otherwise = menuAdmistrador


----------- Sessão Cadastrar Filme -----------
cadastrarFilme :: IO()
cadastrarFilme = do
    putStrLn("\n----Cadastro de Filme----")
    putStrLn("Identificador: ")
    id <- Util.lerEntradaString
    putStrLn("Título: ")
    titulo <- Util.lerEntradaString
    putStrLn("Gênero: ")
    genero <- Util.lerEntradaString
    putStrLn("Diretor: ")
    diretor <- Util.lerEntradaString
    putStrLn("Data de lançamento: ")
    dataLancamento <- Util.lerEntradaString
    putStrLn("Quantidade: ")
    quantidade <- Util.lerEntradaString
    putStrLn("----")

    -- TODO: cadastra o filme aqui

    putStrLn("Filme - " ++ titulo ++ " cadastrado com sucesso!")
    putStrLn("----")

    menuAdmistrador


----------- Sessão Cadastrar Locação -----------
cadastrarLocacao :: IO()
cadastrarLocacao = do
    putStrLn("\n----Cadastro de Locação----")
    putStrLn("\nIdentificador do filme: ")
    filmeId <- Util.lerEntradaString
    putStrLn("Identificador do cliente: ")
    clienteID <- Util.lerEntradaString
    putStrLn("----")

    -- TODO: faz a locação aqui

    putStrLn("Locação do filme - " ++ filmeId ++ " - para o cliente " ++ clienteID ++ " feita com sucesso")
    putStrLn("----")

    menuAdmistrador


----------- Sessão Exibir locações -----------
opcoesExibirLocacoes = 
    "\nComo deseja prosseguir?" ++
    "\n[1] Exibir histórico geral" ++
    "\n[2] Exibir histórico do cliente" ++
    "\n[3] Exibir locações em andamento" ++
    "\n[4] Voltar ao menu inicial" ++
    "\n"


exibirLocacoes :: IO()
exibirLocacoes = do
    putStrLn(opcoesExibirLocacoes)
    opcao <- Util.lerEntradaString

    if opcao == "1" then
        getHistoricoLocacoes
    else if opcao == "2" then do
        getHistoricoLocacoesCliente
    else if opcao == "3" then do
        getLocacoesEmAndamento
    else if opcao == "4" then do
        menuAdmistrador
    else
        exibirLocacoes


getHistoricoLocacoes :: IO()
getHistoricoLocacoes = do
    -- TODO: faz a busca no bd
    putStrLn("histórico geral")
    exibirLocacoes


getHistoricoLocacoesCliente :: IO()
getHistoricoLocacoesCliente = do
    putStrLn("Digite o id do cliente: ")
    clienteID <- getLine

    -- TODO: Faz a busca pelo id do cliente

    putStrLn("histórico do cliente" ++ clienteID)
    exibirLocacoes


getLocacoesEmAndamento :: IO()
getLocacoesEmAndamento = do
    -- TODO: faz a busca no bd
    putStrLn("locações em andamento aqui")
    exibirLocacoes

----------- Sessão Gerenciar Estoque -----------
opcoesGerenciarEstoque = 
    "\nComo deseja prosseguir?" ++
    "\n[1] Adicionar estoque ao filme" ++
    "\n[2] Verificar disponibilidade dos filmes" ++
    "\n[3] Voltar ao menu inicial" ++
    "\n"


gerenciarEstoque :: IO()
gerenciarEstoque = do
    putStrLn(opcoesGerenciarEstoque)
    opcao <- Util.lerEntradaString

    -- esses ifs encadeados estão tenebrosos mas estava dando erro de compilação se eu n fizesse assim :'(
    if opcao == "1" then addFilmeAoEstoque
    else if opcao == "2" then 
        verificarDisponibilidade
    else if opcao == "3" then 
        menuAdmistrador
    else gerenciarEstoque


addFilmeAoEstoque :: IO()
addFilmeAoEstoque = do
    putStrLn("\nIdentificador: ")
    id <- Util.lerEntradaString
    putStrLn("Quantidade: ")
    quantidade <- Util.lerEntradaString
    putStrLn("----")

    -- TODO: atualiza o estoque aqui

    putStrLn(quantidade ++ " filme(s) " ++ "<<nome do filme>>" ++ " adicionado(s) ao estoque com sucesso!")
    putStrLn("----\n")
    gerenciarEstoque


verificarDisponibilidade :: IO()
verificarDisponibilidade = do
    putStrLn("\nIdentificador: ")
    id <- Util.lerEntradaString
    putStrLn("----")

    -- TODO: verifica a disponibilidade aqui

    putStrLn(" Há no estoque " ++ "<<quantidade>>" ++ " filme(s) " ++ "<<nome do filme>>" ++ " disponível para locação.")
    putStrLn("----\n")
    gerenciarEstoque
