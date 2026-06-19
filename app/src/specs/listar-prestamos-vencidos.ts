import { execProcedure } from '../db-client'
import { preguntarTextoOpcional } from '../cli'

export async function ejecutar(): Promise<void> {
	const fecha = await preguntarTextoOpcional(
		'Fecha de revisión (DD-MM-YYYY, vacío = hoy): ',
	)

	const resultado = await execProcedure('sp_prestamos_vencidos_a_fecha', {
		fecha,
	})

	if (resultado.length === 0) {
		throw new Error('Sin préstamos vencidos a esa fecha.')
	}

	console.table(resultado)
}
