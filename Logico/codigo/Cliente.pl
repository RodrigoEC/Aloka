:-use_module(library(csv)).
:-include('Arquivos.pl').

cadastraCliente(Cpf, Nome, Telefone, Endereco) :-
    open('../arquivos/Clientes.csv', append, File),
    writeln(File, (Cpf, Nome, Telefone, Endereco)),                 
    close(File).