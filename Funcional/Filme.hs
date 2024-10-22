module Filme where

import FilmeDB

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

cadastraFilme :: String -> String -> String -> String -> Int -> String
cadastraFilme titulo diretor dataLancamento genero quantidade
    | FilmeDB.verificaExistenciaFilmePorTitulo titulo = "Erro: filme já cadastrado!"
    | otherwise = "Filme de id: " ++ show idFilme ++ " cadastrado com sucesso!\n" ++ toString titulo diretor dataLancamento genero quantidade
    where idFilme = id_filme (FilmeDB.cadastraFilme titulo diretor dataLancamento genero quantidade)

addEstoqueFilme :: Int -> Int -> String
addEstoqueFilme idFilme quantidade
    | not(FilmeDB.verificaExistenciaFilme idFilme) = "Erro: Filme com id " ++ show idFilme ++ " não cadastrado!"
    | otherwise = "Agora temos " ++ qtd ++ " filme(s) " ++ tituloFilme ++ " no estoque!"
    where 
        tituloFilme = titulo (head (FilmeDB.recuperaFilmeID idFilme))
        qtd = FilmeDB.addEstoqueFilme idFilme quantidade

verificaDisponibilidade :: Int -> String
verificaDisponibilidade idFilme 
    | not(FilmeDB.verificaExistenciaFilme idFilme) = "Erro: Filme com id " ++ show idFilme ++ " não cadastrado!"
    | otherwise = "Há no estoque " ++ show quantidade ++ " filme(s) " ++ tituloFilme ++ " disponível(is) para locação."
    where
        quantidade = FilmeDB.recuperaEstoqueFilme idFilme
        tituloFilme = titulo (head (FilmeDB.recuperaFilmeID idFilme))

recuperaFilmes :: String
recuperaFilmes
    | not (null filmes) = "\nFilmes:\n" ++ filmes
    | otherwise = "\nNão há filmes para exibir!\n"
    where filmes = concatenaToStringsFilmes (FilmeDB.recuperaFilmes)

concatenaToStringsFilmes :: [Filme] -> String
concatenaToStringsFilmes [] = ""
concatenaToStringsFilmes (filme:outros) = "id: " ++ show (id_filme filme) ++ " - " ++ (FilmeDB.formataFilme filme) ++ "\n" ++ (concatenaToStringsFilmes outros)

devolucao :: Int -> String
devolucao id = FilmeDB.addEstoqueFilme id 1

decrementa :: Int -> String
decrementa id = FilmeDB.removeEstoqueFilme id 1

toString ::  String -> String -> String -> String -> Int -> String
toString titulo diretor dataLancamento genero quantidade =
    "Titulo: " ++ titulo  ++ "\nGênero: " ++ genero ++ "\nDiretor: " ++ diretor 
    ++ "\nData de lançamento: "  ++ dataLancamento ++ "\nQuantidade: " ++ show quantidade