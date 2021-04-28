{-# LANGUAGE OverloadedStrings #-}
module LocacaoBD where
import           Control.Applicative
import qualified Data.Text as T
import           Database.SQLite.Simple
import           Database.SQLite.Simple.FromRow
import Data.Typeable
import qualified Data.Text.IO as T
import Util(queryBD, executeBD, fromIO)

-- Tipo de dado "Locacao" que será armazenado no BD
data Locacao = Locacao {
    id_locacao :: Int,
    id_filme :: Int,
    cpf_cliente ::String,
    data_locacao ::String,
    status :: String
} deriving (Show)

-- Código que serve para que o Haskell entenda como fazer para transformar os valores das linhas do BD
-- novamente em atributos do Objeto Locacao.
instance FromRow Locacao where
  fromRow = Locacao <$> field
                    <*> field
                    <*> field
                    <*> field
                    <*> field

-- Código que serve para o Haskell saber como transformar o objeto Locacao em uma linha do BD
-- Os atributos do filme são passados para o metodo "toRow" que permite que esse filme seja inserido no BD
instance ToRow Locacao where
  toRow (Locacao id_locacao id_filme cpf_cliente data_locacao status) = toRow (id_locacao, id_filme, cpf_cliente, data_locacao, status)


-- cadastra locação a partir do id do filme, cpf do clinete e data da locação
-- OBS: Verificar formato da data antes de fazer a adição no BD
cadastraLocacao :: Int ->String ->String -> IO()
cadastraLocacao id_filme cpf_cliente data_locacao = do
    executeBD "CREATE TABLE IF NOT EXISTS locacao (\
                 \ id_locacao INTEGER PRIMARY KEY, \
                 \ id_filme INTEGER, \
                 \ cpf_cliente TEXT, \
                 \ data_locacao DATE, \
                 \ status TEXT, \
                 \ CONSTRAINT fk_filme FOREIGN KEY (id_filme) REFERENCES filme(id),\
                 \ CONSTRAINT fk_cliente FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf)\
                 \);"()

    let id = geraId

    executeBD ("INSERT INTO locacao (\
                \ id_locacao, \
                \ id_filme,\
                \ cpf_cliente,\
                \ data_locacao,\
                \ status)\
                \ VALUES\
                \(" ++ show id ++ ",\
                \"++ show id_filme ++ ",'\
                \" ++ cpf_cliente ++ "','\
                \" ++ data_locacao ++ "',\
                \"++ "'em andamento'" ++")")()

-- Metodo que gera um id da tabela a partir da quantidade de locacoes cadastradas
geraId :: Int
geraId = length recuperaLocacoes + 1

-- Método responsavel por retornar todas as locacoes de um cliente
recuperaLocacoes :: [Locacao]
recuperaLocacoes = fromIO (queryBD "SELECT * FROM locacao")

-- Método responsavel por retornar a locação  que possui o id passado como parametro
recuperaLocacaoId :: Int -> [Locacao]
recuperaLocacaoId id_locacao = fromIO (queryBD ("SELECT * FROM locacao WHERE id_locacao = " ++ show id_locacao))

-- Método responsavel por retornar a locação do cliente que possui o cpf passado como parametro
recuperaLocacaoIdCliente :: String -> [Locacao]
recuperaLocacaoIdCliente cpf_cliente = fromIO (queryBD ("SELECT * FROM locacao WHERE cpf_cliente = '" ++ cpf_cliente ++ "'"))

-- Método responsavel por retornar a locação do cliente que possui o status passado como parametro
recuperaLocacaoStatus :: String -> [Locacao]
recuperaLocacaoStatus status = fromIO (queryBD ("SELECT * FROM locacao WHERE status = '" ++ status ++ "'"))

-- Método responsavel por retornar uma lista contendo as locações que possuem o status "em andamento"
recuperaLocacoesEmAndamento :: [Locacao]
recuperaLocacoesEmAndamento  = fromIO (queryBD "SELECT * FROM locacao WHERE status = 'em andamento'")

-- Metodo que altera o status da locacao para finalizado
finalizaLocacao :: Int -> IO ()
finalizaLocacao id_locacao = do
    conn <- open "./dados/aloka.db"
    executeNamed conn "UPDATE locacao SET status = :str WHERE id_locacao = :id" [":str" := ("'finalizado'" :: T.Text), ":id" := id_locacao]
    close conn 
