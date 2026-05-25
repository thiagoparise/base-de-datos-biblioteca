CREATE TABLE Estanteria (
	idEstanteria INT IDENTITY(1,1) NOT NULL,

	zona NVARCHAR(20) NOT NULL,

	CONSTRAINT PK_Estanteria PRIMARY KEY (idEstanteria)
)