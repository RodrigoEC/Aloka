module Util where

import System.IO.Unsafe
import Database.SQLite.Simple

lerEntradaString :: IO String
lerEntradaString = do
         x <- getLine
         return x

ehCpfValido :: String -> Bool
ehCpfValido cpfCliente
   | length cpfCliente /= 11 = False
   | otherwise = all (`elem` ['0'..'9']) cpfCliente

ehNumero :: String -> Bool
ehNumero id
   | length id == 0 = False
   | otherwise = all (`elem` ['0'..'9']) id

fromIO :: IO a -> a
fromIO = unsafePerformIO

executeBD :: ToRow q => String -> q -> IO ()
executeBD acao propriedades = do
   conn <- open "./dados/aloka.db"
   let pesquisa = read $ show acao :: Query
   execute conn pesquisa propriedades
   close conn

queryBD :: FromRow r => String -> IO [r]
queryBD query = do
   conn <- open "./dados/aloka.db"
   let pesquisa = read $ show query :: Query
   query_ conn pesquisa