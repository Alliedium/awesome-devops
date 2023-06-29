#Remove virtual machine
param(
	[Parameter(Mandatory=$true)]
    [string]$n
)
$n = $n.Trim()
$VMName = Get-Vm -Name $n -erroraction 'silentlycontinue'
if ($VMName -and $VMName.Name) {
	echo "Removing VM - [$n] from Hyper-V"
	$HardDrives = Get-VM $n | Select-Object -ExpandProperty HardDrives
	$HardDrivesPath=$HardDrives.Path
	echo "Stop VM [$n]"
	Stop-VM -Name $n -Force
	if ($HardDrivesPath) {
		echo "Found HardDrivesPath [$HardDrivesPath]"
		Remove-Item -Path $HardDrivesPath
		echo "HardDrive [$HardDrivesPath] was removed"
	} else {
		echo "HardDrivesPath of VM [$n] was not found"
	}

	Remove-VM -Name $n -Force
	echo "VM [$n] was removed"
} else {
	echo "VM with name [$n] was not found"
}
