clear() :- writeln('\e[H\e[2J').

putLogo() :-
    cria_path('logo', Path),
    le_arquivo(Path, Linhas),
    escreve_lista(Linhas).

le_arquivo(Path, Linhas) :-
    open(Path, read, File),
    read_file(File, Linhas),
    close(File).

escreve_lista([]).
escreve_lista([Cabeca|Corpo]) :-
    writeln(Cabeca),
    escreve_lista(Corpo).

read_file(Stream,[]) :- at_end_of_stream(Stream).
read_file(Stream,[X | L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    read_file(Stream, L).

cria_path(NomeArquivo, Path) :- concat_atom(['./arquivos/', NomeArquivo, '.txt'], Path).

cria_animacao([]).
cria_animacao([NomeArquivo, Tempo|Resto]) :-
    clear,
    cria_path(NomeArquivo, Path),
    le_arquivo(Path, Linhas),
    escreve_lista(Linhas),
    sleep(Tempo),
    cria_animacao(Resto).