{ TorChat - Get/Set client configuration settings

  Copyright (C) 2012 Bernd Kreuss <prof7bit@googlemail.com>

  This source is free software; you can redistribute it and/or modify it under
  the terms of the GNU General Public License as published by the Free
  Software Foundation; either version 3 of the License, or (at your option)
  any later version.

  This code is distributed in the hope that it will be useful, but WITHOUT ANY
  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
  details.

  A copy of the GNU General Public License is available on the World Wide Web
  at <http://www.gnu.org/copyleft/gpl.html>. You can also obtain it by writing
  to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  MA 02111-1307, USA.
}
unit clientconfig;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

  function ConfGetDataDir: String;
  function ConfGetTorExe: String;
  function ConfGetListenPort: DWord;
  function ConfGetTorHost: String;
  function ConfGetTorPort: DWord;
  function ConfGetHiddenServiceName: String;

implementation

function ConfGetDataDir: String;
begin
  {$ifdef windows}
    //{$fatal Windows is not yet supported}
  {$else}
    {$warning home directory hardcoded, dirty hack}
    Result := ExpandFileName('~/.torchat2');
  {$endif}
end;

function ConfGetTorExe: String;
begin
  {$ifdef windows}
    Result := GetCurrentDir + '\tor\tor.exe';
  {$else}
    Result := '/usr/sbin/tor';
  {$endif}
end;

function ConfGetListenPort: DWord;
begin
  Result := 11009;
end;

function ConfGetTorHost: String;
begin
  Result := 'localhost'
end;

function ConfGetTorPort: DWord;
begin
  Result := 11109;
end;

function ConfGetHiddenServiceName: String;
var
  FileName: String;
  HostnameFile: TFileStream;
const
  OnionLength = 16;
begin
  FileName := ConcatPaths([ConfGetDataDir, 'tor/hidden_service/hostname']);
  SetLength(Result, OnionLength);
  try
    HostnameFile := TFileStream.Create(FileName, fmOpenRead);
    if HostnameFile.Read(Result[1], OnionLength) < OnionLength then
      Result := '';
  except
    Result := '';
  end;
  HostnameFile.Free;
end;

end.

