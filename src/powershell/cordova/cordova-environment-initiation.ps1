function Install-MSIFile {
	[CmdletBinding()]
	 Param(
	  [parameter(mandatory=$true,ValueFromPipeline=$true,ValueFromPipelinebyPropertyName=$true)]
	        [ValidateNotNullorEmpty()]
	        [string]$msiFile,
	        [parameter()]
	        [ValidateNotNullorEmpty()]
	        [string]$targetDir
	 )
	if( ! ( Test-Path $msiFile ) ) {
	    throw "Path to the MSI File $($msiFile) is invalid. Please supply a valid MSI file!"
	}
	$arguments = @(
	    "/i"
	    "`"$msiFile`""
	    "/qn"
	    "/norestart"
	)
	if( $targetDir ) {
	    if( ! ( Test-Path $targetDir ) ) {
	        throw "Path to the Installation Directory $($targetDir) is invalid. Please supply a valid installation directory!"
	    }
	    $arguments += "INSTALLDIR=`"$targetDir`""
	}
	Write-Verbose "Installing $msiFile......."
	$process = Start-Process -FilePath msiexec.exe -ArgumentList $arguments -Wait -PassThru
	if( $process.ExitCode -eq 0 ) {
	    Write-Verbose "$msiFile has been successfully installed!"
	}
	else {
	    Write-Verbose "Installer exit code $($process.ExitCode) for file $($msifile)!"
	}
}

function insertPathVariableEntry( $patternString ) {
	$environmentVariableValue = [System.Environment]::GetEnvironmentVariable( "PATH" , "Machine" )
	$splitValues = $environmentVariableValue -split ';'
	$fl = 0
	foreach ( $item in $splitValues ) {
		$itemLowerCase = $item.ToLower()
		if( $itemLowerCase.Contains( $patternString.ToLower() ) ) {
			$fl = 1
		}
	}
	$patternString += ";"
	if( $fl -eq 0 ) {
		if( $environmentVariableValue.Length -gt 0 ) {
			$lastCharacter = $environmentVariableValue.substring( $environmentVariableValue.Length - 1 , 1 )
			if( $lastCharacter.CompareTo( ";" ) -ne 0 ) {
				$patternString = ";" + $patternString
			}
		}
		$environmentVariableValue += $patternString
		[System.Environment]::SetEnvironmentVariable( "PATH" , $environmentVariableValue , "Machine" )
		echo "'Path' environment value has been set!"
	}
	else {
		echo "'Path' already has the spplied value!"
	}
}

function removePathVariableEntry( $patternString ) {
	$environmentVariableValue = [System.Environment]::GetEnvironmentVariable( "PATH" , "Machine" )
	$splitValues = $environmentVariableValue -split ';'
	$fl = 0
	$res = ""
	foreach ( $item in $splitValues ) {
		$itemLowerCase = $item.ToLower()
		if( $itemLowerCase.Contains( $patternString.ToLower() ) ) {
		}
		else {
			$res += $item + ";"
		}
	}
	echo $res
}

function setJavaHomeEnvironmentVariableDirectly( $pathString ) {
	[System.Environment]::SetEnvironmentVariable( "JAVA_HOME" , ( $pathString + ";" ) , "Machine" )
}

function setAntHomeEnvironmentVariableDirectly( $pathString ) {
	[System.Environment]::SetEnvironmentVariable( "ANT_HOME" , ( $pathString + ";" ) , "Machine" )
}

function getJavaInstalledFolder() {
    $folderList = Get-ChildItem -Path "C:\Program Files\java\" | sort @{Expression={$_.CreationTime}; Ascending=$false} | select-object Name
    $res = "C:\Program Files\java\"
    foreach( $item in $folderList ) {
        if( $item.name.Contains( "jdk" ) ) {
            $res = $res + $item.name
            break
        }
    }
    $res += "\"
	return $res
}

function configureJdk( $jdkSource , $jdkDestination ) {
	#JDK INSTALLATION START
	$client = new-object System.Net.WebClient
	$cookie = "oraclelicense=accept-securebackup-cookie"
	$client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $cookie)
	echo "JDK download started......."
	$client.downloadFile( $jdkSource , $jdkDestination )
	echo "JDK download completed!"
	echo "JDK installation started......."
	Start-Process $jdkDestination -ArgumentList "/s" -Wait
	echo "JDK installation completed!"
	echo "Setting JDK environment variables......."
	$javaInstalledBinFolder = getJavaInstalledFolder
	setJavaHomeEnvironmentVariableDirectly -pathString $javaInstalledBinFolder
	$javaInstalledBinFolder += "bin\"
	insertPathVariableEntry -patternString $javaInstalledBinFolder
	echo "JDK environment variables has been set!"
	echo "JDK installation completed!"
	echo "Deleting JDK instalaltion file......."
	if( Test-Path $jdkDestination ) {
		Remove-Item $jdkDestination
	}
	echo "JDK installer file deleted!"
	#JDK INSTALLATION END
}

function configureNodeJs( $nodeJsSource , $nodeJsDestination ) {
	#NODEJS INSTALLATION START
	$p = New-Object System.Net.WebClient
	echo "Downloading nodejs installer file......."
	$p.DownloadFile( $nodeJsSource , $nodeJsDestination )
	echo "Nodejs installer file download completed!"
	echo "Installing nodejs......."
	$nodeJsDestination | Install-MSIFile -Verbose
	echo "Nodejs installation completed!"
	echo "Setting nodejs environment variable......."
	insertPathVariableEntry -patternString "C:\Program Files\nodejs"
	echo "Nodejs environment variable has been set!"
	echo "Deleting nodejs installer file......."
	if( Test-Path $nodeJsDestination ) {
		Remove-Item $nodeJsDestination
	}
	echo "Deleted nodejs installer file!"
	echo "Installing npm via choco......."
	choco install npm
	echo "NPM installation complete!"
	echo "Installing npm global packages......."
	npm install -g npm
	npm install -g cordova
	npm install -g phonegap
	echo "NPM global package installation completed!"
	#NODEJS INSTALLATION END
}

function getSystemVersion() {
	return ( Get-WmiObject Win32_OperatingSystem ).OSArchitecture
}

function configureAndroid( $path ) {
	echo "Setting android environment variables......."
	$newPath = $path + "tools\"
	insertPathVariableEntry -patternString $newPath
	$newPath = $path + "platform-tools\"
	insertPathVariableEntry -patternString $newPath
	echo "Android environment variables has been set!"
}

function unzipFiles( $zipFile , $extractDestination ) {
    $shell = new-object -com shell.application
    $zipElements = $shell.NameSpace( $zipFile )
    if( ! ( Test-Path $extractDestination ) ) {
		mkdir $extractDestination
	}
    foreach( $item in $zipElements.items() ) {
        $shell.Namespace( $extractDestination ).copyhere( $item )
    }
}

function configureAntModule( $antSourcePath , $antDestinationPath , $antUnzipDestinationPath ) {
	#APACHE ANT INSTALLATION START
	$p = New-Object System.Net.WebClient
	echo "Downloading ant installer file......."
	$p.DownloadFile( $antSourcePath , $antDestinationPath )
	echo "Ant installer file download completed!"
	echo "Installing apache ant......."
	unzipFiles -zipFile $antDestinationPath -extractDestination $antUnzipDestinationPath
	echo "Apache ant installation complete!"
	echo "Setting apache ant_home environment variable......."
	setAntHomeEnvironmentVariableDirectly -pathString $antUnzipDestinationPath
	echo "Apache ant_home environment variable has been set!"
	echo "Deleting ant installer zip file......."
	if( Test-Path $antDestinationPath ) {
		Remove-Item $antDestinationPath
	}
	echo "Deleted ant installer zip file!"
	#APACHE ANT INSTALLATION END
}

function addChocolateyEnvironmentPathVariable() {
	insertPathVariableEntry -patternString "C:\ProgramData\chocolatey\bin"
}

set-ExecutionPolicy Unrestricted

$nodeJs32BitUrl = "http://nodejs.org/dist/v0.10.35/node-v0.10.35-x86.msi"
$nodeJs64BitUrl = "http://nodejs.org/dist/v0.10.35/x64/node-v0.10.35-x64.msi"
$nodeJsDestination = "c:\nodejs-installer.msi"
$javaJdk32BitUrl = "http://download.oracle.com/otn-pub/java/jdk/8u25-b18/jdk-8u25-windows-i586.exe"
$javaJdk64BitUrl = "http://download.oracle.com/otn-pub/java/jdk/8u25-b18/jdk-8u25-windows-x64.exe"
$jdkDestination = "c:\jdk-installer.exe"
$androidSdkLocation = "c:\program files (x86)\android\android-studio\sdk\"
$antFileUrl = "http://www.eu.apache.org/dist//ant/ivyde/2.2.0.final/apache-ivyde-2.2.0.final-201311091524-RELEASE.zip"
$antZipFileDestination = "c:\apache-ant.zip"
$antFolderDestination = "c:\apache-ant"

$systemVersion = getSystemVersion
if( $systemVersion -eq "64-bit" ) {
	$nodeJsSource = $nodejs64BitUrl
	$jdkSource = $javaJdk64BitUrl
}
else {
	$nodeJsSource = $nodejs32BitUrl
	$jdkSource = $javaJdk32BitUrl
}

. .\chocolaty-installation.bat
addChocolateyEnvironmentPathVariable
configureNodeJs -nodeJsSource $nodeJsSource -nodeJsDestination $nodeJsDestination
configureJdk -jdkSource $jdkSource -jdkDestination $jdkDestination
configureAndroid -path $androidSdkLocation
configureAntModule -antSourcePath $antFileUrl -antDestinationPath $antZipFileDestination -antUnzipDestinationPath $antFolderDestination

Get-EventSubscriber | Unregister-Event
