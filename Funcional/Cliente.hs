module Cliente where

import ClienteDB

cadastraCliente :: String -> String -> String -> String -> String
cadastraCliente nome cpf telefone endereco = do
    if verificaExistenciaCliente cpf
        then "Erro: cliente já cadastrado!"
    else ClienteDB.cadastraCliente nome cpf telefone endereco