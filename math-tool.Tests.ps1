Set-StrictMode -Version Latest

BeforeAll {
    $script:ScriptPath = Join-Path $PSScriptRoot 'math-tool.ps1'
    . $script:ScriptPath
}

Describe 'Get-Fibonacci' {
    It 'returns <expected> for N=<n>' -TestCases @(
        @{ n = 0; expected = 0 }
        @{ n = 1; expected = 1 }
        @{ n = 10; expected = 55 }
    ) {
        Get-Fibonacci -N $n | Should -Be $expected
    }

    It 'does not overflow Int64 for large N (e.g. N=93)' {
        $expected = [System.Numerics.BigInteger]::Parse('12200160415121876738')
        Get-Fibonacci -N 93 | Should -Be $expected
    }
}

Describe 'math-tool.ps1 CLI' {
    It 'prints exactly one line "Fibonacci(<n>) = <expected>" for N=<n>' -TestCases @(
        @{ n = 0; expected = 0 }
        @{ n = 1; expected = 1 }
        @{ n = 10; expected = 55 }
    ) {
        $output = @(& pwsh -NoLogo -NoProfile -File $script:ScriptPath -N $n)
        $LASTEXITCODE | Should -Be 0
        $output.Count | Should -Be 1
        $output[0] | Should -BeExactly "Fibonacci($n) = $expected"
    }
}
