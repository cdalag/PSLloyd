function Test-CoreFunctions {
  [CmdletBinding()]
  param(
    [parameter(ValueFromPipeline)]${fill}
  )

  begin {
    [Collections.ArrayList]$inputObjects = @()
  }
  process {
    [void]$inputObjects.Add(${fill})
  }
  end {
    $inputObjects | ForEach-Object -Parallel {

    }
  }
}