#Stop virtual machine
param(
	[Parameter(Mandatory=$true)]
    [string]$n
)
$n = $n.Trim()
$VMName = Get-Vm -Name $n -erroraction 'silentlycontinue'
if ($VMName -and $VMName.Name) {
	echo "Stoping VM - [$n] from Hyper-V"
	Stop-VM -Name $n -Force
	echo "VM [$n] was stopped"
} else {
	echo "VM with name [$n] was not found"
}
