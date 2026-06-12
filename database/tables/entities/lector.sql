CREATE TABLE Lector (
	num_lector INT IDENTITY(1,1) NOT NULL,

	nombre NVARCHAR(100) NOT NULL,
	apellido NVARCHAR(100) NOT NULL,
	cuil NCHAR(11) UNIQUE NOT NULL,
	telefono VARCHAR(15) NOT NULL,
	email VARCHAR(254) NOT NULL,   -- RFC 5321: 254 chars max

	CONSTRAINT PK_Lector PRIMARY KEY (num_lector),
	CONSTRAINT CK_Lector_email_formato CHECK (email LIKE '%_@_%._%')   -- validación mínima de formato
);
