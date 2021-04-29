module Cliente where

import ClienteDB

ehCliente :: String -> Bool
ehCliente cpf = ClienteDB.verificaExistenciaCliente cpf

getNome :: String -> String
getNome cpf = ClienteDB.recuperaNomeCliente cpf

cadastraCliente :: String -> String -> String -> String -> String
cadastraCliente nome cpf telefone endereco = do
    if ehCliente cpf
        then "Erro: usuário já cadastrado!"
    else "Usuário cadastrado com sucesso!\n" ++ 
        ClienteDB.cadastraCliente nome cpf telefone endereco

--listaLocacoes :: String -> String
--listaLocacoes cpf = 

