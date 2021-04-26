{-# LANGUAGE OverloadedStrings #-}

import System.Random
import           Control.Applicative
import qualified Data.Text as T
import           Database.SQLite.Simple
import           Database.SQLite.Simple.FromRow

import Data.Typeable
import qualified Data.Text.IO as T

-- Tipo de dado "Locacao" que será armazenado no BD
data Locacao = Locacao {
    id_locacao :: Int,
    id_filme :: Int,
    cpf_cliente :: T.Text ,
    data_locacao :: T.Text ,
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


-- Adiciona filme a partir de título, diretor, dataLancamento, genero, estoque
-- OBS: Verificar formato da data antes de fazer a adição no BD
cadastraLocacao :: Int -> T.Text  -> T.Text  -> IO()
cadastraLocacao id_filme cpf_cliente data_locacao = do
    conn <- open "../dados/aloka.db"
    execute_ conn "CREATE TABLE IF NOT EXISTS locacao (\
                 \ id_locacao INTEGER PRIMARY KEY, \
                 \ id_filme INTEGER, \
                 \ cpf_cliente TEXT, \
                 \ data_locacao DATE, \
                 \ status TEXT, \
                 \ CONSTRAINT fk_filme FOREIGN KEY (id_filme) REFERENCES filme(id),\
                 \ CONSTRAINT fk_cliente FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf)\
                 \);"

    qtdLinhas <- geraId

    execute conn "INSERT INTO locacao (\
                \ id_locacao, \
                \ id_filme,\
                \ cpf_cliente,\
                \ data_locacao,\
                \ status)\
                \ VALUES\
                \ (?, ?, ?, ?, ?);" (Locacao (qtdLinhas + 1) id_filme cpf_cliente data_locacao "em andamento")
    close conn

geraId :: IO Int
geraId = do
    locacoes <- recuperaLocacoes
    print locacoes
    return (length locacoes)


finalizaLocacao :: Int -> IO ()
finalizaLocacao id_locacao = do
    conn <- open "../dados/aloka.db"
    executeNamed conn "UPDATE locacao SET status = :str WHERE id_locacao = :id" [":str" := ("finalizado" :: T.Text), ":id" := id_locacao]
    close conn

main :: IO()
main = do
    print ""
