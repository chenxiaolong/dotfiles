@{
    DOTNET_CLI_TELEMETRY_OPTOUT = '1';
    POWERSHELL_TELEMETRY_OPTOUT = '1';
}.GetEnumerator() | ForEach-Object {
    [System.Environment]::SetEnvironmentVariable(
        $_.Name, $_.Value, [System.EnvironmentVariableTarget]::User)
}
