CREATE TABLE EjemplarPrestamo (
	idPrestamo INT NOT NULL,
	codISBN CHAR(13) NOT NULL,
	numEjemplar INT NOT NULL, 

	idEstadoDevuelto INT,
	fechaDevuelto DATE,

	CONSTRAINT PK_EjemplarPrestamo PRIMARY KEY (idPrestamo, codISBN, numEjemplar),

	CONSTRAINT FK_EjemplarPrestamo_Prestamo FOREIGN KEY (idPrestamo) REFERENCES Prestamo(idPrestamo),

	CONSTRAINT FK_EjemplarPrestamo_Ejemplar FOREIGN KEY (codISBN, numEjemplar) REFERENCES Ejemplar (codISBN, numEjemplar),
	
	CONSTRAINT FK_EjemplarPrestamo_Estado FOREIGN KEY (idEstadoDevuelto) REFERENCES Estado(idEstado),
);