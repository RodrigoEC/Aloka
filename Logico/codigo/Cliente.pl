:-use_module(library(csv)).
:-include('Arquivos.pl').

cadastraCliente(Cpf, Nome, Telefone, Endereco) :-
    (clienteExiste(Cpf) -> write('Cliente Já Cadastrado');
    addCliente(Cpf, Nome, Telefone, Endereco)).

addCliente(Cpf, Nome, Telefone, Endereco) :-
    open('../arquivos/Clientes.csv', append, File),
    writeln(File, (Cpf, Nome, Telefone, Endereco)),                 
    close(File).

clienteExiste(CpfCliente):-
    lerCsvRowList('Clientes.csv', Clientes),
    verificaNaLista(CpfCliente, Clientes).

verificaNaLista(_,[], false).
verificaNaLista(SearchedCpf, [H|T]) :-
     (member(SearchedCpf, H) -> true
     ;verificaNaLista(SearchedCpf, T)).