:- include('ClienteDB.pl').

% Metodo responsavel por verificar se um cliente esta cadastrado.
eh_cliente(CPF, Result) :- clienteExiste(CPF, Result).

% Metodo que retorna o nome do cliente a partir do cpf.
get_nome(CPF, Result) :- getNome(CPF, Result).

% Metodo que verificar o cliente ja esta cadastrado, caso nao esteja segue para o novo cadastro.
add_cliente(Nome, CPF, Telefone, Endereco, Result) :- clienteExiste(CPF, R),
    (R -> Result = "Erro: usuário já cadastrado!";
    adiciona_cliente(Nome, CPF, Telefone, Endereco, Result)).

% Metodo responsavel por adcionar um cliente no sistema.
adiciona_cliente(Nome, CPF, Telefone, Endereco, Result) :- 
    addCliente(CPF, Nome, Telefone, Endereco),
    resumoCliente(Nome, CPF, Telefone, Endereco, Result).

% Metodo responsavel por exibir o resumo dos dados de um cliente.
resumoCliente(Nome, CPF, Telefone, Endereco, Result):- 
    string_concat('Nome: ', Nome, N),
    string_concat('\nCPF: ', CPF, C),
    string_concat('\nTelefone: ', Telefone, T),
    string_concat('\nEndereco: ', Endereco, E),
    string_concat('Usuário cadastrado com sucesso!\n', N, R1),
    string_concat(R1, C, R2),
    string_concat(R2, T, R3),
    string_concat(R3, E, Result).
