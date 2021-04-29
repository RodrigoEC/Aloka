module Locacao where

import LocacaoDB

recuperaHistoricoLocacoes :: String
recuperaHistoricoLocacoes
    | not (null historico) = historico
    | otherwise = "Sem locações para mostrar"
    where historico = concatenaToStringsLocacoes LocacaoDB.recuperaLocacoes


concatenaToStringsLocacoes :: [Locacao] -> String
concatenaToStringsLocacoes [] = ""
concatenaToStringsLocacoes (locacao:outras) = (LocacaoDB.toString locacao) ++ (concatenaToStringsLocacoes outras)
