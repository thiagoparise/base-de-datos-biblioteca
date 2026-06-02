CREATE TABLE Edicion (
	cod_isbn CHAR(13) NOT NULL,

	fecha_publicacion DATE NOT NULL,
	indice INT NOT NULL,

	id_libro INT NOT NULL,
	id_estanteria INT NOT NULL,

	CONSTRAINT PK_Edicion PRIMARY KEY (cod_isbn),

	CONSTRAINT FK_Edicion_Libro FOREIGN KEY (id_libro) REFERENCES Libro(id_libro),

	CONSTRAINT FK_Edicion_Estanteria FOREIGN KEY (id_estanteria) REFERENCES Estanteria(id_estanteria)
);
