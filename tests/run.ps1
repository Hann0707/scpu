param(
    [string]$Gcc = 'gcc',
    [string]$Iverilog = 'iverilog',
    [string]$Vvp = 'vvp'
)
$ErrorActionPreference = 'Stop'
Push-Location (Split-Path $PSScriptRoot -Parent)
try {
    & $Gcc -std=c2x -Wall -Wextra tests/ref_trace.c -o tests/ref_trace.exe
    if ($LASTEXITCODE -ne 0) { throw 'Reference compilation failed' }
    $trace = & ./tests/ref_trace.exe
    if ($LASTEXITCODE -ne 0) { throw 'Reference execution failed' }
    $trace | Set-Content tests/expected.hex -Encoding ascii
    & $Iverilog -g2012 -Wall -s tb_difftest -o tests/sim.vvp scpu.v pc.v scpu_rom.v decoder.v scpu_regfile.v execute.v seg7_decoder.v tests/tb_difftest.v
    if ($LASTEXITCODE -ne 0) { throw 'RTL compilation failed' }
    Push-Location tests
    try {
        & $Vvp sim.vvp
        if ($LASTEXITCODE -ne 0) { throw 'Differential comparison failed' }
    } finally { Pop-Location }
} finally { Pop-Location }
