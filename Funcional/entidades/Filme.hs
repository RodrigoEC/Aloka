{-# LANGUAGE OverloadedStrings #-}

import System.Random
import           Control.Applicative
import qualified Data.Text as T
import           Database.SQLite.Simple
import           Database.SQLite.Simple.FromRow

import Data.Typeable


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

main :: IO ()
main = do
    -- addFilme 20 "o ataque dos tomates assassinos" "john doe" "20/02/1995" "aventura" 4
    filmesTerror <- recuperaFilmesPorGenero "terror"
    filmes <- recuperaFilmes

    mapM_ print (formataFilmes 0 filmesTerror)
    print "------todos os filmes-------"
    mapM_ print (formataFilmes 0 filmes)
    r <- verificaExistenciaFilme 20
    print(r)



formataFilmes :: Integer -> [Filme] -> [String]
formataFilmes _ [] = []
formataFilmes indice filmes@(filme:resto) = ("[" ++ show indice ++ "] " ++ formataFilme filme) : formataFilmes (indice + 1) resto

formataFilme :: Filme -> String
formataFilme filme = "titulo: " ++ titulo filme ++ ", Genero: " ++ genero filme
