:- include('ClienteDB.pl').

eh_cliente(CPF, Result) :- clienteExiste(CPF, Result).

get_nome(CPF, Result) :- getNome(CPF, Result).

adiciona_cliente(Nome, CPF, Telefone, Endereco, Result) :- clienteExiste(CPF, R),
    (R -> Result = "Erro: usuário já cadastrado!";
    add_Cliente(Nome, CPF, Telefone, Endereco, Result)).

add_Cliente(Nome, CPF, Telefone, Endereco, Result) :- 
    addCliente(CPF, Nome, Telefone, Endereco),
    resumoCliente(Nome, CPF, Telefone, Endereco, Result).

resumoCliente(Nome, CPF, Telefone, Endereco, Result):- 
    string_concat('Nome: ', Nome, N),
    string_concat('\nCPF: ', CPF, C),
    string_concat('\nTelefone: ', Telefone, T),
    string_concat('\nEndereco: ', Endereco, E),
    string_concat('Usuário cadastrado com sucesso!\n', N, R1),
    string_concat(R1, C, R2),
    string_concat(R2, T, R3),
    string_concat(R3, E, Result).
