#Functions

function Get-ElementPath
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([string])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true, Position=0)]
         [System.Xml.XmlElement]$leafNode,

        # Param2 help description
        [Parameter(Mandatory=$true, Position=1)]
        [String] $Delimeter
    )

    Process
    {

            $path =$leafNode.name
            $node = $leafNode

            While (($node.parentnode).name -ne 'Modifications to Standard Image'){
           
                        $node = $node.parentNode
                        $Path = $node.name + "$Delimeter" + $Path
            }
             Return $Path    
     }

     End
     {

     }
}

#Main

cls
Set-Location 'C:\_MyDevWork\VMOptimizationTool'
$xmlfile = "C:\_MyDevWork\VMOptimizationTool\Win10.xml"
$RegCSVExportFile = "C:\_MyDevWork\VMOptimizationTool\Win10_Registry.csv"
$ShellExecuteCSVExportFile = "C:\_MyDevWork\VMOptimizationTool\Win10_ShellExecute.csv"
$ServiceCSVExportFile = "C:\_MyDevWork\VMOptimizationTool\Win10_Service.csv"
$SchTasksExportFile = "C:\_MyDevWork\VMOptimizationTool\Win10_SchTasks.csv"

[xml]$myxml = get-content -path $xmlfile

#Use XPath and make sure the data type is System.Xml.XmlElement (use .SelectedNodes)
$leafNodes = $myxml.SelectNodes("//step")  


#[System.Xml.XmlElement]$leaf = $null
#foreach ($leaf in $LeafNodes){
#Get-ElementPath -leafNode $leaf -Delimeter '\'
#}


#Registry Serialization
$leafNodes|Where-Object -FilterScript {$_.action.Type -eq "Registry"} | 
            select-object @{n = "StepPath" ; e ={Get-ElementPath -leafNode $_ -Delimeter '\'}},
                          #@{n = "StepName" ; e ={$_.name}},
                          @{n = "StepDescription" ; e ={$_.Description}},
                          @{n = "StepCategory" ; e ={$_.Category}},
                          @{n = "StepDefaultSelected" ; e ={$_.DefaultSelected}},
                          @{n = "StepActionComment" ; e ={$_.Action.'#comment'}},
                          @{n = "StepActionCommand" ; e ={$_.Action.command}},
                          @{n = "StepActionType" ; e ={$_.Action.Type}},
                          @{n = "StepActionParamName" ; e ={$_.Action.params.taskName}},
                          @{n = "StepActionParamMode" ; e ={$_.Action.params.Status}},
                          @{n = "StepActionParamKeyname" ; e ={$_.Action.params.Keyname}},
                          @{n = "StepActionParmasFilename" ; e ={$_.Action.params.Filename}},
                          @{n = "StepActionParamsValuename" ; e ={$_.Action.params.Valuename}},
                          @{n = "StepActionParamsType" ; e ={$_.Action.params.Type}},
                          @{n = "StepActionParamsData" ; e ={$_.Action.params.Data}} |
                          Export-Csv -Path $RegCSVExportFile



  #ShellExecute  Serialization
  $leafNodes|Where-Object -FilterScript {$_.action.Type -eq "ShellExecute"} | 
            select-object @{n = "StepPath" ; e ={Get-ElementPath -leafNode $_ -Delimeter '\'}},
                          #@{n = "StepName" ; e ={$_.name}},
                          @{n = "StepDescription" ; e ={$_.Description}},
                          @{n = "StepCategory" ; e ={$_.Category}},
                          @{n = "StepDefaultSelected" ; e ={$_.DefaultSelected}},
                          @{n = "StepActionComment" ; e ={$_.Action.'#comment'}},
                          @{n = "StepActionCommand" ; e ={$_.Action.command}},
                          @{n = "StepActionType" ; e ={$_.Action.Type}},
                          @{n = "StepActionParamName" ; e ={$_.Action.params.taskName}},
                          @{n = "StepActionParamMode" ; e ={$_.Action.params.Status}},
                          @{n = "StepActionParamKeyname" ; e ={$_.Action.params.Keyname}},
                          @{n = "StepActionParmasFilename" ; e ={$_.Action.params.Filename}},
                          @{n = "StepActionParamsValuename" ; e ={$_.Action.params.Valuename}},
                          @{n = "StepActionParamsType" ; e ={$_.Action.params.Type}},
                          @{n = "StepActionParamsData" ; e ={$_.Action.params.Data}} |
                          Export-Csv -Path $RegCSVExportFile -Append


  #Service
    $leafNodes|Where-Object -FilterScript {$_.action.Type -eq "Service"} | 
            select-object @{n = "StepPath" ; e ={Get-ElementPath -leafNode $_ -Delimeter '\'}},
                          #@{n = "StepName" ; e ={$_.name}},
                          @{n = "StepDescription" ; e ={$_.Description}},
                          @{n = "StepCategory" ; e ={$_.Category}},
                          @{n = "StepDefaultSelected" ; e ={$_.DefaultSelected}},
                          @{n = "StepActionComment" ; e ={$_.Action.'#comment'}},
                          @{n = "StepActionCommand" ; e ={$_.Action.command}},
                          @{n = "StepActionType" ; e ={$_.Action.Type}},
                          @{n = "StepActionParamName" ; e ={$_.Action.params.ServiceName}},
                          @{n = "StepActionParamMode" ; e ={$_.Action.params.startMode}},
                          @{n = "StepActionParamKeyname" ; e ={$_.Action.params.Keyname}},
                          @{n = "StepActionParmasFilename" ; e ={$_.Action.params.Filename}},
                          @{n = "StepActionParamsValuename" ; e ={$_.Action.params.Valuename}},
                          @{n = "StepActionParamsType" ; e ={$_.Action.params.Type}},
                          @{n = "StepActionParamsData" ; e ={$_.Action.params.Data}} |
                          Export-Csv -Path $RegCSVExportFile -Append


  #SchTasks
      $leafNodes|Where-Object -FilterScript {$_.action.Type -eq "SchTasks"} | 
            select-object @{n = "StepPath" ; e ={Get-ElementPath -leafNode $_ -Delimeter '\'}},
                          #@{n = "StepName" ; e ={$_.name}},
                          @{n = "StepDescription" ; e ={$_.Description}},
                          @{n = "StepCategory" ; e ={$_.Category}},
                          @{n = "StepDefaultSelected" ; e ={$_.DefaultSelected}},
                          @{n = "StepActionComment" ; e ={$_.Action.'#comment'}},
                          @{n = "StepActionCommand" ; e ={$_.Action.command}},
                          @{n = "StepActionType" ; e ={$_.Action.Type}},
                          @{n = "StepActionParamName" ; e ={$_.Action.params.taskName}},
                          @{n = "StepActionParamMode" ; e ={$_.Action.params.Status}},
                          @{n = "StepActionParamKeyname" ; e ={$_.Action.params.Keyname}},
                          @{n = "StepActionParmasFilename" ; e ={$_.Action.params.Filename}},
                          @{n = "StepActionParamsValuename" ; e ={$_.Action.params.Valuename}},
                          @{n = "StepActionParamsType" ; e ={$_.Action.params.Type}},
                          @{n = "StepActionParamsData" ; e ={$_.Action.params.Data}} |
                          Export-Csv -Path $RegCSVExportFile -Append