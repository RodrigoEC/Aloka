module Filme where

import FilmeDB


cadastraFilme :: String -> String -> String -> String -> Int -> String
cadastraFilme titulo diretor dataLancamento genero quantidade
    | FilmeDB.verificaExistenciaFilmePorTitulo titulo = "Erro: filme já cadastrado!"
    | otherwise = "Filme - " ++ titulo ++ " - com id " ++ show idFilme ++ " cadastrado com sucesso!"
    where idFilme = id_filme (FilmeDB.cadastraFilme titulo genero diretor dataLancamento quantidade)
