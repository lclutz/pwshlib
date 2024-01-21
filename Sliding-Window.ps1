function Sliding-Window {
    <#
        .SYNOPSIS
            Slide a window over items in a pipeline.
        .EXAMPLE
            $(1,2,3,4) | Sliding-Window 2

            Slide a window of width 2 over the input array.
            Output objects contain the grouped items in the Items record.
    #>

    param(
        # Number of items to group together
        [Parameter(Mandatory = $true, ValueFromPipeline = $false)]
        [int]$Count,

        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $Element
    )

    Begin {
        $q = New-Object System.Collections.Queue($Count);
    }

    Process  {
        $q.Enqueue($Element);
        if ($q.Count -eq $Count) {
            $Result = $q.ToArray();
            $null = $q.Dequeue();
            return @{"Items" = $Result};
        }
    }

    End {
    }
}
