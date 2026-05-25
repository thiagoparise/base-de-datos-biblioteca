CREATE TABLE Edicion (
	codISBN CHAR(13) NOT NULL,

	fechaPublicacion DATE NOT NULL,
	indice INT NOT NULL, -- Indice debería ser entero o texto?
	
	idLibro INT NOT NULL,
	idEstanteria INT NOT NULL,

	CONSTRAINT PK_Edicion PRIMARY KEY (codISBN),
	
	CONSTRAINT FK_Edicion_Libro FOREIGN KEY (idLibro) REFERENCES Libro(idLibro),

	CONSTRAINT FK_Edicion_Estanteria FOREIGN KEY (idEstanteria) REFERENCES Estanteria(idEstanteria)
);