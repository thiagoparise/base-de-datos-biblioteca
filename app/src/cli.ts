import { createInterface, type Interface } from 'node:readline/promises'
import { stdin, stdout } from 'node:process'

let consola: Interface | undefined

function getConsola(): Interface {
	if (!consola) {
		consola = createInterface({ input: stdin, output: stdout })
	}
	return consola
}

export async function preguntarTexto(pregunta: string): Promise<string> {
	const respuesta = await getConsola().question(pregunta)
	return respuesta.trim()
}

export async function preguntarTextoOpcional(pregunta: string): Promise<string | null> {
	const respuesta = await preguntarTexto(pregunta)
	return respuesta === '' ? null : respuesta
}

export async function preguntarEntero(pregunta: string): Promise<number> {
	let numero = 0
	let esValida = false
	do {
		const respuesta = await preguntarTexto(pregunta)
		numero = parseInt(respuesta, 10)
		esValida = !Number.isNaN(numero)
		if (!esValida) {
			console.log('✗ No es un número válido. Probá de nuevo.')
		}
	} while (!esValida)
	return numero
}

export async function preguntarOpcion<T extends string>(
	pregunta: string,
	opciones: readonly T[],
): Promise<T> {
	let respuesta = ''
	let esValida = false
	do {
		respuesta = (await preguntarTexto(`${pregunta}: `)).toLowerCase()
		esValida = (opciones as readonly string[]).includes(respuesta)
		if (!esValida) {
			console.log(`✗ Opción inválida. Elegí una de: ${opciones.join(' / ')}`)
		}
	} while (!esValida)
	return respuesta as T
}

export function cerrarCli(): void {
	if (consola) {
		consola.close()
		consola = undefined
	}
}
