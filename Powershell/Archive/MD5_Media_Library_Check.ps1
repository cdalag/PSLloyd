$Main_Directory = Read-Host -Prompt "Enter original directory"
$Media = Get-ChildItem -Path $Main_Directory -Recurse -Exclude "*.csv"
$Media_Directories = Get-ChildItem -Path $Main_Directory -Recurse -Directory
Add-Member -InputObject $Main_Directory
$Backup_Directory = $null


function Parsing_Hash{
    foreach ($Files in $Media){
        $Hashed = Get-FileHash $Files -Algorithm MD5 -ErrorAction SilentlyContinue
        
        if ($Hashed){
            $Hashed | Add-Member -MemberType NoteProperty -Name Name -Value $Files.Name
            Write-Output $Hashed | Format-List -Property Name, Hash | Out-File -FilePath "$Main_Directory/MD5.csv" -Append
        }else{Write-output "False"}
        
    }
}

function MD5_Make_File{
    New-Item -path "$Main_Directory/MD5.csv" -ErrorAction SilentlyContinue
    if (New-Item -neq $false){

    }
}


$Media_Directories | Format-List
$Main_Directory
Parsing_Hash

Set-Location $home
#get-module -list | format-list name | foreach {update-module -confirm -verbose}

# function selection_box_example{
#     Add-Type -AssemblyName System.Windows.Forms
#     Add-Type -AssemblyName System.Drawing

#     $form = New-Object System.Windows.Forms.Form
#     $form.Text = 'Select a Computer'
#     $form.Size = New-Object System.Drawing.Size(300,200)
#     $form.StartPosition = 'CenterScreen'

#     $okButton = New-Object System.Windows.Forms.Button
#     $okButton.Location = New-Object System.Drawing.Point(75,120)
#     $okButton.Size = New-Object System.Drawing.Size(75,23)
#     $okButton.Text = 'OK'
#     $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
#     $form.AcceptButton = $okButton
#     $form.Controls.Add($okButton)

#     $cancelButton = New-Object System.Windows.Forms.Button
#     $cancelButton.Location = New-Object System.Drawing.Point(150,120)
#     $cancelButton.Size = New-Object System.Drawing.Size(75,23)
#     $cancelButton.Text = 'Cancel'
#     $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
#     $form.CancelButton = $cancelButton
#     $form.Controls.Add($cancelButton)

#     $label = New-Object System.Windows.Forms.Label
#     $label.Location = New-Object System.Drawing.Point(10,20)
#     $label.Size = New-Object System.Drawing.Size(280,20)
#     $label.Text = 'Please select a computer:'
#     $form.Controls.Add($label)

#     $listBox = New-Object System.Windows.Forms.ListBox
#     $listBox.Location = New-Object System.Drawing.Point(10,40)
#     $listBox.Size = New-Object System.Drawing.Size(260,20)
#     $listBox.Height = 80

#     [void] $listBox.Items.Add('atl-dc-001')
#     [void] $listBox.Items.Add('atl-dc-002')
#     [void] $listBox.Items.Add('atl-dc-003')
#     [void] $listBox.Items.Add('atl-dc-004')
#     [void] $listBox.Items.Add('atl-dc-005')
#     [void] $listBox.Items.Add('atl-dc-006')
#     [void] $listBox.Items.Add('atl-dc-007')

#     $form.Controls.Add($listBox)

#     $form.Topmost = $true

#     $result = $form.ShowDialog()

#     if ($result -eq [System.Windows.Forms.DialogResult]::OK)
#     {
#         $x = $listBox.SelectedItem
#         $x
#     }
# }


