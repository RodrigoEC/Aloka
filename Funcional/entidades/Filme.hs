{-# LANGUAGE OverloadedStrings #-}
module Filme where

import System.Random
import           Control.Applicative
import qualified Data.Text as T
import           Database.SQLite.Simple
import           Database.SQLite.Simple.FromRow

import Data.Typeable
import qualified Data.Text.IO as T


data Filme = Filme {
    id_filme :: Int,
    titulo :: String,
    diretor :: String,
    dataLancamento :: String,
    genero :: String,
    estoque :: Int

} deriving (Show)

instance FromRow Filme where
  fromRow = Filme <$> field
                    <*> field
                    <*> field
                    <*> field
                    <*> field
                    <*> field

instance ToRow Filme where
  toRow (Filme id_filme titulo diretor dataLancamento genero estoque) = toRow (id_filme, titulo, diretor, dataLancamento, genero, estoque)

addFilme :: Int -> String -> String -> String -> String -> Int -> IO()
addFilme id_filme titulo diretor dataLancamento genero estoque = do
    conn <- open "../dados/filmes.db"
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


recuperaFilmes :: IO [Filme]
recuperaFilmes = do
    conn <- open "../dados/filmes.db"
    query_ conn "SELECT * FROM filmes"

recuperaFilmesID :: Int -> IO [Filme]
recuperaFilmesID id_filme = do
    conn <- open "../dados/filmes.db"
    query conn "SELECT * FROM filmes WHERE id_filme = ?" (Only id_filme) :: IO [Filme]


recuperaFilmesPorGenero :: String -> IO [Filme]
recuperaFilmesPorGenero genero = do
    conn <- open "../dados/filmes.db"
    query conn "SELECT * FROM filmes WHERE genero = ?" (Only genero) :: IO [Filme]


verificaExistenciaFilme :: Int -> IO Bool
verificaExistenciaFilme id_filme = do
    filmes <- recuperaFilmesID id_filme
    if null filmes then return False else return True

recuperaEstoqueFilme :: Int -> IO Int
recuperaEstoqueFilme idFilme = do
    filmes <- recuperaFilmesID idFilme
    return (estoque (head filmes))

alteraEstoqueFilme :: Int -> Int -> IO ()
alteraEstoqueFilme idFilme novoEstoque = do
    conn <- open "../dados/filmes.db"
    execute conn "UPDATE filmes SET estoque = ? WHERE id_filme = ?" (novoEstoque, idFilme)

addEstoqueFilme :: Int -> Int -> IO ()
addEstoqueFilme idFilme qtd = do
    estoque <- recuperaEstoqueFilme idFilme

    if estoque + qtd >= 0 
        then alteraEstoqueFilme idFilme (estoque + qtd)
        else T.putStrLn "Não temos essa quantidade de DVDs disponíveis! Nao dê aLoka, loke menos filmes."

removeEstoqueFilme :: Int -> Int -> IO ()
removeEstoqueFilme idFilme qtd = do
    addEstoqueFilme idFilme (-qtd)

formataFilmes :: Integer -> [Filme] -> [String]
formataFilmes _ [] = []
formataFilmes indice filmes@(filme:resto) = ("[" ++ show indice ++ "] " ++ formataFilme filme) : formataFilmes (indice + 1) resto

formataFilme :: Filme -> String
formataFilme filme = "titulo: " ++ titulo filme ++ ", Genero: " ++ genero filme
