import Util
import Admin
import ClienteDB
import FilmeDB
import LocacaoDB
import Locadora
import Cliente
import Filme
import Info

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
                        | opcao == "2" = Admin.menuAdmistrador
                        | opcao == "3" = telaCadastroUsuario
                        | opcao == "4" = Info.putMsgSaida
                        | otherwise = do {Info.putMsgOpcaoInvalida; telaPrincipal}


------------ Sessão de Login Cliente -----------
telaLoginCliente :: IO()
telaLoginCliente = do
    Info.putMsgLoginCliente

    cpfCliente <- Util.lerEntradaString
    if Util.ehCpfValido cpfCliente
        then if Cliente.ehCliente cpfCliente
                then do telaLogado cpfCliente
            else do {Info.putMsgUserInvalido; telaLoginCliente}
    else do {Info.putMsgCpfInvalido; telaLoginCliente}

telaLogado :: String -> IO()
telaLogado cpfCliente = do
    let nome = ClienteDB.recuperaNomeCliente cpfCliente
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

            Util.putResumoCadastroUsuario(Cliente.cadastraCliente nome cpf telefone endereco);
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
    else if not(Util.ehIdValido idFilme)
        then do {Info.putMsgIdInvalido; telaLocacaoFilme cpfCliente}
    else do {
        verificaFilme idFilme cpfCliente
    }

verificaFilme :: String -> String -> IO()
verificaFilme idFilme cpfCliente = do
    if(not(FilmeDB.verificaExistenciaFilme (read idFilme)))
        then do {Util.putErroFilmeNaoCadastrado ; telaLocacaoFilme cpfCliente}
    else if (FilmeDB.recuperaEstoqueFilme (read idFilme) <= 0)
        then do {Util.putErroFilmeNaoDisponivel ; telaLocacaoFilme cpfCliente}
    else do {locaFilme idFilme cpfCliente}

locaFilme :: String -> String -> IO()
locaFilme idFilme cpfCliente = do
    Util.putData
    data_locacao <- getLine
    LocacaoDB.cadastraLocacao (read idFilme) cpfCliente data_locacao
    let alugado = FilmeDB.getTituloFilme (read idFilme)
    Util.putInfoLocaFilme alugado
    telaLogado cpfCliente


-------- Sessão Recomendação da Locadora ---------
telaRecomendacao :: String -> IO()
telaRecomendacao cpfCliente = do
    Info.putMsgRecomendacaoGenero
    recomendaFilme cpfCliente

recomendaFilme:: String -> IO()
recomendaFilme cpfCliente = do
    genero <- getLine
    let idFilme = (show (FilmeDB.pesquisaFilmeParaRecomendar genero))
    verificaRecomendacao cpfCliente idFilme

verificaRecomendacao :: String -> String -> IO()
verificaRecomendacao cpfCliente idFilme = do
    if(not(Util.ehIdValido idFilme)) 
        then do {Info.putMsgGeneroInvalido; telaRecomendacao cpfCliente}
    else do {alugaRecomendado cpfCliente idFilme}

alugaRecomendado :: String -> String -> IO()
alugaRecomendado cpfCliente idFilme = do
        Info.putMsgRecomendacao (FilmeDB.getTituloFilme (read idFilme))
        Info.putMsgRecomendaLocacao

        opcao <- Util.lerEntradaString
        redireciona opcao cpfCliente idFilme

redireciona :: String -> String -> String -> IO()
redireciona opcao cpfCliente idFilme
    | opcao == "y" = verificaFilme idFilme cpfCliente
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
    Util.putInfoDevolucaoTop

    --listaFilmes

    Util.putInfoDevolucaoBottom

    idLocacao <- Util.lerEntradaString
    if idLocacao == "M"
        then do telaLogado cpfCliente
    else if not(Util.ehIdValido idLocacao)
        then do {Util.putMsgIdInvalido; telaDevolucao cpfCliente}
    else do {
        devolveFilme idLocacao cpfCliente;
        telaLogado cpfCliente
    }

devolveFilme :: String -> String -> IO()
devolveFilme idLocacao cpfCliente = do 
    --faz a devolucao
    --verifica valor da multa
    Util.putInfoDevolveFilme
