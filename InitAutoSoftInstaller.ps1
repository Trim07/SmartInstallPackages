Import-Module ./installDefaultPackages


# Iniciação do sistema
# Todos os direitos reservados a TryMic - Smart Systems

# adicionar - Set-ExecutionPolicy RemoteSigned



Clear-Host

Write-Host "
BEM VINDO AO AutoSoftInstaller
BY TryMic - Smart Systems
"

sleep 2

Write-Host "Verificando conexão com a internet..."

$test_connection = (Test-Connection www.globo.com.br -Count 1 -Quiet)

if($test_connection -eq 'True'){

    Write-Host "Realizando tentativa de conexão com a base de dados..."

    try{
        $request_packages_data_base = Invoke-WebRequest -Uri https://community.chocolatey.org/packages/
    }catch{
        Write-Host "Não foi possivel conectar-se a base de dados, tente novamente mais tarde."
        sleep 3
        exit
    }
    
    

    if($($request_packages_data_base.StatusCode) -eq 200){
        $option = Read-Host "
            Selecione uma das opções:

            [ 1 ] = Instalar pacote padrão de softwares (Chrome, AnyDesk, Adobe Reader)
            [ 2 ] - Instalar software
            [ 3 ] - Desinstalar software
            [ 4 ] - Atualizar software
            [ 5 ] - Pesquisar softwares
        "

        switch($option)
        {
            
            1{
                installDefaultPackages(@("googlechrome", "anydesk", "adobereader"))
            }


            5{
                $search_string = Read-Host "Digite a palavra-chave da pesquisa"
                Write-Host "Iniciando as buscas..."
                choco search $search_string | more
            }
        }

    }else{
        Write-Host "Não foi possivel conectar a base de dados, tente novamente mais tarde."
    }

}else{
    Write-Host "Verifique sua conexão com a internet e tente novamente."
}


