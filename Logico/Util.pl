% Método que da um clear no console durante a execução.
clear :- writeln('\e[H\e[2J').

% Metodo que costumiza a entrada do sistema. Dessa forma, o read possui um formato diferente.
% Ex:
%   administrador>> 
adm_read(Entrada) :-
    write('administrador>> '),
    read(Entrada).

% Metodo que costumiza a entrada do sistema. Dessa forma, o read possui um formato diferente.
% Ex:
%   cliente>> 
cliente_read(Entrada) :-
    write('cliente>> '),
    read(Entrada).

% Método que exibe a logo do ALOKA
put_logo :-
    clear,
    cria_path_frames('logo', 'logo/', Path),
    le_arquivo(Path, Linhas),
    escreve_lista(Linhas).

% Exibe logo do histórico. 
logo_historico :-
    clear,
    cria_path_frames('load_hist10', 'historico/', Path),
    le_arquivo(Path, Linhas),
    escreve_lista(Linhas).

% Exibe logo da pipoca. 
logo_pipoca :-
    cria_path_frames('pipoca', '', Path),
    le_arquivo(Path, Linhas),
    escreve_lista(Linhas).

% Metodo que recebe o path do arquivo, abre, lê e retorna uma lista com o conteúdo
% do arquivo.
le_arquivo(Path, Linhas) :-
    open(Path, read, File),
    read_file(File, Linhas),
    close(File).

% Método que recebe uma lista e escreve no console o seu conteúdo.
escreve_lista([]).
escreve_lista([Cabeca|Corpo]) :-
    writeln(Cabeca),
    escreve_lista(Corpo).

% Metodo auxiliar que é responsável por abrir o arquivo passado
read_file(Stream,[]) :- at_end_of_stream(Stream).
read_file(Stream,[X | L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    read_file(Stream, L).

% Metodo que cria um path para os arquivos txt
cria_path_frames(NomeArquivo, Pasta, Path) :- concat_atom(['./frames/', Pasta, NomeArquivo, '.txt'], Path).

% Metodo que cria a animação dos arquivos txt existentes. O metodo recebe uma lista de nomes
% de arquivos que serão exibidos e o tempo que cada arquivo será exibido na tela.
cria_animacao([], _).
cria_animacao([NomeArquivo, Tempo|Resto], Pasta) :-
    clear,
    cria_path_frames(NomeArquivo, Pasta, Path),
    le_arquivo(Path, Linhas),
    escreve_lista(Linhas),
    sleep(Tempo),
    cria_animacao(Resto, Pasta).

% Método que recebe uma lista e um index da lista e é retornado o elemento associado àquele index.
exibe_por_index([Elem], 0, Elem).
exibe_por_index([Elem|_], 0, Elem).
exibe_por_index([_| Calda], Idx, Elem) :-
    NovoIdx is Idx - 1,
    exibe_por_index(Calda, NovoIdx, Elem).