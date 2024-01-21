function Chunk {
    <#
        .SYNOPSIS
            Chunk items in a pipeline.
        .EXAMPLE
            $(1,2,3,4,5) | Chunk 2

            Chunk input array into groups of up to 2.
            Output objects contain the grouped items in the Items record.
        .EXAMPLE
            $(1,2,3,4,5) | Chunk 2 -NoTail

            Chunk input array into groups of 2.
            Last element will be skipped because there is not enough data to
            fill the last group.
    #>

    param(
        # Number of items to group together
        [Parameter(Mandatory = $true, ValueFromPipeline = $false)]
        [int]$Count,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $Element,

        [Switch]$NoTail = $false
    )

    Begin {
        $stack = New-Object System.Collections.ArrayList($Count);
    }

    Process  {
        $null = $stack.Add($Element);
        if ($stack.Count -eq $Count) {
            $Result = $stack.Clone();
            $stack.Clear();
            return @{"Items" = $Result};
        }
    }

    End {
        if (!$NoTail) {
            return @{"Items" = $stack};
        }
    }
}
