import Util
import ClienteDB
import FilmeDB
import LocacaoDB
import Locadora
import Cliente
import Filme
import Info
import Locacao

--------------------------------------------

main :: IO()
main = do
    Locadora.criaBDs
    Info.putLogoInicial
    telaPrincipal

--------------------------------------------


------------- Tela Principal -------------
telaPrincipal :: IO()
telaPrincipal = do
    Info.putMsgOpcoesMenuInicial

    opcao <- Util.lerEntradaString
    mudaTelaPrincipal opcao

mudaTelaPrincipal :: String -> IO()
mudaTelaPrincipal opcao | opcao == "1" = telaLoginCliente
                        | opcao == "2" = telaLoginAdmin
                        | opcao == "3" = telaCadastroUsuario
                        | opcao == "4" = Info.putMsgSaida
                        | otherwise = do {Info.putMsgOpcaoInvalida; telaPrincipal}


------------ Sessão de Login Cliente -----------
telaLoginCliente :: IO()
telaLoginCliente = do
    Info.putMsgLoginCliente

    cpfCliente <- Util.lerEntradaString
    if Util.ehCpfValido cpfCliente
        then if Locadora.ehCliente cpfCliente
                then do telaLogado cpfCliente
            else do {Info.putMsgUserInvalido; telaLoginCliente}
    else do {Info.putMsgCpfInvalido; telaLoginCliente}

telaLogado :: String -> IO()
telaLogado cpfCliente = do
    let nome = Locadora.getNomeCliente cpfCliente
    Info.putMsgOpcoesMenuCliente nome
    
    opcao <- Util.lerEntradaString
    mudaTelaLogado opcao cpfCliente

mudaTelaLogado :: String -> String -> IO()
mudaTelaLogado opcao cpfCliente
    | opcao == "1" = telaListaFilmes cpfCliente 'I'
    | opcao == "2" = telaLocacaoFilme cpfCliente
    | opcao == "3" = telaRecomendacao cpfCliente
    | opcao == "4" = telaDevolucao cpfCliente
    | opcao == "5" = telaPrincipal
    | otherwise = do {Info.putMsgOpcaoInvalida; telaLogado cpfCliente}


--------- Sessão de Login Administrador ----------
telaLoginAdmin :: IO()
telaLoginAdmin = do
    Info.putMsgOpcoesMenuAdmin
    opcao <- Util.lerEntradaString
    mudaTelaLoginAdmin opcao


mudaTelaLoginAdmin :: String -> IO()
mudaTelaLoginAdmin opcao 
    | opcao == "1" = telaCadastraFilme
    | opcao == "2" = telaExibirLocacoes
    | opcao == "3" = telaGerenciarEstoque
    | opcao == "4" = telaPrincipal
    | otherwise = do {Info.putMsgOpcaoInvalida; telaLoginAdmin}


----------- Sessão Cadastrar Filme -----------
telaCadastraFilme :: IO()
telaCadastraFilme = do
    Info.putMsgCadastroFilmeTitulo
    titulo <- Util.lerEntradaString
    Info.putMsgCadastroFilmeGenero
    genero <- Util.lerEntradaString
    Info.putMsgCadastroFilmeDiretor
    diretor <- Util.lerEntradaString
    Info.putMsgCadastroFilmeData
    dataLancamento <- Util.lerEntradaString
    Info.putMsgFilmeQuantidade
    quantidade <- Util.lerEntradaString
    if not(Util.ehNumero quantidade)
       then do {Info.putMsgQuantidadeInvalida; telaCadastraFilme}
    else do {
        Info.putMsgResumoCadastroFilme(Filme.cadastraFilme titulo diretor dataLancamento genero (read quantidade));
        opcao <- Util.lerEntradaString;
        telaLoginAdmin
    }


----------- Sessão Exibir locações -----------
telaExibirLocacoes :: IO()
telaExibirLocacoes = do
    Info.putMsgOpcoesExibirLocacoes
    
    opcao <- Util.lerEntradaString
    mudaTelaExibirLocacoes opcao

mudaTelaExibirLocacoes :: String -> IO()
mudaTelaExibirLocacoes opcao 
    | opcao == "1" = getHistoricoLocacoes
    | opcao == "2" = getHistoricoLocacoesCliente
    | opcao == "3" = getLocacoesEmAndamento
    | opcao == "4" = telaLoginAdmin
    | otherwise = do {Info.putMsgOpcaoInvalida; telaExibirLocacoes}

getHistoricoLocacoes :: IO()
getHistoricoLocacoes = do
    Info.putMsgHistoricoLocacoes

    putStr(Locacao.recuperaHistoricoLocacoes)
   
    Info.putMsgTeclaEnter
    opcao <- Util.lerEntradaString
    telaExibirLocacoes

getHistoricoLocacoesCliente :: IO()
getHistoricoLocacoesCliente = do
    Info.putMsgHistoricoLocacoes
    Info.putMsgHistoricoLocacoesCpf
    
    cpfCliente <- Util.lerEntradaString
    let msg = Locacao.recuperaHistoricoLocacoesCliente cpfCliente
    putStr(msg)
    
    Info.putMsgTeclaEnter
    opcao <- Util.lerEntradaString
    telaExibirLocacoes


getLocacoesEmAndamento :: IO()
getLocacoesEmAndamento = do 
    Info.putMsgHistoricoLocacoesAndamento
    
    putStr(Locacao.recuperaLocacoesEmAndamento)
    
    Info.putMsgTeclaEnter
    opcao <- Util.lerEntradaString
    telaExibirLocacoes

----------- Sessão Gerenciar Estoque -----------
telaGerenciarEstoque :: IO()
telaGerenciarEstoque = do
    Info.putMsgOpcoesGerenciarEstoque
    
    opcao <- Util.lerEntradaString
    mudaTelaGerenciarEstoque opcao

mudaTelaGerenciarEstoque :: String -> IO()
mudaTelaGerenciarEstoque opcao
    | opcao == "1" = addFilmeAoEstoque
    | opcao == "2" = verificarDisponibilidade
    | opcao == "3" = telaLoginAdmin
    | otherwise = do {Info.putMsgOpcaoInvalida; telaGerenciarEstoque}

addFilmeAoEstoque :: IO()
addFilmeAoEstoque = do
    Info.putMsgEstoqueFilmes
    Info.putMsgFilmeIdentificador
    idFilme <- Util.lerEntradaString
    if not(Util.ehNumero idFilme)
        then do {Info.putMsgIdInvalido; addFilmeAoEstoque}
    else do {
        Info.putMsgFilmeQuantidade;
        quantidade <- Util.lerEntradaString;
        if not(Util.ehNumero quantidade)
            then do {Info.putMsgQuantidadeInvalida; addFilmeAoEstoque}
        else do {
            putStrLn("\n" ++ Filme.addEstoqueFilme (read idFilme) (read quantidade));
            Info.putMsgTeclaEnter;
            opcao <- Util.lerEntradaString;
            telaGerenciarEstoque 
        }
    }

verificarDisponibilidade :: IO()
verificarDisponibilidade = do
    Info.putMsgDisponibilidadeFilmes

    putStrLn(Filme.recuperaFilmes)

    Info.putMsgFilmeIdentificador
    idFilme <- Util.lerEntradaString
    if not(Util.ehNumero idFilme)
        then do {Info.putMsgIdInvalido; addFilmeAoEstoque}
    else do {
        putStrLn("\n"  ++ Filme.verificaDisponibilidade(read idFilme));
        Info.putMsgTeclaEnter;
        opcao <- Util.lerEntradaString;
        telaGerenciarEstoque
    }

----------- Sessão Cadastro de Usuario -----------
telaCadastroUsuario :: IO()
telaCadastroUsuario = do
    Info.putMsgCadastroNome
    nome <- Util.lerEntradaString
    Info.putMsgCadastroCpf
    cpf <- Util.lerEntradaString
    if not(Util.ehCpfValido cpf) 
        then do {Info.putMsgCpfInvalido; telaCadastroUsuario}
    else do {
            Info.putMsgCadastroTelefone;
            telefone <- Util.lerEntradaString;
            Info.putMsgCadastroEndereco;
            endereco <- Util.lerEntradaString;

            Info.putMsgResumoCadastroUsuario(Locadora.cadastraCliente nome cpf telefone endereco);
            opcao <- Util.lerEntradaString;
            telaPrincipal
        }
    

-------------- Sessão Fazer Locação -------------
telaLocacaoFilme :: String -> IO()
telaLocacaoFilme cpfCliente = do
    Info.putMsgLocacaoFilme
    
    idFilme <- Util.lerEntradaString
    if idFilme == "L"
        then do telaListaFilmes cpfCliente 'L'
    else if not(Util.ehNumero idFilme)
        then do {Info.putMsgIdInvalido; telaLocacaoFilme cpfCliente}
    else do {
        if Locadora.filmeExiste(read idFilme)
            then if Locadora.filmeDisponivel(read idFilme)
                then do locaFilme idFilme cpfCliente
            else do {Info.putMsgFilmeNaoDisponivel ; telaLocacaoFilme cpfCliente}
        else do {Info.putMsgFilmeNaoCadastrado ; telaLocacaoFilme cpfCliente}
    }

locaFilme :: String -> String -> IO()
locaFilme idFilme cpfCliente = do
    Info.putMsgDataLocacao
    
    dataLocacao <- Util.lerEntradaString
    Locadora.addLocacao (read idFilme) cpfCliente dataLocacao 
    let qtd = Locadora.decrementaFilme (read idFilme)

    Info.putMsgLocaFilme(Locadora.recuperaNomeFilme (read idFilme)) qtd
    telaLogado cpfCliente


-------- Sessão Recomendação da Locadora ---------
telaRecomendacao :: String -> IO()
telaRecomendacao cpfCliente = do
    Info.putMsgRecomendacaoGenero
    genero <- Util.lerEntradaString
    recomendaFilme genero cpfCliente

recomendaFilme:: String -> String -> IO()
recomendaFilme genero cpfCliente = do
    if Util.ehNumero(Locadora.getIdFilmeRecomendado genero)
        then do {alugaRecomendado cpfCliente (Locadora.getIdFilmeRecomendado genero)}
    else do {Info.putMsgGeneroInvalido; telaRecomendacao cpfCliente}

alugaRecomendado :: String -> String -> IO()
alugaRecomendado cpfCliente idFilme = do
    Info.putMsgRecomendacao (Locadora.recuperaNomeFilme(read idFilme))
    Info.putMsgRecomendaLocacao

    opcao <- Util.lerEntradaString
    redireciona opcao cpfCliente idFilme

redireciona :: String -> String -> String -> IO()
redireciona opcao cpfCliente idFilme
    | opcao == "y" = locaFilme idFilme cpfCliente
    | otherwise = telaLogado cpfCliente


----------- Sessão Listar Filmes -----------
telaListaFilmes :: String -> Char -> IO()
telaListaFilmes cpfCliente telaAnterior = do
    Info.putMsgListaFilmes
    putStrLn("\n" ++ Filme.listaFilmes ++ "\n")
    Info.putMsgTeclaEnter

    opcao <- Util.lerEntradaString
    if (telaAnterior == 'L')
        then telaLocacaoFilme cpfCliente
    else telaLogado cpfCliente


----------- Sessão Devolucao -----------
telaDevolucao :: String -> IO()
telaDevolucao cpfCliente = do
    Info.putMsgDevolucaoTop 
    putStrLn(Locadora.listaLocacoesCliente cpfCliente)
    Info.putMsgDevolucaoBottom 

    idLocacao <- Util.lerEntradaString
    if idLocacao == "M"
        then do telaLogado cpfCliente
    else if not(Util.ehNumero idLocacao)
        then do {Info.putMsgIdInvalido; telaDevolucao cpfCliente}
    else if not(Locadora.locacaoExite(read idLocacao))
        then do putStrLn("Locacao nao existe")
    else do {
        Locadora.encerraLocacao(read idLocacao);
        Info.putMsgDevolveFilme(Locadora.devolveFilme(read idLocacao));
        telaLogado cpfCliente
    }      
    
