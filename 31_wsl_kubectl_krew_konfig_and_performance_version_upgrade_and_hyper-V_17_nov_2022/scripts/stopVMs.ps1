#Stop virtual machines
param(
	[Parameter(Mandatory=$true)]
    [String[]]$ns=@("")
)
echo "___Stoping vms start___ $ns"
foreach($n in $ns)
{
	echo "Try to stop VM [$n]"
   ./stopVM.ps1 -n $n
}

echo "___script completed___"