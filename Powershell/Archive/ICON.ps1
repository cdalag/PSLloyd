Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Shell32_Extract {
    [DllImport("Shell32.dll", EntryPoint = "ExtractIconExW", CharSet = CharSet.Unicode)]
    public static extern int ExtractIconEx(string lpszFile, int iconIndex, out IntPtr phiconLarge, out IntPtr phiconSmall, int nIcons);
}
"@

$FilePath = Read-Host -Prompt "File Path"  # Change this to your target DLL/EXE/Etc
$iconIndex = 0  # Change this to the desired icon index
[System.IntPtr]$phiconLarge = [System.IntPtr]::Zero
[System.IntPtr]$phiconSmall = [System.IntPtr]::Zero

# Extract the icon
while([Shell32_Extract]::ExtractIconEx($FilePath.Trim('"'), $iconIndex, [ref]$phiconLarge, [ref]$phiconSmall, 1)){
    # Convert the extracted icon to a usable format
    $iconLarge = [System.Drawing.Icon]::FromHandle($phiconLarge)
    $iconLarge.ToBitmap().Save("C:\Users\CDalag\Desktop\NewIcons\Icon$($iconIndex).ico", [System.Drawing.Imaging.ImageFormat]::Png)
    ++$iconIndex
}
# Clean up
[System.Runtime.InteropServices.Marshal]::FreeHGlobal($phiconLarge)