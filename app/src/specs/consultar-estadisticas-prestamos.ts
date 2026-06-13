import { execProcedure } from '../db-client'
import { preguntarOpcion, preguntarEntero } from '../cli'

export async function ejecutar(): Promise<void> {
	const año = await preguntarEntero('Año: ')
	const mes = await preguntarEntero('Mes (1-12): ')
	const agrupar_por = await preguntarOpcion('Agrupar por', [
		'titulo',
		'editorial',
		'autor',
		'tema',
	] as const)

	const resultado = await execProcedure('sp_estadisticas_prestamos_mes', {
		año,
		mes,
		agrupar_por,
	})

	if (resultado.length === 0) {
		throw new Error('Sin datos para ese mes.')
	}

	console.table(resultado)
}
