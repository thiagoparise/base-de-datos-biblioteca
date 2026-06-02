CREATE TABLE EsBibliografiaDe (
	id_libro INT NOT NULL,
	id_materia INT NOT NULL,

	es_obligatorio BIT NOT NULL,

	CONSTRAINT PK_EsBibliografiaDe PRIMARY KEY (id_libro, id_materia),

	CONSTRAINT FK_EsBibliografiaDe_Libro FOREIGN KEY (id_libro) REFERENCES Libro(id_libro),

	CONSTRAINT FK_EsBibliografiaDe_Materia FOREIGN KEY (id_materia) REFERENCES Materia(id_materia)
);
