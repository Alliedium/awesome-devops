# Create a VM with static IP configuration and ssh public key access

param(
    [String[]]$vmNamePrefixes,
    [String[]]$vmIds=@()
)

if ($vmIds) {
	$vmIdsLength = $vmIds.length
	echo "Will be create [$vmIdsLength] VMs"
	foreach($vmId in $vmIds) {		
		$newPrefix = ''
		$indexOfvmIds = $vmIds.IndexOf($vmId)
		echo "Try to create VM vmId - [$vmId], vmIdsLength - [$vmIdsLength], indexOfvmIds - [$indexOfvmIds]"
		if ($vmNamePrefixes -and $vmNamePrefixes[$indexOfvmIds]) {
			$newPrefix = $vmNamePrefixes[$indexOfvmIds]			
		}
		./createVM.ps1 -vmNamePrefix $newPrefix -vmId $vmId
	}
} else {
	echo "Parameter [vmIds] is invalid"
}

