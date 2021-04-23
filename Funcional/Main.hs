---  Ler entradas
lerEntradaInt :: IO Int
lerEntradaInt = do
         x <- readLn
         return x

lerEntradaString :: IO String
lerEntradaString = do
         x <- getLine
         return x
--- 