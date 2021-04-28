module Locadora where

import FilmeDB
import LocacaoDB
import ClienteDB

criaBDs :: IO()
criaBDs = do
    FilmeDB.criaBD
    ClienteDB.criaBD
    LocacaoDB.criaBD
