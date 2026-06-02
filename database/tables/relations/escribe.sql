CREATE TABLE Escribe (
	id_autor INT NOT NULL,
	id_libro INT NOT NULL,

	CONSTRAINT PK_Escribe PRIMARY KEY (id_autor, id_libro),

	CONSTRAINT FK_Escribe_Autor FOREIGN KEY (id_autor) REFERENCES Autor(id_autor),

	CONSTRAINT FK_Escribe_Libro FOREIGN KEY (id_libro) REFERENCES Libro(id_libro)
);
