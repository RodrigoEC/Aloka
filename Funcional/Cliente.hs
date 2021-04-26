{-# LANGUAGE OverloadedStrings #-}
module Cliente where
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Database.SQLite.Simple.ToField
import Database.SQLite.Simple.Types

-- definição do tipo Cliente, este será o objeto a ser armazenado no banco de dados.
data Cliente = Cliente{
  nome :: String,
  cpf :: String,
  telefone :: String,
  endereco :: String
} deriving(Show)

-- tradução da representação dos valores dos atributos no bd para o tipo de atributos dos objetos de Cliente.
instance FromRow Cliente   where
  fromRow = Cliente  <$> field
                     <*> field
                     <*> field
                     <*> field

-- tradução dos tipos de atributos dos objetos de Cliente para a representação desses
-- atributos agora no banco de dados.
instance ToRow Cliente where
  toRow(Cliente nome cpf telefone endereco) = toRow(nome, cpf, telefone, endereco)

-- método responsavel por adicionar o objeto cliente no banco de dados 
--a partir do nome, cpf, telefone e endereco.
addCliente :: String -> String -> String -> String -> IO ()
addCliente nome cpf telefone endereco = do
    conn <- open "./dados/aloka.db"
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

-- metodo responsavel por deletar o cliente que possui o cpf passado como parametro 
deletaCliente :: String -> IO()
deletaCliente cpf = do
    conn <- open "./dados/aloka.db"
    execute conn "DELETE FROM clientes WHERE cpf = ?"(Only cpf)


-- Metodo responsavel por retornar uma lista que contém todos os clientes cadastrados no banco de dados.
recuperaClientes :: IO [Cliente]
recuperaClientes = do
    conn <- open "./dados/aloka.db"
    query_ conn "SELECT * FROM clientes"

-- Metodo responsavel por retornar uma lista que contém o cliente com o cpf passado como parametro
recuperaClienteViaCpf :: String -> IO [Cliente]
recuperaClienteViaCpf cpf = do
    conn <- open "./dados/aloka.db"
    query conn "SELECT * FROM clientes WHERE cpf = ?"(Only cpf) :: IO [Cliente]

-- Metodo responsavel por retornar uma string que contém o nome do cliente que possui o cpf passado como parametro.
recuperaNomeCliente :: String -> IO String
recuperaNomeCliente cpf = do
    clientes <- recuperaClienteViaCpf cpf
    return (nome(head clientes))

-- Metodo responsavel por verificar se o cliente está cadastrado no banco de dados
-- se o cliente estiver, retornará True, caso contrário False.
verificaExistenciaCliente :: String -> IO Bool
verificaExistenciaCliente cpf = do
    clientes <- recuperaClienteViaCpf cpf
    if null clientes then
        return False
    else
        return True

-- metodo responsavel por formatar a lista de clientes em uma string mais organizada.
formataExibicaoCliente :: [Cliente] -> [String]
formataExibicaoCliente [] = []
formataExibicaoCliente (cliente:clientes) =  toString cliente : formataExibicaoCliente clientes

-- metodo responsavel pela representação dos atributos do Cliente de forma textual.
toString :: Cliente -> String
toString cliente = "Nome: " ++ nome cliente  ++ ", cpf: " ++ cpf cliente ++ ", telefone: " 
    ++ telefone cliente ++ ", endereco: "  ++ endereco cliente