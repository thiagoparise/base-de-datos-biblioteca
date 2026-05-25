CREATE TABLE AutorLibro (
	idAutor INT NOT NULL,
	idLibro INT NOT NULL,

	CONSTRAINT PK_Autor_Libro PRIMARY KEY (idAutor, idLibro),
	
	CONSTRAINT FK_AutorLibro_Autor FOREIGN KEY (idAutor) REFERENCES Autor(idAutor),
	
	CONSTRAINT FK_AutorLibro_Libro FOREIGN KEY (idLibro) REFERENCES Libro(idLibro)
);