CREATE TABLE SeIncluyeEn (
	id_prestamo INT NOT NULL,
	cod_isbn CHAR(13) NOT NULL,
	num_ejemplar INT NOT NULL,

	id_estado_devuelto INT,
	fecha_devuelto DATE,

	CONSTRAINT PK_SeIncluyeEn PRIMARY KEY (id_prestamo, num_ejemplar, cod_isbn),

	CONSTRAINT FK_SeIncluyeEn_Prestamo FOREIGN KEY (id_prestamo) REFERENCES Prestamo(id_prestamo),

	CONSTRAINT FK_SeIncluyeEn_Ejemplar FOREIGN KEY (num_ejemplar, cod_isbn) REFERENCES Ejemplar(num_ejemplar, cod_isbn),

	CONSTRAINT FK_SeIncluyeEn_Estado FOREIGN KEY (id_estado_devuelto) REFERENCES Estado(id_estado)
);
