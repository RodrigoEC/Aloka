# Aloka
<p align=center>
  <img width=350 src="https://user-images.githubusercontent.com/42751604/115566016-47e34880-a290-11eb-99c6-5052a4c88d13.png"/> 
</p>

O Aloka é um sistema criado como projeto final da disciplina de Paradigmas de Linguagens de Programação com a finalidade de fixar os conhecimentos de programação funcional.

Caso queria visualizar o projeto, acesse esse [link do design e telas do projeto](https://www.figma.com/file/7sJAJApkPpNLwYtmqszuc4/ALOKA?node-id=9%3A30).

## O que é Aloka?
Para relembrar e de certa forma homenagear as locadoras nós decidimos fazer o Aloka, uma locadora de filmes virtual. É possível dividir o nosso sistema em três partes, onde duas dela são as partes principais do sistema:

### Administrador
O administrador é o personagem responsável por fazer o gerenciamento da locadora. O administrador é capaz de fazer:

#### **Cadastro de filmes**
Para fazer o cadastro de um filme, o administrador precisará disponibilizar:
- Título;
- Diretor(a);
- Gênero do filme;
- Data de lançamento;
- Unidades disponíveis;
- Id do filme;

Com esse dados em mãos o administrador pode fazer o cadastro do filme tranquilamente.

#### Exibir locações
A fim de manter o controle das suas locações o administrador pode escolher exibir o histórico de locações, esse histórico pode ser de 3 tipos:
- **Histórico geral**: Todo o histórico de locações ja feitas na locadora;
- **Histórico do cliente**: Todo o histórico de locações ja feitas por um determinado cliente, essa consulta é feita a partir do CPF do cliente;
- **Locações em andamento**: Todas as locações em andamento. 

#### Gerenciamento de estoque
O administrador pode comprar novos DVDs, sendo assim é necessário que seja possível fazer a adição de novas unidades no sistema.

### Cliente
O cliente é o usuário comum da locadora. No Aloka o cliente pode fazer as seguintes operações:

- **Listar filmes**: O cliente pode listar todos os filmes disponíveis para locação
- **Fazer locação**: Uma vez visualizado os filmes disponíveis o cliente pode fazer a locação a partir do id do filme escolhido
- **Solicitar uma recomendação da locadora**: Caso o cliente não consiga decidir qual o filme que ele/ela quer, é possível solicitar a locadora uma recomendação feita a partir do perfil do cliente;
- **Devolução**: Após o tempo de locação o cliente precisa devolver o filme, dessa forma é possível devolver o filme e com essa devolução uma possível multa é mostrada ao cliente.

### Cadastro de novos clientes
Um usuário novo pode querer se cadastrar no sistema do Aloka, dessa forma, é possível que um novo usuário crie a sua própria conta a partir de:
- Nome;
- CPF;
- Telefone;
- Endereço.

## Como executar o projeto?

## Equipe do ALOKA(H)

- [Daniel Gomes de Lima](https://github.com/dnlgomesl)
- [Franciclaudio Dantas](https://github.com/claudiodantas)
- [Gustavo Farias](https://github.com/GusttaFS)
- [Leandra Oliveira](https://github.com/LeandraOS)
- [Rodrigo Eloy](https://github.com/RodrigoEC)

