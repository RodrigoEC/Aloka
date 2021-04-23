import System.IO 
import System.IO.Unsafe
import Control.Exception
import System.IO.Error 
import System.Process
import Control.Monad (when)
import Text.Printf
import System.IO.Unsafe

import Cliente

main::IO()
main = do
    putStrLn ("Nome do usuário: ")
    nomeCliente <- getLine
    putStrLn ("CPF: ")
    cpfCliente <- getLine
    putStrLn ("Telefone: ")
    telefone <- getLine
    putStrLn ("Endereço: ")
    endereco <- getLine
    putStrLn("Usuário " ++ nomeCliente ++ "cadastrado com Sucesso")
    hSetBuffering stdin NoBuffering
    hSetEcho stdin False
    let cliente = Cliente nomeCliente cpfCliente telefone endereco []
    let listaCliente = [cliente]
    let adicionarCliente = listaCliente
    writeCliente adicionarCliente