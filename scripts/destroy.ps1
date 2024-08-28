# Define colors for output
$Blue = [System.ConsoleColor]::Blue
$Yellow = [System.ConsoleColor]::Yellow
$Green = [System.ConsoleColor]::Green
$Default = [System.ConsoleColor]::Gray
$Cyan = [System.ConsoleColor]::Cyan
$Magenta = [System.ConsoleColor]::Magenta

function Write-Colored {
    param (
        [string]$Text,
        [System.ConsoleColor]$Color
    )
    $originalColor = [System.Console]::ForegroundColor
    [System.Console]::ForegroundColor = $Color
    Write-Output $Text
    [System.Console]::ForegroundColor = $originalColor
}

Write-Output ""
Write-Colored "--------------------------------------" $Default
Write-Output ""
Write-Colored "Starting Docker operations..." $Blue
Write-Output ""
Write-Colored "--------------------------------------" $Default

Write-Output ""
Write-Colored "Stopping and cleaning any existing containers..." $Yellow
cd docker
docker-compose down --rmi all --volumes
docker system prune -a --volumes --force
docker volume prune --force
docker builder prune --all --force
docker network prune --force
cd ..

# Print completion message
Write-Output ""
Write-Colored "Docker volumes, images, caches, and networks removed.." $Green
Write-Output ""
