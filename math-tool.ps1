[CmdletBinding()]
param(
    [ValidateRange(0, [int]::MaxValue)]
    [int]$N = 0,

    [ValidateSet('fibonacci', 'factorial')]
    [string]$Operation = 'fibonacci'
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

function Get-Factorial {
    [CmdletBinding()]
    [OutputType([System.Numerics.BigInteger])]
    param(
        [Parameter(Mandatory)]
        [ValidateRange(0, [int]::MaxValue)]
        [int]$N
    )

    # Use BigInteger accumulator so large N values don't overflow Int64.
    [System.Numerics.BigInteger]$result = 1
    for ($i = 2; $i -le $N; $i++) {
        $result *= $i
    }

    return $result
}

# Only run the CLI entry point on direct execution, not when dot-sourced.
if ($MyInvocation.InvocationName -ne '.') {
    switch ($Operation) {
        'fibonacci' { "Fibonacci($N) = $(Get-Fibonacci -N $N)" }
        'factorial' { "Factorial($N) = $(Get-Factorial -N $N)" }
        default { throw "Unsupported operation: $Operation" }
    }
}
