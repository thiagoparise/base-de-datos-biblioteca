CREATE TABLE Consulta (
	id_consulta INT IDENTITY(1,1) NOT NULL,

	fecha_consulta DATE NOT NULL,

	cod_isbn CHAR(13) NOT NULL,
	num_ejemplar INT NOT NULL,
	num_lector INT NOT NULL,

	CONSTRAINT PK_Consulta PRIMARY KEY (id_consulta),

	CONSTRAINT FK_Consulta_Ejemplar FOREIGN KEY (num_ejemplar, cod_isbn) REFERENCES Ejemplar(num_ejemplar, cod_isbn),

	CONSTRAINT FK_Consulta_Lector FOREIGN KEY (num_lector) REFERENCES Lector(num_lector)
);
