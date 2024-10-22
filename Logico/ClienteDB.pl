:-use_module(library(csv)).
:-include('Arquivos.pl').

% Adiciona um cliente no arquivo
addCliente(Cpf, Nome, Telefone, Endereco) :-
    open('./dados/Clientes.csv', append, File),
    writeln(File, (Cpf, Nome, Telefone, Endereco)),                 
    close(File).

% Verifica se o cliente existe, le o arquivo csv e chama o método verificaNaLista que vai ver se o cliente está na lista
clienteExiste(CpfCliente, Result):-
    lerCsvRowList('Clientes.csv', Clientes),
    verificaNaLista(CpfCliente, Clientes, Result).

% Retorna nome do cliente a partir do cpf
getNome(Cpf, Nome):-
    lerCsvRowList('Clientes.csv', Clientes),
    getEntidadeById(Cpf, Clientes, Cliente),
    elementByIndex(1, Cliente, Nome).