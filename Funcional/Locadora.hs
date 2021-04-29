module Locadora where

import FilmeDB
import LocacaoDB
import ClienteDB

criaBDs :: IO()
criaBDs = do
    FilmeDB.criaBD
    ClienteDB.criaBD
    LocacaoDB.criaBD

ehCliente :: String -> Bool
ehCliente cpf = ClienteDB.ehCliente cpf

getNomeCliente :: String -> String
getNomeCliente cpf = ClienteDB.getNome cpf

cadastraCliente :: String -> String -> String -> String -> String
cadastraCliente nome cpf telefone endereco =
    ClienteDB.cadastraCliente nome cpf telefone endereco