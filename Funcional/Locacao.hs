module Locacao where

import LocacaoDB

recuperaHistoricoLocacoes :: String
recuperaHistoricoLocacoes
    | not (null locacoes) = "\nLocações:\n" ++ locacoes
    | otherwise = "\nSem locações para mostrar\n"
    where locacoes = concatenaToStringsLocacoes LocacaoDB.recuperaLocacoes


recuperaHistoricoLocacoesCliente :: String -> String
recuperaHistoricoLocacoesCliente cpfCliente
    | not (null locacoes) = "\nLocações:\n" ++ locacoes
    | otherwise = "\nSem locações para mostrar\n"
    where locacoes = concatenaToStringsLocacoes (LocacaoDB.recuperaLocacaoIdCliente cpfCliente)


recuperaLocacoesEmAndamento :: String
recuperaLocacoesEmAndamento
    | not (null locacoes) = "\nLocações:\n" ++ locacoes
    | otherwise = "\nSem locações para mostrar\n"
    where locacoes = concatenaToStringsLocacoes (LocacaoDB.recuperaLocacoesEmAndamento)


concatenaToStringsLocacoes :: [Locacao] -> String
concatenaToStringsLocacoes [] = ""
concatenaToStringsLocacoes (locacao:outras) = (LocacaoDB.toString locacao) ++ "\n" ++ (concatenaToStringsLocacoes outras)
