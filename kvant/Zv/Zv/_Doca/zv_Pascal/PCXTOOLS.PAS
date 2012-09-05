{$F+,O+}
unit pcxtools;
interface
uses gx_tp,pcx_tp;
function OverlaySetDisplayEga:integer;
function OverlayDisplayFileRes(st:string;page:integer):integer;
function OverlayFileDisplayRes(st:string;page:integer):integer;
function OverlayDisplayFileNRes(st:string;page:integer):integer;
function OverlayFileDisplayNRes(st:string;page:integer):integer;
implementation
function OverlaySetDisplayEga:integer;
   begin
       OverlaySetDisplayEga:=gxsetdisplay(gxega_10);
   end;
function OverlayDisplayFileRes(st:string;page:integer):integer;
   begin
      OverlayDisplayFileRes:=pcxdisplayfile('res'+st+'.pcx',0,0,639,349,page);
   end;
function OverlayFileDisplayRes(st:string;page:integer):integer;
   begin
         OverlayFileDisplayRes:=pcxfiledisplay('res'+st+'.pcx',0,0,page);
   end;
function OverlayDisplayFileNRes(st:string;page:integer):integer;
   begin
      OverlayDisplayFileNRes:=pcxdisplayfile('nres'+st+'.pcx',0,0,639,349,page);
   end;
function OverlayFileDisplayNRes(st:string;page:integer):integer;
   begin
         OverlayFileDisplayNRes:=pcxfiledisplay('nres'+st+'.pcx',0,0,page);
   end;
begin
end.