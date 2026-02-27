# =================================================================
# PIPELINE_001 - Esqueleto de Orquestación VM -> Data Lake
# =================================================================

# Configuraciones Globales
$ACCOUNT_NAME = "amppocexpreports"
$CONTAINER = "reporting-poc"
$ID_DIA = "dia_001"
$PIPELINE_NAME = "pipeline_001"
$BASE_REMOTE_PATH = "$ID_DIA/$PIPELINE_NAME"

# Función para subir carpetas (Para no repetir código)
function Upload-To-DataLake($localPath, $stageName) {
    Write-Host "--- Subiendo $stageName al Data Lake... ---" -ForegroundColor Cyan
    az storage blob upload-batch `
        --account-name $ACCOUNT_NAME `
        --destination "$CONTAINER/$BASE_REMOTE_PATH/$stageName" `
        --source $localPath `
        --auth-mode login
}

# -----------------------------------------------------------------
# PASO 1: Proceso Fortran / Externo
# -----------------------------------------------------------------
Write-Host "Iniciando PASO 1..." -ForegroundColor Yellow

# Simulamos ejecución de proceso (Dummy)
# Supongamos que genera archivos en F:\ClientDB\Spring2026
$STAGE1_LOCAL = "C:\pipeline_001\stage_01"
if (!(Test-Path $STAGE1_LOCAL)) { New-Item -ItemType Directory -Path $STAGE1_LOCAL }

Write-Host "Ejecutando proceso Fortran..."
# Aquí iría tu: .\mi_simulador.exe
# Simulamos copia de F: a C:
# Copy-Item "F:\ClientDB\Spring2026\*" $STAGE1_LOCAL -Recurse

# Subida al Data Lake
Upload-To-DataLake $STAGE1_LOCAL "stage_01"


# -----------------------------------------------------------------
# PASO 2: Procesamiento C++ / Rust
# -----------------------------------------------------------------
Write-Host "Iniciando PASO 2..." -ForegroundColor Yellow

$STAGE2_LOCAL = "C:\pipeline_001\stage_02"
if (!(Test-Path $STAGE2_LOCAL)) { New-Item -ItemType Directory -Path $STAGE2_LOCAL }

Write-Host "Ejecutando programas de transformación..."
# Aquí irían tus programas locales
# .\transformador.exe --input $STAGE1_LOCAL --output $STAGE2_LOCAL

# Subida al Data Lake
Upload-To-DataLake $STAGE2_LOCAL "stage_02"


# -----------------------------------------------------------------
# PASO 3, 4 y 5: (Repetir estructura)
# -----------------------------------------------------------------
Write-Host "Iniciando PASOS FINALES (Parquet/Analytics)..." -ForegroundColor Yellow

$STAGE_FINAL_LOCAL = "C:\pipeline_001\stage_parquet"
if (!(Test-Path $STAGE_FINAL_LOCAL)) { New-Item -ItemType Directory -Path $STAGE_FINAL_LOCAL }

# Simulación de proceso final
Write-Host "Generando archivos Parquet..."

# Subida final
Upload-To-DataLake $STAGE_FINAL_LOCAL "stage_parquet"

Write-Host "===============================================" -ForegroundColor Green
Write-Host "PIPELINE FINALIZADO EXITOSAMENTE" -ForegroundColor Green
Write-Host "Ubicación: $CONTAINER/$BASE_REMOTE_PATH" -ForegroundColor Green
Write-Host "===============================================" -ForegroundColor Green

