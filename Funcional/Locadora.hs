module Locadora where

import FilmeDB
import LocacaoDB
import ClienteDB
import Filme
import Locacao
import Cliente

criaBDs :: IO()
criaBDs = do
    FilmeDB.criaBD
    ClienteDB.criaBD
    LocacaoDB.criaBD

ehCliente :: String -> Bool
ehCliente cpf = Cliente.ehCliente cpf

getNomeCliente :: String -> String
getNomeCliente cpf = Cliente.getNome cpf

cadastraCliente :: String -> String -> String -> String -> String
cadastraCliente nome cpf telefone endereco =
    Cliente.cadastraCliente nome cpf telefone endereco

filmeExiste:: Int-> Bool
filmeExiste idFilme = FilmeDB.verificaExistenciaFilme idFilme

filmeDisponivel:: Int-> Bool
filmeDisponivel idFilme = (FilmeDB.recuperaEstoqueFilme idFilme > 0)

addLocacao:: Int-> String-> String-> IO()
addLocacao idFilme cpfCliente data_locacao = LocacaoDB.cadastraLocacao idFilme cpfCliente data_locacao

decrementaFilme :: Int -> String
decrementaFilme id = Filme.decrementa id

recuperaNomeFilme:: Int-> String
recuperaNomeFilme idFilme = FilmeDB.getTituloFilme idFilme

getIdFilmeRecomendado:: String-> String
getIdFilmeRecomendado genero = (show (FilmeDB.pesquisaFilmeParaRecomendar genero))

listaLocacoesCliente :: String -> String
listaLocacoesCliente = Locacao.listaLocacoes

locacaoExite :: Int -> Bool
locacaoExite id = Locacao.locacaoExiste id

encerraLocacao :: Int -> IO()
encerraLocacao id = Locacao.encerraLocacao id

devolveFilme :: Int -> String
devolveFilme idLocacao = Filme.devolucao(Locacao.getIdFilme idLocacao)