import Util
import Admin
import ClienteDB
import FilmeDB
import LocacaoDB
import Locadora
import Cliente
import Filme

--------------------------------------------

main :: IO()
main = do
    Locadora.criaBDs
    Util.carregaLogoInicial
    telaPrincipal

--------------------------------------------


------------- Tela Principal -------------
telaPrincipal :: IO()
telaPrincipal = do
    Util.carregaLogo
    Util.listaOpcoesMenuInicial

    opcao <- Util.lerEntradaString
    mudaTelaPrincipal opcao

mudaTelaPrincipal :: String -> IO()
mudaTelaPrincipal opcao | opcao == "1" = telaLoginCliente
                        | opcao == "2" = Admin.menuAdmistrador
                        | opcao == "3" = telaCadastroUsuario
                        | opcao == "4" = Util.putMsgSaida
                        | otherwise = do {Util.putMsgOpcaoInvalida; telaPrincipal}


-------------- Sessão de Login -------------
telaLoginCliente :: IO()
telaLoginCliente = do
    Util.carregaLogo
    Util.putInfoLoginCliente

    cpfCliente <- Util.lerEntradaString
    if Util.ehCpfValido cpfCliente
        then do telaLogado cpfCliente
    else do {Util.putMsgCpfInvalido; telaLoginCliente}
   
    verificaUserLogin cpfCliente

--verificaClienteBD cpfCliente (verifica se o cpf digitado existe no bd e retorna um bolean)    
verificaUserLogin :: String -> IO()
verificaUserLogin cpfCliente = if(not(ClienteDB.verificaExistenciaCliente cpfCliente)) 
                                 then do {putStrLn("Erro! Usuário não cadastrado") ; telaLoginCliente}
                               else(telaLogado cpfCliente)

telaLogado :: String -> IO()
telaLogado cpfCliente = do
    Util.carregaLogo

    let cliente = ClienteDB.recuperaNomeCliente cpfCliente

    Util.listaOpcoesMenuLogin cliente
    opcao <- Util.lerEntradaString
    mudaTelaLogado opcao cpfCliente

mudaTelaLogado :: String -> String -> IO()
mudaTelaLogado opcao cpfCliente
    | opcao == "1" = telaListaFilmes cpfCliente 'I'
    | opcao == "2" = telaLocacaoFilme cpfCliente
    | opcao == "3" = telaRecomendacao cpfCliente
    | opcao == "4" = telaDevolucao cpfCliente
    | opcao == "5" = telaPrincipal
    | otherwise = do {Util.putMsgOpcaoInvalida; telaLogado cpfCliente}


----------- Sessão Cadastro de Usuario -----------
telaCadastroUsuario :: IO()
telaCadastroUsuario = do
    Util.carregaLogo
    Util.putInfoCadastroNome
    nome <- Util.lerEntradaString
    Util.putInfoCadastroCpf
    cpf <- Util.lerEntradaString
    if not(Util.ehCpfValido cpf) 
        then do {Util.putMsgCpfInvalido; telaCadastroUsuario}
    else do {
            Util.putInfoCadastroTelefone;
            telefone <- Util.lerEntradaString;
            Util.putInfoCadastroEndereco;
            endereco <- Util.lerEntradaString;

            Util.putResumoCadastroUsuario(Cliente.cadastraCliente nome cpf telefone endereco);
            opcao <- Util.lerEntradaString;
            telaPrincipal
        }
    

-------------- Sessão Fazer Locação -------------
telaLocacaoFilme :: String -> IO()
telaLocacaoFilme cpfCliente = do
    Util.carregaLogo
    Util.putInfoLocacaoFilme
    
    idFilme <- Util.lerEntradaString
    if idFilme == "L"
        then do telaListaFilmes cpfCliente 'L'
    else if not(Util.ehIdValido idFilme)
        then do {Util.putMsgIdInvalido; telaLocacaoFilme cpfCliente}
    else do {
        verificaFilme idFilme cpfCliente
    }

verificaFilme :: String -> String -> IO()
verificaFilme idFilme cpfCliente
    | not(FilmeDB.verificaExistenciaFilme (read idFilme)) = do {putStrLn("Erro! Filme não cadastrado") ; telaLocacaoFilme cpfCliente}
    | (FilmeDB.recuperaEstoqueFilme (read idFilme) < 0) = do {putStrLn("Erro! Filme indisponível") ; telaLocacaoFilme cpfCliente}
    | otherwise = locaFilme idFilme cpfCliente

---- locarFilmeBD: adiciona una locacaO
locaFilme :: String -> String -> IO()
locaFilme idFilme cpfCliente = do
--  locarFilmeBD idFilme cpfCliente
    let alugado = FilmeDB.getTituloFilme (read idFilme)
    
    Util.putInfoLocaFilme alugado
    telaLogado cpfCliente

-------- Sessão Recomendação da Locadora ---------
telaRecomendacao :: String -> IO()
telaRecomendacao cpfCliente = do
    Util.carregaLogo 
    recomendaFilme cpfCliente

recomendaFilme:: String -> IO()
recomendaFilme cpfCliente = do
--  genero <- ClienteDB.pesquisaGeneroMaisFrequenteCliente cpfCliente
--  let idFilme = FilmeDB.pesquisaFilmeParaRecomendar genero
--  let recomendacao = FilmeDB.formataFilme idFilme 
--  Util.putInfoRecomendacao recomendacao
    opcao <- Util.lerEntradaString
    redireciona opcao cpfCliente

redireciona :: String -> String -> IO()
redireciona opcao cpfCliente 
    | opcao == "y" = telaLocacaoFilme cpfCliente
    | otherwise = telaLogado cpfCliente


----------- Sessão Listar Filmes -----------
telaListaFilmes :: String -> Char -> IO()
telaListaFilmes cpfCliente telaAnterior = do
    Util.putInfoListaFilmes
    
    putStrLn("\n" ++ Filme.listaFilmes ++ "\n")

    Util.putInfoTeclaEnter
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
