module Cliente (
    Cliente(Cliente),
    Clientes(Clientes),
    writeCliente
) where

import System.IO
import System.IO.Unsafe
    
-- Definicao dos atributos
data Cliente = Cliente{
    nome :: String,
    cpf :: String,
    telefone :: String,
    endereco :: String,
    locacoes :: [String]
} deriving (Show, Read)

--- Definindo o array
data Clientes = Clientes{
    clientes :: [Cliente]
} deriving Show

--- Getters (acredito eu que nao precise de mais que isso)
toString :: Cliente -> String
toString (Cliente {nome = n, cpf = c, telefone = t, endereco = e, locacoes = l}) = n++" , "++c ++" , "++ t ++" , " ++ e

getNome:: Cliente -> String
getNome (Cliente {nome = n, cpf = c, telefone = t, endereco = e, locacoes = l}) = n

getCpf:: Cliente -> String
getCpf (Cliente {nome = n, cpf = c, telefone = t, endereco = e, locacoes = l}) = c

getLocacoes:: Cliente -> [String]
getLocacoes (Cliente {nome = n, cpf = c, telefone = t, endereco = e, locacoes = l}) = l

getClientes :: Clientes -> [Cliente]
getClientes (Clientes {clientes = c}) = c

--- Persistência acho q n vou usar
writeCliente:: [Cliente] -> IO()
writeCliente clientes = do
    arq <- openFile "../arquivos/arqClientes.csv" AppendMode
    hPutStr arq (formataParaEscritaClientes clientes 0)
    hClose arq

formataParaEscritaClientes :: [Cliente]-> Int -> String
formataParaEscritaClientes cs i
        |i >= length cs = ""
        |otherwise = (toString (getFilmeByIndex i cs)) ++ "\n" ++ formataParaEscritaClientes cs (i+1)

--- Métodos
adicionaLocacaoCliente:: [Cliente] -> Int -> String -> Maybe [Cliente]
adicionaLocacaoCliente clientes i novaLocacao
    |i >= length clientes = Nothing
    |otherwise = addLocacaoCliente (getFilmeByIndex i clientes) novaLocacao

addLocacaoCliente:: Cliente -> String -> Maybe [Cliente]
addLocacaoCliente (Cliente {nome = n, cpf = c, telefone = t, endereco = e, locacoes = l}) novaLocacao = Just([Cliente n c t e (l++[novaLocacao])])

--- Utíl
getFilmeByIndex :: Int -> [Cliente] -> Cliente
getFilmeByIndex 0 (x:xs) = x
getFilmeByIndex n (x:xs) = getFilmeByIndex (n-1) xs