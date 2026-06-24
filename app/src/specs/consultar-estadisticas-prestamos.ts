import { execProcedure } from '../db-client'
import {
	mostrarTitulo,
	preguntarEntero,
	preguntarOpcionNumerada,
	renderTabla,
} from '../cli'

export async function ejecutar(): Promise<void> {
	mostrarTitulo('Estadísticas mensuales de préstamos')

	const año = await preguntarEntero('Año: ')
	const mes = await preguntarEntero('Mes (1-12): ')
	const agrupar_por = await preguntarOpcionNumerada('Agrupar por', [
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

	console.log()
	renderTabla(resultado)
}
