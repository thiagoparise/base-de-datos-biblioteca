# =========================================
# Setup completo: Docker + Base de datos
# =========================================
# Uso: .\setup_database.ps1 [-SkipDocker] [-WithSeed]
#   -SkipDocker  Omite el docker compose up (util si el contenedor ya esta corriendo)
#   -WithSeed    Ejecuta el seed de datos iniciales
# =========================================

param(
    [switch]$SkipDocker,
    [switch]$WithSeed
)

# Detener en cualquier error
$ErrorActionPreference = "Stop"

# Fijar CWD a la carpeta donde esta este script
Set-Location $PSScriptRoot


# =========================================
# LEER .ENV
# =========================================

$envFile = ".env"

if (-not (Test-Path $envFile)) {
    Write-Error "No se encontro el archivo .env en $PSScriptRoot"
    exit 1
}

$config = @{}
Get-Content $envFile | ForEach-Object {
    if ($_ -match "^\s*#" -or $_ -notmatch "=") { return }  # ignorar comentarios y lineas vacias
    $key, $value = $_ -split "=", 2
    $config[$key.Trim()] = $value.Trim()
}

$password = $config["MSSQL_SA_PASSWORD"]
$port     = $config["MSSQL_PORT"]

if (-not $password -or -not $port) {
    Write-Error "Faltan MSSQL_SA_PASSWORD o MSSQL_PORT en el archivo .env"
    exit 1
}


# =========================================
# DOCKER
# =========================================

if (-not $SkipDocker) {
    Write-Host ""
    Write-Host "========================================="
    Write-Host " LEVANTANDO SQL SERVER EN DOCKER"
    Write-Host "========================================="

    docker compose up -d
    if ($LASTEXITCODE -ne 0) {
        Write-Error "docker compose up fallo con codigo $LASTEXITCODE"
        exit $LASTEXITCODE
    }

    Write-Host ""
    Write-Host "Esperando a que SQL Server inicie..."
    Start-Sleep -Seconds 15
} else {
    Write-Host ""
    Write-Host "[SkipDocker] Omitiendo docker compose up..."
}


# Helper: ejecuta sqlcmd y detiene el script si falla
function Invoke-Sqlcmd-File {
    param(
        [string]$Description,
        [string]$File,
        [string]$Database = $null
    )

    Write-Host ""
    Write-Host "========================================="
    Write-Host " $Description"
    Write-Host "========================================="

    $args = @(
        "-S", "localhost,$port",
        "-U", "sa",
        "-P", $password,
        "-b",           # retorna exit code en caso de error
        "-i", (Resolve-Path $File).Path
    )

    if ($Database) {
        $args += @("-d", $Database)
    }

    # Fijar el CWD al directorio del .sql para que los :r resuelvan correctamente
    $sqlDir = Split-Path -Parent (Resolve-Path $File).Path
    Push-Location $sqlDir
    try {
        sqlcmd @args
    } finally {
        Pop-Location
    }

    if ($LASTEXITCODE -ne 0) {
        Write-Error "$Description fallo con codigo $LASTEXITCODE"
        exit $LASTEXITCODE
    }
}


# =========================================
# INIT + REBUILD
# =========================================

Invoke-Sqlcmd-File `
    -Description "CREANDO BASE DE DATOS" `
    -File "database/scripts/init_database.sql"

Invoke-Sqlcmd-File `
    -Description "CREANDO TABLAS Y CONSTRAINTS" `
    -File "database/scripts/rebuild_database.sql" `
    -Database "biblioteca"


# =========================================
# SEED (opcional)
# =========================================

if ($WithSeed) {
    Invoke-Sqlcmd-File `
        -Description "INSERTANDO DATOS INICIALES" `
        -File "database/scripts/seed_database.sql" `
        -Database "biblioteca"
}


# =========================================
# FINALIZADO
# =========================================

Write-Host ""
Write-Host "========================================="
Write-Host " SETUP FINALIZADO CORRECTAMENTE"
Write-Host "========================================="
Write-Host ""