CREATE TABLE SeDescribePor (
	cod_isbn CHAR(13) NOT NULL,

	id_palabra_clave INT NOT NULL,

	CONSTRAINT PK_SeDescribePor PRIMARY KEY (cod_isbn, id_palabra_clave),

	CONSTRAINT FK_SeDescribePor_Edicion FOREIGN KEY (cod_isbn) REFERENCES Edicion(cod_isbn),

	CONSTRAINT FK_SeDescribePor_PalabraClave FOREIGN KEY (id_palabra_clave) REFERENCES PalabraClave(id_palabra_clave)
);
