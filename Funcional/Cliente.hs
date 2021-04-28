module Cliente where

import ClienteDB

ehCliente :: String -> Bool
ehCliente cpf = ClienteDB.verificaExistenciaCliente cpf

cadastraCliente :: String -> String -> String -> String -> String
cadastraCliente nome cpf telefone endereco = do
    if ehCliente cpf
        then "Erro: usuário já cadastrado!"
    else "Usuário cadastrado com sucesso!\n" ++ 
        ClienteDB.cadastraCliente nome cpf telefone endereco

--getRecomendacao :: String -> String
--getRecomendacao cpf
    --genero <- ClienteDB.pesquisaGeneroMaisFrequenteCliente cpfCliente
    --let idFilme = FilmeDB.pesquisaFilmeParaRecomendar genero
    --let recomendacao = FilmeDB.formataFilme idFilme 

--listaLocacoes :: String -> String
--listaLocacoes cpf = 

