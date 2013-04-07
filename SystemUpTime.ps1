#----------------------------------------------------------------
#Script: SystemUpTime.ps1
#Auther: Zachary Zeilinger zzeilinger@gmail.com
#Date: April 6, 2013 09:00pm
#Source code: 
#----------------------------------------------------------------
<#
.SYNOPSIS
    Displays a systems up time

.DESCRIPTION
    Gives system admnistrators a quick check on system up time

.Example
    Zeus up time 45 Day(s) 4 Hour(s) 22 Minute(s)
    GateKeeper up time 45 Day(s) 4 Hour(s) 45 Minute(s)

.Notes
    Requires a srvlst.txt file to be in the same directory as the .ps1 file.
#>

#Turns off error messages
$ErrorActionPreference = 'silentlycontinue'

#Gets script location
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath

#Tests for text file with list of server names. If none exists in the directory the script will create the text file, open it, and the user must then populate the list. 
$path = "$dir\srvlst.txt"
    if(!(Test-Path -path $path))
        {
            new-item -path $path -Value "Please populate srvlst.txt with server names. One per line then save and close" -itemtype file
            Invoke-Item $dir\srvlst.txt
            Write-Host "Press the any key to continue..."
            $x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            cls
        }
            Else
                {
                    cls
                }
$srvlst = Get-Content "$dir\srvlst.txt" 

#Gets the system up time for each system listed in the srvlst.txt file
foreach ($s in $srvlst) {  
    $wmi = Get-WmiObject Win32_OperatingSystem -Computer $s
    $now = get-date
    $uptime = $now - $wmi.ConvertToDateTime($wmi.LastBootUpTime)
    $d = $Uptime.Days  
    $h = $Uptime.Hours  
    $m = $uptime.Minutes 
    "$s up time $d Day(s) $h Hour(s) $m Minute(s)"
}

Write-Host "Press the any key to close the window ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

<#
Systems-Status
Copyright (C) 2013  Zachary Zeilinger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
GNU General Public License, version 3 (http://opensource.org/licenses/GPL-3.0)
Disclaimer of Warranty
THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
Limitation of Liability
IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
#>