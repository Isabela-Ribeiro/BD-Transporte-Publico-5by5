create database empresaOnibus;
CREATE TABLE Empresa
(
	nome VARCHAR(50) NOT NULL,
	localidade VARCHAR(20),
	logradouro VARCHAR(20),
	numero VARCHAR(20) NOT NULL,
	complemento VARCHAR(20),
	uf CHAR(2),
	cep CHAR(8) NOT NULL,
	bairro VARCHAR(20),
	siteWeb VARCHAR(20) NOT NULL,
	CONSTRAINT pkNome PRIMARY KEY (nome)
);
CREATE TABLE TelefoneEmpresa
(
	nome VARCHAR(50) NOT NULL,
	ddd CHAR(2) NOT NULL,
	numero CHAR(9) NOT NULL,
	tipo VARCHAR(20),
	CONSTRAINT fkNome FOREIGN KEY (nome) REFERENCES Empresa (nome),
	CONSTRAINT pkTelefoneEmpresa PRIMARY KEY (nome, numero)
);

CREATE TABLE Linha
(
	codLinha INT NOT NULL,
	nomeLinha VARCHAR(50) NOT NULL,
	sentido VARCHAR(50) NOT NULL,
	CONSTRAINT pkLinha PRIMARY KEY (codLinha)
);
CREATE TABLE EmpresaLinha
(
	nome VARCHAR(50) NOT NULL,
	codLinha INT NOT NULL,
	CONSTRAINT fkEmpresaLinhaNome FOREIGN KEY (nome) REFERENCES Empresa (nome),
	CONSTRAINT fkEmpresaLinhaCodLina FOREIGN KEY (codLinha) REFERENCES Linha (codLinha),
	CONSTRAINT pkEmpresaLinha PRIMARY KEY (nome, codLinha)
);

CREATE TABLE Logradouro
(
	codLog INT NOT NULL,
	nomeLog VARCHAR(50) NOT NULL,
	CONSTRAINT pklogradouro PRIMARY KEY(codLog)
);

CREATE TABLE Itinerario
(
	nomeLog varchar(20)NOT NULL,
	codLog INT NOT NULL,
	codLinha INT NOT NULL,
	CONSTRAINT fkItinerarioCodLog FOREIGN KEY (codLog) REFERENCES Logradouro (codLog),
	CONSTRAINT fkItinerarioCodLinha FOREIGN KEY (codLinha) REFERENCES Linha (codLinha),
	CONSTRAINT pkItinerario PRIMARY KEY (codLog, codLinha),
);

CREATE TABLE Horario
(
	diaSemana VARCHAR(20) NOT NULL,
	horario CHAR(5) NOT NULL,
	codLinha INT NOT NULL,
	CONSTRAINT fkHorarioCodLinha FOREIGN KEY (codLinha) REFERENCES Linha (codLinha),
	CONSTRAINT pkHorario PRIMARY KEY (diaSemana, horario, codLinha)
);

INSERT INTO Empresa
VALUES ('Papini', 'Araraquara', 'Rua 24', '66', 'Apartamento 6 andar', 'SP', '15456789', 'Centro', 'papini.com');

INSERT INTO Linha
VALUES (8, 'Imperador', 'Terminal-Imperador');

INSERT INTO Logradouro
VALUES (7, 'Padre Francisco');

INSERT INTO Itinerario
VALUES ('Av Carlos Bersanetti',32, 1);

insert into Horario
VALUES ('dias uteis', '19:00', 8);

INSERT INTO EmpresaLinha
VALUES ('Isabela', 8);

select nomeLog,codlog from Logradouro,Linha;
SELECT linha.nomeLinha, l.codLinha /*  a) Obter todas as linhas atendidas por uma determinada empresa, dado o nome dessa empresa */
FROM EmpresaLinha l, Linha 
WHERE l.nome = 'Papini' AND Linha.codLinha = L.codLinha;

/* b) Obter o itinerário de uma determinada linha de ônibus, dado o Nome (Identificação) dessa linha.   */
Select x.nomelog from Itinerario x join Linha l ON l.nomeLinha = 'melhado' AND l.codLinha = x.codLinha

 /* c) Obter o quadro de horário de uma determinada linha, dado seu Nome */
Select h.diaSemana, h.horario from Horario h join Linha l ON l.nomeLinha = 'melhado' And h.codLinha = l.codLinha

/*d) Obter  as  linhas  de  ônibus/empresa  quepassam  por  um  determinado logradouro, dado o nome desse logradouro. */
SELECT l.nomeLinha,e.nome
from EmpresaLinha e ,Linha l join Itinerario x  
ON  x.nomeLog = 'Padre Francisco' and x.codLinha = l.codLinha 
where e.codLinha = l.codLinha

