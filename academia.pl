:- use_module(library(odbc)).

%conectar ao banco
% Início da execução do programa

conectar_bd :-
    odbc_connect('MSProlog',_, [user(root),password(''),alias(prolog),open(once)]).

fechar_conexao:-
    odbc_disconnect('prolog').

%função para ler valores



%INSERIR ALUNO

dado_aluno(Nome,Nascimento,Email,Numero,AlunoInserido):-concat(Nome,'","',A),concat(A,Nascimento,B),concat(B,'","',C),concat(C,Email,D),concat(D,'","',E),concat(E,Numero,F),concat('INSERT INTO alunos(nome,data_nasc,email,num) VALUES ("',F,Fim),concat(Fim,'")',AlunoInserido).

%inserir_aluno(Nome,Nascimento,Email,Numero):-dado_aluno(Nome,Nascimento,Email,Numero,Lista),odbc_query('prolog',Lista).

inserir_aluno :-
  write('Digite o nome do aluno (entre aspas("") : '),
  read(Nome),
   write('Digite a data de nascimento do aluno (entre aspas("") e no  formato DD/MM/AAAA: '),
   read(Nascimento),
   write('Digite o e-mail do aluno(entre aspas(""): '),
   read(Email),
   write('Digite o número de telefone do aluno(entre aspas(""): '),
   read(Numero),
   dado_aluno(Nome,Nascimento,Email,Numero,ListaAluno),
   odbc_query('prolog',ListaAluno).



%INSERIR PLANO

dado_plano(Nome,Descricao,Preco,PlanoInserido):-concat(Nome,'","',A),
    concat(A,Descricao,B),
    concat(B,'","',D),
    concat(D,Preco,E),concat('INSERT INTO planos(nome,descricao,preco) VALUES ("',E,FimConcat),
    concat(FimConcat,'")',PlanoInserido).

inserir_plano:-
     write('Digite o nome do plano(entre aspas("")): '),
     read(Nome),
     write('Digite a descrição do plano(entre aspas("") : '),
     read(Descricao),
     write('Digite o preço do plano(entre aspas(""): '),
     read(Preco),
     dado_plano(Nome,Descricao,Preco,ListaPlano),
     odbc_query('prolog',ListaPlano).



%INSERIR AULA

dado_aula(Nome,NomeInstrutor,Horario,AulaInserida):-concat(Nome,'","',A),
    concat(A,NomeInstrutor,B),
    concat(B,'","',C),
    concat(C,Horario,D),
    concat('INSERT INTO aulas(nome,instrutor,horario) VALUES ("',D,FimConcat),
    concat(FimConcat,'")',AulaInserida).

inserir_aula:-
     write('Digite o nome da aula (entre aspas(""): '),
     read(Nome),
     write('Digite o nome do instrutor (somente primeiro nome): '),
     read(String),
     write('Digite o horário: (entre aspas("") e no formato HH-HH'),
     read(Horario),
     lowercase(String,NomeInstrutor),
     dado_aula(Nome,NomeInstrutor,Horario,ListaAula),
     odbc_query('prolog',ListaAula).


%INSERIR FREQUENCIA

dado_frequencia(IdAluno,DataRegistro,Presenca,FrequenciaInserida):-concat(IdAluno,'","',A),
    concat(A,DataRegistro,B),
    concat(B,'","',D),
    concat(D,Presenca,E),
    concat('INSERT INTO frequencia(idaluno,datafreq,presenca) VALUES("',E,FimConcat),
    concat(FimConcat,'")',FrequenciaInserida).

inserir_frequencia:-
    alunos_matriculados,
    write('Digite o id do aluno: '),
     read(IdAluno),
     write('Digite a data do registro: (entre aspas("") e no  formato DD/MM/AAAA'),
     read(DataRegistro),
     write('Digite a presença(s para presente ou n para ausente): '),
     read(Presenca),
     dado_frequencia(IdAluno,DataRegistro,Presenca,ListaFrequencia),
     odbc_query('prolog',ListaFrequencia).


%VER TODOS OS ALUNOS MATRICULADOS.

alunos_matriculados:-
    odbc_query('prolog','SELECT id , nome FROM alunos',row(Id,Nome)),
    writeln(Id-Nome),
    fail.
    alunos_matriculados.

%VER TODOS OS PLANOS DISPONÍVEIS

planos_disponiveis:-
   odbc_query('prolog','SELECT nome FROM planos', row(Nome)),
   writeln(Nome),
    fail.
   planos_disponiveis.

%VÊ A FREQUÊNCIA DE UM ALUNO EM DETERMINADA DATA

dado_frequencia_aluno(IdAluno,Data,BuscaFrequencia):-
    concat('SELECT nome, datafreq,presenca FROM frequencia f
    JOIN alunos a on a.id =f.idaluno
    WHERE idaluno =',IdAluno,A),
    concat(A,' AND ',B),
    concat(B,'datafreq = "',C),
    concat(C,Data,D),
    concat(D,'"',BuscaFrequencia).

frequencia_aluno:-
    alunos_matriculados,
     write('Digite o id do aluno: '),
     read(IdAluno),
     write('Digite a data que quer buscar a presença: (entre aspas("") e no formato DD/MM/AAAA'),
     read(Data),
     dado_frequencia_aluno(IdAluno,Data,ResultadoFrequencia),
    odbc_query('prolog',ResultadoFrequencia,row(Nome,Datafreq,Presenca)),
    writeln(Nome-Datafreq-Presenca).


%ver as aulas ministradas por um instrutor específico

dado_aulas(Instrutor,ListaAulas):-
    concat('SELECT nome,instrutor FROM aulas WHERE instrutor = "',Instrutor,A),
    concat(A,'"',ListaAulas).

ver_aulas:-
    professores,
     write('Digite o nome do instrutor (entre aspas(""):'),
     read(String),
     lowercase(String,Instrutor),
     dado_aulas(Instrutor,ListaAulas),
     odbc_query('prolog',ListaAulas,row(Nome,Instrutor)),
     writeln(Instrutor-Nome).


%MOSTRA OS PROFESSORES DISPONÍVEIS

professores:-
     odbc_query('prolog','SELECT id ,instrutor FROM aulas',row(Id,Instrutor)),
    writeln(Id-Instrutor),
    fail.
    professores.


%TRANSFORMA A STRING EM MINUSCULA

lowercase(String, LowercaseString) :-
    atom_codes(String, StringCodes),
    maplist(lowercase_char, StringCodes, LowercaseCodes),
    atom_codes(LowercaseString, LowercaseCodes).

lowercase_char(Upper, Lower) :-
    code_type(Upper, to_upper(Lower)).



%RECUPERAR ALUNOS AUSENTES

dado_aluno_ausente(Data,ListaAusente):-
    concat('SELECT a.nome,f.datafreq,f.presenca FROM frequencia f
    INNER JOIN alunos a on a.id= f.idaluno
    WHERE presenca = "n" AND datafreq = "',Data,A),
   concat(A,'"',ListaAusente).

ver_ausentes:-
     write('Digite a data (entre aspas("") e no formato DD-MM-AAAA:'),
     read(Data),
     dado_aluno_ausente(Data,Ausentes),
     odbc_query('prolog',Ausentes,row(Nome,DataFreq,Presenca)),
     writeln(Nome-DataFreq-Presenca).


%MENU NO TERMINAL

menu :-
    conectar_bd,
    repeat,
    write('Selecione uma opção:'), nl,
    write('1. Registrar um aluno:'), nl,
    write('2. Registrar um plano:'), nl,
    write('3. Registrar a frequência de um aluno:'), nl,
    write('4. Inserir uma aula:'), nl,
    write('5. Ver os alunos matriculados:'), nl,
    write('6. Ver os planos disponíveis:'), nl,
    write('7. Ver a frequência de um aluno em uma determinada data:'), nl,
    write('8. Ver as aulas ministradas por um instrutor:'), nl,
    write('9. Ver os alunos ausentes em determinada data:'), nl,
    write('0. Sair'), nl,
    read(Opcao),
    executar_opcao(Opcao),
    Opcao = 0,
    !.

executar_opcao(1) :-
    writeln('INSERINDO ALUNO...'),
    inserir_aluno,
     write('ALUNO INSERIDO'),nl,
     write('================').
executar_opcao(2) :-
   writeln('INSERINDO PLANO...'),
   inserir_plano,
   write('PLANO INSERIDO'),nl,
   write('================').
executar_opcao(3) :-
    writeln('REGISTRANDO A FREQUÊNCIA...'),
    inserir_frequencia,
    write('FREQUÊNCIA REGISTRADA'),nl,
    write('================').
executar_opcao(4) :-
   writeln('INSERINDO UMA AULA...'),
   inserir_aula ,
   write('AULA INSERIDA'),nl,
   write('================').
executar_opcao(5) :-
    write('================'),nl,
   alunos_matriculados,
   write('================'),nl.
executar_opcao(6) :-
    write('================'),nl,
    planos_disponiveis,
   write('================'),nl.
executar_opcao(7) :-
    write('================'),nl,
   frequencia_aluno ,
   write('================'),nl.
executar_opcao(8) :-
    write('================'),nl,
  ver_aulas,
   write('================'),nl.
executar_opcao(9) :-
    write('================'),nl,
  ver_ausentes,
   write('================'),nl.
executar_opcao(0) :-
    writeln('Saindo do menu...'),
   fechar_conexao.

