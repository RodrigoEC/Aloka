{-# LANGUAGE OverloadedStrings #-}
module Filme where

import System.Random
import           Control.Applicative
import qualified Data.Text as T
import           Database.SQLite.Simple
import           Database.SQLite.Simple.FromRow

import Data.Typeable
import qualified Data.Text.IO as T

-- Tipo de dado "Filme" que será armazenado no BD
data Filme = Filme {
    id_filme :: Int,
    titulo :: String,
    diretor :: String,
    dataLancamento :: String,
    genero :: String,
    estoque :: Int

} deriving (Show)

-- Código que serve para que o Haskell entenda como fazer para transformar os valores das linhas do BD
-- novamente em atributos do Objeto Filme.
instance FromRow Filme where
  fromRow = Filme <$> field
                    <*> field
                    <*> field
                    <*> field
                    <*> field
                    <*> field

-- Código que serve para o Haskell saber como transformar o objeto Filme em uma linha do BD
-- Os atributos do filme são passados para o metodo "toRow" que permite que esse filme seja inserido no BD
instance ToRow Filme where
  toRow (Filme id_filme titulo diretor dataLancamento genero estoque) = toRow (id_filme, titulo, diretor, dataLancamento, genero, estoque)


-- Adiciona filme a partir de título, diretor, dataLancamento, genero, estoque
-- OBS: Verificar formato da data antes de fazer a adição no BD
addFilme :: Int -> String -> String -> String -> String -> Int -> IO()
addFilme id_filme titulo diretor dataLancamento genero estoque = do
    conn <- open "../dados/aloka.db"
    execute_ conn "CREATE TABLE IF NOT EXISTS filmes (\
                 \ id_filme INTEGER PRIMARY KEY, \
                 \ titulo TEXT, \
                 \ diretor TEXT, \
                 \ dataLancamento DATE, \
                 \ genero TEXT, \
                 \ estoque INTEGER \
                 \);"

    execute conn "INSERT INTO filmes (id_filme,\
                \ titulo,\
                \ diretor,\
                \ dataLancamento,\
                \ genero,\
                \ estoque)\
                \ VALUES\
                \ (?, ?, ?, ?, ?, ?)" (Filme id_filme titulo diretor dataLancamento genero estoque)

    close conn

-- Metodo que retorna uma lista com todos os filmes cadastrados no BD de ALOKA.
recuperaFilmes :: IO [Filme]
recuperaFilmes = do
    conn <- open "../dados/aloka.db"
    query_ conn "SELECT * FROM filmes"

-- Metodo que retorna uma lista contendo o filme do 
-- id passado se ele existir, caso contrário uma lista vazia é retornada.
recuperaFilmesID :: Int -> IO [Filme]
recuperaFilmesID id_filme = do
    conn <- open "../dados/aloka.db"
    query conn "SELECT * FROM filmes WHERE id_filme = ?" (Only id_filme) :: IO [Filme]

-- Metodo retornar uma lista contendo todos os filmes do gênero passado como parâmetro da função
recuperaFilmesPorGenero :: String -> IO [Filme]
recuperaFilmesPorGenero genero = do
    conn <- open "../dados/aloka.db"
    query conn "SELECT * FROM filmes WHERE genero = ?" (Only genero) :: IO [Filme]

-- Metodo que verifica existência de um filme no Banco de dados e retorna um valor booleano
-- True se ele existir e False se ele não existir
verificaExistenciaFilme :: Int -> IO Bool
verificaExistenciaFilme id_filme = do
    filmes <- recuperaFilmesID id_filme
    if null filmes then return False else return True

-- Metodo que retorna o estoque atual de um filme a partir de um id cadastrado.
recuperaEstoqueFilme :: Int -> IO Int
recuperaEstoqueFilme idFilme = do
    filmes <- recuperaFilmesID idFilme
    return (estoque (head filmes))

-- Metodo que altera o estoque de um filme, a partir do parâmetro novoEstoque passado.
alteraEstoqueFilme :: Int -> Int -> IO ()
alteraEstoqueFilme idFilme novoEstoque = do
    conn <- open "../dados/aloka.db"
    execute conn "UPDATE filmes SET estoque = ? WHERE id_filme = ?" (novoEstoque, idFilme)

-- Metodo que adiciona ao estoque de um filme o valor do parâmetro qtd que é passado
addEstoqueFilme :: Int -> Int -> IO ()
addEstoqueFilme idFilme qtd = do
    estoque <- recuperaEstoqueFilme idFilme

    if estoque + qtd >= 0 
        then alteraEstoqueFilme idFilme (estoque + qtd)
        else T.putStrLn "Não temos essa quantidade de DVDs disponíveis! Nao dê aLoka, loke menos filmes."

-- Metodo que remove do estoque de um filme o valor do parâmetro qtd que é passado
-- Caso esse valor seja maior do que a quantidade do estoque atual, uma mensagem é mostrada na tela.
removeEstoqueFilme :: Int -> Int -> IO ()
removeEstoqueFilme idFilme qtd = do
    addEstoqueFilme idFilme (-qtd)

-- Metodo que serve para formatar uma lista de filmes para exibição.
formataFilmes :: Integer -> [Filme] -> [String]
formataFilmes _ [] = []
formataFilmes indice filmes@(filme:resto) = ("[" ++ show indice ++ "] " ++ formataFilme filme) : formataFilmes (indice + 1) resto

-- Metodo que serve para formatar um filme específico para exibição.
formataFilme :: Filme -> String
formataFilme filme = "titulo: " ++ titulo filme ++ ", Genero: " ++ genero filme
