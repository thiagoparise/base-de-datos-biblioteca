CREATE TABLE Dicta (
	num_lector INT NOT NULL,
	id_materia INT NOT NULL,

	CONSTRAINT PK_Dicta PRIMARY KEY (num_lector, id_materia),

	CONSTRAINT FK_Dicta_LectorDocente FOREIGN KEY (num_lector) REFERENCES LectorDocente(num_lector),

	CONSTRAINT FK_Dicta_Materia FOREIGN KEY (id_materia) REFERENCES Materia(id_materia)
);
