CREATE TABLE Recomendado (
	num_lector INT NOT NULL,
	id_materia INT NOT NULL,
	id_libro INT NOT NULL,

	CONSTRAINT PK_Recomendado PRIMARY KEY (num_lector, id_materia, id_libro),

	CONSTRAINT FK_Recomendado_Dicta FOREIGN KEY (num_lector, id_materia) REFERENCES Dicta(num_lector, id_materia),

	CONSTRAINT FK_Recomendado_Libro FOREIGN KEY (id_libro) REFERENCES Libro(id_libro)
);
