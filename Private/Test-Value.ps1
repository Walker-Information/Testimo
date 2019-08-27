﻿function Test-Value {
    [CmdletBinding()]
    param(
        [Object] $Object,
        [string] $TestName,
        [string[]] $Property,
        [Object] $ExpectedValue,
        [string[]] $PropertyExtendedValue,
        <#
        [switch] $lt,
        [switch] $gt,
        [switch] $le,
        [switch] $eq,
        [switch] $ge,
        #>
        [string] $OperationType,
        [int] $Level,
        [string] $Domain,
        [Object] $DomainController,
        [int] $ExpectedCount,
        [string] $OperationResult,
        [scriptblock] $WhereObject
    )

    <#
    if (-not $OperationType) {
        if ($lt) {
            $OperationType = 'lt'
        } elseif ($gt) {
            $OperationType = 'gt'
        } elseif ($ge) {
            $OperationType = 'ge'
        } elseif ($le) {
            $OperationType = 'le'
        } else {
            $OperationType = 'eq'
        }
    }
    #>
    if ($Object) {

        if ($ExpectedCount) {
            Test-Me -Object $Object -ExpectedCount $ExpectedCount -OperationType $OperationType -TestName $TestName -Level $Level -Domain $Domain -DomainController $DomainController -Property $Property -ExpectedValue $ExpectedValue -PropertyExtendedValue $PropertyExtendedValue -OperationResult $OperationResult
        } else {
            if ($WhereObject) {
                $Object = $Object | Where-Object $WhereObject
                Test-Me -Object $Object -OperationType $OperationType -TestName $TestName -Level $Level -Domain $Domain -DomainController $DomainController -Property $Property -ExpectedValue $ExpectedValue -PropertyExtendedValue $PropertyExtendedValue -OperationResult $OperationResult
            } else {
                foreach ($_ in $Object) {
                    Test-Me -Object $_ -OperationType $OperationType -TestName $TestName -Level $Level -Domain $Domain -DomainController $DomainController -Property $Property -ExpectedValue $ExpectedValue -PropertyExtendedValue $PropertyExtendedValue -OperationResult $OperationResult
                }
            }
        }
    } else {
        Write-Warning 'Objected not passed to Test-VALUE.'
    }
}