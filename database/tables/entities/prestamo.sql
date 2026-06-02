CREATE TABLE Prestamo (
	id_prestamo INT IDENTITY(1,1) NOT NULL,

	num_lector INT NOT NULL,

	fecha_realizado DATE NOT NULL,

	CONSTRAINT PK_Prestamo PRIMARY KEY (id_prestamo),
	CONSTRAINT FK_Prestamo_Lector FOREIGN KEY (num_lector) REFERENCES Lector(num_lector)
);
