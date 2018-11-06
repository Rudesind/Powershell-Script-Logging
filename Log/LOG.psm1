<#
    Module : LOG.psm1
    Updated: 11/06/2018
    Author : Zach Nybo <zach.nybo@gmail.com>
    Version: 1.0

    Summary:
    This module is used to handle all functions related to logging scripting
    actions. See the documentation for additional details.

    Disclosure:
    The idea for the below function was taken from the following article:
    https://stackoverflow.com/questions/7834656/create-log-file-in-powershell
#>

Function Initialize-Log {
    <#
    .Synopsis
        This function initializes a log file. Note, the file is not created.
    .Description
        This function is part of the LOG module. This module is used to to initialize and write to a specified log file. All log files are created in .log format.

    .Notes
        Module : LOG.psm1
        Updated: 11/06/2018
        Author : Zach Nybo <zach.nybo@gmail.com>
        Version: 1.0

        Disclosure:
        The idea for the below function was taken from the following article:
        https://stackoverflow.com/questions/7834656/create-log-file-in-powershell

    .Inputs
        System.String

    .Outputs
        System.Int32

    .Parameter Path
        The directory where the log file will be created.

    .Parameter Name
        The name of the log file to create.

    .Example
        Initialize-Log "C:\" "TestLog"

    #>

    # Allows the script to operate like a compiled cmdlet
    #
    [CmdletBinding()]

    # The inner comments of the Param block will be displayed with: Get-Help ... -Detailed if no Parameter section is defined
    #
    Param(

        # Cannot be $null or ""
        # Path to the file must exist
        # Parameter is mandatory and allows piped data
        #
        [ValidateNotNullOrEmpty()]
        [ValidateScript({(Test-Path $_)})]
        [Parameter(ValueFromPipeline=$True, Mandatory=$True)]
        [string] $Path,

        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory=$True)]
        [string] $Name
    )

    # Error Codes
    #
    New-Variable LOG_INITIALIZE_FAILED -option Constant -value 4000

    # Initialize the function
    #
    Begin {

        try {

            # Time stamp is in ISO 8601 standard
            #
            [string] $timeStamp = Get-Date -format "yyyyMMddTHHmmss"

            # Friendly error message for the function
            #
            [string] $errorMsg = [string]::Empty

        } catch {
            throw "Error initializing function"
            return -1
        }

    }

    # Create and initialize log file
    #
    Process {

        try {

            # Create the script variable for the log file
            #
            $script:Log = $Path + "\" + $Name + "_" + $timeStamp + ".log"

        } catch {
            $errorMsg = "Error initializing file: " + $Error[0]
            throw
            return $LOG_INITIALIZE_FAILED
        }
    }

    # Exit the function
    #
    End {
        return 0
    }
}

Function Write-Log {
    <#
    .Synopsis
        This function writes to a defined file with a specific format.
    .Description
        This function is part of the LOG module. This module is used to to initialize and write to a specified log file.

    .Notes
        Module : LOG.psm1
        Updated: 10/22/2018
        Author : Configuration Management
        Version: 1.0
        Documentation: LOG.md

        Disclosure:
        The idea for the below function was taken from the following article:
        https://stackoverflow.com/questions/7834656/create-log-file-in-powershell

    .Inputs
        System.String

    .Outputs
        System.Int32

    .Parameter File
        The log message to write

    .Example
        Write-Log "Beginning the process..."

    #>

    # Allows the script to operate like a compiled cmdlet
    #
    [CmdletBinding()]

    # The inner comments of the Param block will be displayed with: Get-Help ... -Detailed if no Parameter section is defined
    #
    Param(

        # Cannot be $null or ""
        #
        [ValidateNotNullOrEmpty()]

        # Parameter is mandatory and allows piped data
        #
        [Parameter(ValueFromPipeline=$True, Mandatory=$True)]

        [string] $LogMessage
    )

    # Error Codes
    #
    New-Variable LOG_WRITE_FAILED -option Constant -value 4000

    # Initialize the function
    #
    Begin {

        try {


            # The log time variable
            #
            [string] $timeStamp = Get-Date -Format g

            # Friendly error message for the function
            #
            [string] $errorMsg = [string]::Empty

        } catch {
            throw "Error initializing function"
            return -1
        }

    }

    # Begin writing to log file
    #
    Process {

        try {

            # Write the log message to the log file
            #
            Add-Content $script:Log -value "[$timeStamp]`t$LogMessage" -ErrorAction Stop

        } catch {
            $errorMsg = "Error writing to log: " + $Error[0]
            throw
            return $LOG_WRITE_FAILED
        }
    }

    # Exit the function
    #
    End {
       return 0
    }
}
