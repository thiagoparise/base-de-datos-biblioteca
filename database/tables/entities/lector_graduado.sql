CREATE TABLE LectorGraduado (
	num_lector INT NOT NULL,

	fecha_egreso DATE NOT NULL,

	CONSTRAINT PK_LectorGraduado PRIMARY KEY (num_lector),

	CONSTRAINT FK_LectorGraduado_Lector FOREIGN KEY (num_lector) REFERENCES Lector(num_lector)
);
