import sql from 'mssql'
import { execProcedure, getPool } from '../db-client'
import {
	mostrarTitulo,
	preguntarEntero,
	preguntarOpcionNumerada,
	preguntarTexto,
	renderTabla,
} from '../cli'

async function ejecutarExistente(): Promise<void> {
	const id_libro_nuevo = await preguntarEntero('ID del libro (Libro.id_libro): ')
	const resultado = await execProcedure('sp_notificar_nuevo_libro', {
		id_libro_nuevo,
	})
	if (resultado.length === 0) {
		throw new Error('Ningún lector a notificar.')
	}
	console.log()
	renderTabla(resultado)
}

async function ejecutarSimular(): Promise<void> {
	const titulo = await preguntarTexto('Título del libro nuevo: ')
	const id_editorial = await preguntarEntero('ID Editorial (1-4): ')
	const id_idioma = await preguntarEntero(
		'ID Idioma (1=Español, 2=Inglés, 3=Portugués): ',
	)
	const autoresTexto = await preguntarTexto('IDs de autores (separados por coma): ')
	const idAutores = autoresTexto
		.split(',')
		.map((s) => parseInt(s.trim(), 10))
		.filter((n) => !Number.isNaN(n))

	if (idAutores.length === 0) {
		throw new Error('No se proporcionaron autores válidos.')
	}

	const pool = await getPool()
	const transaccion = new sql.Transaction(pool)

	try {
		await transaccion.begin()

		const libroResultado = await new sql.Request(transaccion)
			.input('titulo', titulo)
			.input('id_editorial', id_editorial)
			.input('id_idioma', id_idioma).query(`
				INSERT INTO Libro (titulo, id_editorial, id_idioma)
				OUTPUT INSERTED.id_libro
				VALUES (@titulo, @id_editorial, @id_idioma)
			`)

		const id_libro_nuevo = libroResultado.recordset[0].id_libro as number

		for (const id_autor of idAutores) {
			await new sql.Request(transaccion)
				.input('id_autor', id_autor)
				.input('id_libro', id_libro_nuevo)
				.query(
					'INSERT INTO Escribe (id_autor, id_libro) VALUES (@id_autor, @id_libro)',
				)
		}

		const resultado = await new sql.Request(transaccion)
			.input('id_libro_nuevo', id_libro_nuevo)
			.execute('sp_notificar_nuevo_libro')

		console.log(`(Libro simulado con id_libro = ${id_libro_nuevo})`)

		if (resultado.recordset.length === 0) {
			throw new Error('Ningún lector a notificar.')
		}

		console.log()
		renderTabla(resultado.recordset)
	} finally {
		await transaccion.rollback()
		console.log('↩ Rollback aplicado: la BD no quedó modificada.')
	}
}

export async function ejecutar(): Promise<void> {
	mostrarTitulo('Notificar lectores sobre nuevo libro')

	const modo = await preguntarOpcionNumerada('Modo', [
		'existente',
		'simular',
	] as const)

	switch (modo) {
		case 'existente':
			await ejecutarExistente()
			break
		case 'simular':
			await ejecutarSimular()
			break
	}
}
