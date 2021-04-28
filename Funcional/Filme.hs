module Filme where

import FilmeDB


cadastraFilme :: String -> String -> String -> String -> Int -> String
cadastraFilme titulo diretor dataLancamento genero quantidade = do
    if FilmeDB.verificaExistenciaFilmePorTitulo titulo
        then "Erro: filme já cadastrado!"
    else
        FilmeDB.cadastraFilme titulo genero diretor dataLancamento quantidade
