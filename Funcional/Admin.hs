module Admin where

import qualified Util
import Filme
import Locacao


opcoesMenuAdministrador =
    "\n----" ++
    "\nBem-vindo ao Aloka, Administrador!" ++
    "\n----" ++
    "\nComo deseja prosseguir?" ++
    "\n[1] Cadastrar filme" ++
    "\n[2] Exibir histórico de locações" ++
    "\n[3] Gerenciar estoque" ++
    "\n[4] Sair" ++
    "\n"


menuAdmistrador :: IO()
menuAdmistrador = do
    putStrLn(opcoesMenuAdministrador)
    opcao <- Util.lerEntradaString
    processaOpcao opcao


processaOpcao :: String -> IO()
processaOpcao opcao 
    | opcao == "1" = Admin.cadastraFilme
    | opcao == "2" = exibirLocacoes
    | opcao == "3" = gerenciarEstoque
    | opcao == "4" = Util.putMsgSaida -- pelo figma aqui ficaria pra voltar pra tela inicial, só que fiquei meio na dúvida sobre o aumento do acoplamento...
    | otherwise = menuAdmistrador


----------- Sessão Cadastrar Filme -----------
cadastraFilme :: IO()
cadastraFilme = do
    putStrLn("\n----Cadastro de Filme----")
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

    let msg = Filme.cadastraFilme titulo genero diretor dataLancamento (read quantidade)

    putStrLn(msg)
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
    let result = Locacao.recuperaHistoricoLocacoes
    putStrLn(result)
    putStrLn("----\n")
    exibirLocacoes


getHistoricoLocacoesCliente :: IO()
getHistoricoLocacoesCliente = do
    putStrLn("\nDigite o cpf do cliente: ")
    cpfCliente <- getLine

    let result = Locacao.recuperaHistoricoLocacoesCliente cpfCliente

    putStrLn(result)
    putStrLn("----\n")
    exibirLocacoes


getLocacoesEmAndamento :: IO()
getLocacoesEmAndamento = do
    let result = Locacao.recuperaLocacoesEmAndamento
    putStrLn(result)
    putStrLn("----\n")
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

    let msg = Filme.addEstoqueFilme (read id) (read quantidade)

    putStrLn(msg)
    putStrLn("----\n")
    gerenciarEstoque


verificarDisponibilidade :: IO()
verificarDisponibilidade = do
    let filmes = Filme.recuperaFilmes
    putStrLn("\n" ++ filmes)

    putStrLn("\nIdentificador: ")
    id <- Util.lerEntradaString
    putStrLn("----")

    let msg = Filme.verificaDisponibilidade (read id)

    putStrLn(msg)
    putStrLn("----\n")
    gerenciarEstoque
