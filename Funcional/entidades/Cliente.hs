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
addCliente cpf nome telefone endereco = do
    conn <- open "../dados/clientes.db"
    execute_ conn "CREATE TABLE IF NOT EXISTS clientes(\
                   \cpf TEXT PRIMARY KEY,\
                   \nome TEXT,\
                   \telefone TEXT,\
                   \endereco INTEGER\
                   \);"
    execute conn "INSERT INTO clientes (nome, cpf, telefone, endereco) VALUES (?, ?, ?, ?)" (Cliente nome cpf telefone endereco)

getClientes :: IO [Cliente]
getClientes = do
    conn <- open "../dados/clientes.db"
    query_ conn "SELECT * FROM clientes"

getClienteNome :: String -> IO [Cliente]
getClienteNome cpf = do
    conn <- open "../dados/clientes.db"
    query conn "SELECT nome FROM clientes WHERE cpf = ?"(Only cpf) :: IO[Cliente]