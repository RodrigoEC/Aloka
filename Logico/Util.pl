% Método que da um clear no console durante a execução.
clear :- writeln('\e[H\e[2J').

% Método que exibe a logo do ALOKA
put_logo :-
    clear,
    cria_path('logo', Path),
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
cria_path(NomeArquivo, Path) :- concat_atom(['./arquivos/', NomeArquivo, '.txt'], Path).

% Metodo que cria a animação dos arquivos txt existentes. O metodo recebe uma lista de nomes
% de arquivos que serão exibidos e o tempo que cada arquivo será exibido na tela.
cria_animacao([]).
cria_animacao([NomeArquivo, Tempo|Resto]) :-
    clear,
    cria_path(NomeArquivo, Path),
    le_arquivo(Path, Linhas),
    escreve_lista(Linhas),
    sleep(Tempo),
    cria_animacao(Resto).