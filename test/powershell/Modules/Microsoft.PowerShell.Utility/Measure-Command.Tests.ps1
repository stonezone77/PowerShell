# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.
Describe "Measure-Command" -Tags "CI" {

    Context "Validate return types for Measure-Command" {

        It "Should return TimeSpan as the return type" {
            Measure-Command { Get-Date } | Should -BeOfType timespan
        }
    }

    Context "Validate that it is executing commands correctly" {

        It "Should return TimeSpan after executing a script" {
            Measure-Command { echo hi } | Should -BeOfType timespan
        }

        It "Should return TimeSpan after executing a cmdlet" {
            $pesterscript = Join-Path -Path (Join-Path -Path $PSScriptRoot -ChildPath assets) -ChildPath echoscript.ps1
            $testfile = $pesterscript
            $testcommand = "echo pestertestscript"
            $testcommand | Add-Content -Path $testfile

            Measure-Command { $pesterscript } | Should -BeOfType timespan
            Remove-Item $testfile
        }
    }
}
