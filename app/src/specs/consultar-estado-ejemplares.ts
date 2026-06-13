import { execProcedure } from '../db-client'
import { preguntarOpcion, preguntarEntero } from '../cli'

export async function ejecutar(): Promise<void> {
	const tipo_filtro = await preguntarOpcion('Tipo de filtro', [
		'libro',
		'autor',
		'tema',
		'profesor',
	] as const)
	const id_filtro = await preguntarEntero('ID del filtro: ')

	const resultado = await execProcedure('sp_estado_ejemplares', {
		tipo_filtro,
		id_filtro,
	})

	if (resultado.length === 0) {
		throw new Error('No se encontraron ejemplares.')
	}

	console.table(resultado)
}
