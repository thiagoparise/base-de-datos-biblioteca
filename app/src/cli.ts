import { createInterface, type Interface } from 'node:readline/promises'
import { stdin, stdout } from 'node:process'

const ANSI = {
	reset: '\x1b[0m',
	bold: '\x1b[1m',
	dim: '\x1b[2m',
	cyan: '\x1b[36m',
	green: '\x1b[32m',
	brightCyan: '\x1b[96m',
} as const

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

export async function preguntarOpcionNumerada<T extends string>(
	pregunta: string,
	opciones: readonly T[],
): Promise<T> {
	console.log(`${pregunta}:`)
	opciones.forEach((op, i) =>
		console.log(
			`  ${ANSI.cyan}${i + 1})${ANSI.reset} ${op}`,
		),
	)
	let idx = 0
	let esValida = false
	do {
		idx = await preguntarEntero(`Elegí (1-${opciones.length}): `)
		esValida = idx >= 1 && idx <= opciones.length
		if (!esValida) {
			console.log(
				`✗ Opción fuera de rango. Elegí entre 1 y ${opciones.length}.`,
			)
		}
	} while (!esValida)
	return opciones[idx - 1]
}

export function mostrarTitulo(titulo: string): void {
	console.log(
		`\n${ANSI.brightCyan}${ANSI.bold}=== ${titulo} ===${ANSI.reset}\n`,
	)
}

// Esta función es sólo para mostrar presentable la tabla
export function renderTabla(filas: Record<string, any>[]): void {
	if (filas.length === 0) return
	const columnas = Object.keys(filas[0])
	const anchos = columnas.map((col) =>
		Math.max(col.length, ...filas.map((f) => String(f[col] ?? '').length)),
	)
	const separadorColumna = `${ANSI.dim}${ANSI.cyan} │ ${ANSI.reset}`
	const pintar = (vals: string[], color: string) =>
		vals
			.map((v, i) => `${color}${v.padEnd(anchos[i])}${ANSI.reset}`)
			.join(separadorColumna)
	const separadorFila = anchos
		.map((a) => `${ANSI.dim}${ANSI.cyan}${'─'.repeat(a)}${ANSI.reset}`)
		.join(`${ANSI.dim}${ANSI.cyan}─┼─${ANSI.reset}`)

	console.log(pintar(columnas, `${ANSI.bold}${ANSI.cyan}`))
	console.log(separadorFila)
	filas.forEach((f) =>
		console.log(
			pintar(
				columnas.map((c) => String(f[c] ?? '')),
				ANSI.green,
			),
		),
	)
}

export function cerrarCli(): void {
	if (consola) {
		consola.close()
		consola = undefined
	}
}
