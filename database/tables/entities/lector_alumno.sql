CREATE TABLE LectorAlumno (
	num_lector INT NOT NULL,

	libreta NVARCHAR(100) NOT NULL,

	CONSTRAINT PK_LectorAlumno PRIMARY KEY (num_lector),

	CONSTRAINT FK_LectorAlumno_Lector FOREIGN KEY (num_lector) REFERENCES Lector(num_lector)
);
