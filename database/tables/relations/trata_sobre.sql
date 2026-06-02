CREATE TABLE TrataSobre (
	cod_isbn CHAR(13) NOT NULL,
	id_tema INT NOT NULL,

	CONSTRAINT PK_TrataSobre PRIMARY KEY (cod_isbn, id_tema),

	CONSTRAINT FK_TrataSobre_Edicion FOREIGN KEY (cod_isbn) REFERENCES Edicion(cod_isbn),

	CONSTRAINT FK_TrataSobre_Tema FOREIGN KEY (id_tema) REFERENCES Tema(id_tema)
);
