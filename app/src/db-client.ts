import sql from 'mssql'

const config: sql.config = {
	user: process.env.MSSQL_USER ?? 'sa',
	password: process.env.MSSQL_SA_PASSWORD ?? '',
	server: process.env.MSSQL_SERVER ?? 'localhost',
	port: Number(process.env.MSSQL_PORT ?? 1433),
	database: process.env.MSSQL_DATABASE ?? 'biblioteca',
	options: {
		encrypt: false,
		trustServerCertificate: true,
	},
}

let pool: sql.ConnectionPool | undefined

export async function getPool(): Promise<sql.ConnectionPool> {
	if (!pool) {
		pool = await sql.connect(config)
	}
	return pool
}

export async function closePool(): Promise<void> {
	if (pool) {
		await pool.close()
		pool = undefined
	}
}

type ParamValue = string | number | Date | boolean | null

export async function execProcedure<T = Record<string, unknown>>(
	procedimiento: string,
	params: Record<string, ParamValue> = {},
): Promise<T[]> {
	const req = (await getPool()).request()
	for (const [nombre, valor] of Object.entries(params)) {
		req.input(nombre, valor)
	}
	const resultado = await req.execute(procedimiento)
	return resultado.recordset as T[]
}
