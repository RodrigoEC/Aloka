{-# LANGUAGE OverloadedStrings #-}
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Database.SQLite.Simple.ToField
import Database.SQLite.Simple.Types

data Cliente = Cliente{
  nome :: String,
  cpf :: String,
  telefone :: String,
  endereco :: String
} deriving(Show)

instance FromRow Cliente   where
  fromRow = Cliente  <$> field
                     <*> field
                     <*> field
                     <*> field

instance ToRow Cliente where
  toRow(Cliente nome cpf telefone endereco) = toRow(nome, cpf, telefone, endereco)

addCliente :: String -> String -> String -> String -> IO ()
addCliente nome cpf telefone endereco = do
    conn <- open "../dados/Aloka.db"
    execute_ conn "CREATE TABLE IF NOT EXISTS clientes(\
                   \nome TEXT,\
                   \cpf TEXT PRIMARY KEY,\
                   \telefone TEXT,\
                   \endereco INTEGER\
                   \);"
    execute conn "INSERT INTO clientes(nome,\
                  \ cpf,\
                  \telefone,\
                  \endereco)\
                  \ VALUES (?, ?, ?, ?)"
                  (Cliente nome cpf telefone endereco)

recuperaClientes :: IO [Cliente]
recuperaClientes = do
    conn <- open "../dados/Aloka.db"
    query_ conn "SELECT * FROM clientes"

recuperaClienteViaCpf :: String -> IO [Cliente]
recuperaClienteViaCpf cpf = do
    conn <- open "../dados/Aloka.db"
    query conn "SELECT * FROM clientes WHERE cpf = ?"(Only cpf) :: IO [Cliente]

recuperaNomeCliente :: String -> IO String
recuperaNomeCliente cpf = do
    clientes <- recuperaClienteViaCpf cpf
    return (nome(head clientes))

verificaExistenciaCliente :: String -> IO Bool
verificaExistenciaCliente cpf = do
    clientes <- recuperaClienteViaCpf cpf
    if null clientes then
        return False
    else
        return True

formataExibicaoCliente :: [Cliente] -> [String]
formataExibicaoCliente [] = []
formataExibicaoCliente (cliente:clientes) =  toString cliente : formataExibicaoCliente clientes

toString :: Cliente -> String
toString cliente = "Nome: " ++ nome cliente  ++ ", cpf: " ++ cpf cliente ++ ", telefone: " 
    ++ telefone cliente ++ ", endereco: "  ++ endereco cliente