# :minidisc: ALOKA
<p align=center>
  <img width=350 src="https://user-images.githubusercontent.com/42751604/115566016-47e34880-a290-11eb-99c6-5052a4c88d13.png"/> 
</p>

### Índice
- [O que é o ALOKA?](#o-que-é-o-aloka)
- [Administrador](#-administrador)
  - [Cadastro de filmes](#clipboardclapper-cadastro-de-filmes)
  - [Exibir locações](#pencil-exibir-locações)
  - [Gerenciamento de estoque](#bar_chart-gerenciamento-de-estoque)
- [Cliente](#-cliente)
- [Cadastro de novos clientes](#clipboard-cadastro-de-novos-clientes)
- [Como executar o projeto?](#arrow_forward-como-executar-o-projeto)
- [Equipe do ALOKA(H)](#pushpin-equipe-do-alokah)

O *ALOKA* é um sistema criado como projeto final da disciplina de Paradigmas de Linguagens de Programação com a finalidade de fixar os conhecimentos adquiridos na disciplina.

Caso queira visualizar o projeto, acesse esse [link do design e telas do projeto](https://www.figma.com/file/7sJAJApkPpNLwYtmqszuc4/ALOKA?node-id=9%3A30).

## O que é o ALOKA?
Para relembrar e de certa forma homenagear as locadoras, nós decidimos desenvolver o *ALOKA*, uma locadora de filmes virtual. É possível dividir o nosso sistema em três partes, onde duas dela são as partes principais do sistema:

### 👩🏻‍💼👨🏽‍💼 Administrador
O administrador é o personagem responsável por gerenciar a locadora, sendo assim, é capaz de realizar:

#### :clipboard::clapper: **Cadastro de filmes**
Para realizar o cadastro de um filme, o administrador precisará disponibilizar:
- Título;
- Diretor(a);
- Gênero do filme;
- Data de lançamento;
- Unidades disponíveis;
- Id do filme;

Com esses dados em mãos o administrador pode realizar o cadastro de filme(s) tranquilamente.

#### :pencil: **Exibir locações**
A fim de manter o controle das suas locações o administrador pode escolher exibir o histórico de locações, esse histórico pode ser de três tipos:
- **Histórico geral**: Todo o histórico de locações realizadas na locadora;
- **Histórico do cliente**: Todo o histórico de locações feitas por um determinado cliente, essa consulta é realizada a partir do CPF do cliente;
- **Locações em andamento**: Todas as locações em andamento. 

#### :bar_chart: Gerenciamento de estoque
O administrador pode comprar novos DVDs, sendo assim é necessário que seja possível realizar a adição de novas unidades no sistema.

### 👩🏾‍💻👨🏻‍💻 Cliente
O cliente é o usuário comum da locadora. No *ALOKA* o cliente pode realizar as seguintes operações:

- **Listar filmes**: O cliente pode listar todos os filmes disponíveis para locação.
- **Fazer locação**: Uma vez visualizado os filmes disponíveis o cliente pode fazer a locação a partir do id do filme escolhido.
- **Solicitar uma recomendação da locadora**: Caso o cliente não consiga decidir qual o filme que ele/ela deseja, ou não tenha o filme escolhido disponível, é possível solicitar a locadora uma recomendação feita a partir do perfil do cliente;
- **Devolução**: Após o tempo de locação o cliente precisa devolver o filme, dessa forma é possível devolver o filme e com essa devolução uma eventual multa é exibida ao cliente.

### :clipboard:👩🏼‍💻 Cadastro de novos clientes
Um usuário novo pode desejar se cadastrar no sistema do *ALOKA*, dessa forma, é possível que um novo usuário crie a sua própria conta a partir de:
- Nome;
- CPF;
- Telefone;
- Endereço.

## :arrow_forward: Como executar o ALOKA?

[Acesse o passo a passo para executar o projeto na linguagem Haskell](https://github.com/RodrigoEC/Aloka/edit/main/Funcional/README.md)

## :pushpin: Equipe do ALOKA(H)

- [Daniel Gomes de Lima](https://github.com/dnlgomesl)
- [Franciclaudio Dantas](https://github.com/claudiodantas)
- [Gustavo Farias](https://github.com/GusttaFS)
- [Leandra Oliveira](https://github.com/LeandraOS)
- [Rodrigo Eloy](https://github.com/RodrigoEC)
