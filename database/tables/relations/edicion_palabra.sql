CREATE TABLE EdicionPalabra (
	codISBN CHAR(13) NOT NULL,

	idPalabraClave INT NOT NULL,

	CONSTRAINT PK_EdicionPalabra PRIMARY KEY (codISBN, idPalabraClave),

	CONSTRAINT FK_EdicionPalabra_Edicion FOREIGN KEY (codISBN) REFERENCES Edicion(codISBN),

	CONSTRAINT FK_EdicionPalabra_PalabraClave FOREIGN KEY (idPalabraClave) REFERENCES PalabraClave(idPalabraClave)
);