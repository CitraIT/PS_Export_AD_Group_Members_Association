#####################################################################
#
# Citra IT - Consultoria em TI.
# Script para exportar os grupos do AD para formato planilha CSV.
# 30/07/2020 16:26
#
#####################################################################


# 1. Obter o arquivo .txt com a lista dos grupos a serem exportados.
$grupos = Get-Content -Path $PWD\grupos.txt

# 2. Importar o módulo do Active Directory
Import-Module ActiveDirectory

# 3. Verificar se o arquivo de exportação já existe, e criar um novo.
If ( [system.IO.file]::exists("$pwd\exportado.csv") )
{
    [System.IO.File]::Delete("$pwd\exportado.csv")
}

# 4. Escrever a linha de Colunas no arquivo .csv
Add-Content -Path "exportado.csv" -encoding UTF8 -Value "Grupo; Nome de Usuário; Login"


# 5. Obter os usuários integrantes de cada grupo, um a um e ir salvando no arquivo de saída lista_final.csv
$grupos | ForEach-Object{
    $grupo_atual = $_
    Write-Host "Exportando lista de usuários do grupo $grupo_atual"
    
    $integrantes = Get-ADGroupMember -Identity $grupo_atual
    $integrantes | %{ Add-Content -Path "exportado.csv"  -encoding UTF8 -Value "$grupo_atual; $($_.Name);$($_.SamAccountName)" }
}



