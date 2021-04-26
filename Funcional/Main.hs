import qualified Util as Util

--------------------------------------------

main :: IO()
main = do
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
--                      | opcao == "2" = telaAdmistrador (Cláudio)
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
   
    --  verificaUserLogin cpfCliente

--verificaClienteBD cpfCliente (verifica se o cpf digitado existe no bd e retorna um bolean)    
--verificaUserLogin :: String -> IO()
--verificaUserLogin cpfCliente = if(not(verificaClienteBD cpfCliente)) 
--                                 then do {putStrLn("Erro! Usuário não cadastrado") ; telaLogin}
--                               else(telaLogado cpfCliente)

telaLogado :: String -> IO()
telaLogado cpfCliente = do
    Util.carregaLogo

    -- Consultar bd para obter o nome do Cliente

    Util.listaOpcoesMenuLogin "<<nome>>" -- passar o nome do  futuramente

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

            --faz o cadastro

            Util.putResumoCadastroUsuario nome cpf telefone endereco;
            telaPrincipal
        }
    

-------------- Sessão Fazer Locação -------------
telaLocacaoFilme :: String -> IO()
telaLocacaoFilme cpfCliente = do
    Util.carregaLogo
    Util.putInfoLocacaoFilme
    
    idFilme <- Util.lerEntradaString
    if idFilme == "0"
        then do telaListaFilmes cpfCliente 'L'
    else if not(Util.ehIdValido idFilme)
        then do {Util.putMsgIdInvalido; telaLocacaoFilme cpfCliente}
    else do {
        verificaFilme idFilme cpfCliente
    }

---- verificaExistenciaFilmeBD: verifica se o filme ta cadastrado no bd - retorna um boolean
---- verificaDisponibilidadeBD: verifica se ainda tem copia do filme para alugar, no bd -  retorna um boolean

verificaFilme :: String -> String -> IO()
verificaFilme idFilme cpfCliente
--  | not(verificaExistenciaFilmeBD idFilme) = do {putStrLn("Erro! Filme não cadastrado") ; telaFazerLocacao cpfCliente}
--  | not(verificaDisponibilidadeBD idFilme) = do {putStrLn("Erro! Filme indisponível") ; telaFazerLocacao cpfCliente}
    | otherwise = locaFilme idFilme cpfCliente

---- locarFilmeBD: adiciona um filme no Cliente, no bd
---- pesquisaFilmeBDByID: retorna o nome do filme
locaFilme :: String -> String -> IO()
locaFilme idFilme cpfCliente = do
--  locarFilmeBD idFilme cpfCliente
--  let alugado = pesquisaFilmeBDByID idFilme 
    
    Util.putInfoLocaFilme
    telaLogado cpfCliente

-------- Sessão Recomendação da Locadora ---------
telaRecomendacao :: String -> IO()
telaRecomendacao cpfCliente = do
    Util.carregaLogo
    Util.putInfoRecomendacao

    recomendaFilme cpfCliente

---- pesquisaFilmeParaRecomendarBD: retorna o id do filme recomendado, disponivel
---- pesquisaFilmeBDByID: retorna o nome do filme
recomendaFilme:: String -> IO()
recomendaFilme cpfCliente = do
--  let idFilme = pesquisaFilmeParaRecomendarBD
--  let recomendacao = pesquisaFilmeBDByID idFilme 
--  putStrLn(recomendacao)
    Util.putInfoRecomendaFilme
--  let idFilme = pesquisaFilmeParaRecomendarBD
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
    listaFilmes --listando os dados

    Util.putInfoListaFilmesBottom
    opcao <- Util.lerEntradaString
    if (telaAnterior == 'L')
        then telaLocacaoFilme cpfCliente
    else telaLogado cpfCliente

listaFilmes :: IO()
listaFilmes = do
    putStrLn("---")
    putStrLn("\n<<Lista de filmes>>\n")
    putStrLn("---")


----------- Sessão Devolucao -----------
telaDevolucao :: String -> IO()
telaDevolucao cpfCliente = do
    Util.putInfoDevolucaoTop

    -- consulta dados
    listaFilmes

    Util.putInfoDevolucaoBottom

    idFilme <- Util.lerEntradaString
    if idFilme == "0"
        then do telaLogado cpfCliente
    else if not(Util.ehIdValido idFilme)
        then do {Util.putMsgIdInvalido; telaDevolucao cpfCliente}
    else do {
        devolveFilme idFilme cpfCliente;
        telaLogado cpfCliente
    }

devolveFilme :: String -> String -> IO()
devolveFilme idFilme cpfCliente = do 
    --faz a devolucao
    --verifica valor da multa
    Util.putInfoDevolveFilme
