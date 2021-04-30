module Admin where

import qualified Util
import Filme
import Locacao
import Info


telaLoginAdmin :: IO()
telaLoginAdmin = do
    Info.putMsgOpcoesMenuAdmin
    opcao <- Util.lerEntradaString
    mudaTelaLoginAdmin opcao


mudaTelaLoginAdmin :: String -> IO()
mudaTelaLoginAdmin opcao 
    | opcao == "1" = Admin.cadastraFilme
    | opcao == "2" = exibirLocacoes
    | opcao == "3" = gerenciarEstoque
    | opcao == "4" = telaLoginAdmin
    | otherwise = Info.putMsgOpcaoInvalida


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

    let msg = Filme.cadastraFilme titulo diretor dataLancamento genero (read quantidade)

    putStrLn(msg)
    putStrLn("----")

    telaLoginAdmin


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
        telaLoginAdmin
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
    "\n[2] Verificar disponibilidade de filmes" ++
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
        telaLoginAdmin
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
