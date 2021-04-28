{-# LANGUAGE OverloadedStrings #-}
module ClienteDB  where
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow
import Database.SQLite.Simple.ToField
import Database.SQLite.Simple.Types

import Util (queryBD, fromIO, executeBD)

-- definição do tipo Cliente, este será o objeto a ser armazenado no banco de dados.
data Cliente = Cliente{
  id :: Int,
  nome :: String,
  cpf :: String,
  telefone :: String,
  endereco :: String
} deriving(Show, Read)

-- tradução da representação dos valores dos atributos no bd para o tipo de atributos dos objetos de Cliente.
instance FromRow Cliente   where
  fromRow = Cliente  <$> field
                     <*> field
                     <*> field
                     <*> field
                     <*> field

-- tradução dos tipos de atributos dos objetos de Cliente para a representação desses
-- atributos agora no banco de dados.
instance ToRow Cliente where
  toRow(Cliente id nome cpf telefone endereco) = toRow(id, nome, cpf, telefone, endereco)

cadastraCliente :: String -> String -> String -> String -> String
cadastraCliente nome cpf telefone endereco =
  toString(fromIO(addCliente nome cpf telefone endereco))

-- método responsavel por adicionar o objeto cliente no banco de dados 
--a partir do nome, cpf, telefone e endereco.
addCliente :: String -> String -> String -> String -> IO Cliente
addCliente nome cpf telefone endereco = do
    criaBD
    let id = geraId
    insereDado id nome cpf telefone endereco
    return (head (recuperaClienteViaCpf cpf))

insereDado :: Int -> String -> String -> String -> String -> IO()
insereDado id nome cpf telefone endereco = do
    executeBD ("INSERT INTO clientes(nome,\
                \ id, \
                \ cpf, \
                \ telefone,\
                \ endereco)\
                \ VALUES\
                \ ('" ++ nome ++ "',\
                \ " ++ show id ++ ",\
                \ '" ++ cpf ++ "',\
                \ '" ++ telefone ++ "',\
                \ '" ++ endereco ++ "');") ()

criaBD :: IO ()
criaBD = do executeBD "CREATE TABLE IF NOT EXISTS clientes (\
                   \ id INT PRIMARY KEY, \
                   \ nome TEXT,\
                   \ cpf TEXT,\
                   \ telefone TEXT,\
                   \ endereco INTEGER\
                   \);" ()
                   
-- Metodo que cria um id para o Banco de dados dos filmes
geraId :: Int
geraId = length recuperaClientes + 1

-- metodo responsavel por deletar o cliente que possui o cpf passado como parametro 
deletaCliente :: String -> IO()
deletaCliente cpf = executeBD ("DELETE FROM clientes WHERE cpf = '" ++ cpf ++ "';") ()

-- Metodo responsavel por retornar uma lista que contém todos os clientes cadastrados no banco de dados.
recuperaClientes :: [Cliente]
recuperaClientes = fromIO (queryBD "SELECT * FROM clientes")

-- Metodo responsavel por retornar uma lista que contém o cliente com o cpf passado como parametro
recuperaClienteViaCpf :: String -> [Cliente]
recuperaClienteViaCpf cpf = fromIO (queryBD ("SELECT * FROM clientes WHERE cpf = '" ++ cpf ++ "'"))

-- Metodo responsavel por retornar uma string que contém o nome do cliente que possui o cpf passado como parametro.
recuperaNomeCliente :: String -> String
recuperaNomeCliente cpf = nome (head (recuperaClienteViaCpf cpf))

-- Metodo responsavel por verificar se o cliente está cadastrado no banco de dados
-- se o cliente estiver, retornará True, caso contrário False.
verificaExistenciaCliente :: String -> Bool
verificaExistenciaCliente cpf
    | null (recuperaClienteViaCpf cpf) = False 
    | otherwise = True

-- metodo responsavel por formatar a lista de clientes em uma string mais organizada.
formataExibicaoCliente :: [Cliente] -> [String]
formataExibicaoCliente = map toString

-- metodo responsavel pela representação dos atributos do Cliente de forma textual.
toString :: Cliente -> String
toString cliente = "Nome: " ++ nome cliente  ++ "\nCpf: " ++ cpf cliente ++ "\nTelefone: "
    ++ telefone cliente ++ "\nEndereco: "  ++ endereco cliente
