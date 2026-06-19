import { preguntarOpcion, cerrarCli } from './cli'
import { closePool } from './db-client'
import * as listarPrestamosVencidos from './specs/listar-prestamos-vencidos'
import * as consultarEstadoEjemplares from './specs/consultar-estado-ejemplares'
import * as consultarEstadisticasPrestamos from './specs/consultar-estadisticas-prestamos'
import * as notificarLectoresNuevoLibro from './specs/notificar-lectores-nuevo-libro'

const Opcion = {
	Salir: '0',
	ListarPrestamosVencidos: '1',
	ConsultarEstadoEjemplares: '2',
	ConsultarEstadisticasPrestamos: '3',
	NotificarLectoresNuevoLibro: '4',
} as const

type Opcion = (typeof Opcion)[keyof typeof Opcion]

async function menu(): Promise<void> {
	console.log('\n=== Biblioteca CLI ===')
	console.log('  1) Listar préstamos vencidos')
	console.log('  2) Consultar estado actual de ejemplares')
	console.log('  3) Consultar estadísticas mensuales')
	console.log('  4) Notificar lectores sobre nuevo libro')
	console.log('  0) Salir')

	let salir = false
	do {
		const opcion = await preguntarOpcion(
			'\nSelecciona una opción',
			Object.values(Opcion),
		)

		try {
			switch (opcion) {
				case Opcion.Salir:
					salir = true
					break
				case Opcion.ListarPrestamosVencidos:
					await listarPrestamosVencidos.ejecutar()
					break
				case Opcion.ConsultarEstadoEjemplares:
					await consultarEstadoEjemplares.ejecutar()
					break
				case Opcion.ConsultarEstadisticasPrestamos:
					await consultarEstadisticasPrestamos.ejecutar()
					break
				case Opcion.NotificarLectoresNuevoLibro:
					await notificarLectoresNuevoLibro.ejecutar()
					break
				default:
					throw new Error(`Opción desconocida: ${opcion}`)
			}
		} catch (err) {
			const error = err as Error
			console.error(`✗ Error: ${error.message}`)
		}
	} while (!salir)

	console.log('Hasta luego.')
}

async function cerrarTodo(): Promise<void> {
	await closePool()
	cerrarCli()
}

process.on('SIGINT', async () => {
	console.log('\n\n(Cerrando conexiones...)')
	await cerrarTodo()
	process.exit(0)
})

try {
	await menu()
} catch (err) {
	const error = err as Error
	console.error(`✗ Error fatal: ${error.message}`)
	process.exitCode = 1
} finally {
	await cerrarTodo()
}
