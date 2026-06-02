CREATE TABLE LectorDocente (
	num_lector INT NOT NULL,

	CONSTRAINT PK_LectorDocente PRIMARY KEY (num_lector),

	CONSTRAINT FK_LectorDocente_Lector FOREIGN KEY (num_lector) REFERENCES Lector(num_lector)
);
