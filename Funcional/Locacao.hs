module Locacao where

import LocacaoDB

recuperaHistoricoLocacoes :: String
recuperaHistoricoLocacoes
    | not (null locacoes) = "\nLocações:\n\n" ++ locacoes
    | otherwise = "\nSem locações para mostrar\n"
    where locacoes = concatenaToStringsLocacoes LocacaoDB.recuperaLocacoes


recuperaHistoricoLocacoesCliente :: String -> String
recuperaHistoricoLocacoesCliente cpfCliente
    | not (null locacoes) = "\nLocações:\n\n" ++ locacoes
    | otherwise = "\nSem locações para mostrar\n"
    where locacoes = concatenaToStringsLocacoes (LocacaoDB.recuperaLocacaoIdCliente cpfCliente)


recuperaLocacoesEmAndamento :: String
recuperaLocacoesEmAndamento
    | not (null locacoes) = "\nLocações:\n\n" ++ locacoes
    | otherwise = "\nSem locações para mostrar\n"
    where locacoes = concatenaToStringsLocacoes (LocacaoDB.recuperaLocacoesEmAndamento)

concatenaToStringsLocacoes :: [Locacao] -> String
concatenaToStringsLocacoes [] = ""
concatenaToStringsLocacoes (locacao:outras) = (LocacaoDB.toString locacao) ++ "\n" ++ (concatenaToStringsLocacoes outras)

locacaoExiste :: Int -> Bool
locacaoExiste id = length(LocacaoDB.recuperaLocacaoId id) > 0

listaLocacoes :: String -> String
listaLocacoes cpf = formataLocacoes(LocacaoDB.recuperaLocacaoAndamentoCliente cpf) ""

formataLocacoes :: [Locacao] -> String -> String
formataLocacoes [] txt = txt ++ "\n"
formataLocacoes (x:xs) txt = formataLocacoes xs (txt ++ "\n" ++ LocacaoDB.toString x)

encerraLocacao :: Int -> IO()
encerraLocacao id = LocacaoDB.finalizaLocacao id

getIdFilme :: Int -> Int
getIdFilme idLocacao = LocacaoDB.recuperaIDFilme idLocacao