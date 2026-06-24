import { execProcedure } from '../db-client'
import {
	mostrarTitulo,
	preguntarTextoOpcional,
	renderTabla,
} from '../cli'

export async function ejecutar(): Promise<void> {
	mostrarTitulo('Préstamos vencidos')

	const fecha = await preguntarTextoOpcional(
		'Fecha de revisión (DD-MM-YYYY, vacío = hoy): ',
	)

	const resultado = await execProcedure('sp_prestamos_vencidos_a_fecha', {
		fecha,
	})

	if (resultado.length === 0) {
		throw new Error('Sin préstamos vencidos a esa fecha.')
	}

	// Fix para que se pueda mostrar la tabla entera (siendo que se devuelven muchos datos) Idealmente se hace
	// desde el SP, pero bueno ya tenemos que demostrarlo.
	const filas = resultado.map((r: any) => ({
		nombre: `${r.nombre} ${r.apellido}`,
		email: r.email,
		telefono: r.telefono,
		libro: r.titulo,
		ejemplar: `${r.cod_isbn} #${r.num_ejemplar}`,
		prestado: r.fecha_realizado,
		vencio: r.fecha_limite,
		dias_atraso: r.dias_atraso,
	}))

	console.log()
	renderTabla(filas)
}
