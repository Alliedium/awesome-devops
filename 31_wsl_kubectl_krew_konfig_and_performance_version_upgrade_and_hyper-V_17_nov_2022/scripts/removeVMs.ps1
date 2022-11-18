#Remove virtual machines
param(
	[Parameter(Mandatory=$true)]
    [String[]]$ns=@(" ")
)
echo "___Removing vms start___ $ns"
foreach($n in $ns)
{
	echo "Try to remove VM [$n]"
   ./removeVM.ps1 -n $n
}

echo "___script completed___"