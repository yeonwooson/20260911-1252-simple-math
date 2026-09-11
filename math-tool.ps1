[CmdletBinding()]
param(
    [ValidateRange(0, [int]::MaxValue)]
    [int]$N = 0
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-Fibonacci {
    [CmdletBinding()]
    [OutputType([System.Numerics.BigInteger])]
    param(
        [Parameter(Mandatory)]
        [ValidateRange(0, [int]::MaxValue)]
        [int]$N
    )

    # Use BigInteger accumulators so large N values (e.g. Fibonacci(93)+) don't overflow Int64.
    [System.Numerics.BigInteger]$previous = 0
    [System.Numerics.BigInteger]$current = 1
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
