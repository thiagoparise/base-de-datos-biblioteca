import { execProcedure } from '../db-client'
import {
	mostrarTitulo,
	preguntarEntero,
	preguntarOpcionNumerada,
	renderTabla,
} from '../cli'

export async function ejecutar(): Promise<void> {
	mostrarTitulo('Estado actual de ejemplares')

	const tipo_filtro = await preguntarOpcionNumerada('Tipo de filtro', [
		'libro',
		'autor',
		'tema',
		'profesor',
	] as const)
	const id_filtro = await preguntarEntero(
		`ID del ${tipo_filtro}: `,
	)

	const resultado = await execProcedure('sp_estado_ejemplares', {
		tipo_filtro,
		id_filtro,
	})

	if (resultado.length === 0) {
		throw new Error('No se encontraron ejemplares.')
	}

	console.log()
	renderTabla(resultado)
}
