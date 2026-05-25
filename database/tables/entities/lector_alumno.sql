CREATE TABLE LectorAlumno (
	numLector INT NOT NULL,

	libreta NVARCHAR(100) NOT NULL, -- libreta debería ser una entidad?

	CONSTRAINT PK_LectorAlumno PRIMARY KEY (numLector),

	CONSTRAINT FK_LectorAlumno_Lector FOREIGN KEY (numLector) REFERENCES Lector(numLector)
);