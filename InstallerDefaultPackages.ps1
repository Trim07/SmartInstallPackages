

workflow installDefaultPackages($packages){

    Parallel{

        foreach ($package_name in $packages){
            Write-Host $package_name
        }
    }
}