[CmdletBinding()]
param(
    [ValidateRange(0, [int]::MaxValue)]
    [int]$N = 0
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-Fibonacci {
    [CmdletBinding()]
    [OutputType([long])]
    param(
        [Parameter(Mandatory)]
        [ValidateRange(0, [int]::MaxValue)]
        [int]$N
    )

    [long]$previous = 0
    [long]$current = 1
    for ($i = 0; $i -lt $N; $i++) {
        $next = $previous + $current
        $previous = $current
        $current = $next
    }

    return $previous
}

# Only run the CLI entry point on direct execution, not when dot-sourced.
if ($MyInvocation.InvocationName -ne '.') {
    "Fibonacci($N) = $(Get-Fibonacci -N $N)"
}
