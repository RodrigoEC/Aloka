{-# LANGUAGE OverloadedStrings #-}

module FilmeDB where

import           Control.Applicative
import qualified Data.Text as T
import           Database.SQLite.Simple
import           Database.SQLite.Simple.FromRow
import System.Random

import Data.Typeable
import qualified Data.Text.IO as T

import Util (queryBD, fromIO, executeBD)

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

-- Método que exibe o título de um filme a partir do id do filme.
getTituloFilme :: Int -> String
getTituloFilme idFilme = titulo (head(recuperaFilmeID idFilme))

cadastraFilme :: String -> String -> String -> String -> Int -> Filme
cadastraFilme titulo diretor dataLancamento genero estoque =
    fromIO(addFilme titulo diretor dataLancamento genero estoque)

-- Adiciona filme a partir de título, diretor, dataLancamento, genero, estoque
-- OBS: Verificar formato da data antes de fazer a adição no BD
addFilme :: String -> String -> String -> String -> Int -> IO Filme
addFilme titulo diretor dataLancamento genero estoque = do
    let id = fromIO geraId
    criaBD
    insereDado id titulo diretor dataLancamento genero estoque

    return (head (recuperaFilmeID id))
    

insereDado :: Int -> String -> String -> String -> String -> Int -> IO()
insereDado id titulo diretor dataLancamento genero estoque = do
    executeBD ("INSERT INTO filmes (id_filme,\

                \ titulo,\
                \ diretor,\
                \ dataLancamento,\
                \ genero,\
                \ estoque)\
                \ VALUES\
                \ (" ++ show id ++ ",\
                \ '" ++ titulo ++ "',\
                \ '" ++ diretor ++ "',\
                \ '" ++ dataLancamento ++ "',\
                \ '" ++ genero ++ "',\
                \ " ++ show estoque ++ ");") ()


criaBD :: IO ()
criaBD = do executeBD "CREATE TABLE IF NOT EXISTS filmes (\
                 \ id_filme INT PRIMARY KEY, \
                 \ titulo TEXT, \
                 \ diretor TEXT, \
                 \ dataLancamento DATE, \
                 \ genero TEXT, \
                 \ estoque INT \
                 \);" ()

-- Metodo que cria um id para o Banco de dados dos filmes
geraId :: IO Int
geraId = getStdRandom(randomR (0, 1000)) :: IO Int

-- Metodo que retorna uma lista com todos os filmes cadastrados no BD de ALOKA.
recuperaFilmes :: [Filme]
recuperaFilmes = do
    let resultado = queryBD "SELECT * FROM filmes LIMIT 0, 100"
    let filmes = fromIO resultado
    filmes

    

-- Metodo que retorna uma lista contendo o filme do 
-- id passado se ele existir, caso contrário uma lista vazia é retornada.
recuperaFilmeID :: Int -> [Filme]
recuperaFilmeID id_filme = fromIO (queryBD ("SELECT * FROM filmes WHERE id_filme = " ++ show id_filme))

recuperaFilmeTitulo :: String -> [Filme]
recuperaFilmeTitulo titulo = fromIO (queryBD ("SELECT * FROM filmes WHERE titulo = '" ++ titulo ++ "'"))

-- Metodo retornar uma lista contendo todos os filmes do gênero passado como parâmetro da função
recuperaFilmesPorGenero :: String -> [Filme]
recuperaFilmesPorGenero genero = fromIO (queryBD ("SELECT * FROM filmes WHERE genero = '" ++ genero ++ "'"))

-- Metodo que verifica existência de um filme no Banco de dados e retorna um valor booleano
-- True se ele existir e False se ele não existir
verificaExistenciaFilme :: Int -> Bool
verificaExistenciaFilme id_filme
    | null (recuperaFilmeID (read $ show id_filme)) = False
    | otherwise = True

-- Metodo que verifica existência de um filme no Banco de dados e retorna um valor booleano
-- True se ele existir e False se ele não existir
verificaExistenciaFilmePorTitulo :: String -> Bool
verificaExistenciaFilmePorTitulo titulo
    | null (recuperaFilmeTitulo titulo) = False
    | otherwise = True

-- Metodo que retorna o estoque atual de um filme a partir de um id cadastrado.
recuperaEstoqueFilme :: Int -> Int
recuperaEstoqueFilme idFilme
    | verificaExistenciaFilme idFilme = estoque (head (recuperaFilmeID idFilme))
    | otherwise = -1

-- Metodo que altera o estoque de um filme, a partir do parâmetro novoEstoque passado.
alteraEstoqueFilme :: Int -> Int -> IO String
alteraEstoqueFilme idFilme novoEstoque = do 
    executeBD ("UPDATE filmes SET estoque = " ++ show novoEstoque ++ " WHERE id_filme = " ++ show idFilme) ()
    return (show novoEstoque)

-- Metodo que adiciona ao estoque de um filme o valor do parâmetro qtd que é passado
addEstoqueFilme :: Int -> Int -> String
addEstoqueFilme idFilme qtd
    | estoque + qtd >= 0 = fromIO (alteraEstoqueFilme idFilme (estoque + qtd))
    | otherwise = show qtd
    where
        estoque = recuperaEstoqueFilme idFilme

-- Metodo que remove do estoque de um filme o valor do parâmetro qtd que é passado
-- Caso esse valor seja maior do que a quantidade do estoque atual, uma mensagem é mostrada na tela.
removeEstoqueFilme :: Int -> Int -> String
removeEstoqueFilme idFilme qtd = addEstoqueFilme idFilme (-qtd)

-- Metodo que serve para formatar uma lista de filmes para exibição.
formataFilmes :: Int -> [Filme] -> [String]
formataFilmes _ [] = []
formataFilmes indice filmes@(filme:resto) = ("[" ++ show (id_filme filme) ++ "] " ++ formataFilme filme) : formataFilmes (indice + 1) resto

-- Metodo que serve para formatar um filme específico para exibição.
formataFilme :: Filme -> String
formataFilme filme = "Título: " ++ titulo filme ++ ", Gênero: " ++ genero filme

--- pesdquisa um id de filme para aquele genero, se tiver filmes daquele genero
pesquisaFilmeParaRecomendar:: String -> Int
pesquisaFilmeParaRecomendar genero
    | length (recuperaFilmesPorGeneroDisp genero) > 0 = randomizaFilme (recuperaFilmesPorGeneroDisp genero)
    | otherwise = -1

--método auxiliar que randomiza o id do filme
randomizaFilme:: [Filme] -> Int
randomizaFilme filmes = (id_filme (filmes!!(randomInt 0 (length filmes-1))))

-- randomiza o inteiro, recebe o i que é o inicio do range e o j que eh o final do range
randomInt :: Int-> Int -> Int
randomInt i j = fromIO(getStdRandom(randomR (i, j)) :: IO Int)

-- recupera filmes que estão disponiveis de acordo com seu genero
recuperaFilmesPorGeneroDisp :: String -> [Filme]
recuperaFilmesPorGeneroDisp genero = fromIO (queryBD ("SELECT * FROM filmes WHERE estoque > 0 AND genero = '" ++ genero ++ "'"))

