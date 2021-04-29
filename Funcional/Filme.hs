module Filme where

import FilmeDB

cadastraFilme :: String -> String -> String -> String -> String -> String
cadastraFilme titulo genero diretor dataLancamento quantidade = "filme ja ta cadastrado"

listaFilmes :: String
listaFilmes = Filme.formataFilmes FilmeDB.recuperaFilmes

formataFilmes :: [Filme] -> String
formataFilmes [] = "<<vazio>>"
formataFilmes (x:xs) = geraString (FilmeDB.formataFilmes 1 (x:xs))  ""

geraString :: [String] -> String -> String
geraString [] txt = txt
geraString (x:xs) txt = geraString xs (txt ++ "\n" ++ x)

ehFilme :: Int -> Bool
ehFilme id = FilmeDB.verificaExistenciaFilme id

estaDisponivel :: Int -> Bool
estaDisponivel id = FilmeDB.recuperaEstoqueFilme id <= 0